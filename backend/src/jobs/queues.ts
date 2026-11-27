import { Global, Inject, Injectable, Logger, Module, OnModuleDestroy } from '@nestjs/common';
import { JobsOptions, Queue } from 'bullmq';
import { ENV } from '../config/config.module';
import { Env } from '../config/env';

/** Queue names (§20). Add one here when a new job type arrives. */
export const QUEUES = {
  PHOTO: 'photo-process',
  BOOKING: 'booking', // group-approval-timeout, no-show-check; payment-timeout, reminders later
  KITCHEN: 'kitchen', // kitchen-release at fire time, kitchen-sweep every minute (§7.2, §7.4)
  BILLING: 'billing', // statement-generate (02:00 on the 1st), statement-overdue (daily) §11.3
} as const;
export type QueueName = (typeof QUEUES)[keyof typeof QUEUES];

export interface JobPayloads {
  'photo-process': { photoId: string };
  'group-approval-timeout': { bookingId: string };
  'no-show-check': { bookingId: string };
  'kitchen-release': { bookingId: string };
  'kitchen-sweep': Record<string, never>;
  'group-cutoff': { bookingId: string };
  'cod-close-reminder': { bookingId: string };
  'cod-auto-close': { bookingId: string };
  'statement-generate': Record<string, never>;
  'statement-overdue': Record<string, never>;
}

export function redisConnection(url: string) {
  const u = new URL(url);
  return {
    host: u.hostname,
    port: Number(u.port || 6379),
    password: u.password || undefined,
    db: u.pathname.length > 1 ? Number(u.pathname.slice(1)) : 0,
    maxRetriesPerRequest: null,
  };
}

/**
 * Producer side, used by the API. Job ids are deterministic (§8.3) so jobs can be
 * removed on cancel and enqueueing twice is a no-op.
 * Enqueue failures are logged, never thrown: the API must keep working if Redis blips;
 * sweep jobs cover anything missed.
 */
@Injectable()
export class JobsService implements OnModuleDestroy {
  private readonly logger = new Logger(JobsService.name);
  private readonly queues = new Map<QueueName, Queue>();

  constructor(@Inject(ENV) private readonly env: Env) {}

  private queue(name: QueueName): Queue {
    let q = this.queues.get(name);
    if (!q) {
      q = new Queue(name, {
        connection: redisConnection(this.env.REDIS_URL),
        defaultJobOptions: { attempts: 5, backoff: { type: 'exponential', delay: 5_000 }, removeOnComplete: 1000, removeOnFail: 5000 },
      });
      this.queues.set(name, q);
    }
    return q;
  }

  async add<K extends keyof JobPayloads>(queue: QueueName, name: K, data: JobPayloads[K], opts: JobsOptions & { jobId: string }) {
    if (this.env.NODE_ENV === 'test' && process.env.JOBS_IN_TEST !== 'true') return;
    try {
      await this.queue(queue).add(name, data, opts);
    } catch (e) {
      this.logger.error(`Failed to enqueue ${name} (${opts.jobId}): ${(e as Error).message}`);
    }
  }

  /** Repeating job (one scheduler per name, so restarts do not duplicate it). */
  async repeat<K extends keyof JobPayloads>(queue: QueueName, name: K, opts: { every: number } | { pattern: string; tz: string }) {
    try {
      await this.queue(queue).upsertJobScheduler(`repeat:${name}`, opts, { name, data: {} });
    } catch (e) {
      this.logger.error(`Failed to schedule ${name}: ${(e as Error).message}`);
    }
  }

  async remove(queue: QueueName, jobId: string) {
    try {
      await this.queue(queue).remove(jobId);
    } catch {
      /* job already gone or Redis down — jobs re-check state anyway */
    }
  }

  async onModuleDestroy() {
    await Promise.all([...this.queues.values()].map((q) => q.close().catch(() => undefined)));
  }
}

@Global()
@Module({ providers: [JobsService], exports: [JobsService] })
export class JobsModule {}
