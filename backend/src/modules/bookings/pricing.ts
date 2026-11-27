import { Course } from '@prisma/client';
import { AppError } from '../../common/errors/app-error';
import { assertVnd } from '../../common/utils/money';

/**
 * Pre-order pricing (§8.2 step 4). The server recalculates every price; prices sent by
 * the app are ignored. Order items copy name and price (snapshot, §5.1).
 */

export interface MenuItemForPricing {
  id: string;
  name: string;
  price: number;
  course: Course;
  prepMinutes: number;
  isAvailable: boolean;
  isPreorderable: boolean;
  isAlcohol: boolean;
  leadHours: number;
  deletedAt: Date | null;
  optionGroups: {
    id: string;
    name: string;
    minSelect: number;
    maxSelect: number;
    options: { id: string; name: string; priceDelta: number }[];
  }[];
}

export interface CartLine {
  menuItemId: string;
  quantity: number;
  optionIds?: string[];
  note?: string;
}

export interface PricedLine {
  menuItemId: string;
  nameSnapshot: string;
  unitPrice: number;
  quantity: number;
  optionsSnapshot: { group: string; option: string; priceDelta: number }[];
  note?: string;
  course: Course;
  prepMinutes: number;
  isAlcohol: boolean;
}

export const MAX_QTY_PER_LINE = 99;

export function priceCart(
  lines: CartLine[],
  menu: Map<string, MenuItemForPricing>,
  ctx: { hoursUntilArrival: number },
): { lines: PricedLine[]; subtotal: number; hasAlcohol: boolean } {
  const priced: PricedLine[] = [];
  for (const line of lines) {
    const item = menu.get(line.menuItemId);
    if (!item || item.deletedAt) throw new AppError('ITEM_UNAVAILABLE', 'Dish not found', { menuItemId: line.menuItemId });
    if (!item.isAvailable) throw new AppError('ITEM_UNAVAILABLE', `${item.name} is sold out`, { menuItemId: item.id });
    if (!item.isPreorderable) throw new AppError('ITEM_UNAVAILABLE', `${item.name} can only be ordered at the table`, { menuItemId: item.id });
    if (item.leadHours > 0 && ctx.hoursUntilArrival < item.leadHours) {
      throw new AppError('ITEM_UNAVAILABLE', `${item.name} must be ordered ${item.leadHours} h ahead`, { menuItemId: item.id, leadHours: item.leadHours });
    }
    if (!Number.isInteger(line.quantity) || line.quantity < 1 || line.quantity > MAX_QTY_PER_LINE) {
      throw new AppError('VALIDATION_FAILED', 'Invalid quantity', { menuItemId: item.id });
    }

    const chosen = new Set(line.optionIds ?? []);
    if (chosen.size !== (line.optionIds ?? []).length) throw new AppError('OPTIONS_INVALID', 'Duplicate option', { menuItemId: item.id });
    const snapshot: PricedLine['optionsSnapshot'] = [];
    let delta = 0;
    let matched = 0;
    for (const g of item.optionGroups) {
      const picked = g.options.filter((o) => chosen.has(o.id));
      if (picked.length < g.minSelect || picked.length > g.maxSelect) {
        throw new AppError('OPTIONS_INVALID', `Choose ${g.minSelect}–${g.maxSelect} for "${g.name}"`, { menuItemId: item.id, group: g.name });
      }
      for (const o of picked) {
        snapshot.push({ group: g.name, option: o.name, priceDelta: o.priceDelta });
        delta += o.priceDelta;
        matched++;
      }
    }
    if (matched !== chosen.size) throw new AppError('OPTIONS_INVALID', 'Option does not belong to this dish', { menuItemId: item.id });

    const unitPrice = assertVnd(Math.max(0, item.price + delta));
    priced.push({
      menuItemId: item.id,
      nameSnapshot: item.name,
      unitPrice,
      quantity: line.quantity,
      optionsSnapshot: snapshot,
      note: line.note,
      course: item.course,
      prepMinutes: item.prepMinutes,
      isAlcohol: item.isAlcohol,
    });
  }
  const subtotal = priced.reduce((s, l) => s + l.unitPrice * l.quantity, 0);
  return { lines: priced, subtotal: assertVnd(subtotal), hasAlcohol: priced.some((l) => l.isAlcohol) };
}
