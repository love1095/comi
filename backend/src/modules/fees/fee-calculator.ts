import { BookingStatus, PaymentMode } from '@prisma/client';

/** Pure fee maths (§11). 100 % unit-tested; services only load data and save results. */

export interface PlanTerms {
  rateBps: number;
  minFee: number;
  fixedFee: number;
}

export function calculateFee(base: number, plan: PlanTerms): number {
  if (base <= 0) return 0;
  const pct = Math.round((base * plan.rateBps) / 10_000);
  return Math.max(plan.minFee, pct + plan.fixedFee);
}

/** The amount the fee is charged on (§11.1 table). */
export function feeBase(b: {
  status: BookingStatus;
  paymentMode: PaymentMode;
  preOrderValue: number;
  restaurantDiscount: number;
  finalBillAmount: number | null;
  keptAmount?: number; // prepaid no-show: money the restaurant kept
  refunded?: number;
}): number {
  let base = 0;
  if (b.status === 'COMPLETED') {
    base =
      b.paymentMode === 'PREPAID'
        ? b.preOrderValue - b.restaurantDiscount
        : Math.max(b.preOrderValue - b.restaurantDiscount, b.finalBillAmount ?? 0);
  } else if (b.status === 'NO_SHOW' && b.paymentMode === 'PREPAID') {
    base = b.keptAmount ?? 0;
  }
  return Math.max(0, base - (b.refunded ?? 0));
}

const addMonths = (d: Date, n: number) => {
  const x = new Date(d);
  x.setUTCMonth(x.getUTCMonth() + n);
  return x;
};

/** §11.2: 1 % for the first 3 months after the first order, then 2 %; min 2 000 đ. */
export function launchPlans(firstOrderAt: Date) {
  const switchAt = addMonths(firstOrderAt, 3);
  return [
    { rateBps: 100, minFee: 2000, fixedFee: 0, effectiveFrom: firstOrderAt, effectiveTo: switchAt as Date | null, note: 'Launch: 1% for 3 months' },
    { rateBps: 200, minFee: 2000, fixedFee: 0, effectiveFrom: switchAt, effectiveTo: null as Date | null, note: 'Standard 2%' },
  ];
}

/** The plan in force at `at`. Overlaps (special partner plans) → the most recently started wins. */
export function planAt<T extends { effectiveFrom: Date; effectiveTo: Date | null }>(plans: T[], at: Date): T | null {
  const active = plans.filter((p) => p.effectiveFrom <= at && (!p.effectiveTo || at < p.effectiveTo));
  return active.sort((a, b) => b.effectiveFrom.getTime() - a.effectiveFrom.getTime())[0] ?? null;
}

/** Monthly statement sums (§11.3). Negative amountDue = the platform owes the restaurant. */
export function statementTotals(lines: { baseAmount: number; feeAmount: number; platformDiscount: number }[]) {
  const totalBase = lines.reduce((s, l) => s + l.baseAmount, 0);
  const totalFee = lines.reduce((s, l) => s + l.feeAmount, 0);
  const platformVoucherCredit = lines.reduce((s, l) => s + l.platformDiscount, 0);
  return { bookingCount: lines.length, totalBase, totalFee, platformVoucherCredit, amountDue: totalFee - platformVoucherCredit };
}
