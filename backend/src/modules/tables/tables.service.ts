import { Inject, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { existsSync } from 'fs';
import { join } from 'path';
import PDFDocument from 'pdfkit';
import * as QRCode from 'qrcode';
import { AppError, notFound } from '../../common/errors/app-error';
import { randomToken } from '../../common/utils/crypto';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService } from '../availability/availability.service';
import { validateLayout } from './layout';
import { entranceQrSignature, entranceQrUrl, tableQrSignature, tableQrUrl } from './qr';
import { AreaDto, CreateTableDto, SaveLayoutDto, UpdateAreaDto, UpdateTableDto } from './tables.dto';

/** Fields safe to send to apps (never qrSecret). */
const TABLE_SELECT = {
  id: true,
  areaId: true,
  code: true,
  minSeats: true,
  maxSeats: true,
  isActive: true,
  posX: true,
  posY: true,
  features: true,
  shape: true,
  width: true,
  height: true,
  rotation: true,
  seatLayout: true,
  isSelectable: true,
  surcharge: true,
  joinGroup: true,
} satisfies Prisma.TableSelect;

@Injectable()
export class TablesService {
  constructor(
    private readonly prisma: PrismaService,
    @Inject(ENV) private readonly env: Env,
    private readonly availability: AvailabilityService,
  ) {}

  // ───── areas ─────

  listAreas(restaurantId: string) {
    return this.prisma.tableArea.findMany({
      where: { restaurantId },
      orderBy: [{ floor: 'asc' }, { sortOrder: 'asc' }],
      include: { _count: { select: { tables: { where: { isActive: true } } } } },
    });
  }

  createArea(restaurantId: string, dto: AreaDto) {
    return this.prisma.tableArea.create({ data: { ...dto, restaurantId } });
  }

  async updateArea(restaurantId: string, id: string, dto: UpdateAreaDto) {
    await this.findArea(restaurantId, id);
    return this.prisma.tableArea.update({ where: { id }, data: dto });
  }

  async deleteArea(restaurantId: string, id: string) {
    await this.findArea(restaurantId, id);
    const tables = await this.prisma.table.count({ where: { areaId: id } });
    if (tables > 0) throw new AppError('CONFLICT', 'Move or remove the tables in this area first', { tables });
    await this.prisma.tableArea.delete({ where: { id } });
  }

  /** Full map of one area for the editor / staff view. */
  async getAreaMap(restaurantId: string, id: string) {
    const area = await this.prisma.tableArea.findFirst({
      where: { id, restaurantId },
      include: {
        tables: { where: { isActive: true }, select: TABLE_SELECT, orderBy: { code: 'asc' } },
        elements: true,
      },
    });
    if (!area) throw notFound('Area');
    return area;
  }

  /**
   * Save the whole map of one area atomically (§8.6 editor).
   * - tables with `id` → updated (may move here from another area)
   * - tables without `id` whose code already exists in the restaurant → that table is reused
   * - new codes → created
   * - tables of this area missing from the request → deleted if never booked, else deactivated
   * - elements are replaced
   */
  async saveLayout(restaurantId: string, areaId: string, dto: SaveLayoutDto) {
    const area = await this.findArea(restaurantId, areaId);
    const cols = dto.gridCols ?? area.gridCols;
    const rows = dto.gridRows ?? area.gridRows;

    const problems = validateLayout(
      { cols, rows },
      dto.tables.map((t) => ({
        key: t.code,
        x: t.posX ?? -1,
        y: t.posY ?? -1,
        width: t.width ?? 2,
        height: t.height ?? 2,
        rotation: t.rotation ?? 0,
        minSeats: t.minSeats ?? 1,
        maxSeats: t.maxSeats,
      })),
      dto.elements.map((e, i) => ({
        key: e.label ?? `${e.type}#${i}`,
        x: e.x,
        y: e.y,
        width: e.width ?? 1,
        height: e.height ?? 1,
        rotation: e.rotation ?? 0,
      })),
    );
    if (problems.length) throw new AppError('LAYOUT_INVALID', 'Table map has problems', { problems });

    await this.prisma.$transaction(async (tx) => {
      await tx.tableArea.update({ where: { id: areaId }, data: { gridCols: cols, gridRows: rows } });

      const existing = await tx.table.findMany({ where: { restaurantId }, select: { id: true, code: true, areaId: true } });
      const byId = new Map(existing.map((t) => [t.id, t]));
      const byCode = new Map(existing.map((t) => [t.code.toUpperCase(), t]));
      const keptIds = new Set<string>();

      // Free the codes first so swapping codes between two tables does not hit the unique index.
      const touched = dto.tables.map((t) => t.id ?? byCode.get(t.code.toUpperCase())?.id).filter((x): x is string => !!x);
      for (const id of touched) {
        if (!byId.has(id)) throw new AppError('NOT_FOUND', 'Table not found', { id });
        await tx.table.update({ where: { id }, data: { code: `~tmp-${id}` } });
      }

      for (const t of dto.tables) {
        const { id: _ignored, ...fields } = t;
        const data = { ...fields, code: t.code.toUpperCase(), areaId, isActive: t.isActive ?? true, seatLayout: t.seatLayout ?? Prisma.DbNull };
        const targetId = t.id ?? byCode.get(t.code.toUpperCase())?.id;
        if (targetId) {
          await tx.table.update({ where: { id: targetId }, data });
          keptIds.add(targetId);
        } else {
          const created = await tx.table.create({ data: { ...data, restaurantId, qrSecret: randomToken(24) } });
          keptIds.add(created.id);
        }
      }

      const removed = existing.filter((t) => t.areaId === areaId && !keptIds.has(t.id)).map((t) => t.id);
      if (removed.length) {
        const booked = await tx.booking.findMany({
          where: { tableId: { in: removed } },
          select: { tableId: true },
          distinct: ['tableId'],
        });
        const bookedIds = new Set(booked.map((b) => b.tableId!));
        const deletable = removed.filter((id) => !bookedIds.has(id));
        if (deletable.length) await tx.table.deleteMany({ where: { id: { in: deletable } } });
        if (bookedIds.size) await tx.table.updateMany({ where: { id: { in: [...bookedIds] } }, data: { isActive: false } });
      }

      await tx.mapElement.deleteMany({ where: { areaId } });
      if (dto.elements.length) {
        await tx.mapElement.createMany({ data: dto.elements.map((e) => ({ ...e, areaId })) });
      }
    });
    await this.availability.invalidate(restaurantId);
    return this.getAreaMap(restaurantId, areaId);
  }

