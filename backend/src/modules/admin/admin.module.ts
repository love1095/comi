import { Body, Controller, Get, HttpCode, Module, Param, ParseUUIDPipe, Post, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';
import { IsBoolean, IsOptional, IsString, MaxLength } from 'class-validator';
import { AuditService } from '../../common/audit.service';
import { AdminOnly, CurrentStaffId } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { TokenService } from '../auth/token.service';

const VN_OFFSET_MS = 7 * 3600_000;

/** Start of today and of this month in Vietnam, as UTC instants. */
export function vnPeriods(now: Date) {
  const local = new Date(now.getTime() + VN_OFFSET_MS);
  const day = Date.UTC(local.getUTCFullYear(), local.getUTCMonth(), local.getUTCDate()) - VN_OFFSET_MS;
  const month = Date.UTC(local.getUTCFullYear(), local.getUTCMonth(), 1) - VN_OFFSET_MS;
  return { dayStart: new Date(day), dayEnd: new Date(day + 86_400_000), monthStart: new Date(month) };
}

export class AdminDashboardDto {
  @ApiProperty({ example: { ACTIVE: 12, PENDING_REVIEW: 3 }, type: 'object', additionalProperties: { type: 'number' } })
  restaurants: Record<string, number>;
  @ApiProperty() bookingsToday: number;
  @ApiProperty() bookingsMonth: number;
  @ApiProperty({ description: 'Completed order totals this month (VND)' }) gmvMonth: number;
  @ApiProperty() noShowsMonth: number;
  @ApiProperty() newUsersMonth: number;
  @ApiProperty() reportedReviews: number;
  @ApiProperty() overdueStatements: number;
  @ApiProperty() pendingRefunds: number;
}

export class AdminUserDto {
  @ApiProperty() id: string;
  @ApiPropertyOptional({ nullable: true, type: String }) name: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) phone: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) email: string | null;
  @ApiProperty({ enum: ['ACTIVE', 'BLOCKED', 'DELETED'] }) status: string;
  @ApiProperty() noShowCount: number;
  @ApiProperty() mustPrepay: boolean;
  @ApiProperty() bookings: number;
  @ApiProperty() createdAt: string;
}

export class AdminBookingDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiProperty() status: string;
  @ApiProperty() arrivalAt: string;
  @ApiProperty() partySize: number;
  @ApiProperty() restaurantName: string;
  @ApiProperty() restaurantId: string;
  @ApiPropertyOptional({ nullable: true, type: String }) guestName: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) guestPhone: string | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) total: number | null;
  @ApiProperty() paymentMode: string;
}

export class AuditEntryDto {
  @ApiProperty() id: string;
  @ApiProperty() actorType: string;
  @ApiPropertyOptional({ nullable: true, type: String }) actorId: string | null;
  @ApiProperty() action: string;
  @ApiProperty() entity: string;
  @ApiProperty() entityId: string;
  @ApiPropertyOptional({ type: 'object', nullable: true, additionalProperties: true }) data: unknown;
  @ApiProperty() createdAt: string;
}

class BlockDto {
  @ApiProperty() @IsBoolean() blocked: boolean;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(500) reason?: string;
}

const PAGE = 50;

