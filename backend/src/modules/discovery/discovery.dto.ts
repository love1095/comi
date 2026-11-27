import { ApiPropertyOptional, ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import { IsBoolean, IsDateString, IsIn, IsInt, IsLatitude, IsLongitude, IsNumber, IsOptional, IsString, Matches, Max, MaxLength, Min, MinLength } from 'class-validator';

const toBool = ({ value }: { value: unknown }) => (value === 'true' || value === '1' || value === true ? true : value === 'false' || value === '0' ? false : value);

export class NearbyQuery {
  @ApiProperty() @Type(() => Number) @IsLatitude() lat: number;
  @ApiProperty() @Type(() => Number) @IsLongitude() lng: number;
  @ApiPropertyOptional({ default: 3000, description: 'meters' }) @IsOptional() @Type(() => Number) @IsInt() @Min(100) @Max(20000) radius?: number;
  @ApiPropertyOptional({ description: 'name, accent-insensitive' }) @IsOptional() @IsString() @MaxLength(60) q?: string;
  @ApiPropertyOptional({ description: 'comma separated, e.g. com,nhau' }) @IsOptional() @IsString() @MaxLength(200) cuisine?: string;
  @ApiPropertyOptional() @IsOptional() @Type(() => Number) @IsInt() @Min(1) @Max(4) priceMax?: number;
  @ApiPropertyOptional() @IsOptional() @Type(() => Number) @IsNumber() @Min(0) @Max(5) minRating?: number;
  @ApiPropertyOptional() @IsOptional() @Transform(toBool) @IsBoolean() openNow?: boolean;
  @ApiPropertyOptional({ description: '"Under 60k": has a main dish at or below this price' })
  @IsOptional() @Type(() => Number) @IsInt() @Min(0) maxMainPrice?: number;
  @ApiPropertyOptional({ description: '"Groups 10+"' }) @IsOptional() @Type(() => Number) @IsInt() @Min(1) @Max(500) groupSize?: number;
  @ApiPropertyOptional({ description: 'Open until 23:00 or later today' }) @IsOptional() @Transform(toBool) @IsBoolean() openLate?: boolean;
  @ApiPropertyOptional() @IsOptional() @Transform(toBool) @IsBoolean() privateRoom?: boolean;
  @ApiPropertyOptional({ enum: ['lunch', 'nhau'] }) @IsOptional() @IsIn(['lunch', 'nhau']) mode?: 'lunch' | 'nhau';
  @ApiPropertyOptional({ enum: ['distance', 'rating', 'score'], description: 'score = rating weighted by review count and distance' })
  @IsOptional() @IsIn(['distance', 'rating', 'score']) sort?: 'distance' | 'rating' | 'score';
  @ApiPropertyOptional({ description: 'Tourists: comma separated vegetarian,halal,no_pork,gluten_free' })
  @IsOptional() @IsString() @MaxLength(100) dietary?: string;
  @ApiPropertyOptional({ description: 'Only restaurants with a free table at this time (ISO) — needs partySize' })
  @IsOptional() @IsDateString() availableAt?: string;
  @ApiPropertyOptional({ description: 'With availableAt' }) @IsOptional() @Type(() => Number) @IsInt() @Min(1) @Max(100) partySize?: number;
  @ApiPropertyOptional({ description: 'Offset from the previous page' }) @IsOptional() @Type(() => Number) @IsInt() @Min(0) @Max(500) cursor?: number;
  @ApiPropertyOptional({ default: 20 }) @IsOptional() @Type(() => Number) @IsInt() @Min(1) @Max(50) limit?: number;
}

export class MapQuery {
  @ApiProperty({ example: '106.68,10.76,106.71,10.79', description: 'minLng,minLat,maxLng,maxLat' })
  @Matches(/^-?\d+(\.\d+)?,-?\d+(\.\d+)?,-?\d+(\.\d+)?,-?\d+(\.\d+)?$/)
  bbox: string;
}

export class SuggestQuery {
  @ApiProperty() @IsString() @MinLength(2) @MaxLength(60) q: string;
  @ApiPropertyOptional() @IsOptional() @Type(() => Number) @IsLatitude() lat?: number;
  @ApiPropertyOptional() @IsOptional() @Type(() => Number) @IsLongitude() lng?: number;
}

export class HomeQuery {
  @ApiProperty() @Type(() => Number) @IsLatitude() lat: number;
  @ApiProperty() @Type(() => Number) @IsLongitude() lng: number;
}
