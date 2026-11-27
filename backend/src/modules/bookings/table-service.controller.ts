import { Body, Controller, Get, HttpCode, Param, ParseIntPipe, ParseUUIDPipe, Post } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Perm } from '../../common/auth/auth.types';
import { CurrentStaffId, CurrentUserId, CustomerOnly, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { BillDto, CustomerBookingDto, DepartResultDto, RoundResultDto, ServiceRequestDto } from '../../common/customer-responses';
import { BookingDetailDto, FireResultDto } from '../../common/responses';
import { CheckInDto, CloseBillDto, DepartDto, ServiceRequestCreateDto, TableOrderDto } from './bookings.dto';
import { TableServiceService } from './table-service.service';

const uuid = new ParseUUIDPipe();

/** Guest at (or on the way to) the restaurant. */
@ApiTags('customer / at the table')
@CustomerOnly()
@Controller('bookings')
export class CustomerTableController {
  constructor(private readonly table: TableServiceService) {}

  @Post(':id/check-in')
  @HttpCode(200)
  @ApiOkResponse({ type: CustomerBookingDto })
  checkIn(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: CheckInDto) {
    return this.table.checkInByQr(userId, id, dto.qrPayload);
  }

  @Post(':id/depart')
  @HttpCode(200)
  @ApiOkResponse({ type: DepartResultDto })
  depart(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: DepartDto) {
    return this.table.depart(userId, id, dto.lat, dto.lng);
  }

  @Post(':id/orders')
  @HttpCode(200)
  @ApiOkResponse({ type: RoundResultDto })
  order(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: TableOrderDto) {
    return this.table.addRound({ kind: 'user', userId }, id, dto.items, dto.ageConfirmed);
  }

  @Get(':id/bill')
  @ApiOkResponse({ type: BillDto })
  bill(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.table.bill(id, { userId });
  }

  @Post(':id/service-requests')
  @HttpCode(200)
  @ApiOkResponse({ type: ServiceRequestDto })
  service(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: ServiceRequestCreateDto) {
    return this.table.requestService(userId, id, dto.type, dto.note);
  }
}

@ApiTags('restaurant / at the table')
@Controller('restaurant')
export class RestaurantTableController {
  constructor(private readonly table: TableServiceService) {}

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('bookings/:id/check-in')
  @HttpCode(200)
  @ApiOkResponse({ type: BookingDetailDto })
  checkIn(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string) {
    return this.table.checkInByStaff(rid, staffId, id);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('bookings/:id/extend-grace')
  @HttpCode(200)
  @ApiOkResponse({ type: BookingDetailDto })
  extendGrace(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string) {
    return this.table.extendGrace(rid, staffId, id);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('bookings/:id/orders')
  @HttpCode(200)
  @ApiOkResponse({ type: RoundResultDto })
  order(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: TableOrderDto) {
    return this.table.addRound({ kind: 'staff', staffId }, id, dto.items, true, rid);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('bookings/:id/rounds/:round/approve')
  @HttpCode(200)
  @ApiOkResponse({ type: FireResultDto })
  approveRound(
    @RestaurantId() rid: string,
    @CurrentStaffId() staffId: string,
    @Param('id', uuid) id: string,
    @Param('round', ParseIntPipe) round: number,
  ) {
    return this.table.approveRound(rid, staffId, id, round);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get('bookings/:id/bill')
  @ApiOkResponse({ type: BillDto })
  bill(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.table.bill(id, { restaurantId: rid });
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('bookings/:id/close')
  @HttpCode(200)
  @ApiOkResponse({ type: BookingDetailDto })
  close(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: CloseBillDto) {
    return this.table.closeBill(rid, staffId, id, dto.finalBillAmount);
  }

  @RestaurantRoles(...Perm.KITCHEN)
  @Get('service-requests')
  @ApiOkResponse({ type: [ServiceRequestDto] })
  requests(@RestaurantId() rid: string) {
    return this.table.openRequests(rid);
  }

  @RestaurantRoles(...Perm.KITCHEN)
  @Post('service-requests/:id/done')
  @HttpCode(200)
  @ApiOkResponse({ type: ServiceRequestDto })
  done(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string) {
    return this.table.finishRequest(rid, staffId, id);
  }
}
