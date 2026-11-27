import { Inject, Injectable } from '@nestjs/common';
import { Prisma, SplitMode } from '@prisma/client';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { addMinutes } from '../../common/utils/time';
import { randomToken, sha256 } from '../../common/utils/crypto';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { JobsService, QUEUES } from '../../jobs/queues';
import { PrismaService } from '../../prisma/prisma.service';
import { CartLine, priceCart } from '../bookings/pricing';
import { KitchenService } from '../kitchen/kitchen.service';
import { RealtimeService } from '../realtime/realtime.service';
import { splitBill } from './split';

export const DEFAULT_CUTOFF_MINUTES = 20; // §8.4: order closes arrivalAt − 20 min
const OPEN_BOOKING = ['PENDING', 'CONFIRMED'] as const;

const GROUP_INCLUDE = {
  booking: {
    select: {
      id: true,
      userId: true,
      restaurantId: true,
      status: true,
      arrivalAt: true,
      partySize: true,
      ageConfirmedAt: true,
      restaurant: { select: { id: true, slug: true, name: true, address: true, timezone: true } },
      guests: { orderBy: [{ isHost: 'desc' }, { joinedAt: 'asc' }] },
      order: { select: { items: { where: { round: 0, kitchenStatus: { not: 'CANCELLED' } }, orderBy: { id: 'asc' } } } },
    },
  },
} satisfies Prisma.GroupInviteInclude;

type InviteRow = Prisma.GroupInviteGetPayload<{ include: typeof GROUP_INCLUDE }>;

/**
 * Group orders (§8.4): one booking, a share link, everyone adds their own dishes until the
 * cutoff. Guests do not need an account — they act with the secret key from `join`.
 * Split bill + "paid in cash" (§8.5) live here too.
 */
