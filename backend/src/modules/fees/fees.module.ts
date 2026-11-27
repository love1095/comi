import { Controller, Get, Global, HttpCode, Module, Param, ParseUUIDPipe, Post, Query, Res } from '@nestjs/common';
import { ApiOkResponse, ApiProduces, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Response } from 'express';
import { Perm } from '../../common/auth/auth.types';
import { AdminOnly, CurrentStaffId, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { AppError } from '../../common/errors/app-error';
import { ReportDto, StatementDetailDto, StatementDto } from '../../common/responses';
import { FeesService } from './fees.service';
import { ReportsService } from './reports.service';

const uuid = new ParseUUIDPipe();
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;
const MONTH_RE = /^\d{4}-\d{2}$/;

@ApiTags('restaurant / fees & reports')
@Controller('restaurant')
export class RestaurantFeesController {
  constructor(
    private readonly fees: FeesService,
    private readonly reports: ReportsService,
  ) {}

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('statements')
  @ApiOkResponse({ type: [StatementDto] })
  statements(@RestaurantId() rid: string) {
    return this.fees.list(rid);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('statements/:id')
  @ApiOkResponse({ type: StatementDetailDto })
  statement(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.fees.get(id, rid);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('statements/:id/pdf')
  @ApiProduces('application/pdf')
  async pdf(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Res() res: Response) {
    const buf = await this.fees.pdf(id, rid);
    res.type('application/pdf').setHeader('Content-Disposition', `attachment; filename="comi-statement-${id.slice(0, 8)}.pdf"`).send(buf);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('reports')
  @ApiQuery({ name: 'from', example: '2026-12-01' })
  @ApiQuery({ name: 'to', example: '2026-12-31' })
  @ApiOkResponse({ type: ReportDto })
  report(@RestaurantId() rid: string, @Query('from') from: string, @Query('to') to: string) {
    if (!DATE_RE.test(from ?? '') || !DATE_RE.test(to ?? '')) throw new AppError('VALIDATION_FAILED', 'from/to must be YYYY-MM-DD');
    return this.reports.summary(rid, from, to);
  }
}

@ApiTags('admin / statements')
@AdminOnly()
@Controller('admin/statements')
export class AdminStatementsController {
  constructor(private readonly fees: FeesService) {}

  @Get()
  @ApiQuery({ name: 'status', required: false, enum: ['ISSUED', 'PAID', 'OVERDUE'] })
  @ApiOkResponse({ type: [StatementDto] })
  list(@Query('status') status?: string) {
    return this.fees.list(undefined, status);
  }

  /** Bank transfer received (matched by the memo). */
  @Post(':id/paid')
  @HttpCode(200)
  @ApiOkResponse({ type: StatementDetailDto })
  paid(@CurrentStaffId() adminId: string, @Param('id', uuid) id: string) {
    return this.fees.markPaid(adminId, id);
  }

  /** Run the monthly job by hand (e.g. after fixing data). Idempotent. */
  @Post('generate')
  @HttpCode(200)
  @ApiQuery({ name: 'month', example: '2026-12' })
  async generate(@Query('month') month: string) {
    if (!MONTH_RE.test(month ?? '')) throw new AppError('VALIDATION_FAILED', 'month must be YYYY-MM');
    return { created: await this.fees.generate(month) };
  }
}

@Global()
@Module({ controllers: [RestaurantFeesController, AdminStatementsController], providers: [FeesService, ReportsService], exports: [FeesService] })
export class FeesModule {}
