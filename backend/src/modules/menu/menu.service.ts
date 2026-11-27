import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { JobsService, QUEUES } from '../../jobs/queues';
import { MediaService } from '../media/media.service';
import { ImportedItem } from './menu-import';
import {
  AddPhotoDto,
  CategoryDto,
  MenuItemDto,
  OptionGroupDto,
  TranslationDto,
  UpdateCategoryDto,
  UpdateMenuItemDto,
} from './menu.dto';

const ITEM_INCLUDE = {
  photos: { orderBy: { sortOrder: 'asc' } },
  optionGroups: { orderBy: { sortOrder: 'asc' }, include: { options: { orderBy: { sortOrder: 'asc' } } } },
  translations: true,
} satisfies Prisma.MenuItemInclude;

@Injectable()
export class MenuService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly media: MediaService,
    private readonly clock: Clock,
    private readonly jobs: JobsService,
  ) {}

  /** Full menu for the restaurant app editor (includes sold-out and hidden-from-preorder items). */
  async getMenu(restaurantId: string) {
    return this.prisma.menuCategory.findMany({
      where: { restaurantId, deletedAt: null },
      orderBy: { sortOrder: 'asc' },
      include: {
        items: { where: { deletedAt: null }, orderBy: { sortOrder: 'asc' }, include: ITEM_INCLUDE },
      },
    });
  }

  // ───── categories ─────

  async createCategory(restaurantId: string, dto: CategoryDto) {
    const sortOrder = dto.sortOrder ?? (await this.prisma.menuCategory.count({ where: { restaurantId, deletedAt: null } }));
    return this.prisma.menuCategory.create({ data: { restaurantId, name: dto.name, sortOrder } });
  }

  async updateCategory(restaurantId: string, id: string, dto: UpdateCategoryDto) {
    await this.findCategory(restaurantId, id);
    return this.prisma.menuCategory.update({ where: { id }, data: dto });
  }

  async deleteCategory(restaurantId: string, id: string) {
    await this.findCategory(restaurantId, id);
    const items = await this.prisma.menuItem.count({ where: { categoryId: id, deletedAt: null } });
    if (items) throw new AppError('CONFLICT', 'Move or delete the dishes in this category first', { items });
    await this.prisma.menuCategory.update({ where: { id }, data: { deletedAt: this.clock.now() } });
  }

  async reorderCategories(restaurantId: string, ids: string[]) {
    const owned = await this.prisma.menuCategory.count({ where: { id: { in: ids }, restaurantId } });
    if (owned !== new Set(ids).size) throw notFound('Category');
    await this.prisma.$transaction(ids.map((id, i) => this.prisma.menuCategory.update({ where: { id }, data: { sortOrder: i } })));
  }

  // ───── items ─────

  async createItem(restaurantId: string, dto: MenuItemDto) {
    await this.findCategory(restaurantId, dto.categoryId);
    const { optionGroups, ...data } = dto;
    if (optionGroups) validateOptionGroups(optionGroups);
    const sortOrder = dto.sortOrder ?? (await this.prisma.menuItem.count({ where: { categoryId: dto.categoryId, deletedAt: null } }));
    const item = await this.prisma.menuItem.create({
      data: {
        ...data,
        restaurantId,
        sortOrder,
        tags: dto.tags ?? [],
        optionGroups: optionGroups ? { create: optionGroupsCreate(optionGroups) } : undefined,
      },
      include: ITEM_INCLUDE,
    });
    return item;
  }

  async updateItem(restaurantId: string, id: string, dto: UpdateMenuItemDto) {
    const existing = await this.findItem(restaurantId, id);
    if (dto.categoryId && dto.categoryId !== existing.categoryId) await this.findCategory(restaurantId, dto.categoryId);
    const { optionGroups, ...data } = dto;
    if (optionGroups) validateOptionGroups(optionGroups);

    const sourceChanged =
      (dto.name !== undefined && dto.name !== existing.name) ||
      (dto.description !== undefined && dto.description !== existing.description);

    return this.prisma.$transaction(async (tx) => {
      if (optionGroups) {
        await tx.optionGroup.deleteMany({ where: { itemId: id } });
      }
      // §17.2: source text changed → machine translations are stale; human edits are kept.
      if (sourceChanged) await tx.menuItemTranslation.deleteMany({ where: { itemId: id, isMachine: true } });
      return tx.menuItem.update({
        where: { id },
        data: { ...data, optionGroups: optionGroups ? { create: optionGroupsCreate(optionGroups) } : undefined },
        include: ITEM_INCLUDE,
      });
    });
  }

  async setAvailability(restaurantId: string, id: string, isAvailable: boolean) {
    await this.findItem(restaurantId, id);
    return this.prisma.menuItem.update({ where: { id }, data: { isAvailable }, select: { id: true, isAvailable: true } });
  }

  async deleteItem(restaurantId: string, id: string) {
    await this.findItem(restaurantId, id);
    await this.prisma.menuItem.update({ where: { id }, data: { deletedAt: this.clock.now(), isAvailable: false } });
  }

  async reorderItems(restaurantId: string, ids: string[]) {
    const owned = await this.prisma.menuItem.count({ where: { id: { in: ids }, restaurantId } });
    if (owned !== new Set(ids).size) throw notFound('Menu item');
    await this.prisma.$transaction(ids.map((id, i) => this.prisma.menuItem.update({ where: { id }, data: { sortOrder: i } })));
  }

  /** A human translation; machine translation never overwrites it (§17.2). */
  async putTranslation(restaurantId: string, id: string, locale: string, dto: TranslationDto) {
    await this.findItem(restaurantId, id);
    return this.prisma.menuItemTranslation.upsert({
      where: { itemId_locale: { itemId: id, locale } },
      create: { itemId: id, locale, ...dto, isMachine: false },
      update: { ...dto, isMachine: false },
    });
  }

  // ───── photos ─────

  async addPhoto(restaurantId: string, itemId: string, dto: AddPhotoDto) {
    await this.findItem(restaurantId, itemId);
    const count = await this.prisma.menuItemPhoto.count({ where: { itemId } });
    if (count >= 8) throw new AppError('CONFLICT', 'A dish can have at most 8 photos');
    const size = await this.media.verifyUpload(restaurantId, 'menu_item', dto.publicId, dto);
    const photo = await this.prisma.menuItemPhoto.create({
      data: { itemId, publicId: dto.publicId, width: size.width, height: size.height, sortOrder: count },
    });
    await this.jobs.add(QUEUES.PHOTO, 'photo-process', { photoId: photo.id }, { jobId: `photo:${photo.id}` });
    return photo;
  }

  async deletePhoto(restaurantId: string, photoId: string) {
    const photo = await this.prisma.menuItemPhoto.findFirst({ where: { id: photoId, item: { restaurantId } } });
    if (!photo) throw notFound('Photo');
    await this.prisma.menuItemPhoto.delete({ where: { id: photoId } });
    await this.media.destroy(photo.publicId);
  }

  async reorderPhotos(restaurantId: string, itemId: string, ids: string[]) {
    await this.findItem(restaurantId, itemId);
    const owned = await this.prisma.menuItemPhoto.count({ where: { id: { in: ids }, itemId } });
    if (owned !== new Set(ids).size) throw notFound('Photo');
    await this.prisma.$transaction(ids.map((id, i) => this.prisma.menuItemPhoto.update({ where: { id }, data: { sortOrder: i } })));
  }

  // ───── import ─────

  /** Creates missing categories (matched without accents/case) and appends the dishes. */
  async importItems(restaurantId: string, items: ImportedItem[]) {
    const fold = (s: string) => s.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/đ/gi, 'd').toLowerCase().trim();
    return this.prisma.$transaction(async (tx) => {
      const cats = await tx.menuCategory.findMany({ where: { restaurantId, deletedAt: null } });
      const byName = new Map(cats.map((c) => [fold(c.name), c]));
      let catOrder = cats.length;
      let created = 0;
      const counters = new Map<string, number>();
      for (const it of items) {
        let cat = byName.get(fold(it.category));
        if (!cat) {
          cat = await tx.menuCategory.create({ data: { restaurantId, name: it.category, sortOrder: catOrder++ } });
          byName.set(fold(it.category), cat);
        }
        if (!counters.has(cat.id)) counters.set(cat.id, await tx.menuItem.count({ where: { categoryId: cat.id, deletedAt: null } }));
        const sortOrder = counters.get(cat.id)!;
        counters.set(cat.id, sortOrder + 1);
        await tx.menuItem.create({
          data: {
            restaurantId,
            categoryId: cat.id,
            name: it.name,
            price: it.price,
            course: it.course,
            kind: it.kind,
            description: it.description,
            prepMinutes: it.prepMinutes,
            isAlcohol: it.isAlcohol,
            tags: it.tags,
            sortOrder,
          },
        });
        created++;
      }
      return { created, categories: byName.size };
    });
  }

  // ───── helpers ─────

  private async findCategory(restaurantId: string, id: string) {
    const c = await this.prisma.menuCategory.findFirst({ where: { id, restaurantId, deletedAt: null } });
    if (!c) throw notFound('Category');
    return c;
  }

  private async findItem(restaurantId: string, id: string) {
    const item = await this.prisma.menuItem.findFirst({ where: { id, restaurantId, deletedAt: null } });
    if (!item) throw notFound('Menu item');
    return item;
  }
}

export function validateOptionGroups(groups: OptionGroupDto[]) {
  for (const g of groups) {
    const min = g.minSelect ?? 0;
    const max = g.maxSelect ?? 1;
    if (min > max) throw new AppError('OPTION_GROUP_INVALID', `"${g.name}": minSelect > maxSelect`);
    if (max > g.options.length) throw new AppError('OPTION_GROUP_INVALID', `"${g.name}": maxSelect > number of options`);
  }
}

function optionGroupsCreate(groups: OptionGroupDto[]): Prisma.OptionGroupCreateWithoutItemInput[] {
  return groups.map((g, gi) => ({
    name: g.name,
    minSelect: g.minSelect ?? 0,
    maxSelect: g.maxSelect ?? 1,
    sortOrder: gi,
    options: { create: g.options.map((o, oi) => ({ name: o.name, priceDelta: o.priceDelta ?? 0, sortOrder: oi })) },
  }));
}
