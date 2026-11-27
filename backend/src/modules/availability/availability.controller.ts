import { Body, Controller, Delete, Get, Global, HttpCode, Module, Param, ParseUUIDPipe, Post, Query, Req } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { HoldDto, SlotDto, TableMapDto } from '../../common/customer-responses';
import { Type } from 'class-transformer';
import { ArrayMaxSize, ArrayMinSize, IsArray, IsDateString, IsInt, IsOptional, IsUUID, Matches, Max, Min } from 'class-validator';
import { AuthedRequest } from '../../common/auth/auth.types';
import { CurrentUserId, CustomerOnly, Public } from '../../common/auth/decorators';
import { AvailabilityService } from './availability.service';

class AvailabilityQuery {
  @ApiProperty({ example: '2026-12-02' }) @Matches(/^\d{4}-\d{2}-\d{2}$/) date: string;
  @ApiProperty() @Type(() => Number) @IsInt() @Min(1) @Max(500) partySize: number;
  @ApiPropertyOptional() @IsOptional() @IsUUID() areaId?: string;
}

class TableMapQuery {
  @ApiProperty() @IsDateString() arrivalAt: string;
  @ApiProperty() @Type(() => Number) @IsInt() @Min(1) @Max(500) partySize: number;
  @ApiPropertyOptional() @IsOptional() @IsUUID() areaId?: string;
}

class CreateHoldDto {
  @ApiProperty({ type: [String] }) @IsArray() @ArrayMinSize(1) @ArrayMaxSize(6) @IsUUID('all', { each: true }) tableIds: string[];
  @ApiProperty() @IsDateString() arrivalAt: string;
  @ApiProperty() @IsInt() @Min(1) @Max(500) partySize: number;
}

@ApiTags('customer / availability')
@Controller()
export class AvailabilityController {
  constructor(private readonly availability: AvailabilityService) {}

  @Public()
  @Get('restaurants/:id/availability')
  @ApiOkResponse({ type: [SlotDto] })
  get(@Param('id', ParseUUIDPipe) id: string, @Query() q: AvailabilityQuery) {
    return this.availability.availability(id, q.date, q.partySize, q.areaId);
  }

  /** Works logged out (view only); when logged in, the caller's own hold shows as "mine". */
  @Public()
  @Get('restaurants/:id/table-map')
  @ApiOkResponse({ type: TableMapDto })
  tableMap(@Param('id', ParseUUIDPipe) id: string, @Query() q: TableMapQuery, @Req() req: AuthedRequest) {
    const userId = req.principal?.kind === 'user' ? req.principal.userId : undefined;
    return this.availability.tableMap(id, { arrivalAt: new Date(q.arrivalAt), partySize: q.partySize, areaId: q.areaId }, userId);
  }

  @CustomerOnly()
  @Post('restaurants/:id/table-holds')
  @ApiOkResponse({ type: HoldDto })
  hold(@CurrentUserId() userId: string, @Param('id', ParseUUIDPipe) id: string, @Body() dto: CreateHoldDto) {
    return this.availability.createHold(userId, id, { ...dto, arrivalAt: new Date(dto.arrivalAt) });
  }

  @CustomerOnly()
  @Delete('table-holds/:holdId')
  @HttpCode(204)
  release(@CurrentUserId() userId: string, @Param('holdId', ParseUUIDPipe) holdId: string) {
    return this.availability.releaseHold(userId, holdId);
  }
}

@Global()
@Module({ controllers: [AvailabilityController], providers: [AvailabilityService], exports: [AvailabilityService] })
export class AvailabilityModule {}
