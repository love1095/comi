import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Module,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Put,
  Query,
  Res,
} from '@nestjs/common';
import { ApiOkResponse, ApiProduces, ApiQuery, ApiTags } from '@nestjs/swagger';
import { AreaLayoutDto, AreaSummaryDto, TableDto } from '../../common/responses';
import { Response } from 'express';
import { Perm } from '../../common/auth/auth.types';
import { RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { AreaDto, CreateTableDto, SaveLayoutDto, UpdateAreaDto, UpdateTableDto } from './tables.dto';
import { TablesService } from './tables.service';

const uuid = new ParseUUIDPipe();

@ApiTags('restaurant / tables')
@Controller('restaurant')
export class TablesController {
  constructor(private readonly tables: TablesService) {}

  // areas
  @RestaurantRoles(...Perm.KITCHEN)
  @Get('areas')
  @ApiOkResponse({ type: [AreaSummaryDto] })
  listAreas(@RestaurantId() rid: string) {
    return this.tables.listAreas(rid);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('areas')
  @ApiOkResponse({ type: AreaSummaryDto })
  createArea(@RestaurantId() rid: string, @Body() dto: AreaDto) {
    return this.tables.createArea(rid, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Patch('areas/:id')
  updateArea(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: UpdateAreaDto) {
    return this.tables.updateArea(rid, id, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('areas/:id')
  @HttpCode(204)
  deleteArea(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.tables.deleteArea(rid, id);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get('areas/:id/layout')
  @ApiOkResponse({ type: AreaLayoutDto })
  getLayout(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.tables.getAreaMap(rid, id);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('areas/:id/layout')
  @ApiOkResponse({ type: AreaLayoutDto })
  saveLayout(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: SaveLayoutDto) {
    return this.tables.saveLayout(rid, id, dto);
  }

  // tables
  @RestaurantRoles(...Perm.KITCHEN)
  @Get('tables')
  @ApiOkResponse({ type: [TableDto] })
  @ApiQuery({ name: 'areaId', required: false })
  listTables(@RestaurantId() rid: string, @Query('areaId') areaId?: string) {
    return this.tables.listTables(rid, areaId);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('tables')
  createTable(@RestaurantId() rid: string, @Body() dto: CreateTableDto) {
    return this.tables.createTable(rid, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Patch('tables/:id')
  updateTable(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: UpdateTableDto) {
    return this.tables.updateTable(rid, id, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('tables/:id')
  @HttpCode(204)
  deleteTable(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.tables.deleteTable(rid, id);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('tables/:id/rotate-qr')
  @HttpCode(204)
  rotateQr(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.tables.rotateQrSecret(rid, id);
  }

  // QR codes
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('tables/:id/qr')
  @ApiProduces('image/png')
  async tableQr(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Res() res: Response) {
    res.type('png').send(await this.tables.tableQrPng(rid, id));
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('qr/entrance')
  @ApiProduces('image/png')
  async entranceQr(@RestaurantId() rid: string, @Res() res: Response) {
    res.type('png').send(await this.tables.entranceQrPng(rid));
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('qr/print')
  @ApiProduces('application/pdf')
  @ApiQuery({ name: 'areaId', required: false })
  async printQr(@RestaurantId() rid: string, @Res() res: Response, @Query('areaId') areaId?: string) {
    const pdf = await this.tables.qrPdf(rid, areaId);
    res.type('pdf').setHeader('Content-Disposition', 'inline; filename="comi-qr.pdf"').send(pdf);
  }
}

@Module({ controllers: [TablesController], providers: [TablesService], exports: [TablesService] })
export class TablesModule {}
