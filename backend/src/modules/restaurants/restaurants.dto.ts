import { ApiProperty, ApiPropertyOptional, PartialType } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsBoolean,
  IsDateString,
  IsEnum,
  IsIn,
  IsInt,
  IsLatitude,
  IsLongitude,
  IsOptional,
  IsString,
  Matches,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { RefundRule } from '@prisma/client';

const PHONE = /^\+?[0-9]{8,15}$/;

export class RegisterRestaurantDto {
  @ApiProperty() @IsString() @MinLength(2) @MaxLength(120) name: string;
  @ApiProperty() @Matches(PHONE) phone: string;
  @ApiProperty() @IsString() @MinLength(5) @MaxLength(300) address: string;
  @ApiProperty({ example: '79', description: 'Province code (79 = Ho Chi Minh City)' })
  @IsString() @MaxLength(10) provinceCode: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(10) wardCode?: string;
  @ApiProperty({ minimum: 1, maximum: 4 }) @IsInt() @Min(1) @Max(4) priceLevel: number;
  @ApiPropertyOptional({ type: [String] })
  @IsOptional() @IsArray() @ArrayMaxSize(10) @IsString({ each: true }) cuisineTags?: string[];
  @ApiPropertyOptional() @IsOptional() @IsLatitude() lat?: number;
  @ApiPropertyOptional() @IsOptional() @IsLongitude() lng?: number;
}

export class UpdateProfileDto extends PartialType(RegisterRestaurantDto) {
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(2000) description?: string;
  @ApiPropertyOptional({ type: [String] })
  @IsOptional() @IsArray() @ArrayMaxSize(10) @IsString({ each: true }) ambienceTags?: string[];
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(200) coverPhotoUrl?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(200) googlePlaceId?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() timezone?: string;
}

/** Booking rules (§22.2 #13). Owner only. */
export class UpdateSettingsDto {
  @ApiPropertyOptional() @IsOptional() @IsIn([5, 10, 15, 30]) slotMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(20) @Max(360) diningMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(5) @Max(120) graceMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(1440) minLeadMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(90) maxDaysAhead?: number;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() allowCod?: boolean;
  @ApiPropertyOptional({ enum: RefundRule }) @IsOptional() @IsEnum(RefundRule) prepaidRefundRule?: RefundRule;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() servesLunch?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() servesNhau?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(500) maxGroupSize?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(500) confirmGroupsOver?: number;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() allowTableChoice?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(1440) cancelCutoffMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() startEarlyOnCheckIn?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() codStartOnDepart?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() allowTableOrdering?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() tableOrderingNeedsApproval?: boolean;
}

export class OpeningHoursItemDto {
  @ApiProperty({ minimum: 0, maximum: 6, description: '0 = Sunday' }) @IsInt() @Min(0) @Max(6) weekday: number;
  @ApiProperty({ example: 600, description: 'Minutes from 00:00' }) @IsInt() @Min(0) @Max(1439) openMinute: number;
  @ApiProperty({ example: 1380, description: 'May be > 1440 for after midnight' })
  @IsInt() @Min(1) @Max(2879) closeMinute: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(2879) lastOrderMinute?: number;
}

export class ReplaceOpeningHoursDto {
  @ApiProperty({ type: [OpeningHoursItemDto] })
  @IsArray() @ArrayMaxSize(28) @ValidateNested({ each: true }) @Type(() => OpeningHoursItemDto)
  items: OpeningHoursItemDto[];
}

export class ClosureDto {
  @ApiProperty() @IsDateString() startsAt: string;
  @ApiProperty() @IsDateString() endsAt: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(200) reason?: string;
}

export class RejectDto {
  @ApiProperty() @IsString() @MinLength(3) @MaxLength(500) reason: string;
}
