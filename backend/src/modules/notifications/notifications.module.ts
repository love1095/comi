import { Controller, Get, Global, HttpCode, Injectable, Logger, Module, Param, ParseUUIDPipe, Post, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { CurrentUserId, CustomerOnly } from '../../common/auth/decorators';
import { PrismaService } from '../../prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';
import { BookingEvent, bookingNotice } from './notice';

export class NotificationDto {
  @ApiProperty() id: string;
  @ApiProperty({ example: 'booking.confirmed' }) type: string;
  @ApiProperty() title: string;
  @ApiProperty() body: string;
  @ApiPropertyOptional({ nullable: true, type: String }) bookingId: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) readAt: string | null;
  @ApiProperty() createdAt: string;
}

export class NotificationPageDto {
  @ApiProperty({ type: [NotificationDto] }) items: NotificationDto[];
  @ApiProperty() unread: number;
  @ApiPropertyOptional({ nullable: true, type: String }) nextCursor: string | null;
}

const PAGE = 30;

@Injectable()
export class NotificationsService {
  private readonly logger = new Logger(NotificationsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly realtime: RealtimeService,
  ) {}

  /**
   * Booking changed: tell the open app (realtime hint, as before) and keep a notification-center
   * entry when the change matters to the guest. ⬜ FCM push once Firebase is configured.
   */
  async booking(userId: string, payload: BookingEvent & { bookingId: string }) {
    this.realtime.toUser(userId, 'booking.status', payload);
    try {
      const b = await this.prisma.booking.findUnique({ where: { id: payload.bookingId }, select: { code: true, restaurant: { select: { name: true } } } });
      if (!b) return;
      const n = bookingNotice(payload, { code: b.code, restaurantName: b.restaurant.name });
      if (!n) return;
      const row = await this.prisma.notification.create({ data: { userId, bookingId: payload.bookingId, ...n } });
      this.realtime.toUser(userId, 'notification.new', { id: row.id, type: n.type });
    } catch (e) {
      // Never let the notification center break a booking change.
      this.logger.warn(`notification failed: ${(e as Error).message}`);
    }
  }

  async list(userId: string, cursor?: string) {
    const rows = await this.prisma.notification.findMany({
      where: { userId },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: PAGE + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
    });
    const unread = await this.prisma.notification.count({ where: { userId, readAt: null } });
    return {
      items: rows.slice(0, PAGE).map((n) => ({ ...n, readAt: n.readAt?.toISOString() ?? null, createdAt: n.createdAt.toISOString() })),
      unread,
      nextCursor: rows.length > PAGE ? rows[PAGE - 1].id : null,
    };
  }

  async read(userId: string, id?: string) {
    await this.prisma.notification.updateMany({ where: { userId, readAt: null, ...(id ? { id } : {}) }, data: { readAt: new Date() } });
    return { unread: await this.prisma.notification.count({ where: { userId, readAt: null } }) };
  }
}

class UnreadDto {
  @ApiProperty() unread: number;
}

@ApiTags('customer / notifications')
@CustomerOnly()
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notifications: NotificationsService) {}

  @Get()
  @ApiQuery({ name: 'cursor', required: false })
  @ApiOkResponse({ type: NotificationPageDto })
  list(@CurrentUserId() userId: string, @Query('cursor') cursor?: string) {
    return this.notifications.list(userId, cursor);
  }

  @Post('read-all')
  @HttpCode(200)
  @ApiOkResponse({ type: UnreadDto })
  readAll(@CurrentUserId() userId: string) {
    return this.notifications.read(userId);
  }

  @Post(':id/read')
  @HttpCode(200)
  @ApiOkResponse({ type: UnreadDto })
  readOne(@CurrentUserId() userId: string, @Param('id', ParseUUIDPipe) id: string) {
    return this.notifications.read(userId, id);
  }
}

@Global()
@Module({ controllers: [NotificationsController], providers: [NotificationsService], exports: [NotificationsService] })
export class NotificationsModule {}
