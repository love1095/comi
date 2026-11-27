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
import { JobsModule, QUEUES, redisConnection } from './jobs/queues';
import { PhotoProcessor } from './jobs/photo.processor';
import { PrismaModule } from './prisma/prisma.service';

@Module({
  imports: [ConfigModule, PrismaModule, ClockModule, AuditModule, RedisModule, JobsModule],
  providers: [PhotoProcessor, BookingTimeouts],
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

  const workers = [
    new Worker(QUEUES.PHOTO, (job: Job<{ photoId: string }>) => photos.process(job.data.photoId), { connection, concurrency: 4 }),
    new Worker(
      QUEUES.BOOKING,
      async (job: Job) => {
        if (job.name === 'group-approval-timeout') return bookings.approvalTimeout(job.data.bookingId as string);
        logger.warn(`Unknown job ${job.name}`);
      },
      { connection, concurrency: 8 },
    ),
  ];
  for (const w of workers) {
    w.on('failed', (job, err) => logger.error(`${w.name}/${job?.name} ${job?.id} failed: ${err.message}`));
  }
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
