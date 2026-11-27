import { Inject, Injectable, Logger } from '@nestjs/common';
import { Payment, Prisma } from '@prisma/client';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { decryptSecret, encryptSecret, sha256 } from '../../common/utils/crypto';
import { addMinutes } from '../../common/utils/time';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { JobsService, QUEUES } from '../../jobs/queues';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService } from '../availability/availability.service';
import { noShowDeadline } from '../bookings/booking.state';
import { FeesService } from '../fees/fees.service';
import { KitchenService } from '../kitchen/kitchen.service';
import { RealtimeService } from '../realtime/realtime.service';
import { PayOsAdapter, PayOsCredentials } from './payos';
import { WebhookResult } from './provider';

const OPEN_PAYMENT = ['CREATED', 'PENDING'] as const;
const RECONCILE_AFTER_MS = 3 * 60_000; // §10.3: ask the provider about payments pending > 3 min
const RECONCILE_WINDOW_MS = 24 * 3_600_000;

export type RefundReason = 'RESTAURANT_CANCELLED' | 'CUSTOMER_CANCELLED' | 'LATE_PAYMENT_NO_TABLE' | 'AMOUNT_MISMATCH' | 'NO_SHOW_POLICY';

export function paymentDto(p: Pick<Payment, 'id' | 'bookingId' | 'amount' | 'status' | 'purpose' | 'guestId' | 'checkoutUrl' | 'qrCode' | 'expiresAt' | 'paidAt' | 'refundedAmount'>) {
  return {
    id: p.id,
    bookingId: p.bookingId,
    amount: p.amount,
    status: p.status,
    purpose: p.purpose,
    guestId: p.guestId,
    checkoutUrl: p.checkoutUrl,
    qrCode: p.qrCode,
    expiresAt: p.expiresAt.toISOString(),
    paidAt: p.paidAt?.toISOString() ?? null,
    refundedAmount: p.refundedAmount,
  };
}

/**
 * Online payments (§10). Money goes straight to the restaurant's own PayOS account; comi never
 * holds it. Webhooks are stored once (WebhookEvent unique) and applied idempotently; the
 * reconcile job covers lost webhooks. Refunds are manual transfers tracked in Refund (PayOS has
 * no refund API) — the minimum required before prepaid goes live.
 */
@Injectable()
export class PaymentsService {
  private readonly logger = new Logger(PaymentsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly jobs: JobsService,
    private readonly kitchen: KitchenService,
    private readonly availability: AvailabilityService,
    private readonly realtime: RealtimeService,
    private readonly fees: FeesService,
    @Inject(ENV) private readonly env: Env,
    private readonly payos: PayOsAdapter,
  ) {}

  // ───── restaurant account (§10.1) ─────

  private key() {
    if (!this.env.CREDENTIALS_ENCRYPTION_KEY) throw new AppError('SERVICE_UNAVAILABLE', 'Online payments are not configured on this server');
    return this.env.CREDENTIALS_ENCRYPTION_KEY;
  }

