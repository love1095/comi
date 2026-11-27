import { Body, Controller, Delete, Get, HttpCode, Module, Patch, Post } from '@nestjs/common';
import { ApiOkResponse, ApiPropertyOptional, ApiProperty, ApiTags } from '@nestjs/swagger';
import { MeDto } from '../../common/customer-responses';
import { IsBoolean, IsEmail, IsIn, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';
import { CurrentUserId, CustomerOnly } from '../../common/auth/decorators';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { Throttle } from '@nestjs/throttler';
import { TERMS_VERSION } from '../legal/legal-texts';
import { PrismaService } from '../../prisma/prisma.service';
import { TokenService } from '../auth/token.service';
import { MeExtrasController } from './me-extras.controller';

export const LOCALES = ['vi', 'en', 'ko', 'zh', 'ja'] as const;

class UpdateMeDto {
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(100) name?: string;
  @ApiPropertyOptional() @IsOptional() @IsEmail() email?: string;
  @ApiPropertyOptional({ enum: LOCALES }) @IsOptional() @IsIn(LOCALES) locale?: string;
}

class ConsentDto {
  @ApiProperty({ example: '2026-12' }) @IsString() @MaxLength(20) termsVersion: string;
  @ApiPropertyOptional({ description: 'Offers and news by notification/email' }) @IsOptional() @IsBoolean() marketing?: boolean;
}

class DeviceTokenDto {
  @ApiProperty() @IsString() @MinLength(10) @MaxLength(4096) token: string;
  @ApiProperty({ enum: ['ios', 'android'] }) @IsIn(['ios', 'android']) platform: string;
}

const ME_SELECT = {
  id: true,
  phone: true,
  email: true,
  name: true,
  avatarUrl: true,
  locale: true,
  noShowCount: true,
  mustPrepay: true,
  createdAt: true,
  termsVersion: true,
  marketingOptIn: true,
} as const;

@ApiTags('me')
@CustomerOnly()
@Controller('me')
export class UsersController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tokens: TokenService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
  ) {}

  @Get()
  @ApiOkResponse({ type: MeDto })
  async me(@CurrentUserId() userId: string) {
    const user = await this.prisma.user.findFirst({ where: { id: userId, deletedAt: null }, select: ME_SELECT });
    if (!user) throw notFound('User');
    return user;
  }

  @Patch()
  @ApiOkResponse({ type: MeDto })
  update(@CurrentUserId() userId: string, @Body() dto: UpdateMeDto) {
    return this.prisma.user.update({ where: { id: userId }, data: dto, select: ME_SELECT });
  }

  /**
   * Account deletion (required by Apple/Google, §18.1): anonymize personal data,
   * keep bookings and fees for accounting.
   */
  @Delete()
  @HttpCode(204)
  @Throttle({ default: { limit: 3, ttl: 60_000 } })
  async remove(@CurrentUserId() userId: string) {
    // Upcoming or ongoing bookings must be cancelled first (prepaid money, restaurant waiting).
    const active = await this.prisma.booking.count({
      where: { userId, OR: [{ status: 'CHECKED_IN' }, { status: { in: ['PENDING', 'CONFIRMED'] }, arrivalAt: { gt: this.clock.now() } }] },
    });
    if (active) throw new AppError('ACTIVE_BOOKINGS', 'Cancel or finish your upcoming bookings first', { count: active });
    await this.prisma.$transaction(async (tx) => {
      await tx.notification.deleteMany({ where: { userId } });
      await tx.user.update({
        where: { id: userId },
        data: {
          firebaseUid: `deleted:${userId}`,
          phone: null,
          email: null,
          name: null,
          avatarUrl: null,
          status: 'DELETED',
          deletedAt: this.clock.now(),
        },
      });
      await tx.deviceToken.deleteMany({ where: { userId } });
      await tx.invoiceProfile.deleteMany({ where: { userId } });
      await tx.savedOrder.deleteMany({ where: { userId } });
      await tx.favoriteItem.deleteMany({ where: { userId } });
      await this.audit.log({ actorType: 'USER', actorId: userId, action: 'user.delete', entity: 'User', entityId: userId }, tx);
    });
    await this.tokens.revokeAllFor({ kind: 'user', userId });
  }

  /** Consent to the current terms + privacy policy (Decree 13/2023): stored with time and version. */
  @Post('consent')
  @HttpCode(200)
  @ApiOkResponse({ type: MeDto })
  async consent(@CurrentUserId() userId: string, @Body() dto: ConsentDto) {
    if (dto.termsVersion !== TERMS_VERSION) throw new AppError('VALIDATION_FAILED', `Current terms version is ${TERMS_VERSION}`);
    const user = await this.prisma.user.update({
      where: { id: userId },
      data: { termsVersion: dto.termsVersion, termsAcceptedAt: this.clock.now(), marketingOptIn: dto.marketing ?? false },
      select: ME_SELECT,
    });
    await this.audit.log({ actorType: 'USER', actorId: userId, action: 'user.consent', entity: 'User', entityId: userId, data: dto });
    return user;
  }

  /** "Download my data" (right of access, Decree 13/2023 art. 14). */
  @Get('export')
  @Throttle({ default: { limit: 3, ttl: 3_600_000 } })
  @ApiOkResponse({ description: 'JSON with profile, bookings, orders, reviews, invoice profiles' })
  async export(@CurrentUserId() userId: string) {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      select: {
        ...ME_SELECT,
        termsAcceptedAt: true,
        bookings: {
          select: {
            code: true,
            status: true,
            arrivalAt: true,
            partySize: true,
            restaurant: { select: { name: true } },
            order: { select: { total: true, items: { select: { nameSnapshot: true, quantity: true, unitPrice: true } } } },
          },
          orderBy: { arrivalAt: 'desc' },
        },
        reviews: { select: { rating: true, text: true, createdAt: true } },
        invoiceProfiles: true,
        favorites: { select: { menuItemId: true } },
      },
    });
    return { exportedAt: this.clock.now().toISOString(), user };
  }

  @Post('device-tokens')
  @HttpCode(204)
  async addDeviceToken(@CurrentUserId() userId: string, @Body() dto: DeviceTokenDto) {
    await this.prisma.deviceToken.upsert({
      where: { token: dto.token },
      create: { token: dto.token, platform: dto.platform, userId },
      update: { userId, staffId: null, platform: dto.platform },
    });
  }
}

@Module({ controllers: [UsersController, MeExtrasController] })
export class UsersModule {}
