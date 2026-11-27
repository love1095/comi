import { voucherDiscount, voucherProblem } from './voucher-rules';

const base = {
  restaurantId: null as string | null,
  type: 'FIXED' as const,
  value: 50_000,
  maxDiscount: null as number | null,
  minOrder: 100_000,
  startsAt: new Date('2026-12-01T00:00:00Z'),
  endsAt: new Date('2026-12-31T00:00:00Z'),
  totalLimit: 100 as number | null,
  perUserLimit: 1,
  firstOrderOnly: false,
  usedCount: 0,
  isActive: true,
};
const ctx = { now: new Date('2026-12-10T00:00:00Z'), restaurantId: 'r1', eligibleSubtotal: 150_000, userUses: 0, userHasCompleted: true };

describe('voucherProblem (§12)', () => {
  it('passes a valid voucher', () => expect(voucherProblem(base, ctx)).toBeNull());
  it('checks active, dates, scope, minimum, limits, first order', () => {
    expect(voucherProblem({ ...base, isActive: false }, ctx)).toBe('INACTIVE');
    expect(voucherProblem(base, { ...ctx, now: new Date('2027-01-01T00:00:00Z') })).toBe('EXPIRED');
    expect(voucherProblem(base, { ...ctx, now: new Date('2026-11-30T00:00:00Z') })).toBe('NOT_STARTED');
    expect(voucherProblem({ ...base, restaurantId: 'other' }, ctx)).toBe('WRONG_RESTAURANT');
    expect(voucherProblem(base, { ...ctx, eligibleSubtotal: 99_999 })).toBe('MIN_ORDER');
    expect(voucherProblem({ ...base, usedCount: 100 }, ctx)).toBe('SOLD_OUT');
    expect(voucherProblem(base, { ...ctx, userUses: 1 })).toBe('ALREADY_USED');
    expect(voucherProblem({ ...base, firstOrderOnly: true }, ctx)).toBe('FIRST_ORDER_ONLY');
    expect(voucherProblem({ ...base, firstOrderOnly: true }, { ...ctx, userHasCompleted: false })).toBeNull();
  });
});

describe('voucherDiscount', () => {
  it('fixed amount never exceeds the eligible (non-alcohol) subtotal', () => {
    expect(voucherDiscount(base, 150_000)).toBe(50_000);
    expect(voucherDiscount(base, 30_000)).toBe(30_000);
  });
  it('percent in basis points, capped', () => {
    expect(voucherDiscount({ ...base, type: 'PERCENT', value: 2000, maxDiscount: null }, 155_555)).toBe(31_111);
    expect(voucherDiscount({ ...base, type: 'PERCENT', value: 2000, maxDiscount: 25_000 }, 155_555)).toBe(25_000);
  });
});
