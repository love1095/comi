import { Injectable } from '@nestjs/common';
import { BookingStatus, Prisma } from '@prisma/client';
import { randomInt } from 'crypto';
import { ActorType, AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { addMinutes, zonedMidnight, addDays } from '../../common/utils/time';
import { JobsService, QUEUES } from '../../jobs/queues';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService, mapOverlap } from '../availability/availability.service';
import { choiceFits, pickTables } from '../availability/pick-tables';
import { ACTIVE_STATUSES, assertTransition, noShowDeadline } from './booking.state';
import { CreateBookingDto, MyBookingsQuery, RestaurantBookingsQuery } from './bookings.dto';
import { priceCart } from './pricing';
import { KitchenService } from '../kitchen/kitchen.service';
import { RealtimeService } from '../realtime/realtime.service';
import { FeesService } from '../fees/fees.service';
import { PaymentsService } from '../payments/payments.service';

type Tx = Prisma.TransactionClient;

const APPROVAL_TIMEOUT_MS = 2 * 60 * 60 * 1000; // §8.4: large group not approved in 2 h → cancelled
const CODE_ALPHABET = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'; // no 0/O, 1/I/L

export const bookingCode = () => 'CM-' + Array.from({ length: 5 }, () => CODE_ALPHABET[randomInt(CODE_ALPHABET.length)]).join('');

export const BOOKING_INCLUDE = {
  restaurant: { select: { id: true, slug: true, name: true, address: true, phone: true, coverPhotoUrl: true, timezone: true } },
  table: { select: { id: true, code: true, areaId: true } },
  order: { include: { items: { orderBy: [{ round: 'asc' }, { course: 'asc' }] } } },
  payments: {
    orderBy: { createdAt: 'desc' },
    take: 10,
    select: { id: true, amount: true, status: true, purpose: true, guestId: true, checkoutUrl: true, qrCode: true, expiresAt: true, paidAt: true, refundedAmount: true },
  },
  refunds: { orderBy: { createdAt: 'desc' }, select: { id: true, amount: true, status: true, reason: true, createdAt: true, doneAt: true } },
} satisfies Prisma.BookingInclude;

