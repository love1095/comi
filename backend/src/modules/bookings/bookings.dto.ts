import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsLatitude,
  IsLongitude,
  IsArray,
  IsBoolean,
  IsDateString,
  IsEnum,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Matches,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { BookingStatus, Occasion, PaymentMode, ServeStyle, ServiceType } from '@prisma/client';

export class CartLineDto {
  @ApiProperty() @IsUUID() menuItemId: string;
  @ApiProperty({ minimum: 1, maximum: 99 }) @IsInt() @Min(1) @Max(99) quantity: number;
  @ApiPropertyOptional({ type: [String] }) @IsOptional() @IsArray() @ArrayMaxSize(20) @IsUUID('all', { each: true }) optionIds?: string[];
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(200) note?: string;
}

export class CreateBookingDto {
  @ApiProperty() @IsUUID() restaurantId: string;
  @ApiProperty({ description: 'Exact slot start from /availability (ISO)' }) @IsDateString() arrivalAt: string;
  @ApiProperty() @IsInt() @Min(1) @Max(500) partySize: number;
  @ApiPropertyOptional() @IsOptional() @IsUUID() areaId?: string;
  @ApiPropertyOptional({ description: 'From POST /restaurants/:id/table-holds' }) @IsOptional() @IsUUID() holdId?: string;
  @ApiProperty({ enum: PaymentMode }) @IsEnum(PaymentMode) paymentMode: PaymentMode;
  @ApiPropertyOptional({ enum: ServeStyle }) @IsOptional() @IsEnum(ServeStyle) serveStyle?: ServeStyle;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(500) note?: string;
  @ApiPropertyOptional({ enum: Occasion }) @IsOptional() @IsEnum(Occasion) occasion?: Occasion;
  @ApiPropertyOptional({ description: 'Required when the order contains alcohol' }) @IsOptional() @IsBoolean() ageConfirmed?: boolean;
  @ApiPropertyOptional({ description: 'One voucher per booking (§12); never discounts alcohol' }) @IsOptional() @IsString() @MaxLength(20) voucherCode?: string;
  @ApiPropertyOptional({ type: [CartLineDto] })
  @IsOptional() @IsArray() @ArrayMaxSize(50) @ValidateNested({ each: true }) @Type(() => CartLineDto)
  items?: CartLineDto[];
}

export class CancelDto {
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(300) reason?: string;
}

export class RestaurantCancelDto {
  @ApiProperty() @IsString() @MinLength(3) @MaxLength(300) reason: string;
}

export class MoveTableDto {
  @ApiProperty() @IsUUID() tableId: string;
}

export class MyBookingsQuery {
  @ApiPropertyOptional({ enum: ['upcoming', 'past'] }) @IsOptional() @IsIn(['upcoming', 'past']) status?: 'upcoming' | 'past';
  @ApiPropertyOptional() @IsOptional() @IsUUID() cursor?: string;
  @ApiPropertyOptional() @IsOptional() @Type(() => Number) @IsInt() @Min(1) @Max(50) limit?: number;
}

export class RestaurantBookingsQuery {
  @ApiProperty({ example: '2026-12-02' }) @Matches(/^\d{4}-\d{2}-\d{2}$/) date: string;
  @ApiPropertyOptional({ enum: BookingStatus }) @IsOptional() @IsEnum(BookingStatus) status?: BookingStatus;
  @ApiPropertyOptional({ description: 'Booking code or phone' }) @IsOptional() @IsString() @MaxLength(30) q?: string;
}

// ───── at the table (§7.5, §8.5, §9.2) ─────

export class CheckInDto {
  @ApiProperty({ description: 'The scanned link: https://…/c/{slug}/{tableCode}?s=… or …/c/{slug}?s=…' })
  @IsString()
  @MinLength(10)
  @MaxLength(500)
  qrPayload: string;
}

export class DepartDto {
  @ApiProperty() @IsLatitude() lat: number;
  @ApiProperty() @IsLongitude() lng: number;
}

export class TableOrderDto {
  @ApiProperty({ type: [CartLineDto] })
  @IsArray() @ArrayMinSize(1) @ArrayMaxSize(50) @ValidateNested({ each: true }) @Type(() => CartLineDto)
  items: CartLineDto[];
  @ApiPropertyOptional() @IsOptional() @IsBoolean() ageConfirmed?: boolean;
}

export class ServiceRequestCreateDto {
  @ApiProperty({ enum: ServiceType, enumName: 'ServiceType' }) @IsEnum(ServiceType) type: ServiceType;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(200) note?: string;
}

export class CloseBillDto {
  @ApiPropertyOptional({ description: 'VND; default = live bill total. Edit for dishes added outside the app.' })
  @IsOptional() @IsInt() @Min(0) @Max(1_000_000_000) finalBillAmount?: number;
}
