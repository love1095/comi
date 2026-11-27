import { Body, Controller, Delete, Get, HttpCode, Param, ParseUUIDPipe, Patch, Post, Put, Query } from '@nestjs/common';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { ChecklistDto, GeocodeResultDto, MembershipDto, OpeningHoursDto, RestaurantProfileDto } from '../../common/responses';
import { RestaurantStatus } from '@prisma/client';
import { Perm } from '../../common/auth/auth.types';
import { AdminOnly, CurrentStaffId, RestaurantId, RestaurantRoles, StaffOnly } from '../../common/auth/decorators';
import { GoongService } from './goong.service';
import {
  ClosureDto,
  RegisterRestaurantDto,
  RejectDto,
  ReplaceOpeningHoursDto,
  UpdateProfileDto,
  UpdateSettingsDto,
} from './restaurants.dto';
import { RestaurantsService } from './restaurants.service';

@ApiTags('restaurant')
@Controller('restaurant')
export class RestaurantController {
  constructor(
    private readonly restaurants: RestaurantsService,
    private readonly goong: GoongService,
  ) {}

  @StaffOnly()
  @Post('register')
  @ApiOkResponse({ type: RestaurantProfileDto })
  register(@CurrentStaffId() staffId: string, @Body() dto: RegisterRestaurantDto) {
    return this.restaurants.register(staffId, dto);
  }

  @StaffOnly()
  @Get('me')
  @ApiOkResponse({ type: [MembershipDto] })
  mine(@CurrentStaffId() staffId: string) {
    return this.restaurants.listMine(staffId);
  }

  @StaffOnly()
  @Get('geocode')
  @ApiOkResponse({ type: [GeocodeResultDto] })
  geocode(@Query('q') q: string) {
    return this.goong.geocode(q);
  }

  @RestaurantRoles(...Perm.KITCHEN)
  @Get('profile')
  @ApiOkResponse({ type: RestaurantProfileDto })
  profile(@RestaurantId() id: string) {
    return this.restaurants.getProfile(id);
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Patch('profile')
  @ApiOkResponse({ type: RestaurantProfileDto })
  updateProfile(@CurrentStaffId() staffId: string, @RestaurantId() id: string, @Body() dto: UpdateProfileDto) {
    return this.restaurants.updateProfile(staffId, id, dto);
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Patch('settings')
  @ApiOkResponse({ type: RestaurantProfileDto })
  updateSettings(@CurrentStaffId() staffId: string, @RestaurantId() id: string, @Body() dto: UpdateSettingsDto) {
    return this.restaurants.updateSettings(staffId, id, dto);
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Put('opening-hours')
  @ApiOkResponse({ type: [OpeningHoursDto] })
  openingHours(@RestaurantId() id: string, @Body() dto: ReplaceOpeningHoursDto) {
    return this.restaurants.replaceOpeningHours(id, dto.items);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('closures')
  closures(@RestaurantId() id: string) {
    return this.restaurants.listClosures(id);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('closures')
  createClosure(@RestaurantId() id: string, @Body() dto: ClosureDto) {
    return this.restaurants.createClosure(id, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('closures/:closureId')
  @HttpCode(204)
  deleteClosure(@RestaurantId() id: string, @Param('closureId', ParseUUIDPipe) closureId: string) {
    return this.restaurants.deleteClosure(id, closureId);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('checklist')
  @ApiOkResponse({ type: ChecklistDto })
  checklist(@RestaurantId() id: string) {
    return this.restaurants.checklist(id);
  }

  @RestaurantRoles(...Perm.RESTAURANT_ADMIN)
  @Post('submit')
  @ApiOkResponse({ type: RestaurantProfileDto })
  @HttpCode(200)
  submit(@CurrentStaffId() staffId: string, @RestaurantId() id: string) {
    return this.restaurants.submit(staffId, id);
  }
}

/** Minimal admin endpoints until AdminJS is wired in (§18.4). */
@ApiTags('admin')
@AdminOnly()
@Controller('admin/restaurants')
export class AdminRestaurantsController {
  constructor(private readonly restaurants: RestaurantsService) {}

  @Get()
  @ApiQuery({ name: 'status', enum: RestaurantStatus, required: false })
  list(@Query('status') status?: RestaurantStatus) {
    return this.restaurants.listForReview(status);
  }

  @Get(':id')
  get(@Param('id', ParseUUIDPipe) id: string) {
    return this.restaurants.getProfile(id);
  }

  @Post(':id/approve')
  @HttpCode(200)
  approve(@CurrentStaffId() adminId: string, @Param('id', ParseUUIDPipe) id: string) {
    return this.restaurants.approve(adminId, id);
  }

  @Post(':id/reject')
  @HttpCode(200)
  reject(@CurrentStaffId() adminId: string, @Param('id', ParseUUIDPipe) id: string, @Body() dto: RejectDto) {
    return this.restaurants.reject(adminId, id, dto.reason);
  }

  @Post(':id/pause')
  @HttpCode(200)
  pause(@CurrentStaffId() adminId: string, @Param('id', ParseUUIDPipe) id: string) {
    return this.restaurants.pause(adminId, id);
  }
}
