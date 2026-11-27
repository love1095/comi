import { Throttle } from '@nestjs/throttler';
import { Body, Controller, Get, HttpCode, Injectable, Module, Param, ParseUUIDPipe, Post, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';
import { IsBoolean, IsInt, IsOptional, IsString, Max, MaxLength, Min, MinLength } from 'class-validator';
import { AuditService } from '../../common/audit.service';
import { Perm } from '../../common/auth/auth.types';
import { AdminOnly, CurrentStaffId, CurrentUserId, CustomerOnly, Public, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';
import { reviewWindowProblem, roundRating } from './review-rules';

class CreateReviewDto {
  @ApiProperty({ minimum: 1, maximum: 5 }) @IsInt() @Min(1) @Max(5) rating: number;
  @ApiPropertyOptional({ minimum: 1, maximum: 5 }) @IsOptional() @IsInt() @Min(1) @Max(5) foodRating?: number;
  @ApiPropertyOptional({ minimum: 1, maximum: 5 }) @IsOptional() @IsInt() @Min(1) @Max(5) serviceRating?: number;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(2000) text?: string;
}

class ReplyDto {
  @ApiProperty() @IsString() @MinLength(2) @MaxLength(1000) reply: string;
}

class ReportReviewDto {
  @ApiProperty() @IsString() @MinLength(5) @MaxLength(500) reason: string;
}

class DecisionDto {
  @ApiProperty({ description: 'true = hide the review, false = keep it' }) @IsBoolean() hide: boolean;
}

export class ReviewDto {
  @ApiProperty() id: string;
  @ApiProperty() bookingId: string;
  @ApiProperty() restaurantId: string;
  @ApiProperty({ description: 'First name only (privacy)' }) authorName: string;
  @ApiProperty() rating: number;
  @ApiPropertyOptional({ nullable: true, type: Number }) foodRating: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) serviceRating: number | null;
  @ApiPropertyOptional({ nullable: true, type: String }) text: string | null;
  @ApiProperty({ description: 'Every review comes from a real booking' }) verifiedVisit: boolean;
  @ApiProperty() visitedAt: string;
  @ApiProperty() partySize: number;
  @ApiPropertyOptional({ nullable: true, type: String }) reply: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) repliedAt: string | null;
  @ApiProperty({ enum: ['PUBLISHED', 'HIDDEN', 'REPORTED'] }) status: string;
  @ApiPropertyOptional({ nullable: true, type: String }) reportReason: string | null;
  @ApiProperty() createdAt: string;
}

export class ReviewPageDto {
  @ApiProperty() ratingAvg: number;
  @ApiProperty() ratingCount: number;
  @ApiProperty({ type: [Number], description: 'How many 1★..5★ reviews (index 0 = 1★)' }) histogram: number[];
  @ApiProperty({ type: [ReviewDto] }) items: ReviewDto[];
  @ApiPropertyOptional({ nullable: true, type: String }) nextCursor: string | null;
}

const INCLUDE = { user: { select: { name: true } }, booking: { select: { arrivalAt: true, partySize: true } } } satisfies Prisma.ReviewInclude;
type Row = Prisma.ReviewGetPayload<{ include: typeof INCLUDE }>;

/** "Nguyễn Văn An" → "An" — reviews never show full names or phones. */
export const firstName = (name: string | null | undefined) => name?.trim().split(/\s+/).pop() || 'Khách';

const dto = (r: Row): ReviewDto => ({
  id: r.id,
  bookingId: r.bookingId,
  restaurantId: r.restaurantId,
  authorName: firstName(r.user.name),
  rating: r.rating,
  foodRating: r.foodRating,
  serviceRating: r.serviceRating,
  text: r.text,
  verifiedVisit: true,
  visitedAt: r.booking.arrivalAt.toISOString(),
  partySize: r.booking.partySize,
  reply: r.reply,
  repliedAt: r.repliedAt?.toISOString() ?? null,
  status: r.status,
  reportReason: r.reportReason,
  createdAt: r.createdAt.toISOString(),
});