@ApiTags('admin')
@AdminOnly()
@Controller('admin')
export class AdminController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly tokens: TokenService,
    private readonly clock: Clock,
  ) {}

  @Get('dashboard')
  @ApiOkResponse({ type: AdminDashboardDto })
  async dashboard() {
    const { dayStart, dayEnd, monthStart } = vnPeriods(this.clock.now());
    const [byStatus, bookingsToday, bookingsMonth, gmv, noShows, newUsers, reported, overdue, refunds] = await Promise.all([
      this.prisma.restaurant.groupBy({ by: ['status'], where: { deletedAt: null }, _count: true }),
      this.prisma.booking.count({ where: { arrivalAt: { gte: dayStart, lt: dayEnd } } }),
      this.prisma.booking.count({ where: { arrivalAt: { gte: monthStart } } }),
      this.prisma.order.aggregate({ where: { booking: { status: 'COMPLETED', arrivalAt: { gte: monthStart } } }, _sum: { total: true } }),
      this.prisma.booking.count({ where: { status: 'NO_SHOW', arrivalAt: { gte: monthStart } } }),
      this.prisma.user.count({ where: { createdAt: { gte: monthStart } } }),
      this.prisma.review.count({ where: { status: 'REPORTED' } }),
      this.prisma.statement.count({ where: { status: 'OVERDUE' } }),
      this.prisma.refund.count({ where: { status: 'PENDING' } }),
    ]);
    return {
      restaurants: Object.fromEntries(byStatus.map((r) => [r.status, r._count])),
      bookingsToday,
      bookingsMonth,
      gmvMonth: gmv._sum.total ?? 0,
      noShowsMonth: noShows,
      newUsersMonth: newUsers,
      reportedReviews: reported,
      overdueStatements: overdue,
      pendingRefunds: refunds,
    };
  }

  /** Guests by phone, email or name (support: "I can't book", no-show disputes). */
  @Get('users')
  @ApiQuery({ name: 'q', required: false })
  @ApiOkResponse({ type: [AdminUserDto] })
  async users(@Query('q') q?: string) {
    const term = q?.trim();
    const digits = term?.replace(/\D/g, '');
    const where: Prisma.UserWhereInput = term
      ? {
          OR: [
            { name: { contains: term, mode: 'insensitive' } },
            { email: { contains: term, mode: 'insensitive' } },
            ...(digits && digits.length >= 3 ? [{ phone: { contains: digits.replace(/^0/, '') } }] : []),
          ],
        }
      : {};
    const rows = await this.prisma.user.findMany({
      where,
      orderBy: { createdAt: 'desc' },
      take: PAGE,
      select: { id: true, name: true, phone: true, email: true, status: true, noShowCount: true, mustPrepay: true, createdAt: true, _count: { select: { bookings: true } } },
    });
    return rows.map(({ _count, createdAt, ...u }) => ({ ...u, bookings: _count.bookings, createdAt: createdAt.toISOString() }));
  }

  /** Block (or unblock) a guest: sessions end at once; existing bookings are left to the restaurant. */
  @Post('users/:id/block')
  @HttpCode(200)
  @ApiOkResponse({ type: AdminUserDto })
  async block(@CurrentStaffId() adminId: string, @Param('id', ParseUUIDPipe) id: string, @Body() dto: BlockDto) {
    const u = await this.prisma.user.findUnique({ where: { id } });
    if (!u) throw notFound('User');
    if (u.status === 'DELETED') throw new AppError('CONFLICT', 'Account is deleted');
    await this.prisma.user.update({ where: { id }, data: { status: dto.blocked ? 'BLOCKED' : 'ACTIVE' } });
    if (dto.blocked) await this.tokens.revokeAllFor({ kind: 'user', userId: id });
    await this.audit.log({ actorType: 'STAFF', actorId: adminId, action: dto.blocked ? 'user.block' : 'user.unblock', entity: 'User', entityId: id, data: { reason: dto.reason } });
    return this.userRow(id);
  }

  /** Clear the no-show count after a dispute is settled in the guest's favour. */
  @Post('users/:id/reset-no-show')
  @HttpCode(200)
  @ApiOkResponse({ type: AdminUserDto })
  async resetNoShow(@CurrentStaffId() adminId: string, @Param('id', ParseUUIDPipe) id: string) {
    const u = await this.prisma.user.findUnique({ where: { id } });
    if (!u) throw notFound('User');
    await this.prisma.user.update({ where: { id }, data: { noShowCount: 0, mustPrepay: false } });
    await this.audit.log({ actorType: 'STAFF', actorId: adminId, action: 'user.reset_no_show', entity: 'User', entityId: id, data: { was: u.noShowCount } });
    return this.userRow(id);
  }

  private async userRow(id: string) {
    const { _count, createdAt, ...u } = await this.prisma.user.findUniqueOrThrow({
      where: { id },
      select: { id: true, name: true, phone: true, email: true, status: true, noShowCount: true, mustPrepay: true, createdAt: true, _count: { select: { bookings: true } } },
    });
    return { ...u, bookings: _count.bookings, createdAt: createdAt.toISOString() };
  }

  /** Booking lookup by code (exact) or by guest id (latest first). */
  @Get('bookings')
  @ApiQuery({ name: 'code', required: false })
  @ApiQuery({ name: 'userId', required: false })
  @ApiQuery({ name: 'restaurantId', required: false })
  @ApiOkResponse({ type: [AdminBookingDto] })
  async bookings(@Query('code') code?: string, @Query('userId') userId?: string, @Query('restaurantId') restaurantId?: string) {
    if (!code && !userId && !restaurantId) throw new AppError('VALIDATION_FAILED', 'Give code, userId or restaurantId');
    const rows = await this.prisma.booking.findMany({
      where: { ...(code ? { code: code.trim().toUpperCase() } : {}), ...(userId ? { userId } : {}), ...(restaurantId ? { restaurantId } : {}) },
      orderBy: { arrivalAt: 'desc' },
      take: PAGE,
      include: { restaurant: { select: { name: true } }, user: { select: { name: true, phone: true } }, order: { select: { total: true } } },
    });
    return rows.map((b) => ({
      id: b.id,
      code: b.code,
      status: b.status,
      arrivalAt: b.arrivalAt.toISOString(),
      partySize: b.partySize,
      restaurantId: b.restaurantId,
      restaurantName: b.restaurant.name,
      guestName: b.user.name,
      guestPhone: b.user.phone,
      total: b.order?.total ?? null,
      paymentMode: b.paymentMode,
    }));
  }

  /** Who did what (§23). Filter by entity (e.g. Booking + id) or by actor. */
  @Get('audit')
  @ApiQuery({ name: 'entity', required: false })
  @ApiQuery({ name: 'entityId', required: false })
  @ApiQuery({ name: 'actorId', required: false })
  @ApiQuery({ name: 'before', required: false, description: 'ISO time: older entries (paging)' })
  @ApiOkResponse({ type: [AuditEntryDto] })
  async auditLog(@Query('entity') entity?: string, @Query('entityId') entityId?: string, @Query('actorId') actorId?: string, @Query('before') before?: string) {
    const rows = await this.prisma.auditLog.findMany({
      where: {
        ...(entity ? { entity } : {}),
        ...(entityId ? { entityId } : {}),
        ...(actorId ? { actorId } : {}),
        ...(before ? { createdAt: { lt: new Date(before) } } : {}),
      },
      orderBy: { createdAt: 'desc' },
      take: PAGE,
    });
    return rows.map((r) => ({ ...r, createdAt: r.createdAt.toISOString() }));
  }
}

@Module({ controllers: [AdminController] })
export class AdminModule {}
