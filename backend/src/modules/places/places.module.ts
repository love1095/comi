import { Body, Controller, Get, Global, Inject, Injectable, Logger, Module, Put } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiTags } from '@nestjs/swagger';
import { IsObject } from 'class-validator';
import { AuditService } from '../../common/audit.service';
import { AdminOnly, CurrentStaffId, Public } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError } from '../../common/errors/app-error';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';
import { GooglePlaces } from './places';

const CURRENCIES = ['USD', 'KRW', 'CNY', 'JPY'] as const;
const REFRESH_DAYS = 7;

export class ExchangeRateDto {
  @ApiProperty({ enum: CURRENCIES }) currency: string;
  @ApiProperty({ description: 'How many VND one unit buys' }) vndPerUnit: number;
  @ApiProperty() updatedAt: string;
}

class RatesDto {
  @ApiProperty({ example: { USD: 25400, KRW: 18.5 }, type: 'object', additionalProperties: { type: 'number' } }) @IsObject() rates: Record<string, number>;
}


/** Google ratings (refreshed weekly) and exchange rates for approximate tourist prices. */
@Injectable()
export class PlacesService {
  private readonly logger = new Logger(PlacesService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    @Inject(ENV) private readonly env: Env,
  ) {}

  /** google-ratings (daily): restaurants with a Google place id and a rating older than 7 days. */
  async refreshGoogleRatings(google = this.env.GOOGLE_PLACES_API_KEY ? new GooglePlaces(this.env.GOOGLE_PLACES_API_KEY) : null) {
    if (!google) return { updated: 0, skipped: 'no GOOGLE_PLACES_API_KEY' };
    const stale = new Date(this.clock.now().getTime() - REFRESH_DAYS * 86_400_000);
    const rows = await this.prisma.restaurant.findMany({
      where: { googlePlaceId: { not: null }, deletedAt: null, OR: [{ googleRatingAt: null }, { googleRatingAt: { lt: stale } }] },
      select: { id: true, googlePlaceId: true },
      take: 200,
    });
    let updated = 0;
    for (const r of rows) {
      const g = await google.rating(r.googlePlaceId!);
      await this.prisma.restaurant.update({
        where: { id: r.id },
        data: { googleRating: g?.rating ?? null, googleRatingCount: g?.count ?? null, googleRatingAt: this.clock.now() },
      });
      if (g) updated++;
    }
    this.logger.log(`google ratings: ${updated}/${rows.length} updated`);
    return { updated, checked: rows.length };
  }

  async rates() {
    const rows = await this.prisma.exchangeRate.findMany({ orderBy: { currency: 'asc' } });
    return rows.map((r) => ({ currency: r.currency, vndPerUnit: Number(r.vndPerUnit), updatedAt: r.updatedAt.toISOString() }));
  }

  async setRates(adminId: string, rates: Record<string, number>) {
    const now = this.clock.now();
    for (const [currency, value] of Object.entries(rates)) {
      if (!(CURRENCIES as readonly string[]).includes(currency)) throw new AppError('VALIDATION_FAILED', `Unsupported currency ${currency}`);
      if (!(typeof value === 'number' && value > 0 && value < 1_000_000)) throw new AppError('VALIDATION_FAILED', `Bad rate for ${currency}`);
      await this.prisma.exchangeRate.upsert({ where: { currency }, create: { currency, vndPerUnit: value, updatedAt: now }, update: { vndPerUnit: value, updatedAt: now } });
    }
    await this.audit.log({ actorType: 'STAFF', actorId: adminId, action: 'exchange_rates.updated', entity: 'ExchangeRate', entityId: 'all', data: rates });
    return this.rates();
  }
}

@ApiTags('public / exchange rates')
@Controller()
export class PlacesController {
  constructor(private readonly places: PlacesService) {}

  /** For "≈ $5.90" next to VND prices (tourists). Approximate only — guests pay in VND. */
  @Public()
  @Get('exchange-rates')
  @ApiOkResponse({ type: [ExchangeRateDto] })
  rates() {
    return this.places.rates();
  }

  @AdminOnly()
  @Put('admin/exchange-rates')
  @ApiOkResponse({ type: [ExchangeRateDto] })
  setRates(@CurrentStaffId() adminId: string, @Body() dto: RatesDto) {
    return this.places.setRates(adminId, dto.rates);
  }
}

@Global()
@Module({ controllers: [PlacesController], providers: [PlacesService], exports: [PlacesService] })
export class PlacesModule {}
