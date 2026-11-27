import { Body, Controller, Delete, Get, HttpCode, Param, ParseUUIDPipe, Patch, Post, Put } from '@nestjs/common';
import { ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { Prisma } from '@prisma/client';
import { CurrentUserId, CustomerOnly } from '../../common/auth/decorators';
import { notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { CartLineDto } from '../bookings/bookings.dto';

class FavoriteDto {
  @ApiProperty() @IsUUID() menuItemId: string;
}

class SavedOrderDto {
  @ApiProperty() @IsUUID() restaurantId: string;
  @ApiPropertyOptional({ default: 'My usual' }) @IsOptional() @IsString() @MinLength(1) @MaxLength(40) name?: string;
  @ApiProperty({ type: [CartLineDto] })
  @IsArray() @ArrayMaxSize(30) @ValidateNested({ each: true }) @Type(() => CartLineDto)
  items: CartLineDto[];
}

class PreferencesDto {
  @ApiPropertyOptional() @IsOptional() @IsBoolean() lunchReminder?: boolean;
  @ApiPropertyOptional({ example: 630, description: 'Minutes from midnight (10:30)' })
  @IsOptional() @IsInt() @Min(540) @Max(720) lunchReminderMinute?: number;
  @ApiPropertyOptional({ type: [String] }) @IsOptional() @IsArray() @ArrayMaxSize(10) @IsString({ each: true }) dietaryTags?: string[];
  @ApiPropertyOptional({ enum: ['USD', 'KRW', 'CNY', 'JPY'] }) @IsOptional() @IsIn(['USD', 'KRW', 'CNY', 'JPY']) showApproxCurrency?: string;
}

/** Lunch habits (§0.1): favorite dishes, "my usual" per restaurant, reminders. */
@ApiTags('me')
@CustomerOnly()
@Controller('me')
export class MeExtrasController {
  constructor(private readonly prisma: PrismaService) {}

  @Get('favorites')
  favorites(@CurrentUserId() userId: string) {
    return this.prisma.favoriteItem.findMany({
      where: { userId, menuItem: { deletedAt: null } },
      orderBy: { createdAt: 'desc' },
      include: {
        menuItem: {
          select: {
            id: true, name: true, price: true, isAvailable: true,
            photos: { take: 1, orderBy: { sortOrder: 'asc' }, select: { publicId: true, blurhash: true } },
            restaurant: { select: { id: true, slug: true, name: true } },
          },
        },
      },
    });
  }

  @Post('favorites')
  @HttpCode(204)
  async addFavorite(@CurrentUserId() userId: string, @Body() dto: FavoriteDto) {
    const item = await this.prisma.menuItem.findFirst({ where: { id: dto.menuItemId, deletedAt: null }, select: { id: true } });
    if (!item) throw notFound('Menu item');
    await this.prisma.favoriteItem.upsert({
      where: { userId_menuItemId: { userId, menuItemId: dto.menuItemId } },
      create: { userId, menuItemId: dto.menuItemId },
      update: {},
    });
  }

  @Delete('favorites/:menuItemId')
  @HttpCode(204)
  async removeFavorite(@CurrentUserId() userId: string, @Param('menuItemId', ParseUUIDPipe) menuItemId: string) {
    await this.prisma.favoriteItem.deleteMany({ where: { userId, menuItemId } });
  }

  @Get('saved-orders')
  savedOrders(@CurrentUserId() userId: string) {
    return this.prisma.savedOrder.findMany({
      where: { userId },
      include: { restaurant: { select: { id: true, slug: true, name: true, coverPhotoUrl: true } } },
    });
  }

  /** Create or replace "my usual" (unique per user + restaurant + name). */
  @Put('saved-orders')
  async saveOrder(@CurrentUserId() userId: string, @Body() dto: SavedOrderDto) {
    const r = await this.prisma.restaurant.findFirst({ where: { id: dto.restaurantId, deletedAt: null }, select: { id: true } });
    if (!r) throw notFound('Restaurant');
    const name = dto.name ?? 'My usual';
    const items = dto.items as unknown as Prisma.InputJsonValue;
    return this.prisma.savedOrder.upsert({
      where: { userId_restaurantId_name: { userId, restaurantId: dto.restaurantId, name } },
      create: { userId, restaurantId: dto.restaurantId, name, items },
      update: { items },
    });
  }

  @Delete('saved-orders/:id')
  @HttpCode(204)
  async deleteSavedOrder(@CurrentUserId() userId: string, @Param('id', ParseUUIDPipe) id: string) {
    await this.prisma.savedOrder.deleteMany({ where: { id, userId } });
  }

  @Get('preferences')
  preferences(@CurrentUserId() userId: string) {
    return this.prisma.userPreference.upsert({ where: { userId }, create: { userId }, update: {} });
  }

  @Patch('preferences')
  updatePreferences(@CurrentUserId() userId: string, @Body() dto: PreferencesDto) {
    return this.prisma.userPreference.upsert({ where: { userId }, create: { userId, ...dto }, update: dto });
  }
}