  // ───── tables ─────

  listTables(restaurantId: string, areaId?: string) {
    return this.prisma.table.findMany({
      where: { restaurantId, ...(areaId ? { areaId } : {}) },
      select: TABLE_SELECT,
      orderBy: [{ areaId: 'asc' }, { code: 'asc' }],
    });
  }

  async createTable(restaurantId: string, dto: CreateTableDto) {
    await this.findArea(restaurantId, dto.areaId);
    this.checkSeats(dto.minSeats, dto.maxSeats);
    try {
      return await this.prisma.table.create({
        data: { ...dto, code: dto.code.toUpperCase(), restaurantId, qrSecret: randomToken(24) },
        select: TABLE_SELECT,
      });
    } catch (e) {
      throw this.mapCodeConflict(e);
    }
  }

  async updateTable(restaurantId: string, id: string, dto: UpdateTableDto) {
    const table = await this.findTable(restaurantId, id);
    if (dto.areaId) await this.findArea(restaurantId, dto.areaId);
    this.checkSeats(dto.minSeats ?? table.minSeats, dto.maxSeats ?? table.maxSeats);
    try {
      return await this.prisma.table.update({
        where: { id },
        data: { ...dto, code: dto.code?.toUpperCase() },
        select: TABLE_SELECT,
      });
    } catch (e) {
      throw this.mapCodeConflict(e);
    }
  }

  /** Delete if never booked; otherwise deactivate (bookings keep their history). */
  async deleteTable(restaurantId: string, id: string) {
    await this.findTable(restaurantId, id);
    const bookings = await this.prisma.booking.count({ where: { tableId: id } });
    if (bookings) await this.prisma.table.update({ where: { id }, data: { isActive: false } });
    else await this.prisma.table.delete({ where: { id } });
  }

  /** New secret → old printed QR for this table stops working. */
  async rotateQrSecret(restaurantId: string, id: string) {
    await this.findTable(restaurantId, id);
    await this.prisma.table.update({ where: { id }, data: { qrSecret: randomToken(24) } });
  }

  // ───── QR ─────

