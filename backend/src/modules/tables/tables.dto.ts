import { ApiProperty, ApiPropertyOptional, PartialType } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsBoolean,
  IsEnum,
  IsIn,
  IsInt,
  IsObject,
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
import { MapElementType, TableShape } from '@prisma/client';

const ROTATIONS = [0, 90, 180, 270];

export class AreaDto {
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(60) name: string;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) sortOrder?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(4) @Max(100) gridCols?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(4) @Max(100) gridRows?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(-3) @Max(100) floor?: number;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(300) backgroundUrl?: string;
}
export class UpdateAreaDto extends PartialType(AreaDto) {}

export class TableFieldsDto {
  @ApiProperty({ example: 'A1' }) @Matches(/^[A-Za-z0-9-]{1,10}$/) code: string;
  @ApiPropertyOptional({ default: 1 }) @IsOptional() @IsInt() @Min(1) @Max(100) minSeats?: number;
  @ApiProperty() @IsInt() @Min(1) @Max(100) maxSeats: number;
  @ApiPropertyOptional({ enum: TableShape }) @IsOptional() @IsEnum(TableShape) shape?: TableShape;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(99) posX?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(0) @Max(99) posY?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(20) width?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(20) height?: number;
  @ApiPropertyOptional({ type: Number, description: '0, 90, 180 or 270' }) @IsOptional() @IsIn(ROTATIONS) rotation?: number;
  @ApiPropertyOptional({ type: [String] })
  @IsOptional() @IsArray() @ArrayMaxSize(10) @IsString({ each: true }) features?: string[];
  @ApiPropertyOptional() @IsOptional() @IsObject() seatLayout?: Record<string, number>;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() isSelectable?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsBoolean() isActive?: boolean;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(30) joinGroup?: string;
}

export class CreateTableDto extends TableFieldsDto {
  @ApiProperty() @IsUUID() areaId: string;
}
export class UpdateTableDto extends PartialType(CreateTableDto) {}

/** posX/posY are required here; missing values are reported as OUT_OF_BOUNDS. */
export class LayoutTableDto extends TableFieldsDto {
  @ApiPropertyOptional({ description: 'Existing table id; omit to create' }) @IsOptional() @IsUUID() id?: string;
}

export class MapElementDto {
  @ApiProperty({ enum: MapElementType }) @IsEnum(MapElementType) type: MapElementType;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(40) label?: string;
  @ApiProperty() @IsInt() @Min(0) @Max(99) x: number;
  @ApiProperty() @IsInt() @Min(0) @Max(99) y: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(100) width?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(1) @Max(100) height?: number;
  @ApiPropertyOptional({ type: Number, description: '0, 90, 180 or 270' }) @IsOptional() @IsIn(ROTATIONS) rotation?: number;
}

/** PUT /restaurant/areas/:id/layout — the editor saves the whole map in one request. */
export class SaveLayoutDto {
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(4) @Max(100) gridCols?: number;
  @ApiPropertyOptional() @IsOptional() @IsInt() @Min(4) @Max(100) gridRows?: number;
  @ApiProperty({ type: [LayoutTableDto] })
  @IsArray() @ArrayMaxSize(200) @ValidateNested({ each: true }) @Type(() => LayoutTableDto)
  tables: LayoutTableDto[];
  @ApiProperty({ type: [MapElementDto] })
  @IsArray() @ArrayMaxSize(300) @ValidateNested({ each: true }) @Type(() => MapElementDto)
  elements: MapElementDto[];
}
