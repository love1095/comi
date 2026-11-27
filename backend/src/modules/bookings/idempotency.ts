import { Injectable } from '@nestjs/common';
import { AppError } from '../../common/errors/app-error';
import { RedisService } from '../../common/redis';

const TTL_SECONDS = 24 * 3600;

/**
 * Idempotency-Key (§8.2): a double tap or a retry after a network error returns the
 * first result instead of creating a second booking. Keys live 24 h in Redis.
 */
@Injectable()
export class IdempotencyService {
  constructor(private readonly redis: RedisService) {}

  async run<T>(scope: string, key: string | undefined, fn: () => Promise<T>): Promise<T> {
    if (!key) return fn();
    if (!/^[A-Za-z0-9_-]{8,100}$/.test(key)) throw new AppError('VALIDATION_FAILED', 'Idempotency-Key must be 8–100 chars [A-Za-z0-9_-]');
    const k = `idem:${scope}:${key}`;
    const claimed = await this.redis.client.set(k, 'pending', 'EX', TTL_SECONDS, 'NX');
    if (!claimed) {
      const prev = await this.redis.client.get(k);
      if (prev === 'pending' || prev === null) throw new AppError('REQUEST_IN_PROGRESS', 'The same request is still being processed');
      return JSON.parse(prev) as T;
    }
    try {
      const result = await fn();
      await this.redis.client.set(k, JSON.stringify(result), 'EX', TTL_SECONDS);
      return result;
    } catch (e) {
      await this.redis.client.del(k); // failed requests may be retried with the same key
      throw e;
    }
  }
}
