import { Injectable } from '@nestjs/common';
import { Prisma, RestaurantStatus } from '@prisma/client';
import { AuditService } from '../../common/audit.service';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { slugify } from '../../common/utils/slug';
import { randomToken } from '../../common/utils/crypto';
import { PrismaService } from '../../prisma/prisma.service';
import { AvailabilityService } from '../availability/availability.service';
import {
  ClosureDto,
  OpeningHoursItemDto,
  RegisterRestaurantDto,
  UpdateProfileDto,
  UpdateSettingsDto,
} from './restaurants.dto';

type Tx = Prisma.TransactionClient;

@Injectable()
export class RestaurantsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly availability: AvailabilityService,
  ) {}

  /** POST /restaurant/register — creates a DRAFT restaurant with the caller as OWNER. */
  async register(staffId: string, dto: RegisterRestaurantDto) {
    const { lat, lng, ...data } = dto;
    const restaurant = await this.prisma.$transaction(async (tx) => {
      const slug = await this.uniqueSlug(tx, dto.name);
      const r = await tx.restaurant.create({
        data: {
          ...data,
          slug,
          cuisineTags: dto.cuisineTags ?? [],
          members: { create: { staffId, role: 'OWNER' } },
        },
      });
      if (lat !== undefined && lng !== undefined) await this.setLocation(tx, r.id, lat, lng);
      await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'restaurant.register', entity: 'Restaurant', entityId: r.id }, tx);
      return r;
    });
    return this.getProfile(restaurant.id);
  }

  listMine(staffId: string) {
    return this.prisma.restaurantMember.findMany({
      where: { staffId, restaurant: { deletedAt: null } },
      select: {
        role: true,
        restaurant: { select: { id: true, slug: true, name: true, status: true, coverPhotoUrl: true } },
      },
      orderBy: { createdAt: 'asc' },
    });
  }

  async getProfile(restaurantId: string) {
    const r = await this.prisma.restaurant.findFirst({
      where: { id: restaurantId, deletedAt: null },
      include: {
        openingHours: { orderBy: [{ weekday: 'asc' }, { openMinute: 'asc' }] },
        closures: { where: { endsAt: { gte: this.clock.now() } }, orderBy: { startsAt: 'asc' } },
      },
    });
    if (!r) throw notFound('Restaurant');
    const [loc] = await this.prisma.$queryRaw<{ lat: number | null; lng: number | null }[]>`
      SELECT ST_Y(location::geometry) AS lat, ST_X(location::geometry) AS lng
      FROM "Restaurant" WHERE id = ${restaurantId}`;
    return { ...r, ratingAvg: Number(r.ratingAvg), lat: loc?.lat ?? null, lng: loc?.lng ?? null };
  }

  async updateProfile(staffId: string, restaurantId: string, dto: UpdateProfileDto) {
    const { lat, lng, ...data } = dto;
    if ((lat === undefined) !== (lng === undefined)) {
      throw new AppError('VALIDATION_FAILED', 'lat and lng must be sent together');
    }
    await this.prisma.$transaction(async (tx) => {
      await tx.restaurant.update({ where: { id: restaurantId }, data });
      if (lat !== undefined && lng !== undefined) await this.setLocation(tx, restaurantId, lat, lng);
      await this.audit.log(
        { actorType: 'STAFF', actorId: staffId, action: 'restaurant.update_profile', entity: 'Restaurant', entityId: restaurantId, data: dto },
        tx,
      );
    });
    return this.getProfile(restaurantId);
  }

  async updateSettings(staffId: string, restaurantId: string, dto: UpdateSettingsDto) {
    await this.prisma.$transaction(async (tx) => {
      await tx.restaurant.update({ where: { id: restaurantId }, data: dto });
      await this.audit.log(
        { actorType: 'STAFF', actorId: staffId, action: 'restaurant.update_settings', entity: 'Restaurant', entityId: restaurantId, data: dto },
        tx,
      );
    });
    await this.availability.invalidate(restaurantId);
    return this.getProfile(restaurantId);
  }

  /** Replace the whole week. Overlapping ranges on the same weekday are rejected. */
  async replaceOpeningHours(restaurantId: string, items: OpeningHoursItemDto[]) {
    validateOpeningHours(items);
    await this.prisma.$transaction([
      this.prisma.openingHours.deleteMany({ where: { restaurantId } }),
      this.prisma.openingHours.createMany({ data: items.map((i) => ({ ...i, restaurantId })) }),
    ]);
    await this.availability.invalidate(restaurantId);
    return this.prisma.openingHours.findMany({
      where: { restaurantId },
      orderBy: [{ weekday: 'asc' }, { openMinute: 'asc' }],
    });
  }

  listClosures(restaurantId: string) {
    return this.prisma.closure.findMany({ where: { restaurantId }, orderBy: { startsAt: 'desc' }, take: 100 });
  }

  async createClosure(restaurantId: string, dto: ClosureDto) {
    const startsAt = new Date(dto.startsAt);
    const endsAt = new Date(dto.endsAt);
    if (endsAt <= startsAt) throw new AppError('VALIDATION_FAILED', 'endsAt must be after startsAt');
    const closure = await this.prisma.closure.create({ data: { restaurantId, startsAt, endsAt, reason: dto.reason } });
    await this.availability.invalidate(restaurantId);
    return closure;
  }

  async deleteClosure(restaurantId: string, id: string) {
    const { count } = await this.prisma.closure.deleteMany({ where: { id, restaurantId } });
    if (!count) throw notFound('Closure');
    await this.availability.invalidate(restaurantId);
  }

  /** What is still missing before the restaurant can be submitted for review. */
  async checklist(restaurantId: string) {
    const [profile, hours, tables, items] = await Promise.all([
      this.getProfile(restaurantId),
      this.prisma.openingHours.count({ where: { restaurantId } }),
      this.prisma.table.count({ where: { restaurantId, isActive: true } }),
      this.prisma.menuItem.count({ where: { restaurantId, deletedAt: null } }),
    ]);
    const missing: string[] = [];
    if (profile.lat === null) missing.push('location');
    if (hours === 0) missing.push('openingHours');
    if (tables === 0) missing.push('tables');
    if (items === 0) missing.push('menuItems');
    return { complete: missing.length === 0, missing };
  }

  /** DRAFT/REJECTED → PENDING_REVIEW. */
  async submit(staffId: string, restaurantId: string) {
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId } });
    if (r.status !== 'DRAFT' && r.status !== 'REJECTED') {
      throw new AppError('INVALID_STATUS', `Cannot submit from ${r.status}`, { status: r.status });
    }
    const check = await this.checklist(restaurantId);
    if (!check.complete) throw new AppError('RESTAURANT_INCOMPLETE', 'Restaurant profile is incomplete', check);
    return this.transition(restaurantId, ['DRAFT', 'REJECTED'], 'PENDING_REVIEW', { actorType: 'STAFF', actorId: staffId }, {
      submittedAt: this.clock.now(),
      rejectReason: null,
    });
  }

  // ───── admin ─────

  listForReview(status: RestaurantStatus = 'PENDING_REVIEW') {
    return this.prisma.restaurant.findMany({
      where: { status, deletedAt: null },
      orderBy: { submittedAt: 'asc' },
      select: { id: true, slug: true, name: true, address: true, phone: true, status: true, submittedAt: true },
    });
  }

  approve(adminId: string, restaurantId: string) {
    return this.transition(restaurantId, ['PENDING_REVIEW', 'PAUSED'], 'ACTIVE', { actorType: 'ADMIN', actorId: adminId }, {
      approvedAt: this.clock.now(),
      rejectReason: null,
    });
  }

  reject(adminId: string, restaurantId: string, reason: string) {
    return this.transition(restaurantId, ['PENDING_REVIEW'], 'REJECTED', { actorType: 'ADMIN', actorId: adminId }, { rejectReason: reason });
  }

  pause(adminId: string, restaurantId: string) {
    return this.transition(restaurantId, ['ACTIVE'], 'PAUSED', { actorType: 'ADMIN', actorId: adminId });
  }

  // ───── helpers ─────

  /** Status change with optimistic check, so two admins clicking at once cannot double-transition. */
  private async transition(
    restaurantId: string,
    from: RestaurantStatus[],
    to: RestaurantStatus,
    actor: { actorType: 'STAFF' | 'ADMIN'; actorId: string },
    extra: Prisma.RestaurantUpdateManyMutationInput = {},
  ) {
    await this.prisma.$transaction(async (tx) => {
      const { count } = await tx.restaurant.updateMany({
        where: { id: restaurantId, status: { in: from }, deletedAt: null },
        data: { ...extra, status: to },
      });
      if (!count) {
        const r = await tx.restaurant.findUnique({ where: { id: restaurantId }, select: { status: true } });
        if (!r) throw notFound('Restaurant');
        throw new AppError('INVALID_STATUS', `Cannot move from ${r.status} to ${to}`, { status: r.status });
      }
      await this.audit.log({ ...actor, action: `restaurant.${to.toLowerCase()}`, entity: 'Restaurant', entityId: restaurantId, data: extra }, tx);
    });
    return this.getProfile(restaurantId);
  }

  private async setLocation(tx: Tx, id: string, lat: number, lng: number) {
    await tx.$executeRaw`
      UPDATE "Restaurant" SET location = ST_SetSRID(ST_MakePoint(${lng}, ${lat}), 4326)::geography WHERE id = ${id}`;
  }

  private async uniqueSlug(tx: Tx, name: string): Promise<string> {
    const base = slugify(name) || 'quan';
    const taken = await tx.restaurant.findUnique({ where: { slug: base }, select: { id: true } });
    if (!taken) return base;
    return `${base}-${randomToken(3).toLowerCase().replace(/[^a-z0-9]/g, 'x')}`;
  }
}

export function validateOpeningHours(items: OpeningHoursItemDto[]) {
  for (const i of items) {
    if (i.closeMinute <= i.openMinute) {
      throw new AppError('VALIDATION_FAILED', 'closeMinute must be after openMinute', { item: i });
    }
    if (i.lastOrderMinute !== undefined && (i.lastOrderMinute < i.openMinute || i.lastOrderMinute > i.closeMinute)) {
      throw new AppError('VALIDATION_FAILED', 'lastOrderMinute must be within opening hours', { item: i });
    }
  }
  const byDay = new Map<number, OpeningHoursItemDto[]>();
  for (const i of items) byDay.set(i.weekday, [...(byDay.get(i.weekday) ?? []), i]);
  for (const [weekday, ranges] of byDay) {
    const sorted = [...ranges].sort((a, b) => a.openMinute - b.openMinute);
    for (let k = 1; k < sorted.length; k++) {
      if (sorted[k].openMinute < sorted[k - 1].closeMinute) {
        throw new AppError('VALIDATION_FAILED', 'Opening hours overlap', { weekday });
      }
    }
  }
}
