import { calculateFee, feeBase, launchPlans, planAt, statementTotals } from './fee-calculator';

describe('calculateFee (§11.1)', () => {
  const plan = { rateBps: 200, minFee: 2000, fixedFee: 0 };
  it('percentage, rounded to the đồng, with a minimum', () => {
    expect(calculateFee(500_000, plan)).toBe(10_000);
    expect(calculateFee(55_555, plan)).toBe(2_000); // 1 111 → min 2 000
    expect(calculateFee(123_456, { rateBps: 100, minFee: 0, fixedFee: 0 })).toBe(1_235);
    expect(calculateFee(100_000, { rateBps: 100, minFee: 0, fixedFee: 500 })).toBe(1_500);
  });
  it('nothing on zero or negative base', () => {
    expect(calculateFee(0, plan)).toBe(0);
    expect(calculateFee(-5, plan)).toBe(0);
  });
});

describe('feeBase (§11.1 table)', () => {
  it('COD completed: the larger of pre-order (minus restaurant voucher) and the final bill', () => {
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'COD', preOrderValue: 200_000, restaurantDiscount: 20_000, finalBillAmount: 350_000 })).toBe(350_000);
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'COD', preOrderValue: 200_000, restaurantDiscount: 20_000, finalBillAmount: 100_000 })).toBe(180_000);
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'COD', preOrderValue: 0, restaurantDiscount: 0, finalBillAmount: null })).toBe(0);
  });
  it('prepaid completed: subtotal minus restaurant voucher; platform voucher does not lower it', () => {
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'PREPAID', preOrderValue: 300_000, restaurantDiscount: 30_000, finalBillAmount: 999 })).toBe(270_000);
  });
  it('prepaid no-show: what the restaurant kept; COD no-show and cancellations: nothing', () => {
    expect(feeBase({ status: 'NO_SHOW', paymentMode: 'PREPAID', preOrderValue: 300_000, restaurantDiscount: 0, finalBillAmount: null, keptAmount: 120_000 })).toBe(120_000);
    expect(feeBase({ status: 'NO_SHOW', paymentMode: 'COD', preOrderValue: 300_000, restaurantDiscount: 0, finalBillAmount: null })).toBe(0);
    expect(feeBase({ status: 'CANCELLED', paymentMode: 'COD', preOrderValue: 300_000, restaurantDiscount: 0, finalBillAmount: null })).toBe(0);
  });
  it('partial refunds lower the base, never below zero', () => {
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'PREPAID', preOrderValue: 300_000, restaurantDiscount: 0, finalBillAmount: null, refunded: 50_000 })).toBe(250_000);
    expect(feeBase({ status: 'COMPLETED', paymentMode: 'PREPAID', preOrderValue: 30_000, restaurantDiscount: 0, finalBillAmount: null, refunded: 50_000 })).toBe(0);
  });
});

describe('fee plans (§11.2)', () => {
  const first = new Date('2026-12-02T05:00:00Z');
  it('launch: 1% for 3 months from the first order, then 2%, min 2 000 đ', () => {
    const [intro, normal] = launchPlans(first);
    expect(intro).toMatchObject({ rateBps: 100, minFee: 2000, effectiveFrom: first, effectiveTo: new Date('2027-03-02T05:00:00Z') });
    expect(normal).toMatchObject({ rateBps: 200, minFee: 2000, effectiveFrom: new Date('2027-03-02T05:00:00Z'), effectiveTo: null });
  });
  it('picks the plan active at the booking time; the newest special plan wins', () => {
    const plans = [
      ...launchPlans(first).map((p, i) => ({ ...p, id: `p${i}` })),
      { id: 'vip', rateBps: 50, minFee: 0, fixedFee: 0, effectiveFrom: new Date('2027-01-01T00:00:00Z'), effectiveTo: new Date('2027-02-01T00:00:00Z') },
    ];
    expect(planAt(plans, new Date('2026-12-20T00:00:00Z'))?.id).toBe('p0');
    expect(planAt(plans, new Date('2027-01-15T00:00:00Z'))?.id).toBe('vip');
    expect(planAt(plans, new Date('2027-06-01T00:00:00Z'))?.id).toBe('p1');
    expect(planAt(plans, new Date('2026-01-01T00:00:00Z'))).toBeNull();
  });
});

describe('statementTotals (§11.3)', () => {
  it('fees minus platform voucher credit; can go negative (platform pays the restaurant)', () => {
    expect(statementTotals([{ baseAmount: 500_000, feeAmount: 10_000, platformDiscount: 0 }, { baseAmount: 100_000, feeAmount: 2_000, platformDiscount: 5_000 }])).toEqual({
      bookingCount: 2,
      totalBase: 600_000,
      totalFee: 12_000,
      platformVoucherCredit: 5_000,
      amountDue: 7_000,
    });
    expect(statementTotals([{ baseAmount: 100_000, feeAmount: 2_000, platformDiscount: 30_000 }]).amountDue).toBe(-28_000);
  });
});

describe('statement helpers', () => {
  // Imported here to keep the calculator spec the single place for fee maths tests.
  const { monthRange, previousMonth, statementMemo, vietQrUrl } = jest.requireActual('./statement-helpers') as typeof import('./statement-helpers');

  it('month range is Vietnam time (UTC+7)', () => {
    expect(monthRange('2026-12')).toEqual({ from: new Date('2026-11-30T17:00:00Z'), to: new Date('2026-12-31T17:00:00Z') });
    expect(previousMonth(new Date('2026-12-31T19:00:00Z'))).toBe('2026-12'); // already Jan 1st 02:00 in Vietnam
    expect(previousMonth(new Date('2027-03-10T00:00:00Z'))).toBe('2027-02');
  });

  it('VietQR link only when the bank account is set and something is due', () => {
    const env = { PLATFORM_BANK_BIN: '970436', PLATFORM_BANK_ACCOUNT: '0123456789', PLATFORM_BANK_ACCOUNT_NAME: 'CONG TY COMI' };
    const url = vietQrUrl(env, 125000, 'TS ABC');
    expect(url).toBe('https://img.vietqr.io/image/970436-0123456789-compact2.png?amount=125000&addInfo=TS+ABC&accountName=CONG+TY+COMI');
    expect(vietQrUrl(env, 0, 'x')).toBeNull();
    expect(vietQrUrl({ ...env, PLATFORM_BANK_ACCOUNT: undefined }, 1000, 'x')).toBeNull();
    expect(statementMemo('0d4c7a52-7a3c-4b6e-9f0e-111111111111')).toBe('TS 0D4C7A527A');
  });
});
