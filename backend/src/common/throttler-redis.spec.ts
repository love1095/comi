import { RedisThrottlerStorage } from './throttler-redis';

describe('RedisThrottlerStorage', () => {
  it('maps the script result (ms → s) and namespaces keys', async () => {
    const calls: unknown[][] = [];
    const s = new RedisThrottlerStorage({ eval: async (...a: unknown[]) => (calls.push(a), [11, 42_100, 1, 60_000]) });
    await expect(s.increment('ip:1.2.3.4', 60_000, 10, 0, 'default')).resolves.toEqual({ totalHits: 11, timeToExpire: 43, isBlocked: true, timeToBlockExpire: 60 });
    expect(calls[0].slice(1)).toEqual([2, 'throttle:default:ip:1.2.3.4', 'throttle:default:ip:1.2.3.4:block', 60_000, 10, 60_000]);
  });

  it('lets requests through when Redis is down', async () => {
    const s = new RedisThrottlerStorage({ eval: async () => Promise.reject(new Error('ECONNREFUSED')) });
    await expect(s.increment('k', 1000, 1, 0, 'default')).resolves.toMatchObject({ isBlocked: false });
  });
});