/** Reviews and ratings (§15). Every review comes from a real visit; restaurants reply once or report. */
@Injectable()
export class ReviewsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly realtime: RealtimeService,
  ) {}

  /** Keep Restaurant.ratingAvg / ratingCount in step (hidden reviews do not count). */
  private async recompute(tx: Prisma.TransactionClient, restaurantId: string) {
    const agg = await tx.review.aggregate({ where: { restaurantId, status: { not: 'HIDDEN' } }, _avg: { rating: true }, _count: true });
    await tx.restaurant.update({ where: { id: restaurantId }, data: { ratingAvg: roundRating(agg._avg.rating), ratingCount: agg._count } });
  }

  async create(userId: string, bookingId: string, p: CreateReviewDto) {
    const b = await this.prisma.booking.findFirst({ where: { id: bookingId, userId }, include: { review: true } });
    if (!b) throw notFound('Booking');
    if (b.review) throw new AppError('CONFLICT', 'You already reviewed this visit');
    const problem = reviewWindowProblem(b, this.clock.now());
    if (problem) {
      throw new AppError('REVIEW_NOT_ALLOWED', problem === 'TOO_LATE' ? 'Reviews are open for 14 days after the visit' : 'Review after your meal', { reason: problem });
    }
    const r = await this.prisma.$transaction(async (tx) => {
      const created = await tx.review.create({
        data: {
          bookingId,
          restaurantId: b.restaurantId,
          userId,
          rating: p.rating,
          foodRating: p.foodRating,
          serviceRating: p.serviceRating,
          text: p.text?.trim() || null,
          photoIds: [],
        },
        include: INCLUDE,
      });
      await this.recompute(tx, b.restaurantId);
      await this.audit.log({ actorType: 'USER', actorId: userId, action: 'review.created', entity: 'Review', entityId: created.id, data: { rating: p.rating } }, tx);
      return created;
    });
    this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId, review: r.rating });
    return dto(r);
  }

  async mine(userId: string, bookingId: string) {
    const r = await this.prisma.review.findFirst({ where: { bookingId, userId }, include: INCLUDE });
    if (!r) throw notFound('Review');
    return dto(r);
  }

  /** Public list: newest first, reported ones stay visible until an admin decides. */
  async forRestaurant(restaurantId: string, cursor?: string, includeHidden = false) {
    const take = 20;
    const where: Prisma.ReviewWhereInput = { restaurantId, ...(includeHidden ? {} : { status: { not: 'HIDDEN' } }) };
    const [rows, restaurant, groups] = await Promise.all([
      this.prisma.review.findMany({ where, include: INCLUDE, orderBy: [{ createdAt: 'desc' }, { id: 'desc' }], take: take + 1, ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}) }),
      this.prisma.restaurant.findUnique({ where: { id: restaurantId }, select: { ratingAvg: true, ratingCount: true } }),
      this.prisma.review.groupBy({ by: ['rating'], where: { restaurantId, status: { not: 'HIDDEN' } }, _count: true }),
    ]);
    if (!restaurant) throw notFound('Restaurant');
    const histogram = [1, 2, 3, 4, 5].map((s) => groups.find((g) => g.rating === s)?._count ?? 0);
    return {
      ratingAvg: Number(restaurant.ratingAvg),
      ratingCount: restaurant.ratingCount,
      histogram,
      items: rows.slice(0, take).map(dto),
      nextCursor: rows.length > take ? rows[take - 1].id : null,
    };
  }

  private async ofRestaurant(restaurantId: string, id: string) {
    const r = await this.prisma.review.findFirst({ where: { id, restaurantId } });
    if (!r) throw notFound('Review');
    return r;
  }

  async reply(restaurantId: string, staffId: string, id: string, reply: string) {
    const r = await this.ofRestaurant(restaurantId, id);
    if (r.reply) throw new AppError('CONFLICT', 'You can reply once');
    const updated = await this.prisma.review.update({ where: { id }, data: { reply: reply.trim(), repliedAt: this.clock.now() }, include: INCLUDE });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'review.replied', entity: 'Review', entityId: id });
    return dto(updated);
  }

  async report(restaurantId: string, staffId: string, id: string, reason: string) {
    const r = await this.ofRestaurant(restaurantId, id);
    if (r.status === 'HIDDEN') throw new AppError('INVALID_STATUS', 'Already hidden');
    const updated = await this.prisma.review.update({ where: { id }, data: { status: 'REPORTED', reportReason: reason.trim() }, include: INCLUDE });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'review.reported', entity: 'Review', entityId: id, data: { reason } });
    return dto(updated);
  }

  async reported() {
    const rows = await this.prisma.review.findMany({ where: { status: 'REPORTED' }, include: INCLUDE, orderBy: { createdAt: 'asc' }, take: 200 });
    return rows.map(dto);
  }

  async decide(adminId: string, id: string, hide: boolean) {
    const r = await this.prisma.review.findUnique({ where: { id } });
    if (!r) throw notFound('Review');
    const updated = await this.prisma.$transaction(async (tx) => {
      const u = await tx.review.update({ where: { id }, data: { status: hide ? 'HIDDEN' : 'PUBLISHED' }, include: INCLUDE });
      await this.recompute(tx, r.restaurantId);
      await this.audit.log({ actorType: 'STAFF', actorId: adminId, action: hide ? 'review.hidden' : 'review.kept', entity: 'Review', entityId: id }, tx);
      return u;
    });
    return dto(updated);
  }
}

