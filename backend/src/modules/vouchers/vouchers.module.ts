import { Throttle } from '@nestjs/throttler';
import { Body, Controller, Get, Global, HttpCode, Injectable, Module, Param, ParseUUIDPipe, Patch, Post } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { Prisma, Voucher, VoucherFunder, VoucherType } from '@prisma/client';
import { Type } from 'class-transformer';
import { ArrayMaxSize, IsArray, IsBoolean, IsDateString, IsEnum, IsInt, IsOptional, IsString, IsUUID, Matches, Max, Min, ValidateNested } from 'class-validator';
import { AuditService } from '../../common/audit.service';
import { Perm } from '../../common/auth/auth.types';
import { AdminOnly, CurrentStaffId, CurrentUserId, CustomerOnly, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { CartLineDto } from '../bookings/bookings.dto';
import { priceCart } from '../bookings/pricing';
import { voucherDiscount, voucherProblem, voucherProblemText } from './voucher-rules';

type Tx = Prisma.TransactionClient;

class VoucherInputDto {
  @ApiProperty({ example: 'TRUA20' }) @Matches(/^[A-Z0-9]{3,20}$/, { message: 'code: 3–20 capital letters or digits' }) code: string;
  @ApiProperty({ enum: VoucherType, enumName: 'VoucherType' }) @IsEnum(VoucherType) type: VoucherType;
  @ApiProperty({ description: 'VND for FIXED, basis points for PERCENT (2000 = 20%)' }) @IsInt() @Min(1) @Max(100_000_000) value: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) maxDiscount?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) minOrder?: number;
  @ApiProperty() @IsDateString() startsAt: string;
  @ApiProperty() @IsDateString() endsAt: string;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) totalLimit?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(100) perUserLimit?: number;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() firstOrderOnly?: boolean;
}

class AdminVoucherInputDto extends VoucherInputDto {
  @ApiPropertyOptional({ description: 'Limit to one restaurant (platform still pays)' }) @IsOptional() @IsUUID() restaurantId?: string;
}

class VoucherActiveDto {
  @ApiProperty() @IsBoolean() isActive: boolean;
}

class VoucherCheckDto {
  @ApiProperty() @IsString() code: string;
  @ApiProperty() @IsUUID() restaurantId: string;
  @ApiProperty({ type: [CartLineDto] })
  @IsArray() @ArrayMaxSize(50) @ValidateNested({ each: true }) @Type(() => CartLineDto)
  items: CartLineDto[];
}

export class VoucherDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiPropertyOptional({ nullable: true, type: String }) restaurantId: string | null;
  @ApiProperty({ enum: VoucherFunder, enumName: 'VoucherFunder' }) fundedBy: VoucherFunder;
  @ApiProperty({ enum: VoucherType, enumName: 'VoucherType' }) type: VoucherType;
  @ApiProperty() value: number;
  @ApiPropertyOptional({ nullable: true, type: Number }) maxDiscount: number | null;
  @ApiProperty() minOrder: number;
  @ApiProperty() startsAt: string;
  @ApiProperty() endsAt: string;
  @ApiPropertyOptional({ nullable: true, type: Number }) totalLimit: number | null;
  @ApiProperty() perUserLimit: number;
  @ApiProperty() firstOrderOnly: boolean;
  @ApiProperty() usedCount: number;
  @ApiProperty() isActive: boolean;
}

export class VoucherCheckResultDto {
  @ApiProperty() valid: boolean;
  @ApiProperty() discount: number;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'Why not (code), when invalid' }) problem: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) message: string | null;
}

const dto = (v: Voucher): VoucherDto => ({
  id: v.id,
  code: v.code,
  restaurantId: v.restaurantId,
  fundedBy: v.fundedBy,
  type: v.type,
  value: v.value,
  maxDiscount: v.maxDiscount,
  minOrder: v.minOrder,
  startsAt: v.startsAt.toISOString(),
  endsAt: v.endsAt.toISOString(),
  totalLimit: v.totalLimit,
  perUserLimit: v.perUserLimit,
  firstOrderOnly: v.firstOrderOnly,
  usedCount: v.usedCount,
  isActive: v.isActive,
});

