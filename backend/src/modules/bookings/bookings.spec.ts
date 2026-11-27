import { allowedTransitions, assertTransition, canTransition } from './booking.state';
import { MenuItemForPricing, priceCart } from './pricing';

const item = (over: Partial<MenuItemForPricing> = {}): MenuItemForPricing => ({
  id: 'bo',
  name: 'Bò lúc lắc',
  price: 120_000,
  course: 'MAIN',
  prepMinutes: 15,
  isAvailable: true,
  isPreorderable: true,
  isAlcohol: false,
  leadHours: 0,
  deletedAt: null,
  optionGroups: [
    {
      id: 'size',
      name: 'Size',
      minSelect: 1,
      maxSelect: 1,
      options: [
        { id: 'vua', name: 'Vừa', priceDelta: 0 },
        { id: 'lon', name: 'Lớn', priceDelta: 30_000 },
      ],
    },
    { id: 'add', name: 'Thêm', minSelect: 0, maxSelect: 2, options: [{ id: 'trung', name: 'Trứng', priceDelta: 5_000 }, { id: 'com', name: 'Cơm', priceDelta: 10_000 }] },
  ],
  ...over,
});
const menu = (...items: MenuItemForPricing[]) => new Map(items.map((i) => [i.id, i]));
const ctx = { hoursUntilArrival: 2 };

describe('priceCart (§8.2 step 4)', () => {
  it('recomputes unit price from options and snapshots names', () => {
    const r = priceCart([{ menuItemId: 'bo', quantity: 2, optionIds: ['lon', 'trung'] }], menu(item()), ctx);
    expect(r.lines[0]).toMatchObject({
      nameSnapshot: 'Bò lúc lắc',
      unitPrice: 155_000,
      quantity: 2,
      optionsSnapshot: [
        { group: 'Size', option: 'Lớn', priceDelta: 30_000 },
        { group: 'Thêm', option: 'Trứng', priceDelta: 5_000 },
      ],
    });
    expect(r.subtotal).toBe(310_000);
    expect(r.hasAlcohol).toBe(false);
  });

  it('enforces required / max options and foreign options', () => {
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1 }], menu(item()), ctx)).toThrow('Choose 1–1 for "Size"');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1, optionIds: ['vua', 'lon'] }], menu(item()), ctx)).toThrow('Size');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1, optionIds: ['vua', 'other'] }], menu(item()), ctx)).toThrow('does not belong');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1, optionIds: ['vua', 'vua'] }], menu(item()), ctx)).toThrow('Duplicate');
  });

  it('rejects sold-out, table-only, deleted, lead-time and bad quantities', () => {
    const plain = { optionGroups: [] };
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1 }], menu(item({ ...plain, isAvailable: false })), ctx)).toThrow('sold out');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1 }], menu(item({ ...plain, isPreorderable: false })), ctx)).toThrow('at the table');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1 }], menu(item({ ...plain, deletedAt: new Date() })), ctx)).toThrow('not found');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 1 }], menu(item({ ...plain, leadHours: 24 })), ctx)).toThrow('24 h ahead');
    expect(() => priceCart([{ menuItemId: 'bo', quantity: 0 }], menu(item(plain)), ctx)).toThrow('quantity');
    expect(() => priceCart([{ menuItemId: 'nope', quantity: 1 }], menu(item(plain)), ctx)).toThrow('not found');
  });

  it('flags alcohol for age confirmation', () => {
    const beer = item({ id: 'bia', name: 'Bia Tiger', price: 22_000, course: 'DRINK', isAlcohol: true, optionGroups: [] });
    expect(priceCart([{ menuItemId: 'bia', quantity: 24 }], menu(beer), ctx)).toMatchObject({ subtotal: 528_000, hasAlcohol: true });
  });
});

describe('booking state machine (§6.1)', () => {
  it('allows only the documented transitions', () => {
    expect(canTransition('PENDING', 'CONFIRMED')).toBe(true);
    expect(canTransition('CONFIRMED', 'NO_SHOW')).toBe(true);
    expect(canTransition('CHECKED_IN', 'CANCELLED')).toBe(false);
    expect(canTransition('COMPLETED', 'CANCELLED')).toBe(false);
    expect(() => assertTransition('CANCELLED', 'CONFIRMED')).toThrow('cannot go from CANCELLED');
  });

  it('terminal states have no exits', () => {
    for (const s of ['COMPLETED', 'CANCELLED', 'NO_SHOW', 'EXPIRED'] as const) expect(allowedTransitions[s]).toEqual([]);
  });
});