  async connect(restaurantId: string, staffId: string, creds: PayOsCredentials) {
    const encrypted = encryptSecret(JSON.stringify(creds), this.key());
    await this.prisma.paymentAccount.upsert({
      where: { restaurantId_provider: { restaurantId, provider: 'PAYOS' } },
      create: { restaurantId, provider: 'PAYOS', credentialsEncrypted: encrypted, isActive: true },
      update: { credentialsEncrypted: encrypted, isActive: true },
    });
    // Never log secrets: only a fingerprint of the client id.
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'payment_account.connected', entity: 'Restaurant', entityId: restaurantId, data: { provider: 'PAYOS', client: sha256(creds.clientId).slice(0, 8) } });
    return this.accountStatus(restaurantId);
  }

  async disconnect(restaurantId: string, staffId: string) {
    await this.prisma.paymentAccount.updateMany({ where: { restaurantId, provider: 'PAYOS' }, data: { isActive: false } });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'payment_account.disconnected', entity: 'Restaurant', entityId: restaurantId });
    return this.accountStatus(restaurantId);
  }

  async accountStatus(restaurantId: string) {
    const a = await this.prisma.paymentAccount.findUnique({ where: { restaurantId_provider: { restaurantId, provider: 'PAYOS' } } });
    let clientIdHint: string | null = null;
    if (a?.isActive && this.env.CREDENTIALS_ENCRYPTION_KEY) {
      try {
        const c = JSON.parse(decryptSecret(a.credentialsEncrypted, this.env.CREDENTIALS_ENCRYPTION_KEY)) as PayOsCredentials;
        clientIdHint = `…${c.clientId.slice(-4)}`;
      } catch {
        clientIdHint = null;
      }
    }
    return { provider: 'PAYOS', connected: !!a?.isActive && clientIdHint !== null, clientIdHint, serverReady: !!this.env.CREDENTIALS_ENCRYPTION_KEY };
  }

  private async credentials(restaurantId: string): Promise<PayOsCredentials | null> {
    if (!this.env.CREDENTIALS_ENCRYPTION_KEY) return null;
    const a = await this.prisma.paymentAccount.findFirst({ where: { restaurantId, provider: 'PAYOS', isActive: true } });
    if (!a) return null;
    return JSON.parse(decryptSecret(a.credentialsEncrypted, this.env.CREDENTIALS_ENCRYPTION_KEY)) as PayOsCredentials;
  }

  /** Can guests prepay at this restaurant? (§10.1: needs its own connected account.) */
  async prepaidAvailable(restaurantId: string) {
    if (!this.env.CREDENTIALS_ENCRYPTION_KEY) return false;
    return (await this.prisma.paymentAccount.count({ where: { restaurantId, provider: 'PAYOS', isActive: true } })) > 0;
  }

  // ───── paying ─────

  /** Booking was created PREPAID (or just approved): unpaid by the deadline → EXPIRED. */
  async schedulePaymentTimeout(bookingId: string) {
    await this.jobs.remove(QUEUES.BOOKING, `paytimeout:${bookingId}`);
    await this.jobs.add(QUEUES.BOOKING, 'payment-timeout', { bookingId }, { jobId: `paytimeout:${bookingId}`, delay: this.env.PAYMENT_TIMEOUT_MINUTES * 60_000 });
  }

  /** Guest taps "Pay": a payment link for the pre-order (re-used while still open). */
  async payBooking(userId: string, bookingId: string) {
    const b = await this.prisma.booking.findFirst({ where: { id: bookingId, userId }, include: { order: true } });
    if (!b) throw notFound('Booking');
    if (b.paymentMode !== 'PREPAID') throw new AppError('INVALID_STATUS', 'This booking is paid at the restaurant');
    if (b.needsApproval) throw new AppError('AWAITING_APPROVAL', 'Wait for the restaurant to approve your group first');
    if (b.status !== 'PENDING') throw new AppError('INVALID_STATUS', b.status === 'CONFIRMED' ? 'Already paid' : 'Booking is not waiting for payment');
    const amount = b.order?.total ?? 0;
    if (amount <= 0) throw new AppError('NOTHING_TO_PAY', 'Nothing to pay');
    return this.open(b, amount, { purpose: 'BOOKING', description: b.code });
  }

  /** A group member pays their split share (§8.4 "each pays own"). */
  async payShare(token: string, guestKey: string) {
    const inv = await this.prisma.groupInvite.findUnique({ where: { token }, include: { booking: { include: { guests: true } } } });
    if (!inv) throw notFound('Group');
    const guest = inv.booking.guests.find((g) => g.accessKeyHash === sha256(guestKey));
    if (!guest) throw new AppError('GUEST_KEY_INVALID', 'Join the group again');
    const due = guest.amountDue - guest.amountPaid;
    if (due <= 0) throw new AppError('NOTHING_TO_PAY', 'Your share is already paid');
    return this.open(inv.booking, due, { purpose: 'SHARE', guestId: guest.id, description: `${inv.booking.code} ${guest.displayName}` });
  }

  private async open(
    b: { id: string; restaurantId: string; code: string },
    amount: number,
    p: { purpose: 'BOOKING' | 'SHARE'; guestId?: string; description: string },
  ) {
    const now = this.clock.now();
    const existing = await this.prisma.payment.findFirst({
      where: { bookingId: b.id, purpose: p.purpose, guestId: p.guestId ?? null, status: { in: [...OPEN_PAYMENT] }, expiresAt: { gt: now }, amount },
      orderBy: { createdAt: 'desc' },
    });
    if (existing?.checkoutUrl) return paymentDto(existing);

    const creds = await this.credentials(b.restaurantId);
    if (!creds) throw new AppError('PAYMENT_NOT_CONNECTED', 'This restaurant does not take online payments yet');
    const [{ nextval }] = await this.prisma.$queryRaw<{ nextval: bigint }[]>`SELECT nextval('payment_order_code_seq')`;
    const expiresAt = addMinutes(now, this.env.PAYMENT_TIMEOUT_MINUTES);
    const payment = await this.prisma.payment.create({
      data: { bookingId: b.id, provider: 'PAYOS', providerOrderId: String(nextval), amount, expiresAt, purpose: p.purpose, guestId: p.guestId },
    });
    const back = `${this.env.APP_LINK_BASE_URL.replace(/\/$/, '')}/pay/${b.id}`;
    try {
      const link = await this.payos.createPayment({
        account: creds,
        providerOrderId: payment.providerOrderId,
        amount,
        description: p.description,
        returnUrl: `${back}?result=paid`,
        cancelUrl: `${back}?result=cancelled`,
        expiresAt,
      });
      const updated = await this.prisma.payment.update({ where: { id: payment.id }, data: { status: 'PENDING', checkoutUrl: link.checkoutUrl, qrCode: link.qrCode } });
      return paymentDto(updated);
    } catch (e) {
      await this.prisma.payment.update({ where: { id: payment.id }, data: { status: 'FAILED' } });
      throw e;
    }
  }

  // ───── webhook + applying a payment (§10.3) ─────

  /** POST /webhooks/payos. Unknown orderCode (PayOS's URL check) → ok. Bad signature → FORBIDDEN. */
  async handleWebhook(body: unknown) {
    const orderCode = (body as { data?: { orderCode?: unknown } })?.data?.orderCode;
    if (orderCode === undefined || orderCode === null) return { success: true };
    const payment = await this.prisma.payment.findUnique({ where: { providerOrderId: String(orderCode) }, include: { booking: { select: { restaurantId: true } } } });
    if (!payment) return { success: true };
    const creds = await this.credentials(payment.booking.restaurantId);
    if (!creds) throw new AppError('FORBIDDEN', 'Restaurant account is not connected');
    const result = this.payos.verifyWebhook(body, creds);

    let eventId: string;
    try {
      const ev = await this.prisma.webhookEvent.create({ data: { provider: 'PAYOS', eventKey: result.eventKey, payload: body as Prisma.InputJsonValue } });
      eventId = ev.id;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError && e.code === 'P2002') return { success: true }; // duplicate delivery
      throw e;
    }
    // Applying is quick DB work; if it fails the reconcile job retries unprocessed events.
    try {
      await this.applyWebhook(eventId, result);
    } catch (e) {
      this.logger.error(`webhook ${eventId} not applied yet: ${(e as Error).message}`);
    }
    return { success: true };
  }

  private async applyWebhook(eventId: string, r: WebhookResult) {
    if (r.paid) {
      const p = await this.prisma.payment.findUniqueOrThrow({ where: { providerOrderId: r.providerOrderId } });
      await this.applyPaid(p.id, { amount: r.amount, providerTxnId: r.providerTxnId, payer: r.payer, raw: true });
    }
    await this.prisma.webhookEvent.update({ where: { id: eventId }, data: { processedAt: this.clock.now() } });
  }

  /**
   * Money arrived. Idempotent: only the first call moves the payment to PAID.
   * BOOKING: PENDING → CONFIRMED (dishes scheduled, no-show job); EXPIRED → CONFIRMED if the
   * table is still free, else refund; CANCELLED → refund. Short amount → FAILED + refund.
   * SHARE: the guest's part is marked paid.
   */
  async applyPaid(paymentId: string, r: { amount: number; providerTxnId?: string; payer?: WebhookResult['payer']; raw?: boolean }) {
    const now = this.clock.now();
    const p = await this.prisma.payment.findUniqueOrThrow({ where: { id: paymentId } });
    const short = r.amount < p.amount;
    const { count } = await this.prisma.payment.updateMany({
      where: { id: paymentId, status: { in: ['CREATED', 'PENDING', 'EXPIRED'] } },
      data: {
        status: short ? 'FAILED' : 'PAID',
        paidAt: now,
        providerTxnId: r.providerTxnId,
        payerBankBin: r.payer?.bankBin,
        payerAccountNo: r.payer?.accountNo,
        payerName: r.payer?.name,
      },
    });
    if (!count) return false; // already applied

    const b = await this.prisma.booking.findUniqueOrThrow({ where: { id: p.bookingId }, include: { restaurant: { select: { graceMinutes: true } } } });
    if (short) {
      await this.audit.log({ actorType: 'SYSTEM', action: 'payment.amount_mismatch', entity: 'Payment', entityId: paymentId, data: { expected: p.amount, got: r.amount } });
      await this.createRefund(p.id, b.id, r.amount, 'AMOUNT_MISMATCH');
      this.realtime.toUser(b.userId, 'booking.status', { bookingId: b.id, payment: 'failed' });
      return true;
    }
    await this.audit.log({ actorType: 'SYSTEM', action: 'payment.paid', entity: 'Payment', entityId: paymentId, data: { amount: r.amount, purpose: p.purpose } });

    if (p.purpose === 'SHARE') {
      if (p.guestId) await this.prisma.bookingGuest.update({ where: { id: p.guestId }, data: { amountPaid: { increment: r.amount }, paidAt: now } });
      this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId: b.id, payment: 'share_paid' });
      this.realtime.toGroup(b.id, { bookingId: b.id, what: 'paid' });
      return true;
    }

    let confirm = b.status === 'PENDING' && !b.needsApproval;
    if (b.status === 'EXPIRED') {
      // §10.3 late payment: confirm only if the table is still free for that time.
      const [free] = await this.availability.freeTables(b.restaurantId, [{ start: b.arrivalAt, end: b.endsAt }], { ignoreBookingId: b.id });
      const tables = [b.tableId, ...b.extraTableIds].filter(Boolean) as string[];
      confirm = tables.every((t) => free.some((f) => f.id === t)) && b.arrivalAt > now;
      if (!confirm) await this.createRefund(p.id, b.id, r.amount, 'LATE_PAYMENT_NO_TABLE');
    } else if (b.status === 'CANCELLED') {
      await this.createRefund(p.id, b.id, r.amount, b.cancelledBy === 'RESTAURANT' ? 'RESTAURANT_CANCELLED' : 'CUSTOMER_CANCELLED');
    }

    if (confirm) {
      const moved = await this.prisma.booking.updateMany({ where: { id: b.id, status: b.status }, data: { status: 'CONFIRMED' } });
      if (moved.count) {
        if (b.status === 'EXPIRED') {
          await this.prisma.orderItem.updateMany({ where: { order: { bookingId: b.id }, kitchenStatus: 'CANCELLED', round: 0 }, data: { kitchenStatus: 'HOLD' } });
          await this.prisma.order.updateMany({ where: { bookingId: b.id }, data: { status: 'PLACED' } });
        }
        await this.audit.log({ actorType: 'SYSTEM', action: 'booking.confirmed', entity: 'Booking', entityId: b.id, data: { from: b.status, by: 'payment' } });
        await this.jobs.remove(QUEUES.BOOKING, `paytimeout:${b.id}`);
        // Prepaid dishes get fire times now (§7.2).
        await this.kitchen.planBooking(b.id, { arrival: b.arrivalAt, statuses: ['HOLD'], release: true });
        const at = noShowDeadline(b, b.restaurant.graceMinutes);
        await this.jobs.add(QUEUES.BOOKING, 'no-show-check', { bookingId: b.id }, { jobId: `noshow:${b.id}`, delay: Math.max(0, at.getTime() - now.getTime()) });
        await this.availability.invalidate(b.restaurantId);
      }
    }
    this.realtime.toUser(b.userId, 'booking.status', { bookingId: b.id, status: confirm ? 'CONFIRMED' : b.status, payment: 'paid' });
    this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId: b.id, payment: 'paid' });
    return true;
  }

  // ───── jobs ─────

  /** payment-timeout: still unpaid PENDING prepaid booking → EXPIRED, table freed, dishes cancelled. */
  async paymentTimeout(bookingId: string) {
    const now = this.clock.now();
    const b = await this.prisma.booking.findUnique({ where: { id: bookingId }, include: { payments: { where: { status: 'PAID', purpose: 'BOOKING' } } } });
    if (!b || b.status !== 'PENDING' || b.needsApproval || b.paymentMode !== 'PREPAID' || b.payments.length) return false;
    const done = await this.prisma.$transaction(async (tx) => {
      const { count } = await tx.booking.updateMany({ where: { id: bookingId, status: 'PENDING' }, data: { status: 'EXPIRED' } });
      if (!count) return false;
      await tx.orderItem.updateMany({ where: { order: { bookingId }, kitchenStatus: { in: ['HOLD', 'SCHEDULED'] } }, data: { kitchenStatus: 'CANCELLED' } });
      await tx.order.updateMany({ where: { bookingId }, data: { status: 'CANCELLED' } });
      await tx.payment.updateMany({ where: { bookingId, status: { in: [...OPEN_PAYMENT] } }, data: { status: 'EXPIRED' } });
      await this.audit.log({ actorType: 'SYSTEM', action: 'booking.payment_timeout', entity: 'Booking', entityId: bookingId, data: { at: now } }, tx);
      return true;
    });
    if (!done) return false;
    await this.availability.invalidate(b.restaurantId);
    this.realtime.toUser(b.userId, 'booking.status', { bookingId, status: 'EXPIRED' });
    this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId, status: 'EXPIRED' });
    return true;
  }

  /** payment-reconcile (every 5 min): replay stuck webhooks, ask PayOS about pending payments. */
  async reconcile() {
    const now = this.clock.now();
    const stuck = await this.prisma.webhookEvent.findMany({ where: { processedAt: null, createdAt: { lt: new Date(now.getTime() - 60_000) } }, take: 50 });
    for (const ev of stuck) {
      try {
        const body = ev.payload as { data?: { orderCode?: unknown } };
        const payment = await this.prisma.payment.findUnique({ where: { providerOrderId: String(body.data?.orderCode) }, include: { booking: { select: { restaurantId: true } } } });
        const creds = payment && (await this.credentials(payment.booking.restaurantId));
        if (creds) await this.applyWebhook(ev.id, this.payos.verifyWebhook(ev.payload, creds));
      } catch (e) {
        this.logger.warn(`reconcile webhook ${ev.id}: ${(e as Error).message}`);
      }
    }
    const pending = await this.prisma.payment.findMany({
      where: { status: 'PENDING', createdAt: { lt: new Date(now.getTime() - RECONCILE_AFTER_MS), gt: new Date(now.getTime() - RECONCILE_WINDOW_MS) } },
      include: { booking: { select: { restaurantId: true } } },
      take: 100,
    });
    let paid = 0;
    for (const p of pending) {
      try {
        const creds = await this.credentials(p.booking.restaurantId);
        if (!creds) continue;
        const s = await this.payos.getStatus(p.providerOrderId, creds);
        if (s.status === 'PAID' && (await this.applyPaid(p.id, { amount: s.amountPaid || p.amount }))) paid++;
        else if (s.status === 'CANCELLED' || p.expiresAt < now) await this.prisma.payment.updateMany({ where: { id: p.id, status: 'PENDING' }, data: { status: 'EXPIRED' } });
      } catch (e) {
        this.logger.warn(`reconcile payment ${p.id}: ${(e as Error).message}`);
      }
    }
    return { webhooks: stuck.length, checked: pending.length, paid };
  }

  // ───── minimum refunds ─────

  private async createRefund(paymentId: string, bookingId: string, amount: number, reason: RefundReason) {
    if (amount <= 0) return null;
    const p = await this.prisma.payment.findUniqueOrThrow({ where: { id: paymentId } });
    const r = await this.prisma.refund.create({
      data: { paymentId, bookingId, amount, reason, toBankBin: p.payerBankBin, toAccountNo: p.payerAccountNo, toAccountName: p.payerName },
    });
    await this.audit.log({ actorType: 'SYSTEM', action: 'refund.created', entity: 'Refund', entityId: r.id, data: { amount, reason } });
    const b = await this.prisma.booking.findUniqueOrThrow({ where: { id: bookingId }, select: { restaurantId: true, userId: true } });
    this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId, refund: 'pending' });
    this.realtime.toUser(b.userId, 'booking.status', { bookingId, refund: 'pending' });
    return r;
  }

  /**
   * A prepaid booking was cancelled (restaurant, or customer before the cutoff): full refund of
   * everything paid and not yet refunded (§Phase 4 minimum). Unpaid links are closed.
   */
  async refundOnCancel(bookingId: string, cancelledBy: 'USER' | 'RESTAURANT' | 'SYSTEM') {
    await this.prisma.payment.updateMany({ where: { bookingId, status: { in: [...OPEN_PAYMENT] } }, data: { status: 'EXPIRED' } });
    const paid = await this.prisma.payment.findMany({ where: { bookingId, status: { in: ['PAID', 'PARTIALLY_REFUNDED'] } }, include: { refunds: true } });
    for (const p of paid) {
      const covered = p.refunds.reduce((s, r) => s + r.amount, 0);
      await this.createRefund(p.id, bookingId, p.amount - covered, cancelledBy === 'USER' ? 'CUSTOMER_CANCELLED' : 'RESTAURANT_CANCELLED');
    }
  }

  async refundsForRestaurant(restaurantId: string, status?: 'PENDING' | 'DONE') {
    const rows = await this.prisma.refund.findMany({
      where: { booking: { restaurantId }, ...(status ? { status } : {}) },
      include: { booking: { select: { code: true, user: { select: { name: true, phone: true } } } } },
      orderBy: { createdAt: 'desc' },
      take: 200,
    });
    return rows.map((r) => ({
      id: r.id,
      bookingId: r.bookingId,
      bookingCode: r.booking.code,
      guestName: r.booking.user.name,
      guestPhone: r.booking.user.phone,
      amount: r.amount,
      reason: r.reason,
      status: r.status,
      toBankBin: r.toBankBin,
      toAccountNo: r.toAccountNo,
      toAccountName: r.toAccountName,
      note: r.note,
      createdAt: r.createdAt.toISOString(),
      doneAt: r.doneAt?.toISOString() ?? null,
    }));
  }

  /** Customer gives the account to refund to (when the bank transfer did not tell us). */
  async setRefundAccount(userId: string, bookingId: string, p: { bankBin: string; accountNo: string; accountName: string }) {
    const b = await this.prisma.booking.findFirst({ where: { id: bookingId, userId } });
    if (!b) throw notFound('Booking');
    const { count } = await this.prisma.refund.updateMany({
      where: { bookingId, status: 'PENDING' },
      data: { toBankBin: p.bankBin, toAccountNo: p.accountNo, toAccountName: p.accountName.toUpperCase() },
    });
    if (!count) throw new AppError('INVALID_STATUS', 'No refund waiting');
    return { updated: count };
  }

  /** Staff transferred the money back. Updates the payment and the fee (refunds lower the base). */
  async markRefundDone(restaurantId: string, staffId: string, refundId: string, note?: string) {
    const r = await this.prisma.refund.findFirst({ where: { id: refundId, booking: { restaurantId } }, include: { booking: { select: { userId: true } } } });
    if (!r) throw notFound('Refund');
    if (r.status === 'PENDING') {
      await this.prisma.$transaction(async (tx) => {
        await tx.refund.update({ where: { id: refundId }, data: { status: 'DONE', doneAt: this.clock.now(), doneByStaffId: staffId, note } });
        const p = await tx.payment.update({ where: { id: r.paymentId }, data: { refundedAmount: { increment: r.amount } } });
        if (p.status === 'PAID' || p.status === 'PARTIALLY_REFUNDED') {
          await tx.payment.update({ where: { id: p.id }, data: { status: p.refundedAmount >= p.amount ? 'REFUNDED' : 'PARTIALLY_REFUNDED' } });
        }
        await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'refund.done', entity: 'Refund', entityId: refundId, data: { amount: r.amount, note } }, tx);
      });
      await this.fees.finalize(r.bookingId);
      this.realtime.toUser(r.booking.userId, 'booking.status', { bookingId: r.bookingId, refund: 'done' });
    }
    return (await this.refundsForRestaurant(restaurantId)).find((x) => x.id === refundId)!;
  }
}