/** Vouchers (§12): one per booking, alcohol never discounted, row locked while applying. */
@Injectable()
export class VouchersService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
  ) {}

  private async context(db: Tx | PrismaService, voucherId: string, userId: string) {
    const [userUses, completed] = await Promise.all([
      db.voucherRedemption.count({ where: { voucherId, userId, status: 'APPLIED' } }),
      db.booking.count({ where: { userId, status: 'COMPLETED' } }),
    ]);
    return { userUses, userHasCompleted: completed > 0 };
  }

  /** Preview at checkout (not binding: the booking re-checks under a lock). */
  async check(userId: string, p: VoucherCheckDto) {
    const v = await this.prisma.voucher.findUnique({ where: { code: p.code.trim().toUpperCase() } });
    if (!v) return { valid: false, discount: 0, problem: 'NOT_FOUND', message: 'Voucher not found' };
    const eligible = await this.eligibleSubtotal(this.prisma, p.restaurantId, p.items);
    const problem = voucherProblem(v, { now: this.clock.now(), restaurantId: p.restaurantId, eligibleSubtotal: eligible, ...(await this.context(this.prisma, v.id, userId)) });
    if (problem) return { valid: false, discount: 0, problem, message: voucherProblemText[problem] };
    return { valid: true, discount: voucherDiscount(v, eligible), problem: null, message: null };
  }

  private async eligibleSubtotal(db: Tx | PrismaService, restaurantId: string, lines: CartLineDto[]) {
    if (!lines.length) return 0;
    const menu = await db.menuItem.findMany({ where: { id: { in: lines.map((l) => l.menuItemId) }, restaurantId }, include: { optionGroups: { include: { options: true } } } });
    const cart = priceCart(lines, new Map(menu.map((m) => [m.id, m])), { hoursUntilArrival: Number.MAX_SAFE_INTEGER });
    return cart.lines.filter((l) => !l.isAlcohol).reduce((s, l) => s + l.unitPrice * l.quantity, 0);
  }

  /**
   * Inside the booking transaction: lock the voucher row, re-check, count the use.
   * Returns the discount split by who pays it (restaurant voucher lowers the fee base, §11.1).
   */
  async apply(tx: Tx, p: { code: string; userId: string; restaurantId: string; eligibleSubtotal: number }) {
    const [locked] = await tx.$queryRaw<{ id: string }[]>`SELECT id FROM "Voucher" WHERE code = ${p.code.trim().toUpperCase()} FOR UPDATE`;
    if (!locked) throw new AppError('VOUCHER_INVALID', 'Voucher not found', { problem: 'NOT_FOUND' });
    const v = await tx.voucher.findUniqueOrThrow({ where: { id: locked.id } });
    const problem = voucherProblem(v, { now: this.clock.now(), restaurantId: p.restaurantId, eligibleSubtotal: p.eligibleSubtotal, ...(await this.context(tx, v.id, p.userId)) });
    if (problem) throw new AppError('VOUCHER_INVALID', voucherProblemText[problem], { problem });
    const discount = voucherDiscount(v, p.eligibleSubtotal);
    await tx.voucher.update({ where: { id: v.id }, data: { usedCount: { increment: 1 } } });
    return { voucherId: v.id, discount, fundedBy: v.fundedBy };
  }

  /** Booking cancelled / expired: give the use back (§12, payment-timeout releases too). */
  async release(bookingId: string, db: Tx | PrismaService = this.prisma) {
    const rows = await db.voucherRedemption.findMany({ where: { bookingId, status: 'APPLIED' } });
    for (const r of rows) {
      const { count } = await db.voucherRedemption.updateMany({ where: { id: r.id, status: 'APPLIED' }, data: { status: 'RELEASED' } });
      if (count) await db.voucher.update({ where: { id: r.voucherId }, data: { usedCount: { decrement: 1 } } });
    }
  }

  // ───── management ─────

  private validate(p: VoucherInputDto) {
    if (new Date(p.endsAt) <= new Date(p.startsAt)) throw new AppError('VALIDATION_FAILED', 'endsAt must be after startsAt');
    if (p.type === 'PERCENT' && p.value > 10_000) throw new AppError('VALIDATION_FAILED', 'Percent is at most 100% (10000 bps)');
  }

  private async create(p: VoucherInputDto, fundedBy: VoucherFunder, restaurantId: string | null, actor: { type: 'STAFF'; id: string }) {
    this.validate(p);
    try {
      const v = await this.prisma.voucher.create({
        data: {
          code: p.code,
          restaurantId,
          fundedBy,
          type: p.type,
          value: p.value,
          maxDiscount: p.maxDiscount,
          minOrder: p.minOrder ?? 0,
          startsAt: new Date(p.startsAt),
          endsAt: new Date(p.endsAt),
          totalLimit: p.totalLimit,
          perUserLimit: p.perUserLimit ?? 1,
          firstOrderOnly: p.firstOrderOnly ?? false,
        },
      });
      await this.audit.log({ actorType: actor.type, actorId: actor.id, action: 'voucher.created', entity: 'Voucher', entityId: v.id, data: { code: v.code, fundedBy } });
      return dto(v);
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError && e.code === 'P2002') throw new AppError('CONFLICT', 'This code is taken');
      throw e;
    }
  }

  createForRestaurant(restaurantId: string, staffId: string, p: VoucherInputDto) {
    return this.create(p, 'RESTAURANT', restaurantId, { type: 'STAFF', id: staffId });
  }

  createPlatform(adminId: string, p: AdminVoucherInputDto) {
    return this.create(p, 'PLATFORM', p.restaurantId ?? null, { type: 'STAFF', id: adminId });
  }

  async list(where: Prisma.VoucherWhereInput) {
    return (await this.prisma.voucher.findMany({ where, orderBy: { startsAt: 'desc' }, take: 200 })).map(dto);
  }

  async setActive(id: string, isActive: boolean, by: { restaurantId?: string; staffId: string }) {
    const v = await this.prisma.voucher.findFirst({ where: { id, ...(by.restaurantId ? { restaurantId: by.restaurantId, fundedBy: 'RESTAURANT' } : {}) } });
    if (!v) throw notFound('Voucher');
    const u = await this.prisma.voucher.update({ where: { id }, data: { isActive } });
    await this.audit.log({ actorType: 'STAFF', actorId: by.staffId, action: isActive ? 'voucher.activated' : 'voucher.paused', entity: 'Voucher', entityId: id });
    return dto(u);
  }
}

