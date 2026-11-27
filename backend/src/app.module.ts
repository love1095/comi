import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { LoggerModule } from 'nestjs-pino';
import { AuditModule } from './common/audit.service';
import { AuthGuard } from './common/auth/auth.guard';
import { ClockModule } from './common/clock';
import { RedisModule, RedisService } from './common/redis';
import { RedisThrottlerStorage } from './common/throttler-redis';
import { JobsModule } from './jobs/queues';
import { AvailabilityModule } from './modules/availability/availability.controller';
import { BookingsModule } from './modules/bookings/bookings.controller';
import { KitchenModule } from './modules/kitchen/kitchen.module';
import { GroupModule } from './modules/group/group.controller';
import { FeesModule } from './modules/fees/fees.module';
import { InvoicesModule } from './modules/invoices/invoices.module';
import { PaymentsModule } from './modules/payments/payments.module';
import { ReviewsModule } from './modules/reviews/reviews.module';
import { VouchersModule } from './modules/vouchers/vouchers.module';
import { PlacesModule } from './modules/places/places.module';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { TranslationsModule } from './modules/translations/translations.module';
import { LegalModule } from './modules/legal/legal.module';
import { AdminModule } from './modules/admin/admin.module';
import { RealtimeGatewayModule } from './modules/realtime/realtime.gateway';
import { RealtimeModule } from './modules/realtime/realtime.service';
import { MailModule } from './common/mail';
import { DiscoveryModule } from './modules/discovery/discovery.controller';
import { ConfigModule } from './config/config.module';
import { AuthModule } from './modules/auth/auth.module';
import { HealthModule } from './modules/health/health.controller';
import { MediaModule } from './modules/media/media.module';
import { MenuModule } from './modules/menu/menu.controller';
import { RestaurantsModule } from './modules/restaurants/restaurants.module';
import { TablesModule } from './modules/tables/tables.controller';
import { UsersModule } from './modules/users/users.controller';
import { PrismaModule } from './prisma/prisma.service';

const isDev = (process.env.NODE_ENV ?? 'development') === 'development';

@Module({
  imports: [
    ConfigModule,
    LoggerModule.forRoot({
      pinoHttp: {
        level: process.env.NODE_ENV === 'test' ? 'silent' : isDev ? 'debug' : 'info',
        transport: isDev ? { target: 'pino-pretty', options: { singleLine: true } } : undefined,
        redact: ['req.headers.authorization', 'req.headers.cookie', 'req.body.password', 'req.body.refreshToken', 'req.body.idToken'],
        autoLogging: { ignore: (req) => req.url === '/api/v1/health' },
      },
    }),
    // Production: counters in Redis so every API instance shares them (§3, §23); in-memory elsewhere.
    ThrottlerModule.forRootAsync({
      inject: [RedisService],
      useFactory: (redis: RedisService) => ({
        throttlers: [{ name: 'default', ttl: 60_000, limit: 300 }],
        skipIf: () => process.env.NODE_ENV === 'test',
        storage: process.env.NODE_ENV === 'production' ? new RedisThrottlerStorage(redis.client) : undefined,
      }),
    }),
    PrismaModule,
    ClockModule,
    AuditModule,
    RedisModule,
    JobsModule,
    AvailabilityModule,
    AuthModule,
    UsersModule,
    HealthModule,
    MediaModule,
    RestaurantsModule,
    TablesModule,
    MenuModule,
    DiscoveryModule,
    BookingsModule,
    RealtimeModule,
    MailModule,
    RealtimeGatewayModule,
    KitchenModule,
    GroupModule,
    FeesModule,
    InvoicesModule,
    PaymentsModule,
    ReviewsModule,
    VouchersModule,
    PlacesModule,
    NotificationsModule,
    TranslationsModule,
    LegalModule,
    AdminModule,
  ],
  providers: [
    { provide: APP_GUARD, useClass: ThrottlerGuard },
    { provide: APP_GUARD, useClass: AuthGuard },
  ],
})
export class AppModule {}
