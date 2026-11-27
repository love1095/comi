import 'reflect-metadata';
import { Logger, Module } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { Job, Worker } from 'bullmq';
import { AuditModule } from './common/audit.service';
import { ClockModule } from './common/clock';
import { RedisModule } from './common/redis';
import { ConfigModule, ENV } from './config/config.module';
import { Env, loadEnv } from './config/env';
import { BookingTimeouts } from './modules/bookings/booking-timeouts';
import { JobsModule, JobsService, QUEUES, redisConnection } from './jobs/queues';
import { PhotoProcessor } from './jobs/photo.processor';
import { PrismaModule } from './prisma/prisma.service';
import { KitchenService } from './modules/kitchen/kitchen.service';
import { GroupService } from './modules/group/group.service';
import { FeesService, previousMonth } from './modules/fees/fees.service';
import { MailModule } from './common/mail';
import { PaymentsService } from './modules/payments/payments.service';
import { PayOsAdapter } from './modules/payments/payos';
import { AvailabilityService } from './modules/availability/availability.service';
import { RealtimeModule } from './modules/realtime/realtime.service';

@Module({
  imports: [ConfigModule, PrismaModule, ClockModule, AuditModule, RedisModule, JobsModule, RealtimeModule, MailModule],
  providers: [
    PhotoProcessor,
    BookingTimeouts,
    KitchenService,
    GroupService,
    FeesService,
    AvailabilityService,
    PaymentsService,
    { provide: PayOsAdapter, inject: [ENV], useFactory: (env: Env) => new PayOsAdapter(fetch, env.PAYOS_API_URL) },
  ],
})
class WorkerModule {}

/** BullMQ worker entry (§1: same code, separate process). Run: npm run start:worker */
async function bootstrap() {
  loadEnv();
  const app = await NestFactory.createApplicationContext(WorkerModule);
  const env = app.get<Env>(ENV);
  const logger = new Logger('Worker');
  const connection = redisConnection(env.REDIS_URL);

  const photos = app.get(PhotoProcessor);
  const bookings = app.get(BookingTimeouts);
  const kitchen = app.get(KitchenService);
  const groups = app.get(GroupService);
  const fees = app.get(FeesService);
  const payments = app.get(PaymentsService);

  const workers = [
    new Worker(QUEUES.PHOTO, (job: Job<{ photoId: string }>) => photos.process(job.data.photoId), { connection, concurrency: 4 }),
    new Worker(
      QUEUES.BOOKING,
      async (job: Job) => {
        if (job.name === 'group-approval-timeout') return bookings.approvalTimeout(job.data.bookingId as string);
        if (job.name === 'no-show-check') return bookings.noShow(job.data.bookingId as string);
        if (job.name === 'group-cutoff') return groups.lock(job.data.bookingId as string, 'system').catch(() => undefined);
        if (job.name === 'cod-close-reminder') return bookings.codCloseReminder(job.data.bookingId as string);
        if (job.name === 'cod-auto-close') return bookings.codAutoClose(job.data.bookingId as string);
        if (job.name === 'payment-timeout') return payments.paymentTimeout(job.data.bookingId as string);
        logger.warn(`Unknown job ${job.name}`);
      },
      { connection, concurrency: 8 },
    ),
    new Worker(
      QUEUES.KITCHEN,
      async (job: Job) => {
        if (job.name === 'kitchen-release') return kitchen.releaseDue(job.data.bookingId as string);
        if (job.name === 'kitchen-sweep') return kitchen.releaseDue();
        logger.warn(`Unknown job ${job.name}`);
      },
      { connection, concurrency: 8 },
    ),
    new Worker(
      QUEUES.BILLING,
      async (job: Job) => {
        if (job.name === 'statement-generate') return fees.generate(previousMonth(new Date()));
        if (job.name === 'statement-overdue') return fees.markOverdue();
        if (job.name === 'payment-reconcile') return payments.reconcile();
        logger.warn(`Unknown job ${job.name}`);
      },
      { connection, concurrency: 1 },
    ),
  ];
  for (const w of workers) {
    w.on('failed', (job, err) => logger.error(`${w.name}/${job?.name} ${job?.id} failed: ${err.message}`));
  }
  // §7.4 safety net: release overdue SCHEDULED dishes every minute (survives lost delayed jobs).
  await app.get(JobsService).repeat(QUEUES.KITCHEN, 'kitchen-sweep', { every: 60_000 });
  // §11.3: statements at 02:00 on the 1st (Vietnam), overdue check every morning.
  await app.get(JobsService).repeat(QUEUES.BILLING, 'statement-generate', { pattern: '0 2 1 * *', tz: 'Asia/Ho_Chi_Minh' });
  await app.get(JobsService).repeat(QUEUES.BILLING, 'statement-overdue', { pattern: '0 3 * * *', tz: 'Asia/Ho_Chi_Minh' });
  // §10.3: lost webhooks / stuck payments, every 5 minutes.
  await app.get(JobsService).repeat(QUEUES.BILLING, 'payment-reconcile', { every: 5 * 60_000 });
  logger.log(`comi worker started: ${workers.map((w) => w.name).join(', ')}`);

  const shutdown = async () => {
    await Promise.all(workers.map((w) => w.close()));
    await app.close();
    process.exit(0);
  };
  process.on('SIGTERM', shutdown);
  process.on('SIGINT', shutdown);
}

void bootstrap();
