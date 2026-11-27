import { Injectable } from '@nestjs/common';
import { Prisma, Restaurant } from '@prisma/client';
import { randomUUID } from 'crypto';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { RedisService } from '../../common/redis';
import { addMinutes, isValidDateString, zonedParts } from '../../common/utils/time';
import { PrismaService } from '../../prisma/prisma.service';
import { choiceFits, FreeTable, pickTables } from './pick-tables';
import { buildSlots, Slot } from './slots';

type Tx = Prisma.TransactionClient;

export const HOLD_MINUTES = 5;
const ACTIVE = Prisma.sql`ARRAY['PENDING','CONFIRMED','CHECKED_IN']::text[]`;

/** Prisma DateTime columns are `timestamp(3)` holding UTC; send naive UTC strings to compare. */
export const pgTs = (d: Date) => d.toISOString().replace('Z', '');

export interface SlotAvailability {
  time: string; // ISO UTC
  local: string; // "12:15"
  available: boolean;
  diningMinutes: number;
}

export type TableState = 'available' | 'booked' | 'held' | 'mine' | 'unfit' | 'unavailable';

@Injectable()
export class AvailabilityService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly redis: RedisService,
    private readonly clock: Clock,
  ) {}

  async activeRestaurant(id: string): Promise<Restaurant> {
    const r = await this.prisma.restaurant.findFirst({ where: { id, deletedAt: null } });
    if (!r) throw notFound('Restaurant');
    if (r.status !== 'ACTIVE') throw new AppError('RESTAURANT_NOT_AVAILABLE', 'Restaurant is not taking bookings');
    return r;
  }

  /** Slots for a local date, before table checks (§8.1 steps 1–2). */
  async slotsFor(r: Restaurant, date: string, db: Tx = this.prisma): Promise<Slot[]> {
    if (!isValidDateString(date)) throw new AppError('VALIDATION_FAILED', 'date must be YYYY-MM-DD');
    const [hours, diningRules, closures] = await Promise.all([
      db.openingHours.findMany({ where: { restaurantId: r.id } }),
      db.diningRule.findMany({ where: { restaurantId: r.id } }),
      db.closure.findMany({ where: { restaurantId: r.id, endsAt: { gt: this.clock.now() } } }),
    ]);
    return buildSlots({ date, now: this.clock.now(), settings: r, hours, diningRules, closures });
  }

  /** The slot that starts exactly at `arrivalAt`, or SLOT_INVALID. */
  async slotAt(r: Restaurant, arrivalAt: Date, db: Tx = this.prisma): Promise<Slot> {
    const date = zonedParts(arrivalAt, r.timezone).date;
    const slot = (await this.slotsFor(r, date, db)).find((s) => s.start.getTime() === arrivalAt.getTime());
    if (!slot) throw new AppError('SLOT_INVALID', 'This time is not bookable', { arrivalAt: arrivalAt.toISOString() });
    return slot;
  }

  /**
   * Free tables for many time windows in ONE query (§8.1 step 4).
   * A table is busy if an active booking uses it (main or joined table) or someone else
   * holds it on the map. Returns one list per window, same order as `windows`.
   */
  async freeTables(
    restaurantId: string,
    windows: { start: Date; end: Date }[],
    opts: { ignoreHoldsOf?: string; ignoreBookingId?: string } = {},
    db: Tx = this.prisma,
  ): Promise<FreeTable[][]> {
    if (!windows.length) return [];
    const now = pgTs(this.clock.now());
    const rows = await db.$queryRaw<(FreeTable & { idx: bigint })[]>`
      WITH s AS (
        SELECT * FROM unnest(${windows.map((w) => pgTs(w.start))}::timestamp[], ${windows.map((w) => pgTs(w.end))}::timestamp[])
          WITH ORDINALITY AS s(st, en, idx)
      )
      SELECT s.idx, t.id, t.code, t."areaId", t."minSeats", t."maxSeats", t."joinGroup"
      FROM s
      JOIN "Table" t ON t."restaurantId" = ${restaurantId} AND t."isActive"
      WHERE NOT EXISTS (
          SELECT 1 FROM "Booking" b
          WHERE b."restaurantId" = ${restaurantId}
            AND b.status::text = ANY(${ACTIVE})
            AND (b."tableId" = t.id OR t.id = ANY(b."extraTableIds"))
            AND b.id <> ${opts.ignoreBookingId ?? ''}
            AND tsrange(b."arrivalAt", b."endsAt", '[)') && tsrange(s.st, s.en, '[)')
        )
        AND NOT EXISTS (
          SELECT 1 FROM "TableHold" h
          WHERE h."tableId" = t.id
            AND h."expiresAt" > ${now}::timestamp
            AND h."userId" <> ${opts.ignoreHoldsOf ?? ''}
            AND tsrange(h."startsAt", h."endsAt", '[)') && tsrange(s.st, s.en, '[)')
        )
      ORDER BY s.idx, t."maxSeats", t.code`;
    const out: FreeTable[][] = windows.map(() => []);
    for (const { idx, ...t } of rows) out[Number(idx) - 1].push(t);
    return out;
  }

  /** GET /restaurants/:id/availability — cached 30 s, invalidated on any booking/hold change. */
  async availability(restaurantId: string, date: string, partySize: number, areaId?: string): Promise<SlotAvailability[]> {
    const r = await this.activeRestaurant(restaurantId);
    if (partySize > r.maxGroupSize) throw new AppError('PARTY_TOO_LARGE', `Max ${r.maxGroupSize} people`, { max: r.maxGroupSize });
    const version = (await this.redis.client.get(`availv:${r.id}`).catch(() => null)) ?? '0';
    const key = `avail:${r.id}:${version}:${date}:${partySize}:${areaId ?? '-'}`;
    return this.redis.cached(key, 30, async () => {
      const slots = await this.slotsFor(r, date);
      const free = await this.freeTables(r.id, slots);
      return slots.map((s, i) => {
        const p = zonedParts(s.start, r.timezone);
        return {
          time: s.start.toISOString(),
          local: `${String(p.hour).padStart(2, '0')}:${String(p.minute).padStart(2, '0')}`,
          available: pickTables(free[i], partySize, areaId) !== null,
          diningMinutes: s.diningMinutes,
        };
      });
    });
  }

  async invalidate(restaurantId: string) {
    await this.redis.client.incr(`availv:${restaurantId}`).catch(() => undefined);
  }

  /** Serialize booking/hold writes per restaurant (also protects joined tables, §8.4). */
  async lockRestaurant(tx: Tx, restaurantId: string) {
    await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtext(${'booking:' + restaurantId}))`;
  }

  // ───── table map (§8.6) ─────

  async tableMap(restaurantId: string, q: { arrivalAt: Date; partySize: number; areaId?: string }, userId?: string) {
    const r = await this.activeRestaurant(restaurantId);
    const slot = await this.slotAt(r, q.arrivalAt);
    const areas = await this.prisma.tableArea.findMany({
      where: { restaurantId },
      orderBy: [{ floor: 'asc' }, { sortOrder: 'asc' }],
      select: { id: true, name: true, floor: true, gridCols: true, gridRows: true, backgroundUrl: true },
    });
    const area = q.areaId ? areas.find((a) => a.id === q.areaId) : areas[0];
    if (!area) throw notFound('Area');

    const [tables, elements, [free], mineRows] = await Promise.all([
      this.prisma.table.findMany({
        where: { restaurantId, areaId: area.id, isActive: true },
        orderBy: { code: 'asc' },
        select: {
          id: true, code: true, minSeats: true, maxSeats: true, shape: true, posX: true, posY: true, width: true,
          height: true, rotation: true, features: true, seatLayout: true, isSelectable: true, surcharge: true, joinGroup: true,
        },
      }),
      this.prisma.mapElement.findMany({ where: { areaId: area.id } }),
      this.freeTables(restaurantId, [slot], { ignoreHoldsOf: userId }),
      userId
        ? this.prisma.tableHold.findMany({
            where: { restaurantId, userId, expiresAt: { gt: this.clock.now() }, startsAt: slot.start },
            select: { tableId: true, holdId: true, expiresAt: true },
          })
        : Promise.resolve([]),
    ]);
    const freeIds = new Set(free.map((t) => t.id));
    const heldIds = new Set(
      (
        await this.prisma.tableHold.findMany({
          where: {
            restaurantId,
            expiresAt: { gt: this.clock.now() },
            startsAt: { lt: slot.end },
            endsAt: { gt: slot.start },
            ...(userId ? { userId: { not: userId } } : {}),
          },
          select: { tableId: true },
        })
      ).map((h) => h.tableId),
    );
    const mine = new Set(mineRows.map((h) => h.tableId));

    return {
      allowTableChoice: r.allowTableChoice,
      arrivalAt: slot.start.toISOString(),
      diningMinutes: slot.diningMinutes,
      areas,
      area: { ...area, elements },
      myHold: mineRows[0] ? { holdId: mineRows[0].holdId, expiresAt: mineRows[0].expiresAt, tableIds: [...mine] } : null,
      tables: tables.map((t) => {
        let state: TableState;
        if (mine.has(t.id)) state = 'mine';
        else if (!t.isSelectable || !r.allowTableChoice) state = 'unavailable';
        else if (!freeIds.has(t.id)) state = heldIds.has(t.id) ? 'held' : 'booked';
        else if (q.partySize < t.minSeats || q.partySize > t.maxSeats) state = t.joinGroup ? 'available' : 'unfit';
        else state = 'available';
        return { ...t, state };
      }),
    };
  }

  /** POST /restaurants/:id/table-holds — 5-minute hold, like an airline seat (§8.6). */
  async createHold(userId: string, restaurantId: string, dto: { tableIds: string[]; arrivalAt: Date; partySize: number }) {
    const r = await this.activeRestaurant(restaurantId);
    if (!r.allowTableChoice) throw new AppError('BAD_REQUEST', 'This restaurant assigns tables itself');
    const slot = await this.slotAt(r, dto.arrivalAt);
    const tableIds = [...new Set(dto.tableIds)];
    const tables = await this.prisma.table.findMany({
      where: { id: { in: tableIds }, restaurantId, isActive: true, isSelectable: true },
      select: { id: true, code: true, areaId: true, minSeats: true, maxSeats: true, joinGroup: true },
    });
    if (tables.length !== tableIds.length) throw notFound('Table');
    if (!choiceFits(tables, dto.partySize)) {
      throw new AppError('BAD_REQUEST', 'These tables do not fit your party', { partySize: dto.partySize });
    }

    const now = this.clock.now();
    const holdId = randomUUID();
    const expiresAt = addMinutes(now, HOLD_MINUTES);
    try {
      await this.prisma.$transaction(async (tx) => {
        await this.lockRestaurant(tx, restaurantId);
        // One hold per user per restaurant; expired holds of anyone are cleaned up.
        await tx.tableHold.deleteMany({ where: { OR: [{ restaurantId, userId }, { restaurantId, expiresAt: { lte: now } }] } });
        const [free] = await this.freeTables(restaurantId, [slot], { ignoreHoldsOf: userId }, tx);
        const freeIds = new Set(free.map((t) => t.id));
        const taken = tables.filter((t) => !freeIds.has(t.id)).map((t) => t.code);
        if (taken.length) throw new AppError('TABLE_TAKEN', 'Table was just taken', { tables: taken });
        await tx.tableHold.createMany({
          data: tables.map((t) => ({
            holdId, restaurantId, tableId: t.id, userId, partySize: dto.partySize, startsAt: slot.start, endsAt: slot.end, expiresAt,
          })),
        });
      });
    } catch (e) {
      throw mapOverlap(e, 'TABLE_TAKEN');
    }
    await this.invalidate(restaurantId);
    return { holdId, expiresAt, tableIds: tables.map((t) => t.id), arrivalAt: slot.start };
  }

  async releaseHold(userId: string, holdId: string) {
    const rows = await this.prisma.tableHold.findMany({ where: { holdId, userId }, select: { restaurantId: true } });
    if (!rows.length) return;
    await this.prisma.tableHold.deleteMany({ where: { holdId, userId } });
    await this.invalidate(rows[0].restaurantId);
  }
}

/** Exclusion-constraint violation (23P01) → stable error code. */
export function mapOverlap(e: unknown, code: 'TABLE_TAKEN' | 'SLOT_TAKEN'): unknown {
  const msg = e instanceof Error ? e.message : '';
  const pgCode = (e as { meta?: { code?: string } })?.meta?.code;
  if (pgCode === '23P01' || msg.includes('23P01') || msg.includes('exclusion constraint')) {
    return new AppError(code, 'Table was just taken');
  }
  return e;
}
