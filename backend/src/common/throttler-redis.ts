import { Logger } from '@nestjs/common';
import { ThrottlerStorage } from '@nestjs/throttler';

/** Fixed-window counter + block key, atomic in Redis. Returns [hits, ttlMs, blocked(0/1), blockMs]. */
const SCRIPT = `
local hits = redis.call('INCR', KEYS[1])
if hits == 1 then redis.call('PEXPIRE', KEYS[1], ARGV[1]) end
local ttl = redis.call('PTTL', KEYS[1])
local block = redis.call('PTTL', KEYS[2])
if block > 0 then return {hits, ttl, 1, block} end
if hits > tonumber(ARGV[2]) then
  redis.call('SET', KEYS[2], '1', 'PX', ARGV[3])
  return {hits, ttl, 1, tonumber(ARGV[3])}
end
return {hits, ttl, 0, 0}
`;

type EvalClient = { eval(script: string, numKeys: number, ...args: (string | number)[]): Promise<unknown> };

/**
 * Rate-limit counters shared by every API instance (§3, §23). Fails open: if Redis is down,
 * requests are allowed rather than the whole API going down with it.
 */
export class RedisThrottlerStorage implements ThrottlerStorage {
  private readonly logger = new Logger(RedisThrottlerStorage.name);

  constructor(private readonly redis: EvalClient) {}

  async increment(key: string, ttl: number, limit: number, blockDuration: number, throttlerName: string) {
    const k = `throttle:${throttlerName}:${key}`;
    try {
      const [hits, ttlMs, blocked, blockMs] = (await this.redis.eval(SCRIPT, 2, k, `${k}:block`, ttl, limit, blockDuration > 0 ? blockDuration : ttl)) as number[];
      return {
        totalHits: hits,
        timeToExpire: Math.max(0, Math.ceil(ttlMs / 1000)),
        isBlocked: blocked === 1,
        timeToBlockExpire: Math.max(0, Math.ceil(blockMs / 1000)),
      };
    } catch (e) {
      this.logger.warn(`rate limit storage unavailable: ${(e as Error).message}`);
      return { totalHits: 0, timeToExpire: 0, isBlocked: false, timeToBlockExpire: 0 };
    }
  }
}
