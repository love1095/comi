import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { Clock } from '../../common/clock';
import { notFound } from '../../common/errors/app-error';
import { Locale, translate } from '../../common/i18n';
import { zonedParts } from '../../common/utils/time';
import { PrismaService } from '../../prisma/prisma.service';
import { isOpenAt } from '../availability/slots';
import { NearbyQuery } from './discovery.dto';

/** Launch city time zone, used for "open now / open late" filters in list queries. */
const LIST_TZ = 'Asia/Ho_Chi_Minh';

export interface RestaurantCard {
  id: string;
  slug: string;
  name: string;
  address: string;
  priceLevel: number;
  ratingAvg: number;
  ratingCount: number;
  coverPhotoUrl: string | null;
  cuisineTags: string[];
  servesLunch: boolean;
  servesNhau: boolean;
  allowTableChoice: boolean;
  lat: number;
  lng: number;
  distanceM: number | null;
  minMainPrice: number | null;
}

@Injectable()
export class DiscoveryService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly clock: Clock,
  ) {}

  /** GET /restaurants — nearby with filters (§14.1 + lunch/nhậu filters). */
  async nearby(q: NearbyQuery, locale: Locale) {
    const limit = q.limit ?? 20;
    const offset = q.cursor ?? 0;
    const here = Prisma.sql`ST_SetSRID(ST_MakePoint(${q.lng}, ${q.lat}), 4326)::geography`;
    const { weekday, minuteOfDay } = zonedParts(this.clock.now(), LIST_TZ);
    const prev = (weekday + 6) % 7;

    const where: Prisma.Sql[] = [
      Prisma.sql`r.status = 'ACTIVE' AND r."deletedAt" IS NULL AND r.location IS NOT NULL`,
      Prisma.sql`ST_DWithin(r.location, ${here}, ${q.radius ?? 3000})`,
    ];
    if (q.q) where.push(Prisma.sql`search_norm(r.name) LIKE '%' || search_norm(${q.q}) || '%'`);
    if (q.cuisine) where.push(Prisma.sql`r."cuisineTags" && ${q.cuisine.split(',').map((c) => c.trim()).filter(Boolean)}::text[]`);
    if (q.priceMax) where.push(Prisma.sql`r."priceLevel" <= ${q.priceMax}`);
    if (q.minRating !== undefined) where.push(Prisma.sql`r."ratingAvg" >= ${q.minRating}`);
    if (q.mode === 'lunch') where.push(Prisma.sql`r."servesLunch"`);
    if (q.mode === 'nhau') where.push(Prisma.sql`r."servesNhau"`);
    if (q.groupSize) where.push(Prisma.sql`r."maxGroupSize" >= ${q.groupSize}`);
    if (q.maxMainPrice !== undefined) {
      where.push(Prisma.sql`EXISTS (SELECT 1 FROM "MenuItem" m WHERE m."restaurantId" = r.id AND m."deletedAt" IS NULL
        AND m.course = 'MAIN' AND m.price <= ${q.maxMainPrice})`);
    }
    if (q.openNow) {
      where.push(Prisma.sql`EXISTS (SELECT 1 FROM "OpeningHours" h WHERE h."restaurantId" = r.id AND (
        (h.weekday = ${weekday} AND ${minuteOfDay} >= h."openMinute" AND ${minuteOfDay} < h."closeMinute")
        OR (h.weekday = ${prev} AND h."closeMinute" > 1440 AND ${minuteOfDay} < h."closeMinute" - 1440)))`);
    }
    if (q.openLate) {
      where.push(Prisma.sql`EXISTS (SELECT 1 FROM "OpeningHours" h WHERE h."restaurantId" = r.id AND h.weekday = ${weekday} AND h."closeMinute" >= 1380)`);
    }
    if (q.privateRoom) {
      where.push(Prisma.sql`('private_room' = ANY(r."ambienceTags") OR EXISTS (SELECT 1 FROM "Table" t
        WHERE t."restaurantId" = r.id AND t."isActive" AND 'private' = ANY(t.features)))`);
    }
    const order = q.sort === 'rating' ? Prisma.sql`r."ratingAvg" DESC, "distanceM" ASC` : Prisma.sql`"distanceM" ASC`;

    const rows = await this.prisma.$queryRaw<RestaurantCard[]>`
      SELECT r.id, r.slug, r.name, r.address, r."priceLevel", r."ratingAvg"::float AS "ratingAvg", r."ratingCount",
             r."coverPhotoUrl", r."cuisineTags", r."servesLunch", r."servesNhau", r."allowTableChoice",
             ST_Y(r.location::geometry) AS lat, ST_X(r.location::geometry) AS lng,
             round(ST_Distance(r.location, ${here}))::int AS "distanceM",
             (SELECT min(m.price) FROM "MenuItem" m WHERE m."restaurantId" = r.id AND m."deletedAt" IS NULL AND m.course = 'MAIN') AS "minMainPrice"
      FROM "Restaurant" r
      WHERE ${Prisma.join(where, ' AND ')}
      ORDER BY ${order}, r.id
      LIMIT ${limit + 1} OFFSET ${offset}`;

    const items = await this.translateNames(rows.slice(0, limit), locale);
    return { items, nextCursor: rows.length > limit ? offset + limit : null };
  }

  /** GET /restaurants/map — pins inside the visible box, max 200 (clustered in the app). */
  async map(bbox: string) {
    const [minLng, minLat, maxLng, maxLat] = bbox.split(',').map(Number);
    return this.prisma.$queryRaw<{ id: string; slug: string; name: string; lat: number; lng: number; priceLevel: number; ratingAvg: number }[]>`
      SELECT r.id, r.slug, r.name, ST_Y(r.location::geometry) AS lat, ST_X(r.location::geometry) AS lng,
             r."priceLevel", r."ratingAvg"::float AS "ratingAvg", r."coverPhotoUrl", r."servesLunch", r."servesNhau"
      FROM "Restaurant" r
      WHERE r.status = 'ACTIVE' AND r."deletedAt" IS NULL
        AND r.location && ST_MakeEnvelope(${minLng}, ${minLat}, ${maxLng}, ${maxLat}, 4326)::geography
      ORDER BY r."ratingAvg" DESC
      LIMIT 200`;
  }

  /** GET /restaurants/:slug — public detail (translated). */
  async detail(slug: string, locale: Locale) {
    const r = await this.prisma.restaurant.findFirst({
      where: { slug, status: 'ACTIVE', deletedAt: null },
      include: {
        translations: true,
        openingHours: { orderBy: [{ weekday: 'asc' }, { openMinute: 'asc' }] },
        areas: { orderBy: [{ floor: 'asc' }, { sortOrder: 'asc' }], select: { id: true, name: true, floor: true } },
        closures: { where: { endsAt: { gte: this.clock.now() } }, orderBy: { startsAt: 'asc' }, take: 5 },
      },
    });
    if (!r) throw notFound('Restaurant');
    const [loc] = await this.prisma.$queryRaw<{ lat: number; lng: number }[]>`
      SELECT ST_Y(location::geometry) AS lat, ST_X(location::geometry) AS lng FROM "Restaurant" WHERE id = ${r.id}`;
    const now = zonedParts(this.clock.now(), r.timezone);
    const t = translate(r, r.translations.map((x) => ({ ...x, name: x.name })), locale);
    return {
      id: r.id,
      slug: r.slug,
      name: t.name,
      description: t.description,
      translated: t.translated,
      phone: r.phone,
      address: r.address,
      lat: loc?.lat ?? null,
      lng: loc?.lng ?? null,
      timezone: r.timezone,
      cuisineTags: r.cuisineTags,
      ambienceTags: r.ambienceTags,
      priceLevel: r.priceLevel,
      coverPhotoUrl: r.coverPhotoUrl,
      ratingAvg: Number(r.ratingAvg),
      ratingCount: r.ratingCount,
      servesLunch: r.servesLunch,
      servesNhau: r.servesNhau,
      allowTableChoice: r.allowTableChoice,
      allowCod: r.allowCod,
      maxGroupSize: r.maxGroupSize,
      confirmGroupsOver: r.confirmGroupsOver,
      cancelCutoffMinutes: r.cancelCutoffMinutes,
      isOpenNow: isOpenAt(r.openingHours, now.weekday, now.minuteOfDay),
      openingHours: r.openingHours.map(({ weekday, openMinute, closeMinute, lastOrderMinute }) => ({ weekday, openMinute, closeMinute, lastOrderMinute })),
      closures: r.closures.map(({ startsAt, endsAt, reason }) => ({ startsAt, endsAt, reason })),
      areas: r.areas,
    };
  }

  /** GET /restaurants/:id/menu — categories → dishes with photos and options, translated. */
  async menu(restaurantId: string, locale: Locale) {
    const r = await this.prisma.restaurant.findFirst({ where: { id: restaurantId, status: 'ACTIVE', deletedAt: null }, select: { id: true } });
    if (!r) throw notFound('Restaurant');
    const cats = await this.prisma.menuCategory.findMany({
      where: { restaurantId, deletedAt: null },
      orderBy: { sortOrder: 'asc' },
      include: {
        items: {
          where: { deletedAt: null },
          orderBy: { sortOrder: 'asc' },
          include: {
            photos: { orderBy: { sortOrder: 'asc' }, select: { id: true, publicId: true, width: true, height: true, blurhash: true } },
            translations: true,
            optionGroups: { orderBy: { sortOrder: 'asc' }, include: { options: { orderBy: { sortOrder: 'asc' } } } },
          },
        },
      },
    });
    return cats
      .filter((c) => c.items.length)
      .map((c) => ({
        id: c.id,
        name: c.name,
        items: c.items.map((i) => {
          const t = translate(i, i.translations, locale);
          return {
            id: i.id,
            name: t.name,
            description: t.description,
            translated: t.translated,
            originalName: i.name,
            price: i.price,
            course: i.course,
            kind: i.kind,
            prepMinutes: i.prepMinutes,
            isAvailable: i.isAvailable,
            isPreorderable: i.isPreorderable,
            isAlcohol: i.isAlcohol,
            leadHours: i.leadHours,
            tags: i.tags,
            photos: i.photos,
            optionGroups: i.optionGroups.map((g) => ({
              id: g.id,
              name: g.name,
              minSelect: g.minSelect,
              maxSelect: g.maxSelect,
              options: g.options.map((o) => ({ id: o.id, name: o.name, priceDelta: o.priceDelta })),
            })),
          };
        }),
      }));
  }

  /** GET /search/suggest — restaurants + dishes, accent-insensitive ("pho" finds "Phở"). */
  async suggest(q: string) {
    const [restaurants, dishes] = await Promise.all([
      this.prisma.$queryRaw<{ id: string; slug: string; name: string }[]>`
        SELECT r.id, r.slug, r.name FROM "Restaurant" r
        WHERE r.status = 'ACTIVE' AND r."deletedAt" IS NULL AND search_norm(r.name) LIKE '%' || search_norm(${q}) || '%'
        ORDER BY similarity(search_norm(r.name), search_norm(${q})) DESC LIMIT 5`,
      this.prisma.$queryRaw<{ id: string; name: string; price: number; restaurantId: string; restaurantSlug: string; restaurantName: string }[]>`
        SELECT m.id, m.name, m.price, r.id AS "restaurantId", r.slug AS "restaurantSlug", r.name AS "restaurantName"
        FROM "MenuItem" m JOIN "Restaurant" r ON r.id = m."restaurantId"
        WHERE r.status = 'ACTIVE' AND r."deletedAt" IS NULL AND m."deletedAt" IS NULL
          AND search_norm(m.name) LIKE '%' || search_norm(${q}) || '%'
        ORDER BY similarity(search_norm(m.name), search_norm(${q})) DESC LIMIT 8`,
    ]);
    return { restaurants, dishes };
  }

  /** GET /home — sections change with the time of day (§0.5). */
  async home(lat: number, lng: number, locale: Locale) {
    const { minuteOfDay } = zonedParts(this.clock.now(), LIST_TZ);
    const mode = minuteOfDay >= 600 && minuteOfDay < 810 ? 'lunch' : minuteOfDay >= 960 && minuteOfDay < 1380 ? 'tonight' : 'explore';
    const sections: { key: string; items: RestaurantCard[] }[] = [];
    if (mode === 'lunch') {
      sections.push({ key: 'lunch_near_you', items: (await this.nearby({ lat, lng, radius: 1500, mode: 'lunch', openNow: true, limit: 10 }, locale)).items });
      sections.push({ key: 'under_60k', items: (await this.nearby({ lat, lng, radius: 1500, maxMainPrice: 60_000, limit: 10 }, locale)).items });
    } else if (mode === 'tonight') {
      sections.push({ key: 'tonight_groups', items: (await this.nearby({ lat, lng, radius: 5000, mode: 'nhau', groupSize: 8, limit: 10 }, locale)).items });
      sections.push({ key: 'open_late', items: (await this.nearby({ lat, lng, radius: 5000, openLate: true, limit: 10 }, locale)).items });
    }
    sections.push({ key: 'top_rated', items: (await this.nearby({ lat, lng, radius: 5000, sort: 'rating', limit: 10 }, locale)).items });
    if (locale !== 'vi') {
      const translated = await this.prisma.restaurant.findMany({ where: { status: 'ACTIVE', menuFullyTranslated: true }, select: { id: true }, take: 50 });
      const ids = new Set(translated.map((x) => x.id));
      const near = (await this.nearby({ lat, lng, radius: 5000, limit: 50 }, locale)).items.filter((x) => ids.has(x.id)).slice(0, 10);
      sections.unshift({ key: 'menus_in_your_language', items: near });
    }
    return { mode, sections: sections.filter((s) => s.items.length) };
  }

  private async translateNames<T extends { id: string; name: string }>(rows: T[], locale: Locale): Promise<T[]> {
    if (locale === 'vi' || !rows.length) return rows;
    const trs = await this.prisma.restaurantTranslation.findMany({ where: { restaurantId: { in: rows.map((r) => r.id) } } });
    return rows.map((r) => ({ ...r, name: translate(r, trs.filter((t) => t.restaurantId === r.id), locale).name }));
  }
}
