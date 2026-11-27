import { Body, Controller, Delete, Get, Global, HttpCode, Module, Param, ParseUUIDPipe, Post, Put, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { IsOptional, IsString, Matches, MaxLength, MinLength } from 'class-validator';
import { Perm } from '../../common/auth/auth.types';
import { CurrentStaffId, CurrentUserId, CustomerOnly, Public, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PayOsAdapter } from './payos';
import { PaymentsService } from './payments.service';

const uuid = new ParseUUIDPipe();

class ConnectPayOsDto {
  @ApiProperty() @IsString() @MinLength(8) @MaxLength(200) clientId: string;
  @ApiProperty() @IsString() @MinLength(8) @MaxLength(200) apiKey: string;
  @ApiProperty() @IsString() @MinLength(8) @MaxLength(200) checksumKey: string;
}

class GuestKeyPayDto {
  @ApiProperty() @IsString() @MinLength(10) @MaxLength(100) guestKey: string;
}

class RefundAccountDto {
  @ApiProperty({ example: '970436', description: 'Bank BIN (NAPAS)' }) @Matches(/^\d{6}$/) bankBin: string;
  @ApiProperty() @Matches(/^[0-9]{6,20}$/) accountNo: string;
  @ApiProperty() @IsString() @MinLength(2) @MaxLength(100) accountName: string;
}

class RefundDoneDto {
  @ApiPropertyOptional({ description: 'Bank transfer reference' }) @IsOptional() @IsString() @MaxLength(100) note?: string;
}

export class PaymentAccountStatusDto {
  @ApiProperty({ enum: ['PAYOS'] }) provider: string;
  @ApiProperty() connected: boolean;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'Last 4 characters of the client id' }) clientIdHint: string | null;
  @ApiProperty({ description: 'False when the server has no encryption key (payments off on this server)' }) serverReady: boolean;
}

export class PaymentDto {
  @ApiProperty() id: string;
  @ApiProperty() bookingId: string;
  @ApiProperty() amount: number;
  @ApiProperty({ enum: ['CREATED', 'PENDING', 'PAID', 'FAILED', 'EXPIRED', 'REFUNDED', 'PARTIALLY_REFUNDED'] }) status: string;
  @ApiProperty({ enum: ['BOOKING', 'SHARE'] }) purpose: string;
  @ApiPropertyOptional({ nullable: true, type: String }) guestId: string | null;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'Open in the browser / bank app' }) checkoutUrl: string | null;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'VietQR payload to draw as a QR code' }) qrCode: string | null;
  @ApiProperty() expiresAt: string;
  @ApiPropertyOptional({ nullable: true, type: String }) paidAt: string | null;
  @ApiProperty() refundedAmount: number;
}

export class RefundDto {
  @ApiProperty() id: string;
  @ApiProperty() bookingId: string;
  @ApiProperty() bookingCode: string;
  @ApiPropertyOptional({ nullable: true, type: String }) guestName: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) guestPhone: string | null;
  @ApiProperty() amount: number;
  @ApiProperty({ enum: ['RESTAURANT_CANCELLED', 'CUSTOMER_CANCELLED', 'LATE_PAYMENT_NO_TABLE', 'AMOUNT_MISMATCH', 'NO_SHOW_POLICY'] }) reason: string;
  @ApiProperty({ enum: ['PENDING', 'DONE'] }) status: string;
  @ApiPropertyOptional({ nullable: true, type: String }) toBankBin: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) toAccountNo: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) toAccountName: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
  @ApiProperty() createdAt: string;
  @ApiPropertyOptional({ nullable: true, type: String }) doneAt: string | null;
}

class UpdatedDto {
  @ApiProperty() updated: number;
}

@ApiTags('customer / payments')
@CustomerOnly()
@Controller('bookings')
export class CustomerPaymentsController {
  constructor(private readonly payments: PaymentsService) {}

  /** Payment link for a prepaid booking (re-used while open). Confirmation comes from the webhook, never from the app. */
  @Post(':id/pay')
  @HttpCode(200)
  @ApiOkResponse({ type: PaymentDto })
  pay(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.payments.payBooking(userId, id);
  }

  /** Where to send a refund when the bank transfer did not tell us. */
  @Put(':id/refund-account')
  @ApiOkResponse({ type: UpdatedDto })
  refundAccount(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: RefundAccountDto) {
    return this.payments.setRefundAccount(userId, id, dto);
  }
}

@ApiTags('public / group order')
@Public()
@Controller('groups')
export class GroupPaymentsController {
  constructor(private readonly payments: PaymentsService) {}

  /** A member pays their split share online (§8.4 "each pays own"). */
  @Post(':token/pay')
  @HttpCode(200)
  @ApiOkResponse({ type: PaymentDto })
  pay(@Param('token') token: string, @Body() dto: GuestKeyPayDto) {
    return this.payments.payShare(token, dto.guestKey);
  }
}

@ApiTags('webhooks')
@Public()
@Controller('webhooks')
export class WebhooksController {
  constructor(private readonly payments: PaymentsService) {}

  /** PayOS payment notification. Signature checked with the restaurant's checksum key. */
  @Post('payos')
  @HttpCode(200)
  payos(@Body() body: unknown) {
    return this.payments.handleWebhook(body);
  }
}

@ApiTags('restaurant / payments')
@Controller('restaurant')
export class RestaurantPaymentsController {
  constructor(private readonly payments: PaymentsService) {}

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('payment-account')
  @ApiOkResponse({ type: PaymentAccountStatusDto })
  account(@RestaurantId() rid: string) {
    return this.payments.accountStatus(rid);
  }

  /** Owner connects the restaurant's own PayOS merchant (money goes straight to the restaurant). */
  @RestaurantRoles('OWNER')
  @Put('payment-account')
  @ApiOkResponse({ type: PaymentAccountStatusDto })
  connect(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Body() dto: ConnectPayOsDto) {
    return this.payments.connect(rid, staffId, { clientId: dto.clientId.trim(), apiKey: dto.apiKey.trim(), checksumKey: dto.checksumKey.trim() });
  }

  @RestaurantRoles('OWNER')
  @Delete('payment-account')
  @ApiOkResponse({ type: PaymentAccountStatusDto })
  disconnect(@RestaurantId() rid: string, @CurrentStaffId() staffId: string) {
    return this.payments.disconnect(rid, staffId);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get('refunds')
  @ApiQuery({ name: 'status', required: false, enum: ['PENDING', 'DONE'] })
  @ApiOkResponse({ type: [RefundDto] })
  refunds(@RestaurantId() rid: string, @Query('status') status?: 'PENDING' | 'DONE') {
    return this.payments.refundsForRestaurant(rid, status === 'PENDING' || status === 'DONE' ? status : undefined);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post('refunds/:id/done')
  @HttpCode(200)
  @ApiOkResponse({ type: RefundDto })
  done(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: RefundDoneDto) {
    return this.payments.markRefundDone(rid, staffId, id, dto.note);
  }
}

@Global()
@Module({
  controllers: [CustomerPaymentsController, GroupPaymentsController, WebhooksController, RestaurantPaymentsController],
  providers: [PaymentsService, { provide: PayOsAdapter, inject: [ENV], useFactory: (env: Env) => new PayOsAdapter(fetch, env.PAYOS_API_URL) }],
  exports: [PaymentsService],
})
export class PaymentsModule {}
