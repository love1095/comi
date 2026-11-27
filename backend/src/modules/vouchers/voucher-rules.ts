import { VoucherType } from '@prisma/client';

export interface VoucherTerms {
  restaurantId: string | null;
  type: VoucherType;
  value: number; // VND, or basis points for PERCENT
  maxDiscount: number | null;
  minOrder: number;
  startsAt: Date;
  endsAt: Date;
  totalLimit: number | null;
  perUserLimit: number;
  firstOrderOnly: boolean;
  usedCount: number;
  isActive: boolean;
}

export type VoucherProblem = 'INACTIVE' | 'NOT_STARTED' | 'EXPIRED' | 'WRONG_RESTAURANT' | 'MIN_ORDER' | 'SOLD_OUT' | 'ALREADY_USED' | 'FIRST_ORDER_ONLY';

/** §12 checks. `eligibleSubtotal` excludes alcohol (vouchers never discount alcohol). */
export function voucherProblem(
  v: VoucherTerms,
  c: { now: Date; restaurantId: string; eligibleSubtotal: number; userUses: number; userHasCompleted: boolean },
): VoucherProblem | null {
  if (!v.isActive) return 'INACTIVE';
  if (c.now < v.startsAt) return 'NOT_STARTED';
  if (c.now >= v.endsAt) return 'EXPIRED';
  if (v.restaurantId && v.restaurantId !== c.restaurantId) return 'WRONG_RESTAURANT';
  if (c.eligibleSubtotal < v.minOrder) return 'MIN_ORDER';
  if (v.totalLimit !== null && v.usedCount >= v.totalLimit) return 'SOLD_OUT';
  if (c.userUses >= v.perUserLimit) return 'ALREADY_USED';
  if (v.firstOrderOnly && c.userHasCompleted) return 'FIRST_ORDER_ONLY';
  return null;
}

export function voucherDiscount(v: Pick<VoucherTerms, 'type' | 'value' | 'maxDiscount'>, eligibleSubtotal: number): number {
  if (eligibleSubtotal <= 0) return 0;
  const raw = v.type === 'FIXED' ? v.value : Math.round((eligibleSubtotal * v.value) / 10_000);
  const capped = v.maxDiscount !== null && v.type === 'PERCENT' ? Math.min(raw, v.maxDiscount) : raw;
  return Math.max(0, Math.min(capped, eligibleSubtotal));
}

export const voucherProblemText: Record<VoucherProblem, string> = {
  INACTIVE: 'This voucher is no longer active',
  NOT_STARTED: 'This voucher has not started yet',
  EXPIRED: 'This voucher has expired',
  WRONG_RESTAURANT: 'This voucher is for another restaurant',
  MIN_ORDER: 'Order more to use this voucher',
  SOLD_OUT: 'This voucher has run out',
  ALREADY_USED: 'You already used this voucher',
  FIRST_ORDER_ONLY: 'This voucher is for your first visit only',
};
