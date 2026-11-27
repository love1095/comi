import { Global, Inject, Injectable, Logger, Module, OnModuleDestroy } from '@nestjs/common';
import { Emitter } from '@socket.io/redis-emitter';
import Redis from 'ioredis';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';

/** Socket.IO namespaces and rooms (§19.1). */
export const NS = { RESTAURANT: '/restaurant', CUSTOMER: '/customer' } as const;
export const rooms = {
  restaurant: (restaurantId: string) => `r:${restaurantId}`,
  kitchen: (restaurantId: string) => `r:${restaurantId}:kitchen`,
  user: (userId: string) => `u:${userId}`,
  map: (restaurantId: string, date: string) => `map:${restaurantId}:${date}`,
  group: (bookingId: string) => `g:${bookingId}`,
};

/** Event names. Payloads are small "something changed" hints — apps reload over REST (§19.1 reconnect rule). */
export type RealtimeEvent =
  | 'booking.created'
  | 'booking.updated'
  | 'booking.checked_in'
  | 'booking.eta_updated'
  | 'booking.status'
  | 'kitchen.item_queued'
  | 'kitchen.item_updated'
  | 'order.item_status'
  | 'order.round_added'
  | 'service.requested'
  | 'service.updated'
  | 'table.state'
  | 'group.updated';

/**
 * Publishes through Redis so both the API and the worker can emit; the API's socket
 * server (Redis adapter) delivers to connected apps. Failures are logged, never thrown:
 * events are hints and the REST state stays the truth.
 */
@Injectable()
export class RealtimeService implements OnModuleDestroy {
  private readonly logger = new Logger(RealtimeService.name);
  private readonly redis?: Redis;
  private readonly emitter?: Emitter;

  constructor(@Inject(ENV) env: Env) {
    if (env.NODE_ENV === 'test' && process.env.REALTIME_IN_TEST !== 'true') return;
    this.redis = new Redis(env.REDIS_URL, { lazyConnect: true, maxRetriesPerRequest: 1, enableOfflineQueue: true });
    this.redis.on('error', () => undefined); // reconnects by itself; emit() logs failures
    const safe = { publish: (channel: string, message: string) => this.redis!.publish(channel, message).catch((e: Error) => this.fail(e)) };
    this.emitter = new Emitter(safe as unknown as Redis);
  }

  private fail(e: Error) {
    this.logger.warn(`realtime publish failed: ${e.message}`);
    return 0;
  }

  emit(namespace: string, room: string, event: RealtimeEvent, payload: Record<string, unknown>) {
    if (!this.emitter) return;
    try {
      this.emitter.of(namespace).to(room).emit(event, payload);
    } catch (e) {
      this.fail(e as Error);
    }
  }

  toRestaurant(restaurantId: string, event: RealtimeEvent, payload: Record<string, unknown>) {
    this.emit(NS.RESTAURANT, rooms.restaurant(restaurantId), event, payload);
  }

  toKitchen(restaurantId: string, event: RealtimeEvent, payload: Record<string, unknown>) {
    this.emit(NS.RESTAURANT, rooms.kitchen(restaurantId), event, payload);
  }

  toUser(userId: string, event: RealtimeEvent, payload: Record<string, unknown>) {
    this.emit(NS.CUSTOMER, rooms.user(userId), event, payload);
  }

  /** Shared cart of a group order changed (§8.4). */
  toGroup(bookingId: string, payload: Record<string, unknown>) {
    this.emit(NS.CUSTOMER, rooms.group(bookingId), 'group.updated', payload);
  }

  toMap(restaurantId: string, date: string, payload: Record<string, unknown>) {
    this.emit(NS.CUSTOMER, rooms.map(restaurantId, date), 'table.state', payload);
  }

  async onModuleDestroy() {
    if (this.redis && this.redis.status !== 'end') await this.redis.quit().catch(() => undefined);
  }
}

@Global()
@Module({ providers: [RealtimeService], exports: [RealtimeService] })
export class RealtimeModule {}