const uuid = new ParseUUIDPipe();

@ApiTags('customer / vouchers')
@CustomerOnly()
@Controller('vouchers')
export class CustomerVouchersController {
  constructor(private readonly vouchers: VouchersService) {}

  @Throttle({ default: { limit: 10, ttl: 60_000 } }) // stops guessing codes
  @Post('check')
  @HttpCode(200)
  @ApiOkResponse({ type: VoucherCheckResultDto })
  check(@CurrentUserId() userId: string, @Body() dto: VoucherCheckDto) {
    return this.vouchers.check(userId, dto);
  }
}

@ApiTags('restaurant / vouchers')
@Controller('restaurant/vouchers')
export class RestaurantVouchersController {
  constructor(private readonly vouchers: VouchersService) {}

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get()
  @ApiOkResponse({ type: [VoucherDto] })
  list(@RestaurantId() rid: string) {
    return this.vouchers.list({ restaurantId: rid });
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post()
  @ApiOkResponse({ type: VoucherDto })
  create(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Body() dto: VoucherInputDto) {
    return this.vouchers.createForRestaurant(rid, staffId, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Patch(':id')
  @ApiOkResponse({ type: VoucherDto })
  active(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: VoucherActiveDto) {
    return this.vouchers.setActive(id, dto.isActive, { restaurantId: rid, staffId });
  }
}

@ApiTags('admin / vouchers')
@AdminOnly()
@Controller('admin/vouchers')
export class AdminVouchersController {
  constructor(private readonly vouchers: VouchersService) {}

  @Get()
  @ApiOkResponse({ type: [VoucherDto] })
  list() {
    return this.vouchers.list({ fundedBy: 'PLATFORM' });
  }

  @Post()
  @ApiOkResponse({ type: VoucherDto })
  create(@CurrentStaffId() adminId: string, @Body() dto: AdminVoucherInputDto) {
    return this.vouchers.createPlatform(adminId, dto);
  }

  @Patch(':id')
  @ApiOkResponse({ type: VoucherDto })
  active(@CurrentStaffId() adminId: string, @Param('id', uuid) id: string, @Body() dto: VoucherActiveDto) {
    return this.vouchers.setActive(id, dto.isActive, { staffId: adminId });
  }
}

@Global()
@Module({ controllers: [CustomerVouchersController, RestaurantVouchersController, AdminVouchersController], providers: [VouchersService], exports: [VouchersService] })
export class VouchersModule {}
