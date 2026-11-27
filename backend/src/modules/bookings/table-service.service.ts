import { Inject, Injectable } from '@nestjs/common';
import { Prisma, ServiceType } from '@prisma/client';
import { ActorType, AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { addMinutes } from '../../common/utils/time';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { JobsService, QUEUES } from '../../jobs/queues';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService } from '../availability/availability.service';
import { KitchenService } from '../kitchen/kitchen.service';
import { travelMinutes } from '../kitchen/kitchen.state';
import { RealtimeService } from '../realtime/realtime.service';
import { entranceQrSignature, parseQrPayload, tableQrSignature, verifySignature } from '../tables/qr';
import { noShowDeadline } from './booking.state';
import { BOOKING_INCLUDE, BookingsService } from './bookings.service';
import { CartLine, priceCart } from './pricing';

const CHECK_IN_EARLY_MINUTES = 60; // §9.2: from arrivalAt − 60 min
const DEPART_EARLY_MINUTES = 45; // §7.5
const ETA_REPLAN_MINUTES = 3;

type Actor = { kind: 'user'; userId: string } | { kind: 'staff'; staffId: string };

const actorOf = (a: Actor): { actorType: ActorType; actorId: string } =>
  a.kind === 'user' ? { actorType: 'USER', actorId: a.userId } : { actorType: 'STAFF', actorId: a.staffId };

/**
 * At the restaurant (§7.5, §8.5, §9): check-in, "I'm leaving now", ordering more at the
 * table, the live bill, calling staff, closing the bill.
 */
