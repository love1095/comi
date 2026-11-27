/** All money is integer VND (§1). Rates are basis points (100 = 1%). */

export function assertVnd(amount: number): number {
  if (!Number.isSafeInteger(amount)) throw new Error(`Money must be an integer VND, got ${amount}`);
  return amount;
}

/** round(base × bps / 10000), half away from zero, integer math only. */
export function applyBps(base: number, bps: number): number {
  assertVnd(base);
  if (!Number.isInteger(bps)) throw new Error('bps must be an integer');
  const product = base * bps;
  const sign = product < 0 ? -1 : 1;
  return sign * Math.floor((Math.abs(product) + 5000) / 10000);
}
