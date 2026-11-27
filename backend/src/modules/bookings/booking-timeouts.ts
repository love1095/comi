import { Injectable } from '@nestjs/common';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { RedisService } from '../../common/redis';
import { PrismaService } from '../../prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';
import { NO_SHOW_LIMIT, noShowDeadline } from './booking.state';

/**
 * Booking jobs run by the worker. Kept free of API-only dependencies so worker.ts can
 * load it with a small module. Every handler is idempotent (§20).
 */
@Injectable()
export class BookingTimeouts {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly redis: RedisService,
    private readonly realtime: RealtimeService,
  ) {}

  /** group-approval-timeout: large group not approved in 2 h → cancelled (§8.4). */
  async approvalTimeout(bookingId: string): Promise<void> {
    const restaurantId = await this.prisma.$transaction(async (tx) => {
      const { count } = await tx.booking.updateMany({
        where: { id: bookingId, status: 'PENDING', needsApproval: true },
        data: { status: 'CANCELLED', cancelledAt: this.clock.now(), cancelledBy: 'SYSTEM', cancelReason: 'Restaurant did not approve in time' },
      });
      if (!count) return null;
      await tx.order.updateMany({ where: { bookingId }, data: { status: 'CANCELLED' } });
      await tx.orderItem.updateMany({ where: { order: { bookingId } }, data: { kitchenStatus: 'CANCELLED' } });
      await this.audit.log({ actorType: 'SYSTEM', action: 'booking.approval_timeout', entity: 'Booking', entityId: bookingId }, tx);
      return (await tx.booking.findUniqueOrThrow({ where: { id: bookingId }, select: { restaurantId: true } })).restaurantId;
    });
    if (restaurantId) await this.redis.client.incr(`availv:${restaurantId}`).catch(() => undefined);
    // TODO(phase2/push): notify the customer.
  }

  /**
   * no-show-check (§9.3): still CONFIRMED after the deadline → NO_SHOW, table freed,
   * waiting dishes cancelled, user's no-show count +1 (3 → must prepay). A job that runs
   * before the current deadline (ETA moved, grace extended) does nothing.
   */
  async noShow(bookingId: string): Promise<boolean> {
    const now = this.clock.now();
    const done = await this.prisma.$transaction(async (tx) => {
      const b = await tx.booking.findUnique({
        where: { id: bookingId },
        select: { status: true, userId: true, restaurantId: true, arrivalAt: true, etaAt: true, graceExtendedAt: true, restaurant: { select: { graceMinutes: true } } },
      });
      if (!b || b.status !== 'CONFIRMED') return null;
      if (now < noShowDeadline(b, b.restaurant.graceMinutes)) return null;
      const { count } = await tx.booking.updateMany({ where: { id: bookingId, status: 'CONFIRMED' }, data: { status: 'NO_SHOW', noShowAt: now } });
      if (!count) return null;
      await tx.orderItem.updateMany({
        where: { order: { bookingId }, kitchenStatus: { in: ['HOLD', 'SCHEDULED', 'QUEUED'] } },
        data: { kitchenStatus: 'CANCELLED' },
      });
      await tx.order.updateMany({ where: { bookingId }, data: { status: 'CANCELLED' } });
      const user = await tx.user.update({ where: { id: b.userId }, data: { noShowCount: { increment: 1 } }, select: { noShowCount: true } });
      if (user.noShowCount >= NO_SHOW_LIMIT) await tx.user.update({ where: { id: b.userId }, data: { mustPrepay: true } });
      await this.audit.log(
        { actorType: 'SYSTEM', action: 'booking.no_show', entity: 'Booking', entityId: bookingId, data: { noShowCount: user.noShowCount } },
        tx,
      );
      return b;
    });
    if (!done) return false;
    await this.redis.client.incr(`availv:${done.restaurantId}`).catch(() => undefined);
    this.realtime.toRestaurant(done.restaurantId, 'booking.updated', { bookingId, status: 'NO_SHOW' });
    this.realtime.toKitchen(done.restaurantId, 'kitchen.item_updated', { bookingId });
    this.realtime.toUser(done.userId, 'booking.status', { bookingId, status: 'NO_SHOW' });
    // TODO(phase2/push): "Your booking was marked as no-show".
    return true;
  }
}