const uuid = new ParseUUIDPipe();

@ApiTags('customer / reviews')
@Controller()
export class ReviewsController {
  constructor(private readonly reviews: ReviewsService) {}

  @CustomerOnly()
  @Throttle({ default: { limit: 10, ttl: 60_000 } })
  @Post('bookings/:id/review')
  @HttpCode(200)
  @ApiOkResponse({ type: ReviewDto })
  create(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: CreateReviewDto) {
    return this.reviews.create(userId, id, dto);
  }

  @CustomerOnly()
  @Get('bookings/:id/review')
  @ApiOkResponse({ type: ReviewDto })
  mine(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.reviews.mine(userId, id);
  }

  @Public()
  @Get('restaurants/:id/reviews')
  @ApiQuery({ name: 'cursor', required: false })
  @ApiOkResponse({ type: ReviewPageDto })
  list(@Param('id', uuid) id: string, @Query('cursor') cursor?: string) {
    return this.reviews.forRestaurant(id, cursor);
  }
}

@ApiTags('restaurant / reviews')
@Controller('restaurant/reviews')
export class RestaurantReviewsController {
  constructor(private readonly reviews: ReviewsService) {}

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get()
  @ApiQuery({ name: 'cursor', required: false })
  @ApiOkResponse({ type: ReviewPageDto })
  list(@RestaurantId() rid: string, @Query('cursor') cursor?: string) {
    return this.reviews.forRestaurant(rid, cursor, true);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post(':id/reply')
  @HttpCode(200)
  @ApiOkResponse({ type: ReviewDto })
  reply(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: ReplyDto) {
    return this.reviews.reply(rid, staffId, id, dto.reply);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Throttle({ default: { limit: 20, ttl: 3_600_000 } })
  @Post(':id/report')
  @HttpCode(200)
  @ApiOkResponse({ type: ReviewDto })
  report(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: ReportReviewDto) {
    return this.reviews.report(rid, staffId, id, dto.reason);
  }
}

@ApiTags('admin / reviews')
@AdminOnly()
@Controller('admin/reviews')
export class AdminReviewsController {
  constructor(private readonly reviews: ReviewsService) {}

  @Get('reported')
  @ApiOkResponse({ type: [ReviewDto] })
  reported() {
    return this.reviews.reported();
  }

  @Post(':id/decision')
  @HttpCode(200)
  @ApiOkResponse({ type: ReviewDto })
  decide(@CurrentStaffId() adminId: string, @Param('id', uuid) id: string, @Body() dto: DecisionDto) {
    return this.reviews.decide(adminId, id, dto.hide);
  }
}

@Module({ controllers: [ReviewsController, RestaurantReviewsController, AdminReviewsController], providers: [ReviewsService] })
export class ReviewsModule {}