  async tableQrPng(restaurantId: string, id: string): Promise<Buffer> {
    const table = await this.findTable(restaurantId, id);
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { slug: true } });
    const url = tableQrUrl(this.env.APP_LINK_BASE_URL, r.slug, table.code, tableQrSignature(table.qrSecret, restaurantId, table.id));
    return QRCode.toBuffer(url, { type: 'png', width: 800, margin: 2, errorCorrectionLevel: 'M' });
  }

  async entranceQrPng(restaurantId: string): Promise<Buffer> {
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { slug: true } });
    const url = entranceQrUrl(this.env.APP_LINK_BASE_URL, r.slug, entranceQrSignature(this.env.JWT_SECRET, restaurantId));
    return QRCode.toBuffer(url, { type: 'png', width: 800, margin: 2, errorCorrectionLevel: 'M' });
  }

  /** Printable A4 PDF: entrance QR first, then one card per active table (2 × 3 per page). */
  async qrPdf(restaurantId: string, areaId?: string): Promise<Buffer> {
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { slug: true, name: true } });
    const tables = await this.prisma.table.findMany({
      where: { restaurantId, isActive: true, ...(areaId ? { areaId } : {}) },
      include: { area: { select: { name: true } } },
      orderBy: [{ areaId: 'asc' }, { code: 'asc' }],
    });

    const cards: { title: string; subtitle: string; url: string }[] = [];
    if (!areaId) {
      cards.push({
        title: 'Check-in',
        subtitle: r.name,
        url: entranceQrUrl(this.env.APP_LINK_BASE_URL, r.slug, entranceQrSignature(this.env.JWT_SECRET, restaurantId)),
      });
    }
    for (const t of tables) {
      cards.push({
        title: `Bàn ${t.code}`,
        subtitle: `${r.name} · ${t.area.name}`,
        url: tableQrUrl(this.env.APP_LINK_BASE_URL, r.slug, t.code, tableQrSignature(t.qrSecret, restaurantId, t.id)),
      });
    }

    const doc = new PDFDocument({ size: 'A4', margin: 36 });
    const fonts = registerVietnameseFonts(doc);
    const chunks: Buffer[] = [];
    doc.on('data', (c: Buffer) => chunks.push(c));
    const done = new Promise<Buffer>((resolve) => doc.on('end', () => resolve(Buffer.concat(chunks))));

    const colW = (doc.page.width - 72) / 2;
    const rowH = (doc.page.height - 72) / 3;
    for (let i = 0; i < cards.length; i++) {
      if (i > 0 && i % 6 === 0) doc.addPage();
      const slot = i % 6;
      const x = 36 + (slot % 2) * colW;
      const y = 36 + Math.floor(slot / 2) * rowH;
      const png = await QRCode.toBuffer(cards[i].url, { type: 'png', width: 600, margin: 1 });
      const size = Math.min(colW, rowH) - 70;
      doc.rect(x + 6, y + 6, colW - 12, rowH - 12).dash(4, { space: 4 }).strokeColor('#bbbbbb').stroke().undash();
      doc.image(png, x + (colW - size) / 2, y + 16, { width: size });
      doc.font(fonts.bold).fillColor('#111111').fontSize(20).text(fonts.text(cards[i].title), x, y + size + 22, { width: colW, align: 'center' });
      doc.font(fonts.regular).fillColor('#666666').fontSize(10).text(fonts.text(cards[i].subtitle), x, y + size + 48, { width: colW, align: 'center' });
    }
    if (cards.length === 0) doc.fontSize(14).text('No active tables');
    doc.end();
    return done;
  }

  // ───── helpers ─────

  private async findArea(restaurantId: string, id: string) {
    const area = await this.prisma.tableArea.findFirst({ where: { id, restaurantId } });
    if (!area) throw notFound('Area');
    return area;
  }

  private async findTable(restaurantId: string, id: string) {
    const table = await this.prisma.table.findFirst({ where: { id, restaurantId } });
    if (!table) throw notFound('Table');
    return table;
  }

  private checkSeats(min = 1, max: number) {
    if (min < 1 || max < min) throw new AppError('VALIDATION_FAILED', 'maxSeats must be ≥ minSeats ≥ 1');
  }

  private mapCodeConflict(e: unknown) {
    if (e instanceof Prisma.PrismaClientKnownRequestError && e.code === 'P2002') {
      return new AppError('TABLE_CODE_TAKEN', 'Another table already uses this code');
    }
    return e;
  }
}

/** Be Vietnam Pro (OFL, src/assets/fonts). Copied to dist/assets by nest-cli. */
const FONT_DIR = join(__dirname, '..', '..', 'assets', 'fonts');

function registerVietnameseFonts(doc: PDFKit.PDFDocument) {
  const regular = join(FONT_DIR, 'BeVietnamPro-Regular.ttf');
  const bold = join(FONT_DIR, 'BeVietnamPro-Bold.ttf');
  if (existsSync(regular) && existsSync(bold)) {
    doc.registerFont('vi', regular);
    doc.registerFont('vi-bold', bold);
    return { regular: 'vi', bold: 'vi-bold', text: (s: string) => s };
  }
  // Fallback: built-in fonts have no Vietnamese glyphs, so strip accents rather than print garbage.
  return { regular: 'Helvetica', bold: 'Helvetica-Bold', text: asciiFold };
}

function asciiFold(s: string): string {
  return s.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/đ/g, 'd').replace(/Đ/g, 'D');
}