@Injectable()
export class TableServiceService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly bookings: BookingsService,
    private readonly kitchen: KitchenService,
    private readonly availability: AvailabilityService,
    private readonly realtime: RealtimeService,
    private readonly audit: AuditService,
    private readonly jobs: JobsService,
    private readonly clock: Clock,
    @Inject(ENV) private readonly env: Env,
  ) {}

  private async mine(userId: string, id: string) {
    const b = await this.prisma.booking.findFirst({ where: { id, userId }, include: { restaurant: true, table: true } });
    if (!b) throw notFound('Booking');
    return b;
  }

  private async ofRestaurant(restaurantId: string, id: string) {
    const b = await this.prisma.booking.findFirst({ where: { id, restaurantId }, include: { restaurant: true, table: true } });
    if (!b) throw notFound('Booking');
    return b;
  }

  // ───── check-in (§9.2) ─────

  /** Guest scans the table or entrance QR. */
  async checkInByQr(userId: string, id: string, qrPayload: string) {
    const b = await this.mine(userId, id);
    if (b.status === 'CHECKED_IN') return this.prisma.booking.findUniqueOrThrow({ where: { id }, include: BOOKING_INCLUDE });
    if (b.status !== 'CONFIRMED') throw new AppError('INVALID_STATUS', 'Booking is not confirmed');

    const qr = parseQrPayload(qrPayload);
    if (!qr || qr.slug !== b.restaurant.slug) throw new AppError('QR_INVALID', 'This QR code is not for this restaurant');
    let scannedTableId: string | undefined;
    if (qr.tableCode) {
      const table = await this.prisma.table.findFirst({ where: { restaurantId: b.restaurantId, code: qr.tableCode.toUpperCase(), isActive: true } });
      if (!table || !verifySignature(tableQrSignature(table.qrSecret, b.restaurantId, table.id), qr.sig)) {
        throw new AppError('QR_INVALID', 'QR code is not valid — ask the staff');
      }
      scannedTableId = table.id;
    } else if (!verifySignature(entranceQrSignature(this.env.JWT_SECRET, b.restaurantId), qr.sig)) {
      throw new AppError('QR_INVALID', 'QR code is not valid — ask the staff');
    }

    const now = this.clock.now();
    if (now < addMinutes(b.arrivalAt, -CHECK_IN_EARLY_MINUTES)) {
      throw new AppError('CHECK_IN_TOO_EARLY', `Check-in opens ${CHECK_IN_EARLY_MINUTES} minutes before your time`, { opensAt: addMinutes(b.arrivalAt, -CHECK_IN_EARLY_MINUTES).toISOString() });
    }
    if (now > noShowDeadline(b, b.restaurant.graceMinutes)) throw new AppError('CHECK_IN_TOO_LATE', 'Booking time has passed — ask the staff');

    // Sat at another table: take it if it is free for this booking's time, else keep the assigned one (§9.2.5).
    if (scannedTableId && scannedTableId !== b.tableId && !b.extraTableIds.length) {
      await this.prisma.$transaction(async (tx) => {
        await this.availability.lockRestaurant(tx, b.restaurantId);
        const [free] = await this.availability.freeTables(b.restaurantId, [{ start: b.arrivalAt, end: b.endsAt }], { ignoreBookingId: b.id }, tx);
        if (free.some((t) => t.id === scannedTableId)) await tx.booking.update({ where: { id }, data: { tableId: scannedTableId } });
      });
    }
    return this.checkIn(b, 'QR', { kind: 'user', userId });
  }

  /** Cashier taps "Guest arrived" (booking code or phone search on the board). */
  async checkInByStaff(restaurantId: string, staffId: string, id: string) {
    const b = await this.ofRestaurant(restaurantId, id);
    if (b.status === 'CHECKED_IN') return this.bookings.getForRestaurant(restaurantId, id);
    if (b.status !== 'CONFIRMED') throw new AppError('INVALID_STATUS', 'Booking is not confirmed');
    await this.checkIn(b, 'STAFF', { kind: 'staff', staffId });
    return this.bookings.getForRestaurant(restaurantId, id);
  }

  private async checkIn(
    b: { id: string; restaurantId: string; arrivalAt: Date; restaurant: { startEarlyOnCheckIn: boolean } },
    method: 'QR' | 'STAFF',
    actor: Actor,
  ) {
    const now = this.clock.now();
    const result = await this.bookings.changeStatus(b.id, 'CHECKED_IN', actorOf(actor), { checkedInAt: now, checkInMethod: method });
    await this.jobs.remove(QUEUES.BOOKING, `noshow:${b.id}`);
    // COD dishes start now (§7.2). Early guest: start now too unless the restaurant turned that off (§7.4).
    const arrival = now < b.arrivalAt && !b.restaurant.startEarlyOnCheckIn ? b.arrivalAt : now;
    await this.kitchen.planBooking(b.id, { arrival, statuses: ['HOLD', 'SCHEDULED'], release: true, courses: ['DRINK', 'STARTER', 'MAIN', 'DESSERT'] });
    this.realtime.toRestaurant(b.restaurantId, 'booking.checked_in', { bookingId: b.id, method });
    return method === 'QR' ? this.prisma.booking.findUniqueOrThrow({ where: { id: b.id }, include: BOOKING_INCLUDE }) : result;
  }

  // ───── "I'm leaving now" (§7.5) ─────

  async depart(userId: string, id: string, lat: number, lng: number) {
    const b = await this.mine(userId, id);
    if (b.status !== 'CONFIRMED') throw new AppError('INVALID_STATUS', 'Booking is not confirmed');
    const now = this.clock.now();
    if (now < addMinutes(b.arrivalAt, -DEPART_EARLY_MINUTES)) {
      throw new AppError('DEPART_TOO_EARLY', `Tap this within ${DEPART_EARLY_MINUTES} minutes of your booking time`);
    }
    if (now > noShowDeadline(b, b.restaurant.graceMinutes)) throw new AppError('CHECK_IN_TOO_LATE', 'Booking time has passed');

    const [row] = await this.prisma.$queryRaw<{ d: number | null }[]>`
      SELECT ST_Distance(location, ST_SetSRID(ST_MakePoint(${lng}, ${lat}), 4326)::geography)::float AS d FROM "Restaurant" WHERE id = ${b.restaurantId}`;
    const minutes = row?.d == null ? 10 : travelMinutes(row.d);
    const etaAt = addMinutes(now, minutes);
    await this.prisma.booking.update({ where: { id }, data: { departedAt: now, etaAt } });

    if (Math.abs(etaAt.getTime() - b.arrivalAt.getTime()) > ETA_REPLAN_MINUTES * 60_000) {
      await this.kitchen.planBooking(id, { arrival: etaAt, statuses: ['SCHEDULED'], release: true });
    }
    if (b.paymentMode === 'COD' && b.restaurant.codStartOnDepart) {
      await this.kitchen.planBooking(id, { arrival: etaAt, statuses: ['HOLD'], release: true });
    }
    await this.bookings.scheduleNoShow(id);
    await this.audit.log({ actorType: 'USER', actorId: userId, action: 'booking.depart', entity: 'Booking', entityId: id, data: { etaAt, minutes } });
    this.realtime.toRestaurant(b.restaurantId, 'booking.eta_updated', { bookingId: id, etaAt: etaAt.toISOString() });
    return { etaAt: etaAt.toISOString(), travelMinutes: minutes };
  }

  /** "Guest is late, keep the table": +15 min once (§9.3). */
  async extendGrace(restaurantId: string, staffId: string, id: string) {
    const b = await this.ofRestaurant(restaurantId, id);
    if (b.status !== 'CONFIRMED') throw new AppError('INVALID_STATUS', 'Booking is not waiting for the guest');
    if (b.graceExtendedAt) throw new AppError('CONFLICT', 'Already extended once');
    await this.prisma.booking.update({ where: { id }, data: { graceExtendedAt: this.clock.now() } });
    await this.bookings.scheduleNoShow(id);
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'booking.extend_grace', entity: 'Booking', entityId: id });
    this.realtime.toRestaurant(restaurantId, 'booking.updated', { bookingId: id });
    return this.bookings.getForRestaurant(restaurantId, id);
  }

  // ───── ordering at the table (§8.5) ─────

  /**
   * New round of dishes for a seated booking. From staff → QUEUED at once. From the guest's
   * phone → QUEUED, or HOLD until staff confirm when `tableOrderingNeedsApproval` is on.
   */
  async addRound(actor: Actor, id: string, lines: CartLine[], ageConfirmed?: boolean, restaurantId?: string) {
    const b = actor.kind === 'user' ? await this.mine(actor.userId, id) : await this.ofRestaurant(restaurantId!, id);
    if (b.status !== 'CHECKED_IN') throw new AppError('NOT_CHECKED_IN', 'Check in at the restaurant first');
    if (actor.kind === 'user' && !b.restaurant.allowTableOrdering) throw new AppError('TABLE_ORDERING_OFF', 'Order with the staff at this restaurant');
    if (!lines.length) throw new AppError('VALIDATION_FAILED', 'Add at least one dish');

    const menu = await this.prisma.menuItem.findMany({
      where: { id: { in: lines.map((l) => l.menuItemId) }, restaurantId: b.restaurantId },
      include: { optionGroups: { include: { options: true } } },
    });
    const cart = priceCart(lines, new Map(menu.map((m) => [m.id, m])), { hoursUntilArrival: 0, atTable: true });
    if (cart.hasAlcohol && actor.kind === 'user' && !b.ageConfirmedAt && !ageConfirmed) {
      throw new AppError('AGE_CONFIRMATION_REQUIRED', 'Confirm you are 18 or older to order alcohol');
    }
    const waitForStaff = actor.kind === 'user' && b.restaurant.tableOrderingNeedsApproval;
    const now = this.clock.now();

    const round = await this.prisma.$transaction(async (tx) => {
      const order =
        (await tx.order.findUnique({ where: { bookingId: id } })) ??
        (await tx.order.create({ data: { bookingId: id, subtotal: 0, total: 0, status: 'PLACED' } }));
      const last = await tx.orderItem.aggregate({ _max: { round: true }, where: { orderId: order.id } });
      const n = (last._max.round ?? 0) + 1;
      await tx.orderItem.createMany({
        data: cart.lines.map(({ isAlcohol: _a, ...l }) => ({
          ...l,
          orderId: order.id,
          optionsSnapshot: l.optionsSnapshot as Prisma.InputJsonValue,
          round: n,
          kitchenStatus: waitForStaff ? 'HOLD' : 'QUEUED',
          scheduledStartAt: now,
          releasedAt: waitForStaff ? null : now,
        })),
      });
      await tx.order.update({
        where: { id: order.id },
        data: { subtotal: { increment: cart.subtotal }, total: { increment: cart.subtotal }, status: order.status === 'CANCELLED' ? 'PLACED' : order.status },
      });
      if (cart.hasAlcohol && !b.ageConfirmedAt) await tx.booking.update({ where: { id }, data: { ageConfirmedAt: now } });
      await this.audit.log({ ...actorOf(actor), action: 'order.round_added', entity: 'Booking', entityId: id, data: { round: n, total: cart.subtotal, waitForStaff } }, tx);
      return n;
    });

    this.realtime.toRestaurant(b.restaurantId, 'order.round_added', { bookingId: id, round, needsApproval: waitForStaff });
    if (!waitForStaff) this.realtime.toKitchen(b.restaurantId, 'kitchen.item_queued', { bookingId: id, count: cart.lines.length });
    return { round, needsApproval: waitForStaff, total: cart.subtotal };
  }

  /** Staff confirm a round the guest ordered from the app. */
  async approveRound(restaurantId: string, staffId: string, id: string, round: number) {
    await this.ofRestaurant(restaurantId, id);
    const now = this.clock.now();
    const { count } = await this.prisma.orderItem.updateMany({
      where: { order: { bookingId: id }, round, kitchenStatus: 'HOLD' },
      data: { kitchenStatus: 'QUEUED', releasedAt: now, scheduledStartAt: now },
    });
    if (!count) throw new AppError('INVALID_STATUS', 'Nothing waiting in this round');
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'order.round_approved', entity: 'Booking', entityId: id, data: { round, count } });
    this.realtime.toKitchen(restaurantId, 'kitchen.item_queued', { bookingId: id, count });
    return { queued: count };
  }

  /** Live bill: every round, cancelled dishes left out (§8.5). Splitting comes in Phase 3b. */
  async bill(id: string, who: { userId: string } | { restaurantId: string }) {
    const b = await this.prisma.booking.findFirst({
      where: { id, ...('userId' in who ? { userId: who.userId } : { restaurantId: who.restaurantId }) },
      select: { id: true, code: true, status: true, finalBillAmount: true, order: { select: { items: { orderBy: [{ round: 'asc' }, { course: 'asc' }] } } } },
    });
    if (!b) throw notFound('Booking');
    const items = (b.order?.items ?? []).filter((i) => i.kitchenStatus !== 'CANCELLED');
    const rounds = [...new Set(items.map((i) => i.round))].map((round) => {
      const lines = items.filter((i) => i.round === round);
      return {
        round,
        waitingForStaff: lines.some((i) => i.round > 0 && i.kitchenStatus === 'HOLD'),
        subtotal: lines.reduce((s, i) => s + i.unitPrice * i.quantity, 0),
        items: lines.map((i) => ({
          id: i.id,
          nameSnapshot: i.nameSnapshot,
          unitPrice: i.unitPrice,
          quantity: i.quantity,
          optionsSnapshot: i.optionsSnapshot,
          note: i.note,
          course: i.course,
          kitchenStatus: i.kitchenStatus,
          round: i.round,
        })),
      };
    });
    const total = rounds.reduce((s, r) => s + r.subtotal, 0);
    return { bookingId: b.id, code: b.code, status: b.status, rounds, total, finalBillAmount: b.finalBillAmount };
  }

  /** Cashier closes the bill: CHECKED_IN → COMPLETED (§6.1). Amount defaults to the live bill. */
  async closeBill(restaurantId: string, staffId: string, id: string, finalBillAmount?: number) {
    const b = await this.ofRestaurant(restaurantId, id);
    if (b.status !== 'CHECKED_IN') throw new AppError('INVALID_STATUS', 'Guest has not checked in');
    const amount = finalBillAmount ?? (await this.bill(id, { restaurantId })).total;
    await this.bookings.changeStatus(id, 'COMPLETED', { actorType: 'STAFF', actorId: staffId }, { completedAt: this.clock.now(), finalBillAmount: amount });
    await this.prisma.order.updateMany({ where: { bookingId: id, status: { not: 'CANCELLED' } }, data: { status: 'SERVED' } });
    await this.prisma.serviceRequest.updateMany({ where: { bookingId: id, status: 'OPEN' }, data: { status: 'DONE', doneAt: this.clock.now() } });
    // TODO(phase3b): "Get home safe" ride links; TODO(phase4): fee record from finalBillAmount.
    return this.bookings.getForRestaurant(restaurantId, id);
  }

  // ───── call staff (§8.5) ─────

  async requestService(userId: string, id: string, type: ServiceType, note?: string) {
    const b = await this.mine(userId, id);
    if (b.status !== 'CHECKED_IN') throw new AppError('NOT_CHECKED_IN', 'Check in at the restaurant first');
    // Tapping "more ice" twice should not ring twice.
    const open = await this.prisma.serviceRequest.findFirst({ where: { bookingId: id, type, status: 'OPEN' } });
    if (open) return serviceDto(open, b);
    const r = await this.prisma.serviceRequest.create({ data: { bookingId: id, restaurantId: b.restaurantId, tableId: b.tableId, type, note } });
    this.realtime.toRestaurant(b.restaurantId, 'service.requested', { requestId: r.id, bookingId: id, type, tableCode: b.table?.code ?? null });
    return serviceDto(r, b);
  }

  async openRequests(restaurantId: string) {
    const rows = await this.prisma.serviceRequest.findMany({
      where: { restaurantId, status: 'OPEN' },
      orderBy: { createdAt: 'asc' },
      include: { booking: { select: { code: true, table: { select: { code: true } } } } },
      take: 200,
    });
    return rows.map((r) => serviceDto(r, r.booking));
  }

  async finishRequest(restaurantId: string, staffId: string, requestId: string) {
    const r = await this.prisma.serviceRequest.findFirst({ where: { id: requestId, restaurantId }, include: { booking: { select: { code: true, userId: true, table: { select: { code: true } } } } } });
    if (!r) throw notFound('Request');
    if (r.status !== 'DONE') {
      await this.prisma.serviceRequest.update({ where: { id: requestId }, data: { status: 'DONE', doneAt: this.clock.now() } });
      await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'service.done', entity: 'ServiceRequest', entityId: requestId });
      this.realtime.toRestaurant(restaurantId, 'service.updated', { requestId, status: 'DONE' });
      this.realtime.toUser(r.booking.userId, 'service.updated', { requestId, bookingId: r.bookingId, status: 'DONE' });
    }
    return serviceDto({ ...r, status: 'DONE', doneAt: r.doneAt ?? this.clock.now() }, r.booking);
  }
}

function serviceDto(
  r: { id: string; bookingId: string; type: ServiceType; note: string | null; status: string; createdAt: Date; doneAt: Date | null },
  b: { code: string; table: { code: string } | null },
) {
  return {
    id: r.id,
    bookingId: r.bookingId,
    bookingCode: b.code,
    tableCode: b.table?.code ?? null,
    type: r.type,
    note: r.note,
    status: r.status,
    createdAt: r.createdAt.toISOString(),
    doneAt: r.doneAt?.toISOString() ?? null,
  };
}
