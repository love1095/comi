import { Body, Controller, Get, Global, HttpCode, Module, Param, ParseUUIDPipe, Post, Put } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { Course, KitchenStatus } from '@prisma/client';
import { Type } from 'class-transformer';
import { ArrayMaxSize, ArrayMinSize, IsArray, IsEnum, IsIn, IsInt, IsOptional, Max, Min, ValidateNested } from 'class-validator';
import { Perm } from '../../common/auth/auth.types';
import { CurrentStaffId, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { CapacityRuleDto, FireResultDto, KitchenItemDto, KitchenQueueDto } from '../../common/responses';
import { AppError } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { KitchenService } from './kitchen.service';

const uuid = new ParseUUIDPipe();

class KitchenStatusDto {
  @ApiProperty({ enum: ['QUEUED', 'COOKING', 'READY', 'SERVED'] }) @IsIn(['QUEUED', 'COOKING', 'READY', 'SERVED']) status: KitchenStatus;
}

class CapacityRuleInput {
  @ApiProperty({ type: [Number] }) @IsArray() @ArrayMinSize(1) @ArrayMaxSize(7) @IsInt({ each: true }) @Min(0, { each: true }) @Max(6, { each: true }) weekdays: number[];
  @ApiProperty() @IsInt() @Min(0) @Max(1439) startMinute: number;
  @ApiProperty() @IsInt() @Min(1) @Max(2880) endMinute: number;
  @ApiProperty() @IsIn([10, 15, 20, 30]) windowMinutes: number;
  @ApiProperty() @IsInt() @Min(1) @Max(500) maxItems: number;
}

class CapacityRulesDto {
  @ApiProperty({ type: [CapacityRuleInput] }) @IsArray() @ArrayMaxSize(20) @ValidateNested({ each: true }) @Type(() => CapacityRuleInput) rules: CapacityRuleInput[];
}

class FireDto {
  @ApiPropertyOptional({ enum: Course, enumName: 'Course', description: 'Omit to fire everything still waiting' })
  @IsOptional()
  @IsEnum(Course)
  course?: Course;
}

@ApiTags('restaurant / kitchen')
@Controller('restaurant/kitchen')
export class KitchenController {
  constructor(
    private readonly kitchen: KitchenService,
    private readonly prisma: PrismaService,
  ) {}

  /** Kitchen capacity limit (§7.6): empty list = no limit. */
  @RestaurantRoles(...Perm.KITCHEN)
  @Get('capacity-rules')
  @ApiOkResponse({ type: [CapacityRuleDto] })
  rules(@RestaurantId() rid: string) {
    return this.prisma.kitchenCapacityRule.findMany({ where: { restaurantId: rid }, select: { weekdays: true, startMinute: true, endMinute: true, windowMinutes: true, maxItems: true } });
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('capacity-rules')
  @ApiOkResponse({ type: [CapacityRuleDto] })
  async replaceRules(@RestaurantId() rid: string, @Body() dto: CapacityRulesDto) {
    if (dto.rules.some((r) => r.endMinute <= r.startMinute)) throw new AppError('VALIDATION_FAILED', 'endMinute must be after startMinute');
    await this.prisma.$transaction([
      this.prisma.kitchenCapacityRule.deleteMany({ where: { restaurantId: rid } }),
      this.prisma.kitchenCapacityRule.createMany({ data: dto.rules.map((r) => ({ ...r, restaurantId: rid })) }),
    ]);
    return this.rules(rid);
  }

  /** The truth after any socket hint or reconnect (§19.1). */
  @RestaurantRoles(...Perm.KITCHEN)
  @Get('queue')
  @ApiOkResponse({ type: KitchenQueueDto })
  queue(@RestaurantId() rid: string) {
    return this.kitchen.queue(rid);
  }

  @RestaurantRoles(...Perm.KITCHEN)
  @Post('items/:id/status')
  @HttpCode(200)
  @ApiOkResponse({ type: KitchenItemDto })
  setStatus(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: KitchenStatusDto) {
    return this.kitchen.setStatus(rid, staffId, id, dto.status);
  }

  /** "Fire dessert" / "Start now" for one booking. */
  @RestaurantRoles(...Perm.KITCHEN)
  @Post('bookings/:id/fire')
  @HttpCode(200)
  @ApiOkResponse({ type: FireResultDto })
  fire(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: FireDto) {
    return this.kitchen.fire(rid, staffId, id, dto.course);
  }
}

@Global()
@Module({ controllers: [KitchenController], providers: [KitchenService], exports: [KitchenService] })
export class KitchenModule {}
