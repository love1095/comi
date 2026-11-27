import { Injectable } from '@nestjs/common';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { RedisService } from '../../common/redis';
import { PrismaService } from '../../prisma/prisma.service';

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
}
