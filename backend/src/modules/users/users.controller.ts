import { Body, Controller, Delete, Get, HttpCode, Module, Patch, Post } from '@nestjs/common';
import { ApiOkResponse, ApiPropertyOptional, ApiProperty, ApiTags } from '@nestjs/swagger';
import { MeDto } from '../../common/customer-responses';
import { IsEmail, IsIn, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';
import { CurrentUserId, CustomerOnly } from '../../common/auth/decorators';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { TokenService } from '../auth/token.service';
import { MeExtrasController } from './me-extras.controller';

export const LOCALES = ['vi', 'en', 'ko', 'zh', 'ja'] as const;

class UpdateMeDto {
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(100) name?: string;
  @ApiPropertyOptional() @IsOptional() @IsEmail() email?: string;
  @ApiPropertyOptional({ enum: LOCALES }) @IsOptional() @IsIn(LOCALES) locale?: string;
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
  async remove(@CurrentUserId() userId: string) {
    await this.prisma.$transaction(async (tx) => {
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
