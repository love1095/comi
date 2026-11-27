import { Body, Controller, Delete, Get, HttpCode, Param, ParseUUIDPipe, Post } from '@nestjs/common';
import { ApiProperty, ApiTags } from '@nestjs/swagger';
import { ArrayMaxSize, ArrayMinSize, IsArray, IsInt, Max, Min } from 'class-validator';
import { Perm } from '../../common/auth/auth.types';
import { RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { AppError, notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService } from '../availability/availability.service';

class DiningRuleDto {
  @ApiProperty({ example: [1, 2, 3, 4, 5] }) @IsArray() @ArrayMinSize(1) @ArrayMaxSize(7) @IsInt({ each: true }) @Min(0, { each: true }) @Max(6, { each: true })
  weekdays: number[];
  @ApiProperty({ example: 600 }) @IsInt() @Min(0) @Max(1439) startMinute: number;
  @ApiProperty({ example: 840 }) @IsInt() @Min(1) @Max(1440) endMinute: number;
  @ApiProperty({ example: 45 }) @IsInt() @Min(15) @Max(360) diningMinutes: number;
}

/** Table hold time per time window: lunch 45 min, evening 120 min (§5.5, §22.2 #14). */
@ApiTags('restaurant / settings')
@Controller('restaurant/dining-rules')
export class DiningRulesController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly availability: AvailabilityService,
  ) {}

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get()
  list(@RestaurantId() rid: string) {
    return this.prisma.diningRule.findMany({ where: { restaurantId: rid }, orderBy: { startMinute: 'asc' } });
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Post()
  async create(@RestaurantId() rid: string, @Body() dto: DiningRuleDto) {
    if (dto.endMinute <= dto.startMinute) throw new AppError('VALIDATION_FAILED', 'endMinute must be after startMinute');
    const existing = await this.prisma.diningRule.findMany({ where: { restaurantId: rid } });
    const clash = existing.find(
      (r) => r.weekdays.some((d) => dto.weekdays.includes(d)) && r.startMinute < dto.endMinute && dto.startMinute < r.endMinute,
    );
    if (clash) throw new AppError('CONFLICT', 'Overlaps another dining rule', { ruleId: clash.id });
    const rule = await this.prisma.diningRule.create({ data: { ...dto, weekdays: [...new Set(dto.weekdays)].sort(), restaurantId: rid } });
    await this.availability.invalidate(rid);
    return rule;
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Delete(':id')
  @HttpCode(204)
  async remove(@RestaurantId() rid: string, @Param('id', ParseUUIDPipe) id: string) {
    const { count } = await this.prisma.diningRule.deleteMany({ where: { id, restaurantId: rid } });
    if (!count) throw notFound('Dining rule');
    await this.availability.invalidate(rid);
  }
}
