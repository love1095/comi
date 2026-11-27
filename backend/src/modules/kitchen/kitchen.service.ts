import { Injectable } from '@nestjs/common';
import { Course, KitchenStatus, Prisma } from '@prisma/client';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { zonedParts } from '../../common/utils/time';
import { JobsService, QUEUES } from '../../jobs/queues';
import { PrismaService } from '../../prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';
import { assertKitchenTransition, fireTimes, kitchenCapacityProblem } from './kitchen.state';

type Tx = Prisma.TransactionClient;

const ITEM_FOR_KITCHEN = {
  order: {
    select: {
      booking: {
        select: {
          id: true,
          code: true,
          userId: true,
          restaurantId: true,
          partySize: true,
          arrivalAt: true,
          status: true,
          table: { select: { code: true } },
        },
      },
    },
  },
} satisfies Prisma.OrderItemInclude;

type KitchenRow = Prisma.OrderItemGetPayload<{ include: typeof ITEM_FOR_KITCHEN }>;

/** One dish line as the kitchen screen shows it. */
export function kitchenItem(i: KitchenRow) {
  const b = i.order.booking;
  return {
    id: i.id,
    bookingId: b.id,
    bookingCode: b.code,
    tableCode: b.table?.code ?? null,
    partySize: b.partySize,
    arrivalAt: b.arrivalAt.toISOString(),
    guestArrived: b.status === 'CHECKED_IN',
    nameSnapshot: i.nameSnapshot,
    quantity: i.quantity,
    optionsSnapshot: i.optionsSnapshot as { group: string; option: string; priceDelta: number }[],
    note: i.note,
    course: i.course,
    prepMinutes: i.prepMinutes,
    kitchenStatus: i.kitchenStatus,
    round: i.round,
    scheduledStartAt: i.scheduledStartAt?.toISOString() ?? null,
    releasedAt: i.releasedAt?.toISOString() ?? null,
    startedAt: i.startedAt?.toISOString() ?? null,
    readyAt: i.readyAt?.toISOString() ?? null,
  };
}

/**
 * Kitchen queue (§7). Shared by the API and the worker: no HTTP-only dependencies.
 * Every method is safe to run twice (jobs retry, §20).
 */