@Injectable()
export class GroupService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly kitchen: KitchenService,
    private readonly realtime: RealtimeService,
    private readonly audit: AuditService,
    private readonly jobs: JobsService,
    private readonly clock: Clock,
    @Inject(ENV) private readonly env: Env,
  ) {}

  private link(token: string) {
    return `${this.env.APP_LINK_BASE_URL.replace(/\/$/, '')}/g/${token}`;
  }

  private isLocked(inv: { lockedAt: Date | null; expiresAt: Date }) {
    return !!inv.lockedAt || this.clock.now() >= inv.expiresAt;
  }

  /** What every member sees: guests, everybody's dishes, totals, cutoff. */
  private view(inv: InviteRow) {
    const b = inv.booking;
    const items = b.order?.items ?? [];
    const subtotal = (guestId: string | null) => items.filter((i) => i.guestId === guestId).reduce((s, i) => s + i.unitPrice * i.quantity, 0);
    return {
      token: inv.token,
      link: this.link(inv.token),
      bookingId: b.id,
      status: b.status,
      restaurant: { id: b.restaurant.id, slug: b.restaurant.slug, name: b.restaurant.name, address: b.restaurant.address },
      arrivalAt: b.arrivalAt.toISOString(),
      partySize: b.partySize,
      cutoffAt: inv.expiresAt.toISOString(),
      locked: this.isLocked(inv),
      maxGuests: inv.maxGuests,
      guests: b.guests.map((g) => ({
        id: g.id,
        displayName: g.displayName,
        isHost: g.isHost,
        subtotal: subtotal(g.id),
        amountDue: g.amountDue,
        amountPaid: g.amountPaid,
      })),
      items: items.map((i) => ({
        id: i.id,
        guestId: i.guestId,
        menuItemId: i.menuItemId,
        nameSnapshot: i.nameSnapshot,
        unitPrice: i.unitPrice,
        quantity: i.quantity,
        optionsSnapshot: i.optionsSnapshot as { group: string; option: string; priceDelta: number }[],
        note: i.note,
        course: i.course,
      })),
      total: items.reduce((s, i) => s + i.unitPrice * i.quantity, 0),
    };
  }

  private async load(token: string) {
    const inv = await this.prisma.groupInvite.findUnique({ where: { token }, include: GROUP_INCLUDE });
    if (!inv) throw notFound('Group');
    return inv;
  }

  private changed(inv: { bookingId: string; booking: { restaurantId: string } }, what: string) {
    this.realtime.toGroup(inv.bookingId, { bookingId: inv.bookingId, what });
    this.realtime.toRestaurant(inv.booking.restaurantId, 'booking.updated', { bookingId: inv.bookingId });
  }

  // ───── host ─────

  /** Turn a booking into a group order (idempotent: returns the existing link). The host gets a key too. */
  async start(userId: string, bookingId: string, p: { cutoffMinutes?: number; maxGuests?: number }) {
    const b = await this.prisma.booking.findFirst({
      where: { id: bookingId, userId },
      include: { user: { select: { name: true } }, groupInvite: true, guests: true },
    });
    if (!b) throw notFound('Booking');
    if (!OPEN_BOOKING.includes(b.status as (typeof OPEN_BOOKING)[number])) throw new AppError('INVALID_STATUS', 'Booking is not open');

    const hostKey = randomToken(24);
    if (b.groupInvite) {
      // Re-issue the host key (keys are stored hashed, so the old one cannot be shown again).
      await this.prisma.bookingGuest.updateMany({ where: { bookingId, isHost: true }, data: { accessKeyHash: sha256(hostKey) } });
      return { ...this.view(await this.load(b.groupInvite.token)), guestKey: hostKey, guestId: b.guests.find((g) => g.isHost)?.id ?? null };
    }

    const expiresAt = addMinutes(b.arrivalAt, -(p.cutoffMinutes ?? DEFAULT_CUTOFF_MINUTES));
    if (this.clock.now() >= expiresAt) throw new AppError('GROUP_LOCKED', 'Too close to the booking time to collect orders');
    const token = randomToken(12);
    const host = await this.prisma.$transaction(async (tx) => {
      await tx.groupInvite.create({ data: { token, bookingId, expiresAt, maxGuests: Math.max(p.maxGuests ?? b.partySize, 2) } });
      const guest = await tx.bookingGuest.create({
        data: { bookingId, userId, displayName: b.user.name?.trim() || 'Chủ bàn', isHost: true, accessKeyHash: sha256(hostKey) },
      });
      // Dishes the host already pre-ordered become the host's.
      await tx.orderItem.updateMany({ where: { order: { bookingId }, round: 0, guestId: null }, data: { guestId: guest.id } });
      await tx.booking.update({ where: { id: bookingId }, data: { isGroupOrder: true } });
      await this.audit.log({ actorType: 'USER', actorId: userId, action: 'group.start', entity: 'Booking', entityId: bookingId }, tx);
      return guest;
    });
    await this.jobs.add(QUEUES.BOOKING, 'group-cutoff', { bookingId }, { jobId: `groupcut:${bookingId}`, delay: Math.max(0, expiresAt.getTime() - this.clock.now().getTime()) });
    return { ...this.view(await this.load(token)), guestKey: hostKey, guestId: host.id };
  }

  /** Host taps "Lock order" (or the cutoff job runs). */
  async lock(bookingId: string, by: { userId: string } | 'system') {
    const inv = await this.prisma.groupInvite.findUnique({ where: { bookingId }, include: GROUP_INCLUDE });
    if (!inv || (by !== 'system' && inv.booking.userId !== by.userId)) throw notFound('Group');
    if (!inv.lockedAt) {
      await this.prisma.groupInvite.update({ where: { token: inv.token }, data: { lockedAt: this.clock.now() } });
      await this.audit.log({
        actorType: by === 'system' ? 'SYSTEM' : 'USER',
        actorId: by === 'system' ? undefined : by.userId,
        action: 'group.lock',
        entity: 'Booking',
        entityId: bookingId,
      });
      this.changed(inv, 'locked');
    }
    return this.view(await this.load(inv.token));
  }

  // ───── anyone with the link ─────

  async get(token: string) {
    return this.view(await this.load(token));
  }

  /** Join with a name. Logged-in users join once (a new key is issued on re-join). */
  async join(token: string, displayName: string, userId?: string) {
    const inv = await this.load(token);
    if (this.isLocked(inv)) throw new AppError('GROUP_LOCKED', 'The group order is closed');
    if (!OPEN_BOOKING.includes(inv.booking.status as (typeof OPEN_BOOKING)[number])) throw new AppError('GROUP_LOCKED', 'This booking is no longer open');
    const key = randomToken(24);
    const existing = userId ? inv.booking.guests.find((g) => g.userId === userId) : undefined;
    let guestId: string;
    if (existing) {
      await this.prisma.bookingGuest.update({ where: { id: existing.id }, data: { accessKeyHash: sha256(key) } });
      guestId = existing.id;
    } else {
      if (inv.booking.guests.length >= inv.maxGuests) throw new AppError('GROUP_FULL', 'The group is full');
      const g = await this.prisma.bookingGuest.create({
        data: { bookingId: inv.bookingId, userId: userId ?? null, displayName: displayName.trim(), accessKeyHash: sha256(key) },
      });
      guestId = g.id;
      this.changed(inv, 'joined');
    }
    return { ...this.view(await this.load(token)), guestKey: key, guestId };
  }

  private guestOf(inv: InviteRow, guestKey: string) {
    const hash = sha256(guestKey);
    const g = inv.booking.guests.find((x) => x.accessKeyHash === hash);
    if (!g) throw new AppError('GUEST_KEY_INVALID', 'Join the group again');
    return g;
  }

  /** A member adds their dishes (pay at the restaurant: they wait for check-in like any pre-order). */
  async addItems(token: string, guestKey: string, lines: CartLine[], ageConfirmed?: boolean) {
    const inv = await this.load(token);
    const guest = this.guestOf(inv, guestKey);
    if (this.isLocked(inv)) throw new AppError('GROUP_LOCKED', 'The group order is closed');
    if (!lines.length) throw new AppError('VALIDATION_FAILED', 'Add at least one dish');
    const b = inv.booking;
    const now = this.clock.now();
    const menu = await this.prisma.menuItem.findMany({
      where: { id: { in: lines.map((l) => l.menuItemId) }, restaurantId: b.restaurantId },
      include: { optionGroups: { include: { options: true } } },
    });
    const cart = priceCart(lines, new Map(menu.map((m) => [m.id, m])), { hoursUntilArrival: (b.arrivalAt.getTime() - now.getTime()) / 3_600_000 });
    if (cart.hasAlcohol && !ageConfirmed) throw new AppError('AGE_CONFIRMATION_REQUIRED', 'Confirm you are 18 or older to order alcohol');
    const booking = await this.prisma.booking.findUniqueOrThrow({ where: { id: b.id }, select: { serveStyle: true } });

    await this.prisma.$transaction(async (tx) => {
      await this.kitchen.assertCapacity(b.restaurant, cart.lines, { arrival: b.arrivalAt, serveStyle: booking.serveStyle }, tx);
      const order =
        (await tx.order.findUnique({ where: { bookingId: b.id } })) ??
        (await tx.order.create({ data: { bookingId: b.id, subtotal: 0, total: 0, status: 'PLACED' } }));
      await tx.orderItem.createMany({
        data: cart.lines.map(({ isAlcohol: _a, ...l }) => ({
          ...l,
          orderId: order.id,
          optionsSnapshot: l.optionsSnapshot as Prisma.InputJsonValue,
          guestId: guest.id,
          round: 0,
          kitchenStatus: 'HOLD',
        })),
      });
      await tx.order.update({ where: { id: order.id }, data: { subtotal: { increment: cart.subtotal }, total: { increment: cart.subtotal } } });
      if (cart.hasAlcohol && !b.ageConfirmedAt) await tx.booking.update({ where: { id: b.id }, data: { ageConfirmedAt: now } });
      await this.kitchen.planBooking(b.id, { arrival: b.arrivalAt, statuses: ['HOLD'], release: false }, tx);
    });
    this.changed(inv, 'items');
    return this.view(await this.load(token));
  }

  /** Remove one of your own dishes before the cutoff. */
  async removeItem(token: string, guestKey: string, itemId: string) {
    const inv = await this.load(token);
    const guest = this.guestOf(inv, guestKey);
    if (this.isLocked(inv)) throw new AppError('GROUP_LOCKED', 'The group order is closed');
    const item = (inv.booking.order?.items ?? []).find((i) => i.id === itemId);
    if (!item || item.guestId !== guest.id) throw notFound('Dish');
    await this.prisma.$transaction(async (tx) => {
      const { count } = await tx.orderItem.updateMany({ where: { id: itemId, kitchenStatus: 'HOLD' }, data: { kitchenStatus: 'CANCELLED' } });
      if (!count) throw new AppError('INVALID_STATUS', 'The kitchen already started this dish');
      const amount = item.unitPrice * item.quantity;
      await tx.order.updateMany({ where: { bookingId: inv.bookingId }, data: { subtotal: { decrement: amount }, total: { decrement: amount } } });
    });
    this.changed(inv, 'items');
    return this.view(await this.load(token));
  }

  // ───── split bill + paid in cash (§8.5) ─────

  private async splitContext(bookingId: string, who: { userId: string } | { restaurantId: string }) {
    const b = await this.prisma.booking.findFirst({
      where: { id: bookingId, ...('userId' in who ? { userId: who.userId } : { restaurantId: who.restaurantId }) },
      include: {
        user: { select: { name: true } },
        guests: { orderBy: [{ isHost: 'desc' }, { joinedAt: 'asc' }] },
        billSplit: true,
        order: { select: { items: { where: { kitchenStatus: { not: 'CANCELLED' } } } } },
      },
    });
    if (!b) throw notFound('Booking');
    const items = b.order?.items ?? [];
    const total = b.finalBillAmount ?? items.reduce((s, i) => s + i.unitPrice * i.quantity, 0);
    return { b, items, total };
  }

  private splitDto(
    b: { billSplit: { mode: SplitMode } | null; guests: { id: string; displayName: string; isHost: boolean; amountDue: number; amountPaid: number; paidAt: Date | null }[] },
    total: number,
  ) {
    return {
      mode: b.billSplit?.mode ?? null,
      total,
      paid: b.guests.reduce((s, g) => s + g.amountPaid, 0),
      guests: b.guests.map((g) => ({
        id: g.id,
        displayName: g.displayName,
        isHost: g.isHost,
        amountDue: g.amountDue,
        amountPaid: g.amountPaid,
        paidAt: g.paidAt?.toISOString() ?? null,
      })),
    };
  }

  async getSplit(bookingId: string, who: { userId: string } | { restaurantId: string }) {
    const { b, total } = await this.splitContext(bookingId, who);
    return this.splitDto(b, total);
  }

  /**
   * Save a split. A booking without group members gets `people` placeholder guests
   * ("Khách 1"…) so a table that did not use the group link can still split equally.
   */
  async saveSplit(
    bookingId: string,
    who: { userId: string } | { restaurantId: string; staffId: string },
    p: { mode: SplitMode; people?: number; amounts?: Record<string, number> },
  ) {
    const ctx = await this.splitContext(bookingId, who);
    if (!['CONFIRMED', 'CHECKED_IN', 'COMPLETED'].includes(ctx.b.status)) throw new AppError('INVALID_STATUS', 'Nothing to split yet');
    let guests = ctx.b.guests;
    if (!guests.length) {
      const n = Math.max(1, Math.min(p.people ?? ctx.b.partySize, 50));
      await this.prisma.bookingGuest.createMany({
        data: Array.from({ length: n }, (_, i) => ({
          bookingId,
          userId: i === 0 ? ctx.b.userId : null,
          displayName: i === 0 ? ctx.b.user.name?.trim() || 'Khách 1' : `Khách ${i + 1}`,
          isHost: i === 0,
        })),
      });
      guests = await this.prisma.bookingGuest.findMany({ where: { bookingId }, orderBy: [{ isHost: 'desc' }, { joinedAt: 'asc' }] });
    }
    const shares = splitBill({
      total: ctx.total,
      guests,
      items: ctx.items.map((i) => ({ amount: i.unitPrice * i.quantity, guestId: i.guestId })),
      mode: p.mode,
      custom: p.amounts,
    });
    await this.prisma.$transaction(async (tx) => {
      await tx.billSplit.upsert({ where: { bookingId }, create: { bookingId, mode: p.mode }, update: { mode: p.mode } });
      for (const g of guests) await tx.bookingGuest.update({ where: { id: g.id }, data: { amountDue: shares[g.id] } });
      await this.audit.log(
        {
          actorType: 'userId' in who ? 'USER' : 'STAFF',
          actorId: 'userId' in who ? who.userId : who.staffId,
          action: 'bill.split',
          entity: 'Booking',
          entityId: bookingId,
          data: { mode: p.mode, total: ctx.total },
        },
        tx,
      );
    });
    this.realtime.toRestaurant(ctx.b.restaurantId, 'booking.updated', { bookingId });
    return this.getSplit(bookingId, 'userId' in who ? { userId: who.userId } : { restaurantId: who.restaurantId });
  }

  /** Staff took cash (or a transfer) from one guest. */
  async markPaid(restaurantId: string, staffId: string, bookingId: string, guestId: string, paid: boolean) {
    const g = await this.prisma.bookingGuest.findFirst({ where: { id: guestId, bookingId, booking: { restaurantId } } });
    if (!g) throw notFound('Guest');
    await this.prisma.bookingGuest.update({
      where: { id: guestId },
      data: paid ? { amountPaid: g.amountDue, paidAt: this.clock.now() } : { amountPaid: 0, paidAt: null },
    });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: paid ? 'guest.paid_cash' : 'guest.unpaid', entity: 'BookingGuest', entityId: guestId, data: { amount: g.amountDue } });
    this.realtime.toRestaurant(restaurantId, 'booking.updated', { bookingId });
    return this.getSplit(bookingId, { restaurantId });
  }
}
