import { Controller, Get, Global, Inject, Injectable, Logger, Module, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Perm } from '../../common/auth/auth.types';
import { RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { AppError } from '../../common/errors/app-error';
import { SUPPORTED_LOCALES } from '../../common/i18n';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';
import { GoogleTranslator, Translator, chunk } from './translator';

const TARGETS = SUPPORTED_LOCALES.filter((l) => l !== 'vi');
const BATCH = 100;

export class TranslationRowDto {
  @ApiProperty() itemId: string;
  @ApiProperty({ description: 'Vietnamese source' }) sourceName: string;
  @ApiPropertyOptional({ nullable: true, type: String }) sourceDescription: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) name: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty({ enum: ['none', 'machine', 'human'] }) state: string;
}

/**
 * Machine translation of menus and restaurant descriptions (§17.2):
 * missing translations are filled every 10 minutes; human edits are never overwritten
 * (text changes delete only machine rows, so they are translated again).
 */
@Injectable()
export class TranslationsService {
  private readonly logger = new Logger(TranslationsService.name);

  constructor(
    private readonly prisma: PrismaService,
    @Inject(ENV) private readonly env: Env,
  ) {}

  private translator(): Translator | null {
    return this.env.GOOGLE_TRANSLATE_API_KEY ? new GoogleTranslator(this.env.GOOGLE_TRANSLATE_API_KEY) : null;
  }

  /** translate-sweep job. Returns how many rows were written. */
  async sweep(translator: Translator | null = this.translator()) {
    if (!translator) return { written: 0, skipped: 'no GOOGLE_TRANSLATE_API_KEY' };
    let written = 0;
    for (const locale of TARGETS) {
      const items = await this.prisma.menuItem.findMany({
        where: { deletedAt: null, restaurant: { deletedAt: null, status: { in: ['ACTIVE', 'PENDING_REVIEW'] } }, translations: { none: { locale } } },
        select: { id: true, name: true, description: true },
        take: 500,
      });
      for (const part of chunk(items, BATCH)) {
        const names = await translator.translate(part.map((i) => i.name), locale);
        const withDesc = part.filter((i) => i.description);
        const descs = await translator.translate(withDesc.map((i) => i.description!), locale);
        const descOf = new Map(withDesc.map((i, k) => [i.id, descs[k]]));
        const r = await this.prisma.menuItemTranslation.createMany({
          data: part.map((i, k) => ({ itemId: i.id, locale, name: names[k], description: descOf.get(i.id) ?? null, isMachine: true })),
          skipDuplicates: true,
        });
        written += r.count;
      }

      // Restaurant names stay Vietnamese (they are proper names); only the description is translated.
      const rs = await this.prisma.restaurant.findMany({
        where: { deletedAt: null, description: { not: null }, status: { in: ['ACTIVE', 'PENDING_REVIEW'] }, translations: { none: { locale } } },
        select: { id: true, name: true, description: true },
        take: 200,
      });
      for (const part of chunk(rs, BATCH)) {
        const descs = await translator.translate(part.map((r) => r.description!), locale);
        const r = await this.prisma.restaurantTranslation.createMany({
          data: part.map((x, k) => ({ restaurantId: x.id, locale, name: x.name, description: descs[k], isMachine: true })),
          skipDuplicates: true,
        });
        written += r.count;
      }
    }
    if (written) this.logger.log(`translations written: ${written}`);
    return { written };
  }

  /** Translation editor: every dish with its source text and the current translation. */
  async editorRows(restaurantId: string, locale: string) {
    if (!(TARGETS as readonly string[]).includes(locale)) throw new AppError('VALIDATION_FAILED', `Unsupported locale ${locale}`);
    const items = await this.prisma.menuItem.findMany({
      where: { restaurantId, deletedAt: null },
      orderBy: [{ category: { sortOrder: 'asc' } }, { sortOrder: 'asc' }],
      select: { id: true, name: true, description: true, translations: { where: { locale } } },
    });
    return items.map((i) => {
      const t = i.translations[0];
      return {
        itemId: i.id,
        sourceName: i.name,
        sourceDescription: i.description,
        name: t?.name ?? null,
        description: t?.description ?? null,
        state: !t ? 'none' : t.isMachine ? 'machine' : 'human',
      };
    });
  }
}

@ApiTags('restaurant / menu')
@Controller('restaurant/menu/translations')
export class TranslationsController {
  constructor(private readonly translations: TranslationsService) {}

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get()
  @ApiQuery({ name: 'locale', enum: TARGETS })
  @ApiOkResponse({ type: [TranslationRowDto] })
  rows(@RestaurantId() rid: string, @Query('locale') locale: string) {
    return this.translations.editorRows(rid, locale);
  }
}

@Global()
@Module({ controllers: [TranslationsController], providers: [TranslationsService], exports: [TranslationsService] })
export class TranslationsModule {}