@Injectable()
export class BookingsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly availability: AvailabilityService,
    private readonly audit: AuditService,
    private readonly jobs: JobsService,
    private readonly clock: Clock,
    private readonly kitchen: KitchenService,
    private readonly realtime: RealtimeService,
    private readonly fees: FeesService,
    private readonly payments: PaymentsService,
  ) {}

  /** POST /bookings (§8.2). Pay-at-restaurant (COD) only until payments arrive in Phase 4. */
  async create(userId: string, dto: CreateBookingDto) {
    const now = this.clock.now();
    const arrivalAt = new Date(dto.arrivalAt);
    const [user, r] = await Promise.all([
      this.prisma.user.findUniqueOrThrow({ where: { id: userId } }),
      this.availability.activeRestaurant(dto.restaurantId),
    ]);

    // 1–3. who and how
    if (user.status !== 'ACTIVE') throw new AppError('USER_BLOCKED');
    const prepaid = dto.paymentMode === 'PREPAID';
    if (prepaid && !(await this.payments.prepaidAvailable(r.id))) {
      throw new AppError('PAYMENT_NOT_CONNECTED', 'This restaurant does not take online payments yet — choose pay at restaurant');
    }
    if (!prepaid && user.mustPrepay) throw new AppError('PREPAY_REQUIRED', 'Too many no-shows: this account must prepay');
    if (!prepaid && !r.allowCod) throw new AppError('COD_NOT_ALLOWED');
    if (prepaid && !dto.items?.length) throw new AppError('NOTHING_TO_PAY', 'Prepay needs at least one dish — or choose pay at restaurant');
    if (dto.partySize > r.maxGroupSize) throw new AppError('PARTY_TOO_LARGE', `Max ${r.maxGroupSize} people`, { max: r.maxGroupSize });

    // 4. prices are always computed here
    const lines = dto.items ?? [];
    const menuItems = lines.length
      ? await this.prisma.menuItem.findMany({
          where: { id: { in: lines.map((l) => l.menuItemId) }, restaurantId: r.id },
          include: { optionGroups: { include: { options: true } } },
        })
      : [];
    const cart = priceCart(lines, new Map(menuItems.map((m) => [m.id, m])), {
      hoursUntilArrival: (arrivalAt.getTime() - now.getTime()) / 3_600_000,
    });
    if (cart.hasAlcohol && !dto.ageConfirmed) {
      throw new AppError('AGE_CONFIRMATION_REQUIRED', 'Confirm you are 18 or older to order alcohol');
    }

    const needsApproval = dto.partySize > r.confirmGroupsOver;

    let booking;
    try {
      booking = await this.prisma.$transaction(async (tx) => {
        await this.availability.lockRestaurant(tx, r.id);
        const slot = await this.availability.slotAt(r, arrivalAt, tx);
        const tableIds = await this.chooseTables(tx, { userId, restaurantId: r.id, slot, partySize: dto.partySize, areaId: dto.areaId, holdId: dto.holdId });

        // §7.6: too many pre-ordered dishes starting in the same kitchen window → KITCHEN_FULL.
        await this.kitchen.assertCapacity(r, cart.lines, { arrival: slot.start, serveStyle: dto.serveStyle ?? 'BY_COURSE' }, tx);
        const created = await tx.booking.create({
          data: {
            code: await this.uniqueCode(tx),
            restaurantId: r.id,
            userId,
            tableId: tableIds[0],
            extraTableIds: tableIds.slice(1),
            areaId: dto.areaId,
            partySize: dto.partySize,
            arrivalAt: slot.start,
            endsAt: slot.end,
            paymentMode: prepaid ? 'PREPAID' : 'COD',
            serveStyle: dto.serveStyle ?? 'BY_COURSE',
            // COD is confirmed now; prepaid waits for the payment (§10.3); big groups wait for approval.
            status: needsApproval || prepaid ? 'PENDING' : 'CONFIRMED',
            needsApproval,
            note: dto.note,
            occasion: dto.occasion,
            ageConfirmedAt: cart.hasAlcohol ? now : null,
            order: cart.lines.length
              ? {
                  create: {
                    subtotal: cart.subtotal,
                    total: cart.subtotal,
                    status: 'PLACED',
                    items: {
                      create: cart.lines.map(({ isAlcohol: _a, ...l }) => ({
                        ...l,
                        optionsSnapshot: l.optionsSnapshot as Prisma.InputJsonValue,
                        kitchenStatus: 'HOLD', // COD: cooking starts at check-in (R5)
                      })),
                    },
                  },
                }
              : undefined,
          },
          include: BOOKING_INCLUDE,
        });
        // COD: dishes stay HOLD until check-in, but keep the planned fire times (capacity + "Upcoming" list).
        if (cart.lines.length) await this.kitchen.planBooking(created.id, { arrival: slot.start, statuses: ['HOLD'], release: false }, tx);
        if (dto.holdId) await tx.tableHold.deleteMany({ where: { holdId: dto.holdId, userId } });
        await this.audit.log(
          { actorType: 'USER', actorId: userId, action: 'booking.create', entity: 'Booking', entityId: created.id, data: { tableIds, total: cart.subtotal } },
          tx,
        );
        return created;
      });
    } catch (e) {
      throw mapOverlap(e, 'SLOT_TAKEN');
    }

    await this.availability.invalidate(r.id);
    if (prepaid && !needsApproval) await this.payments.schedulePaymentTimeout(booking.id);
    if (needsApproval) {
      await this.jobs.add(QUEUES.BOOKING, 'group-approval-timeout', { bookingId: booking.id }, {
        jobId: `approval:${booking.id}`,
        delay: APPROVAL_TIMEOUT_MS,
      });
    }
    if (booking.status === 'CONFIRMED') await this.scheduleNoShow(booking.id);
    await this.fees.ensurePlans(r.id, now); // §11.2: first order starts the launch fee plans
    this.realtime.toRestaurant(r.id, 'booking.created', { bookingId: booking.id, status: booking.status, arrivalAt: booking.arrivalAt.toISOString() });
    // TODO(phase2/push): push to staff (§19.2).
    return booking;
  }

  /** Hold from the table map, or the smallest free table(s) that fit (§8.2 step 6). */
  private async chooseTables(
    tx: Tx,
    p: { userId: string; restaurantId: string; slot: { start: Date; end: Date }; partySize: number; areaId?: string; holdId?: string },
  ): Promise<string[]> {
    const [free] = await this.availability.freeTables(p.restaurantId, [p.slot], { ignoreHoldsOf: p.userId }, tx);
    if (p.holdId) {
      const hold = await tx.tableHold.findMany({ where: { holdId: p.holdId, userId: p.userId, restaurantId: p.restaurantId } });
      const now = this.clock.now();
      if (!hold.length || hold.some((h) => h.expiresAt <= now || h.startsAt.getTime() !== p.slot.start.getTime())) {
        throw new AppError('HOLD_INVALID', 'Your table hold expired — pick a table again');
      }
      const chosen = free.filter((t) => hold.some((h) => h.tableId === t.id));
      if (chosen.length !== hold.length) throw new AppError('TABLE_TAKEN', 'Table was just taken');
      if (!choiceFits(chosen, p.partySize)) throw new AppError('BAD_REQUEST', 'Held tables do not fit your party');
      const main = [...chosen].sort((a, b) => b.maxSeats - a.maxSeats)[0];
      return [main.id, ...chosen.filter((t) => t.id !== main.id).map((t) => t.id)];
    }
    const pick = pickTables(free, p.partySize, p.areaId);
    if (!pick) throw new AppError('SLOT_TAKEN', 'No table left at this time — try another time');
    return pick.tableIds;
  }

  private async uniqueCode(tx: Tx): Promise<string> {
    for (let i = 0; i < 5; i++) {
      const code = bookingCode();
      if (!(await tx.booking.findUnique({ where: { code }, select: { id: true } }))) return code;
    }
    throw new AppError('INTERNAL', 'Could not allocate a booking code');
  }

  // ───── customer reads ─────

  async listMine(userId: string, q: MyBookingsQuery) {
    const now = this.clock.now();
    const upcoming = q.status !== 'past';
    const limit = q.limit ?? 20;
    const rows = await this.prisma.booking.findMany({
      where: upcoming
        ? { userId, status: { in: ACTIVE_STATUSES }, endsAt: { gte: now } }
        : { userId, OR: [{ status: { notIn: ACTIVE_STATUSES } }, { endsAt: { lt: now } }] },
      orderBy: [{ arrivalAt: upcoming ? 'asc' : 'desc' }, { id: 'asc' }],
      take: limit + 1,
      ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
      include: BOOKING_INCLUDE,
    });
    return { items: rows.slice(0, limit), nextCursor: rows.length > limit ? rows[limit - 1].id : null };
  }

  async getMine(userId: string, id: string) {
    const b = await this.prisma.booking.findFirst({ where: { id, userId }, include: BOOKING_INCLUDE });
    if (!b) throw notFound('Booking'); // same error for "not yours" — never leak existence
    return b;
  }

  /** "Order again": the old cart with today's prices; unavailable dishes listed separately. */
  async reorder(userId: string, id: string) {
    const b = await this.getMine(userId, id);
    const old = b.order?.items.filter((i) => i.round === 0) ?? [];
    const current = await this.prisma.menuItem.findMany({
      where: { id: { in: old.map((i) => i.menuItemId) }, deletedAt: null },
      select: { id: true, name: true, price: true, isAvailable: true, isPreorderable: true },
    });
    const byId = new Map(current.map((m) => [m.id, m]));
    const items = [];
    const unavailable = [];
    for (const i of old) {
      const m = byId.get(i.menuItemId);
      if (m && m.isAvailable && m.isPreorderable) items.push({ menuItemId: m.id, name: m.name, price: m.price, quantity: i.quantity, note: i.note });
      else unavailable.push({ menuItemId: i.menuItemId, name: i.nameSnapshot });
    }
    return { restaurant: b.restaurant, partySize: b.partySize, serveStyle: b.serveStyle, items, unavailable };
  }

  // ───── status changes ─────

  /** Customer cancel (§8.3): until arrivalAt − cancelCutoffMinutes. */
  async cancelByCustomer(userId: string, id: string, reason?: string) {
    const b = await this.prisma.booking.findFirst({ where: { id, userId }, include: { restaurant: true } });
    if (!b) throw notFound('Booking');
    if (this.clock.now() > addMinutes(b.arrivalAt, -b.restaurant.cancelCutoffMinutes)) {
      throw new AppError('CANCEL_TOO_LATE', `Cancel at least ${b.restaurant.cancelCutoffMinutes} minutes before arrival — call the restaurant`, {
        cutoffMinutes: b.restaurant.cancelCutoffMinutes,
      });
    }
    return this.cancel(b.id, { actorType: 'USER', actorId: userId, cancelledBy: 'USER', reason });
  }

  async cancel(id: string, p: { actorType: ActorType; actorId?: string; cancelledBy: 'USER' | 'RESTAURANT' | 'SYSTEM'; reason?: string }) {
    const result = await this.changeStatus(id, 'CANCELLED', { actorType: p.actorType, actorId: p.actorId }, {
      cancelledAt: this.clock.now(),
      cancelledBy: p.cancelledBy,
      cancelReason: p.reason,
    });
    await this.jobs.remove(QUEUES.BOOKING, `approval:${id}`);
    await this.jobs.remove(QUEUES.BOOKING, `noshow:${id}`);
    await this.jobs.remove(QUEUES.BOOKING, `paytimeout:${id}`);
    // Prepaid: full refund of what was paid (minimum refund before prepaid goes live).
    if (result.paymentMode === 'PREPAID') await this.payments.refundOnCancel(id, p.cancelledBy);
    await this.fees.finalize(id); // waive a pending fee
    return result;
  }

  /** Large group approved by the restaurant (§8.4). COD → CONFIRMED. */
  async approve(restaurantId: string, staffId: string, id: string) {
    const b = await this.forRestaurant(restaurantId, id);
    if (!b.needsApproval || b.status !== 'PENDING') throw new AppError('INVALID_STATUS', 'Booking is not waiting for approval');
    if (b.paymentMode === 'PREPAID') {
      // Approved big group still has to pay: stays PENDING, the payment clock starts now.
      await this.prisma.booking.updateMany({ where: { id, status: 'PENDING' }, data: { needsApproval: false } });
      await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'booking.approved', entity: 'Booking', entityId: id, data: { awaiting: 'payment' } });
      await this.jobs.remove(QUEUES.BOOKING, `approval:${id}`);
      await this.payments.schedulePaymentTimeout(id);
      const after = await this.prisma.booking.findUniqueOrThrow({ where: { id }, include: BOOKING_INCLUDE });
      this.realtime.toUser(after.userId, 'booking.status', { bookingId: id, status: 'PENDING', approved: true });
      return after;
    }
    const result = await this.changeStatus(id, 'CONFIRMED', { actorType: 'STAFF', actorId: staffId }, { needsApproval: false });
    await this.jobs.remove(QUEUES.BOOKING, `approval:${id}`);
    await this.scheduleNoShow(id);
    return result;
  }

  async cancelByRestaurant(restaurantId: string, staffId: string, id: string, reason: string) {
    await this.forRestaurant(restaurantId, id);
    return this.cancel(id, { actorType: 'STAFF', actorId: staffId, cancelledBy: 'RESTAURANT', reason });
    // TODO(phase2/push): notify the customer.
  }

  /** Staff moves a booking to another table (broken table, walk-in shuffle — §8.6). */
  async moveTable(restaurantId: string, staffId: string, id: string, tableId: string) {
    const b = await this.forRestaurant(restaurantId, id);
    if (!ACTIVE_STATUSES.includes(b.status)) throw new AppError('INVALID_STATUS', 'Booking is not active');
    const table = await this.prisma.table.findFirst({ where: { id: tableId, restaurantId, isActive: true } });
    if (!table) throw notFound('Table');
    try {
      await this.prisma.$transaction(async (tx) => {
        await this.availability.lockRestaurant(tx, restaurantId);
        const [free] = await this.availability.freeTables(restaurantId, [{ start: b.arrivalAt, end: b.endsAt }], { ignoreBookingId: b.id }, tx);
        if (!free.some((t) => t.id === tableId)) throw new AppError('TABLE_TAKEN', `Table ${table.code} is busy at that time`);
        await tx.booking.update({ where: { id }, data: { tableId, extraTableIds: b.extraTableIds.filter((x) => x !== tableId) } });
        await this.audit.log(
          { actorType: 'STAFF', actorId: staffId, action: 'booking.move_table', entity: 'Booking', entityId: id, data: { from: b.tableId, to: tableId } },
          tx,
        );
      });
    } catch (e) {
      throw mapOverlap(e, 'TABLE_TAKEN');
    }
    await this.availability.invalidate(restaurantId);
    // TODO(phase2/push): "Your table changed to A3".
    return this.prisma.booking.findUniqueOrThrow({ where: { id }, include: BOOKING_INCLUDE });
  }

  /** Schedule (or move) the no-show-check job (§9.3). The job re-checks the deadline, so a stale one does nothing. */
  async scheduleNoShow(id: string) {
    const b = await this.prisma.booking.findUnique({
      where: { id },
      select: { status: true, arrivalAt: true, etaAt: true, graceExtendedAt: true, restaurant: { select: { graceMinutes: true } } },
    });
    if (!b || b.status !== 'CONFIRMED') return;
    const at = noShowDeadline(b, b.restaurant.graceMinutes);
    await this.jobs.remove(QUEUES.BOOKING, `noshow:${id}`);
    await this.jobs.add(QUEUES.BOOKING, 'no-show-check', { bookingId: id }, { jobId: `noshow:${id}`, delay: Math.max(0, at.getTime() - this.clock.now().getTime()) });
  }

  /** The only way to change booking status: state check + optimistic update + audit + events. */
  async changeStatus(
    id: string,
    to: BookingStatus,
    actor: { actorType: ActorType; actorId?: string },
    extra: Prisma.BookingUpdateManyMutationInput = {},
  ) {
    await this.prisma.$transaction(async (tx) => {
      const b = await tx.booking.findUniqueOrThrow({ where: { id } });
      assertTransition(b.status, to);
      const { count } = await tx.booking.updateMany({ where: { id, status: b.status }, data: { ...extra, status: to } });
      if (!count) throw new AppError('CONFLICT', 'Booking changed at the same time — reload');
      if (to === 'CANCELLED') {
        await tx.order.updateMany({ where: { bookingId: id }, data: { status: 'CANCELLED' } });
        await tx.orderItem.updateMany({
          where: { order: { bookingId: id }, kitchenStatus: { in: ['HOLD', 'SCHEDULED', 'QUEUED'] } },
          data: { kitchenStatus: 'CANCELLED' },
        });
      }
      await this.audit.log(
        { actorType: actor.actorType, actorId: actor.actorId, action: `booking.${to.toLowerCase()}`, entity: 'Booking', entityId: id, data: { from: b.status, ...extra } },
        tx,
      );
      return b.restaurantId;
    }).then((rid) => this.availability.invalidate(rid));
    const after = await this.prisma.booking.findUniqueOrThrow({ where: { id }, include: BOOKING_INCLUDE });
    this.realtime.toRestaurant(after.restaurantId, 'booking.updated', { bookingId: id, status: to });
    this.realtime.toUser(after.userId, 'booking.status', { bookingId: id, status: to });
    return after;
  }

  // ───── restaurant reads ─────

  /** Today board (§22.2 #3): bookings of one local day, by time. */
  async listForRestaurant(restaurantId: string, q: RestaurantBookingsQuery) {
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { timezone: true } });
    const from = zonedMidnight(q.date, r.timezone);
    const to = zonedMidnight(addDays(q.date, 1), r.timezone);
    const search = q.q?.trim();
    return this.prisma.booking.findMany({
      where: {
        restaurantId,
        arrivalAt: { gte: from, lt: to },
        ...(q.status ? { status: q.status } : {}),
        ...(search ? { OR: [{ code: { contains: search.toUpperCase() } }, { user: { phone: { contains: search } } }] } : {}),
      },
      orderBy: { arrivalAt: 'asc' },
      include: {
        table: { select: { id: true, code: true } },
        user: { select: { id: true, name: true, phone: true, noShowCount: true } },
        order: { select: { total: true, _count: { select: { items: true } } } },
      },
    });
  }

  async getForRestaurant(restaurantId: string, id: string) {
    const b = await this.prisma.booking.findFirst({
      where: { id, restaurantId },
      include: { ...BOOKING_INCLUDE, user: { select: { id: true, name: true, phone: true, noShowCount: true } } },
    });
    if (!b) throw notFound('Booking');
    return b;
  }

  private async forRestaurant(restaurantId: string, id: string) {
    const b = await this.prisma.booking.findFirst({ where: { id, restaurantId } });
    if (!b) throw notFound('Booking');
    return b;
  }
}
