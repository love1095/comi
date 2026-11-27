import { Body, Controller, Get, HttpCode, Module, Param, ParseUUIDPipe, Post, Req } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { SplitMode } from '@prisma/client';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsBoolean,
  IsEnum,
  IsInt,
  IsObject,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { AuthedRequest, Perm } from '../../common/auth/auth.types';
import { CurrentStaffId, CurrentUserId, CustomerOnly, Public, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { GroupMemberDto, GroupViewDto, SplitDto } from '../../common/customer-responses';
import { CartLineDto } from '../bookings/bookings.dto';
import { GroupService } from './group.service';
import { GroupWebController } from './group.web';

const uuid = new ParseUUIDPipe();

class StartGroupDto {
  @ApiPropertyOptional({ description: 'Orders close this many minutes before arrival (default 20)' })
  @IsOptional() @IsInt() @Min(5) @Max(24 * 60) cutoffMinutes?: number;
  @ApiPropertyOptional({ description: 'Default = party size' }) @IsOptional() @IsInt() @Min(2) @Max(100) maxGuests?: number;
}

class JoinGroupDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(40) displayName: string;
}

class GroupItemsDto {
  @ApiProperty() @IsString() @MinLength(10) @MaxLength(100) guestKey: string;
  @ApiProperty({ type: [CartLineDto] })
  @IsArray() @ArrayMinSize(1) @ArrayMaxSize(30) @ValidateNested({ each: true }) @Type(() => CartLineDto)
  items: CartLineDto[];
  @ApiPropertyOptional() @IsOptional() @IsBoolean() ageConfirmed?: boolean;
}

class GuestKeyDto {
  @ApiProperty() @IsString() @MinLength(10) @MaxLength(100) guestKey: string;
}

class SaveSplitDto {
  @ApiProperty({ enum: SplitMode, enumName: 'SplitMode' }) @IsEnum(SplitMode) mode: SplitMode;
  @ApiPropertyOptional({ description: 'Table without group members: split between this many people' })
  @IsOptional() @IsInt() @Min(1) @Max(50) people?: number;
  @ApiPropertyOptional({ description: 'CUSTOM: guestId → VND', type: 'object', additionalProperties: { type: 'integer' } })
  @IsOptional() @IsObject() amounts?: Record<string, number>;
}

class MarkPaidDto {
  @ApiProperty({ description: 'false = undo' }) @IsBoolean() paid: boolean;
}

/** Host side of a group order + split from the customer app. */
@ApiTags('customer / group order')
@CustomerOnly()
@Controller('bookings')
export class CustomerGroupController {
  constructor(private readonly groups: GroupService) {}

  @Post(':id/group')
  @HttpCode(200)
  @ApiOkResponse({ type: GroupMemberDto })
  start(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: StartGroupDto) {
    return this.groups.start(userId, id, dto);
  }

  @Post(':id/group/lock')
  @HttpCode(200)
  @ApiOkResponse({ type: GroupViewDto })
  lock(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.groups.lock(id, { userId });
  }

  @Get(':id/split')
  @ApiOkResponse({ type: SplitDto })
  split(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.groups.getSplit(id, { userId });
  }

  @Post(':id/split')
  @HttpCode(200)
  @ApiOkResponse({ type: SplitDto })
  saveSplit(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: SaveSplitDto) {
    return this.groups.saveSplit(id, { userId }, dto);
  }
}

/** Anyone with the share link — no account needed (§8.4). */
@ApiTags('public / group order')
@Public()
@Controller('groups')
export class PublicGroupController {
  constructor(private readonly groups: GroupService) {}

  @Get(':token')
  @ApiOkResponse({ type: GroupViewDto })
  get(@Param('token') token: string) {
    return this.groups.get(token);
  }

  /** Logged-in users (token sent) are linked to their account; others join by name. */
  @Post(':token/join')
  @HttpCode(200)
  @ApiOkResponse({ type: GroupMemberDto })
  join(@Param('token') token: string, @Body() dto: JoinGroupDto, @Req() req: AuthedRequest) {
    return this.groups.join(token, dto.displayName, req.principal?.kind === 'user' ? req.principal.userId : undefined);
  }

  @Post(':token/items')
  @HttpCode(200)
  @ApiOkResponse({ type: GroupViewDto })
  add(@Param('token') token: string, @Body() dto: GroupItemsDto) {
    return this.groups.addItems(token, dto.guestKey, dto.items, dto.ageConfirmed);
  }

  @Post(':token/items/:itemId/remove')
  @HttpCode(200)
  @ApiOkResponse({ type: GroupViewDto })
  remove(@Param('token') token: string, @Param('itemId', uuid) itemId: string, @Body() dto: GuestKeyDto) {
    return this.groups.removeItem(token, dto.guestKey, itemId);
  }
}

@ApiTags('restaurant / split bill')
@Controller('restaurant/bookings')
export class RestaurantSplitController {
  constructor(private readonly groups: GroupService) {}

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get(':id/split')
  @ApiOkResponse({ type: SplitDto })
  split(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.groups.getSplit(id, { restaurantId: rid });
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/split')
  @HttpCode(200)
  @ApiOkResponse({ type: SplitDto })
  saveSplit(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: SaveSplitDto) {
    return this.groups.saveSplit(id, { restaurantId: rid, staffId }, dto);
  }

  /** "Đã thu tiền mặt" for one guest. */
  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/guests/:guestId/paid')
  @HttpCode(200)
  @ApiOkResponse({ type: SplitDto })
  paid(
    @RestaurantId() rid: string,
    @CurrentStaffId() staffId: string,
    @Param('id', uuid) id: string,
    @Param('guestId', uuid) guestId: string,
    @Body() dto: MarkPaidDto,
  ) {
    return this.groups.markPaid(rid, staffId, id, guestId, dto.paid);
  }
}

@Module({
  controllers: [CustomerGroupController, PublicGroupController, RestaurantSplitController, GroupWebController],
  providers: [GroupService],
})
export class GroupModule {}
