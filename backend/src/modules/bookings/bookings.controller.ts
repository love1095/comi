import { Body, Controller, Get, Headers, HttpCode, Module, Param, ParseUUIDPipe, Post, Query } from '@nestjs/common';
import { ApiHeader, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { BoardBookingDto, BookingDetailDto } from '../../common/responses';
import { CustomerBookingDto, MyBookingsPageDto, ReorderDraftDto } from '../../common/customer-responses';
import { Throttle } from '@nestjs/throttler';
import { Perm } from '../../common/auth/auth.types';
import { CurrentStaffId, CurrentUserId, CustomerOnly, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import {
  CancelDto,
  CreateBookingDto,
  MoveTableDto,
  MyBookingsQuery,
  RestaurantBookingsQuery,
  RestaurantCancelDto,
} from './bookings.dto';
import { BookingsService } from './bookings.service';
import { IdempotencyService } from './idempotency';
import { CustomerTableController, RestaurantTableController } from './table-service.controller';
import { TableServiceService } from './table-service.service';

const uuid = new ParseUUIDPipe();

@ApiTags('customer / bookings')
@CustomerOnly()
@Controller('bookings')
export class BookingsController {
  constructor(
    private readonly bookings: BookingsService,
    private readonly idem: IdempotencyService,
  ) {}

  @Post()
  @Throttle({ default: { limit: 20, ttl: 60_000 } })
  @ApiHeader({ name: 'Idempotency-Key', required: false, description: 'Random per checkout; retries return the first result' })
  @ApiOkResponse({ type: CustomerBookingDto })
  create(@CurrentUserId() userId: string, @Body() dto: CreateBookingDto, @Headers('idempotency-key') key?: string) {
    return this.idem.run(`booking:${userId}`, key, () => this.bookings.create(userId, dto));
  }

  @Get()
  @ApiOkResponse({ type: MyBookingsPageDto })
  list(@CurrentUserId() userId: string, @Query() q: MyBookingsQuery) {
    return this.bookings.listMine(userId, q);
  }

  @Get(':id')
  @ApiOkResponse({ type: CustomerBookingDto })
  get(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.bookings.getMine(userId, id);
  }

  @Post(':id/cancel')
  @HttpCode(200)
  @ApiOkResponse({ type: CustomerBookingDto })
  cancel(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: CancelDto) {
    return this.bookings.cancelByCustomer(userId, id, dto.reason);
  }

  @Post(':id/reorder')
  @HttpCode(200)
  @ApiOkResponse({ type: ReorderDraftDto })
  reorder(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.bookings.reorder(userId, id);
  }
}

@ApiTags('restaurant / bookings')
@Controller('restaurant/bookings')
export class RestaurantBookingsController {
  constructor(private readonly bookings: BookingsService) {}

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get()
  @ApiOkResponse({ type: [BoardBookingDto] })
  list(@RestaurantId() rid: string, @Query() q: RestaurantBookingsQuery) {
    return this.bookings.listForRestaurant(rid, q);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get(':id')
  @ApiOkResponse({ type: BookingDetailDto })
  get(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.bookings.getForRestaurant(rid, id);
  }

  // Actions answer with the staff detail shape (includes the customer), same as GET :id.

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/approve')
  @ApiOkResponse({ type: BookingDetailDto })
  @HttpCode(200)
  async approve(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string) {
    await this.bookings.approve(rid, staffId, id);
    return this.bookings.getForRestaurant(rid, id);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/cancel')
  @ApiOkResponse({ type: BookingDetailDto })
  @HttpCode(200)
  async cancel(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: RestaurantCancelDto) {
    await this.bookings.cancelByRestaurant(rid, staffId, id, dto.reason);
    return this.bookings.getForRestaurant(rid, id);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/move-table')
  @ApiOkResponse({ type: BookingDetailDto })
  @HttpCode(200)
  async moveTable(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: MoveTableDto) {
    await this.bookings.moveTable(rid, staffId, id, dto.tableId);
    return this.bookings.getForRestaurant(rid, id);
  }
}

@Module({
  controllers: [BookingsController, RestaurantBookingsController, CustomerTableController, RestaurantTableController],
  providers: [BookingsService, IdempotencyService, TableServiceService],
})
export class BookingsModule {}
