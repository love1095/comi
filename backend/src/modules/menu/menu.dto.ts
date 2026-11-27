import { ApiProperty, ApiPropertyOptional, PartialType } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsBoolean,
  IsEnum,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { Course, ItemKind } from '@prisma/client';

export const CONTENT_LOCALES = ['en', 'ko', 'zh', 'ja'] as const; // vi is the source

export class CategoryDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(60) name: string;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) sortOrder?: number;
}
export class UpdateCategoryDto extends PartialType(CategoryDto) {}

export class ReorderDto {
  @ApiProperty({ type: [String], description: 'Ids in the new order' })
  @IsArray() @ArrayMaxSize(500) @IsUUID('all', { each: true }) ids: string[];
}

export class OptionDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(60) name: string;
  @ApiPropertyOptional({ description: 'VND, may be negative' }) @IsOptional() @IsInt() @Min(-10_000_000) @Max(10_000_000) priceDelta?: number;
}

export class OptionGroupDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(60) name: string;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(20) minSelect?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(20) maxSelect?: number;
  @ApiProperty({ type: [OptionDto] })
  @IsArray() @ArrayMinSize(1) @ArrayMaxSize(30) @ValidateNested({ each: true }) @Type(() => OptionDto)
  options: OptionDto[];
}

export class MenuItemDto {
  @ApiProperty() @IsUUID() categoryId: string;
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(120) name: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(1000) description?: string;
  @ApiProperty({ description: 'VND' }) @IsInt() @Min(0) @Max(100_000_000) price: number;
  @ApiPropertyOptional({ enum: Course }) @IsOptional() @IsEnum(Course) course?: Course;
  @ApiPropertyOptional({ enum: ItemKind }) @IsOptional() @IsEnum(ItemKind) kind?: ItemKind;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(240) prepMinutes?: number;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() isAvailable?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() isPreorderable?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() isAlcohol?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(168) leadHours?: number;
  @ApiPropertyOptional({ type: [String] })
  @IsOptional() @IsArray() @ArrayMaxSize(10) @IsString({ each: true }) tags?: string[];
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) sortOrder?: number;
  @ApiPropertyOptional({ type: [OptionGroupDto], description: 'When sent, replaces all option groups' })
  @IsOptional() @IsArray() @ArrayMaxSize(10) @ValidateNested({ each: true }) @Type(() => OptionGroupDto)
  optionGroups?: OptionGroupDto[];
}
export class UpdateMenuItemDto extends PartialType(MenuItemDto) {}

export class AvailabilityDto {
  @ApiProperty() @IsBoolean() isAvailable: boolean;
}

export class TranslationDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(120) name: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(1000) description?: string;
}

export class TranslationParams {
  @IsUUID() id: string;
  @IsIn(CONTENT_LOCALES) locale: string;
}

export class AddPhotoDto {
  @ApiProperty({ description: 'Cloudinary public_id returned by the direct upload' })
  @IsString() @MinLength(3) @MaxLength(300) publicId: string;
  @ApiPropertyOptional({ description: 'Only used when Cloudinary is not configured (local dev)' })
  @IsOptional() @IsInt() width?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() height?: number;
}