@Injectable()
export class KitchenService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly clock: Clock,
    private readonly jobs: JobsService,
    private readonly audit: AuditService,
    private readonly realtime: RealtimeService,
  ) {}

  /**
   * (Re)compute fire times for a booking's pre-ordered dishes in `statuses` (§7.1–7.2).
   * `release: false` only writes the planned times (COD before check-in: items stay HOLD,
   * but the plan counts toward kitchen capacity and shows under "Upcoming").
   */
  async planBooking(bookingId: string, p: { arrival: Date; statuses: KitchenStatus[]; release: boolean; courses?: Course[] }, db?: Tx) {
    const run = async (tx: Tx) => {
      const b = await tx.booking.findUnique({
        where: { id: bookingId },
        select: { id: true, restaurantId: true, serveStyle: true, order: { select: { items: true } } },
      });
      if (!b?.order) return { queued: 0, scheduled: [] as Date[], restaurantId: b?.restaurantId };
      const items = b.order.items.filter((i) => p.statuses.includes(i.kitchenStatus) && (!p.courses || p.courses.includes(i.course)));
      const now = this.clock.now();
      const times = fireTimes(items, { arrival: p.arrival, serveStyle: b.serveStyle, now });
      let queued = 0;
      const scheduled = new Set<number>();
      for (const i of items) {
        const at = times.get(i.id)!;
        const due = at.getTime() <= now.getTime();
        const to: KitchenStatus = !p.release ? i.kitchenStatus : due ? 'QUEUED' : 'SCHEDULED';
        const { count } = await tx.orderItem.updateMany({
          where: { id: i.id, kitchenStatus: i.kitchenStatus },
          data: { kitchenStatus: to, scheduledStartAt: at, ...(to === 'QUEUED' ? { releasedAt: now } : {}) },
        });
        if (!count || !p.release) continue;
        if (to === 'QUEUED') queued++;
        else scheduled.add(at.getTime());
      }
      return { queued, scheduled: [...scheduled].map((t) => new Date(t)), restaurantId: b.restaurantId };
    };
    const res = db ? await run(db) : await this.prisma.$transaction(run);
    if (p.release) await this.afterPlan(bookingId, res);
    return res;
  }

  private async afterPlan(bookingId: string, res: { queued: number; scheduled: Date[]; restaurantId?: string }) {
    const now = this.clock.now().getTime();
    for (const at of res.scheduled) {
      await this.jobs.add(QUEUES.KITCHEN, 'kitchen-release', { bookingId }, { jobId: `krel:${bookingId}:${at.getTime()}`, delay: Math.max(0, at.getTime() - now) });
    }
    if (res.restaurantId) {
      if (res.queued) this.realtime.toKitchen(res.restaurantId, 'kitchen.item_queued', { bookingId, count: res.queued });
      this.realtime.toKitchen(res.restaurantId, 'kitchen.item_updated', { bookingId });
    }
  }

  /** kitchen-release / kitchen-sweep: SCHEDULED dishes whose time has come → QUEUED. */
  async releaseDue(bookingId?: string): Promise<number> {
    const now = this.clock.now();
    const due = await this.prisma.orderItem.findMany({
      where: { kitchenStatus: 'SCHEDULED', scheduledStartAt: { lte: now }, ...(bookingId ? { order: { bookingId } } : {}) },
      select: { id: true, order: { select: { bookingId: true, booking: { select: { restaurantId: true } } } } },
      take: 500,
    });
    if (!due.length) return 0;
    const { count } = await this.prisma.orderItem.updateMany({
      where: { id: { in: due.map((d) => d.id) }, kitchenStatus: 'SCHEDULED' },
      data: { kitchenStatus: 'QUEUED', releasedAt: now },
    });
    const byRestaurant = new Map<string, Set<string>>();
    for (const d of due) {
      const set = byRestaurant.get(d.order.booking.restaurantId) ?? new Set();
      set.add(d.order.bookingId);
      byRestaurant.set(d.order.booking.restaurantId, set);
    }
    for (const [rid, bookings] of byRestaurant) {
      this.realtime.toKitchen(rid, 'kitchen.item_queued', { bookingIds: [...bookings], count: due.length });
    }
    return count;
  }

  /** GET /restaurant/kitchen/queue — active list + upcoming (§7.3). */
  async queue(restaurantId: string) {
    const now = this.clock.now();
    const inRestaurant = { order: { booking: { restaurantId } } } satisfies Prisma.OrderItemWhereInput;
    const [active, ready, upcoming] = await Promise.all([
      this.prisma.orderItem.findMany({ where: { ...inRestaurant, kitchenStatus: { in: ['QUEUED', 'COOKING'] } }, include: ITEM_FOR_KITCHEN }),
      this.prisma.orderItem.findMany({
        where: { ...inRestaurant, kitchenStatus: 'READY' },
        include: ITEM_FOR_KITCHEN,
        orderBy: { readyAt: 'asc' },
        take: 100,
      }),
      this.prisma.orderItem.findMany({
        where: {
          ...inRestaurant,
          OR: [
            { kitchenStatus: 'SCHEDULED', scheduledStartAt: { lte: new Date(now.getTime() + 2 * 3_600_000) } },
            {
              kitchenStatus: 'HOLD',
              order: { booking: { restaurantId, status: { in: ['CONFIRMED', 'CHECKED_IN'] }, arrivalAt: { lte: new Date(now.getTime() + 3 * 3_600_000) } } },
            },
          ],
        },
        include: ITEM_FOR_KITCHEN,
        orderBy: [{ scheduledStartAt: 'asc' }],
        take: 200,
      }),
    ]);
    const ts = (d: Date | null) => d?.getTime() ?? Number.MAX_SAFE_INTEGER;
    active.sort(
      (a, b) =>
        (a.kitchenStatus === 'COOKING' ? 0 : 1) - (b.kitchenStatus === 'COOKING' ? 0 : 1) ||
        ts(a.scheduledStartAt) - ts(b.scheduledStartAt) ||
        ts(a.releasedAt) - ts(b.releasedAt),
    );
    return { now: now.toISOString(), active: active.map(kitchenItem), ready: ready.map(kitchenItem), upcoming: upcoming.map(kitchenItem) };
  }

  /** Cook / waiter taps: QUEUED → COOKING → READY → SERVED (and COOKING → QUEUED to undo). */
  async setStatus(restaurantId: string, staffId: string, itemId: string, to: KitchenStatus) {
    const item = await this.prisma.orderItem.findFirst({ where: { id: itemId, order: { booking: { restaurantId } } }, include: ITEM_FOR_KITCHEN });
    if (!item) throw notFound('Dish');
    assertKitchenTransition(item.kitchenStatus, to);
    const now = this.clock.now();
    const stamps: Prisma.OrderItemUpdateManyMutationInput =
      to === 'COOKING' ? { startedAt: now } : to === 'READY' ? { readyAt: now } : to === 'SERVED' ? { servedAt: now } : to === 'QUEUED' ? { startedAt: null } : {};
    const updated = await this.prisma.$transaction(async (tx) => {
      const { count } = await tx.orderItem.updateMany({ where: { id: itemId, kitchenStatus: item.kitchenStatus }, data: { kitchenStatus: to, ...stamps } });
      if (!count) throw new AppError('CONFLICT', 'Dish changed on another screen — reload');
      await this.audit.log(
        { actorType: 'STAFF', actorId: staffId, action: `kitchen.${to.toLowerCase()}`, entity: 'OrderItem', entityId: itemId, data: { from: item.kitchenStatus } },
        tx,
      );
      return tx.orderItem.findUniqueOrThrow({ where: { id: itemId }, include: ITEM_FOR_KITCHEN });
    });
    const b = item.order.booking;
    this.realtime.toKitchen(restaurantId, 'kitchen.item_updated', { itemId, bookingId: b.id, status: to });
    this.realtime.toRestaurant(restaurantId, 'kitchen.item_updated', { itemId, bookingId: b.id, status: to });
    if (to === 'COOKING' || to === 'READY' || to === 'SERVED') {
      this.realtime.toUser(b.userId, 'order.item_status', { bookingId: b.id, itemId, status: to });
    }
    return kitchenItem(updated);
  }

  /** "Fire dessert" / "Start now": a course (or everything) waiting for this booking goes to the queue now. */
  async fire(restaurantId: string, staffId: string, bookingId: string, course?: Course) {
    const b = await this.prisma.booking.findFirst({ where: { id: bookingId, restaurantId }, select: { id: true, status: true } });
    if (!b) throw notFound('Booking');
    if (b.status !== 'CONFIRMED' && b.status !== 'CHECKED_IN') throw new AppError('INVALID_STATUS', 'Booking is not active');
    const now = this.clock.now();
    const { count } = await this.prisma.orderItem.updateMany({
      where: { order: { bookingId }, kitchenStatus: { in: ['HOLD', 'SCHEDULED'] }, ...(course ? { course } : {}) },
      data: { kitchenStatus: 'QUEUED', releasedAt: now, scheduledStartAt: now },
    });
    if (count) {
      await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'kitchen.fire', entity: 'Booking', entityId: bookingId, data: { course: course ?? 'ALL', count } });
      this.realtime.toKitchen(restaurantId, 'kitchen.item_queued', { bookingId, count });
    }
    return { queued: count };
  }

  /** Kitchen capacity check for a new pre-order (§7.6). Throws KITCHEN_FULL. */
  async assertCapacity(
    restaurant: { id: string; timezone: string },
    items: { course: Course; prepMinutes: number; quantity: number }[],
    p: { arrival: Date; serveStyle: 'BY_COURSE' | 'ALL_TOGETHER' },
    db: Tx | PrismaService = this.prisma,
  ) {
    if (!items.length) return;
    const rules = await db.kitchenCapacityRule.findMany({ where: { restaurantId: restaurant.id } });
    if (!rules.length) return;
    const keyed = items.map((i, n) => ({ ...i, id: String(n) }));
    const times = fireTimes(keyed, { ...p, now: new Date(0) });
    const fire = keyed.map((i) => ({ at: times.get(i.id)!, quantity: i.quantity }));
    const counts = new Map<string, number>();
    for (const f of fire) {
      for (const r of rules) {
        const size = r.windowMinutes * 60_000;
        const start = Math.floor(f.at.getTime() / size) * size;
        const key = `${start}|${r.windowMinutes}`;
        if (counts.has(key)) continue;
        const agg = await db.orderItem.aggregate({
          _sum: { quantity: true },
          where: {
            order: { booking: { restaurantId: restaurant.id } },
            kitchenStatus: { notIn: ['CANCELLED', 'SERVED'] },
            scheduledStartAt: { gte: new Date(start), lt: new Date(start + size) },
          },
        });
        counts.set(key, agg._sum.quantity ?? 0);
      }
    }
    const problem = kitchenCapacityProblem(fire, rules, (ws, wm) => counts.get(`${ws.getTime()}|${wm}`) ?? 0, (d) => zonedParts(d, restaurant.timezone));
    if (problem) {
      throw new AppError('KITCHEN_FULL', 'The kitchen is fully booked for pre-orders at this time — book the table only or pick another time', {
        windowStart: problem.windowStart.toISOString(),
      });
    }
  }
}
