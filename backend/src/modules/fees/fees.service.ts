import { Inject, Injectable, Logger } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import PDFDocument from 'pdfkit';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { notFound } from '../../common/errors/app-error';
import { MailService } from '../../common/mail';
import { registerVietnameseFonts } from '../../common/utils/pdf-fonts';
import { zonedParts } from '../../common/utils/time';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';
import { calculateFee, feeBase, launchPlans, planAt, statementTotals } from './fee-calculator';
import { monthRange, statementMemo, vietQrUrl } from './statement-helpers';

export { monthRange, previousMonth, statementMemo, vietQrUrl } from './statement-helpers';

type Tx = Prisma.TransactionClient;

const TZ = 'Asia/Ho_Chi_Minh';
export const OVERDUE_DAYS = 15;
export const PAUSE_DAYS = 30;


/**
 * Platform fee records and monthly statements (§11). Loadable in the worker.
 * Money stays integer VND; Statement sums are BigInt columns, converted at the edges.
 */
@Injectable()
export class FeesService {
  private readonly logger = new Logger(FeesService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly mail: MailService,
    @Inject(ENV) private readonly env: Env,
  ) {}

  /** §11.2: on the first order, start the launch plans (1 % for 3 months, then 2 %). */
  async ensurePlans(restaurantId: string, firstOrderAt: Date, db: Tx | PrismaService = this.prisma) {
    const r = await db.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { firstOrderAt: true, _count: { select: { feePlans: true } } } });
    if (r._count.feePlans > 0) return;
    const start = r.firstOrderAt ?? firstOrderAt;
    if (!r.firstOrderAt) await db.restaurant.update({ where: { id: restaurantId }, data: { firstOrderAt: start } });
    await db.feePlan.createMany({ data: launchPlans(start).map((p) => ({ ...p, restaurantId })) });
  }

  /**
   * Compute (or waive) the fee once a booking ends (§11.1): COMPLETED / NO_SHOW → FINAL
   * (WAIVED when the base is 0); CANCELLED / EXPIRED → WAIVED. Billed records never change.
   */
  async finalize(bookingId: string) {
    const b = await this.prisma.booking.findUnique({
      where: { id: bookingId },
      include: { order: { include: { items: true } }, fee: true, payments: { where: { status: { in: ['PAID', 'PARTIALLY_REFUNDED', 'REFUNDED'] } } } },
    });
    if (!b || b.fee?.status === 'BILLED') return null;
    const ended = ['COMPLETED', 'NO_SHOW', 'CANCELLED', 'EXPIRED'].includes(b.status);
    if (!ended) return null;

    const preOrderValue = (b.order?.items ?? []).filter((i) => i.round === 0 && i.kitchenStatus !== 'CANCELLED').reduce((s, i) => s + i.unitPrice * i.quantity, 0);
    const paid = b.payments.reduce((s, p) => s + p.amount, 0);
    const refunded = b.payments.reduce((s, p) => s + p.refundedAmount, 0);
    const base = feeBase({
      status: b.status,
      paymentMode: b.paymentMode,
      preOrderValue,
      restaurantDiscount: b.order?.restaurantDiscount ?? 0,
      finalBillAmount: b.finalBillAmount,
      keptAmount: paid - refunded,
      refunded: b.status === 'COMPLETED' ? refunded : 0,
    });
    if (base <= 0 && !b.fee) return null; // nothing to record (cancelled, COD no-show)

    await this.ensurePlans(b.restaurantId, b.arrivalAt);
    const plans = await this.prisma.feePlan.findMany({ where: { restaurantId: b.restaurantId } });
    const plan = planAt(plans, b.arrivalAt) ?? planAt(plans, plans.reduce((min, p) => (p.effectiveFrom < min ? p.effectiveFrom : min), b.arrivalAt));
    if (!plan) return null;
    const feeAmount = calculateFee(base, plan);
    const data = { restaurantId: b.restaurantId, feePlanId: plan.id, baseAmount: base, rateBps: plan.rateBps, feeAmount, status: base > 0 ? 'FINAL' : 'WAIVED', computedAt: this.clock.now() } as const;
    return this.prisma.feeRecord.upsert({ where: { bookingId }, create: { bookingId, ...data }, update: data });
  }

  // ───── monthly statements (§11.3) ─────

  /** statement-generate: one statement per restaurant for `periodMonth`. Safe to run twice. */
  async generate(periodMonth: string) {
    const { from, to } = monthRange(periodMonth);
    const records = await this.prisma.feeRecord.findMany({
      where: { status: 'FINAL', statementId: null, booking: { arrivalAt: { gte: from, lt: to } } },
      include: { booking: { select: { order: { select: { platformDiscount: true } } } } },
    });
    const byRestaurant = new Map<string, typeof records>();
    for (const r of records) byRestaurant.set(r.restaurantId, [...(byRestaurant.get(r.restaurantId) ?? []), r]);

    const created: string[] = [];
    for (const [restaurantId, lines] of byRestaurant) {
      const exists = await this.prisma.statement.findUnique({ where: { restaurantId_periodMonth: { restaurantId, periodMonth } } });
      if (exists) continue; // late records go into next month's run (they keep statementId = null)
      const t = statementTotals(lines.map((l) => ({ baseAmount: l.baseAmount, feeAmount: l.feeAmount, platformDiscount: l.booking.order?.platformDiscount ?? 0 })));
      const st = await this.prisma.$transaction(async (tx) => {
        const s = await tx.statement.create({
          data: {
            restaurantId,
            periodMonth,
            bookingCount: t.bookingCount,
            totalBase: BigInt(t.totalBase),
            totalFee: BigInt(t.totalFee),
            platformVoucherCredit: BigInt(t.platformVoucherCredit),
            amountDue: BigInt(t.amountDue),
            status: 'ISSUED',
            issuedAt: this.clock.now(),
          },
        });
        await tx.feeRecord.updateMany({ where: { id: { in: lines.map((l) => l.id) }, statementId: null }, data: { statementId: s.id, status: 'BILLED' } });
        await this.audit.log({ actorType: 'SYSTEM', action: 'statement.issued', entity: 'Statement', entityId: s.id, data: { periodMonth, amountDue: t.amountDue } }, tx);
        return s;
      });
      created.push(st.id);
      await this.emailStatement(st.id).catch((e: Error) => this.logger.warn(`statement email ${st.id}: ${e.message}`));
    }
    return created;
  }

  private async emailStatement(id: string) {
    const s = await this.prisma.statement.findUniqueOrThrow({
      where: { id },
      include: { restaurant: { select: { name: true, members: { where: { role: 'OWNER' }, select: { staff: { select: { email: true } } } } } } },
    });
    const to = s.restaurant.members.map((m) => m.staff.email).filter(Boolean).join(', ');
    if (!to) return;
    const due = Number(s.amountDue);
    await this.mail.send({
      to,
      subject: `comi — Bảng phí tháng ${s.periodMonth} · ${s.restaurant.name}`,
      text: [
        `Xin chào ${s.restaurant.name},`,
        '',
        `Phí nền tảng tháng ${s.periodMonth}: ${s.bookingCount} đơn, số tiền ${due >= 0 ? 'cần thanh toán' : 'comi sẽ chuyển trả'}: ${Math.abs(due).toLocaleString('vi-VN')} đ.`,
        due > 0 ? `Chuyển khoản với nội dung: ${statementMemo(s.id)} (hạn ${OVERDUE_DAYS} ngày).` : '',
        'Chi tiết trong file PDF đính kèm và trong ứng dụng comi cho nhà hàng.',
      ].join('\n'),
      attachments: [{ filename: `comi-${s.periodMonth}.pdf`, content: await this.pdf(id), contentType: 'application/pdf' }],
    });
  }

  /** statement-overdue (daily): ISSUED > 15 days → OVERDUE; > 30 days → restaurant PAUSED (hidden from search). */
  async markOverdue() {
    const now = this.clock.now();
    const overdue = await this.prisma.statement.updateMany({
      where: { status: 'ISSUED', amountDue: { gt: 0 }, issuedAt: { lt: addDaysUtc(now, -OVERDUE_DAYS) } },
      data: { status: 'OVERDUE' },
    });
    const late = await this.prisma.statement.findMany({
      where: { status: 'OVERDUE', issuedAt: { lt: addDaysUtc(now, -PAUSE_DAYS) }, restaurant: { status: 'ACTIVE' } },
      select: { id: true, restaurantId: true },
    });
    for (const s of late) {
      await this.prisma.restaurant.update({ where: { id: s.restaurantId }, data: { status: 'PAUSED' } });
      await this.audit.log({ actorType: 'SYSTEM', action: 'restaurant.paused_unpaid', entity: 'Restaurant', entityId: s.restaurantId, data: { statementId: s.id } });
    }
    return { overdue: overdue.count, paused: late.length };
  }

  async markPaid(adminId: string, id: string) {
    const s = await this.prisma.statement.findUnique({ where: { id } });
    if (!s) throw notFound('Statement');
    if (s.status !== 'PAID') {
      await this.prisma.statement.update({ where: { id }, data: { status: 'PAID', paidAt: this.clock.now() } });
      await this.audit.log({ actorType: 'STAFF', actorId: adminId, action: 'statement.paid', entity: 'Statement', entityId: id });
    }
    return this.get(id);
  }

  // ───── reads ─────

  private dto(s: { id: string; restaurantId: string; periodMonth: string; bookingCount: number; totalBase: bigint; totalFee: bigint; platformVoucherCredit: bigint; amountDue: bigint; status: string; issuedAt: Date | null; paidAt: Date | null }) {
    const due = Number(s.amountDue);
    return {
      id: s.id,
      restaurantId: s.restaurantId,
      periodMonth: s.periodMonth,
      bookingCount: s.bookingCount,
      totalBase: Number(s.totalBase),
      totalFee: Number(s.totalFee),
      platformVoucherCredit: Number(s.platformVoucherCredit),
      amountDue: due,
      status: s.status,
      issuedAt: s.issuedAt?.toISOString() ?? null,
      paidAt: s.paidAt?.toISOString() ?? null,
      dueAt: s.issuedAt ? addDaysUtc(s.issuedAt, OVERDUE_DAYS).toISOString() : null,
      transferMemo: statementMemo(s.id),
      vietQrUrl: s.status === 'PAID' ? null : vietQrUrl(this.env, due, statementMemo(s.id)),
    };
  }

  async list(restaurantId?: string, status?: string) {
    const rows = await this.prisma.statement.findMany({
      where: { ...(restaurantId ? { restaurantId } : {}), ...(status ? { status: status as never } : {}) },
      orderBy: { periodMonth: 'desc' },
      take: 120,
    });
    return rows.map((r) => this.dto(r));
  }

  async get(id: string, restaurantId?: string) {
    const s = await this.prisma.statement.findFirst({
      where: { id, ...(restaurantId ? { restaurantId } : {}) },
      include: { fees: { include: { booking: { select: { code: true, arrivalAt: true, partySize: true } } }, orderBy: { computedAt: 'asc' } } },
    });
    if (!s) throw notFound('Statement');
    return {
      ...this.dto(s),
      lines: s.fees.map((f) => ({
        bookingId: f.bookingId,
        bookingCode: f.booking.code,
        arrivalAt: f.booking.arrivalAt.toISOString(),
        partySize: f.booking.partySize,
        baseAmount: f.baseAmount,
        rateBps: f.rateBps,
        feeAmount: f.feeAmount,
      })),
    };
  }

  /** A4 statement with every booking line (Vietnamese font). */
  async pdf(id: string, restaurantId?: string): Promise<Buffer> {
    const s = await this.get(id, restaurantId);
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: s.restaurantId }, select: { name: true, address: true } });
    const doc = new PDFDocument({ size: 'A4', margin: 40 });
    const f = registerVietnameseFonts(doc);
    const chunks: Buffer[] = [];
    doc.on('data', (c: Buffer) => chunks.push(c));
    const done = new Promise<Buffer>((resolve) => doc.on('end', () => resolve(Buffer.concat(chunks))));
    const vnd = (n: number) => `${n.toLocaleString('vi-VN')} đ`;

    doc.font(f.bold).fontSize(20).text('comi', { continued: false });
    doc.font(f.regular).fontSize(10).fillColor('#666666').text(f.text('Bảng phí nền tảng'));
    doc.moveDown();
    doc.fillColor('#111111').font(f.bold).fontSize(14).text(f.text(r.name));
    doc.font(f.regular).fontSize(10).text(f.text(r.address));
    doc.moveDown();
    doc.fontSize(11).text(f.text(`Tháng: ${s.periodMonth}    Số đơn: ${s.bookingCount}    Trạng thái: ${s.status}`));
    doc.text(f.text(`Tổng doanh thu tính phí: ${vnd(s.totalBase)}`));
    doc.text(f.text(`Phí nền tảng: ${vnd(s.totalFee)}`));
    if (s.platformVoucherCredit) doc.text(f.text(`Trừ voucher comi đã tài trợ: −${vnd(s.platformVoucherCredit)}`));
    doc.font(f.bold).text(f.text(s.amountDue >= 0 ? `Cần thanh toán: ${vnd(s.amountDue)}` : `comi chuyển trả quán: ${vnd(-s.amountDue)}`));
    if (s.amountDue > 0) doc.font(f.regular).text(f.text(`Nội dung chuyển khoản: ${s.transferMemo}   ·   Hạn: ${s.dueAt?.slice(0, 10) ?? ''}`));
    doc.moveDown();

    doc.font(f.bold).fontSize(10);
    const cols = [40, 140, 260, 330, 430];
    const header = ['Mã đơn', 'Ngày', 'Khách', 'Doanh thu', 'Phí'];
    header.forEach((h, i) => doc.text(f.text(h), cols[i], doc.y, { continued: false, lineBreak: false }));
    doc.moveDown();
    doc.font(f.regular);
    for (const l of s.lines) {
      if (doc.y > 760) doc.addPage();
      const y = doc.y;
      const d = zonedParts(new Date(l.arrivalAt), TZ);
      const cells = [l.bookingCode, `${d.day}/${d.month}`, String(l.partySize), vnd(l.baseAmount), `${vnd(l.feeAmount)} (${l.rateBps / 100}%)`];
      cells.forEach((c, i) => doc.text(f.text(c), cols[i], y, { lineBreak: false }));
      doc.moveDown(0.8);
    }
    doc.end();
    return done;
  }
}

const addDaysUtc = (d: Date, n: number) => new Date(d.getTime() + n * 86_400_000);
