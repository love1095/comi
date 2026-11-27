import { zonedMidnight, zonedParts } from '../../common/utils/time';
import { Env } from '../../config/env';

const TZ = 'Asia/Ho_Chi_Minh';

/** `2026-12` → [start, end) instants of that month in Vietnam time. */
export function monthRange(periodMonth: string): { from: Date; to: Date } {
  const [y, m] = periodMonth.split('-').map(Number);
  const next = m === 12 ? `${y + 1}-01` : `${y}-${String(m + 1).padStart(2, '0')}`;
  return { from: zonedMidnight(`${periodMonth}-01`, TZ), to: zonedMidnight(`${next}-01`, TZ) };
}

/** The month before `now` in Vietnam time (`2027-01-01 02:00` → `2026-12`). */
export function previousMonth(now: Date): string {
  const p = zonedParts(now, TZ);
  return p.month === 1 ? `${p.year - 1}-12` : `${p.year}-${String(p.month - 1).padStart(2, '0')}`;
}

/** VietQR image for paying a statement (img.vietqr.io quick link), or null when the bank account is not configured. */
export function vietQrUrl(env: Pick<Env, 'PLATFORM_BANK_BIN' | 'PLATFORM_BANK_ACCOUNT' | 'PLATFORM_BANK_ACCOUNT_NAME'>, amount: number, memo: string) {
  if (!env.PLATFORM_BANK_BIN || !env.PLATFORM_BANK_ACCOUNT || amount <= 0) return null;
  const q = new URLSearchParams({ amount: String(amount), addInfo: memo });
  if (env.PLATFORM_BANK_ACCOUNT_NAME) q.set('accountName', env.PLATFORM_BANK_ACCOUNT_NAME);
  return `https://img.vietqr.io/image/${env.PLATFORM_BANK_BIN}-${env.PLATFORM_BANK_ACCOUNT}-compact2.png?${q}`;
}

/** Memo the restaurant writes on the transfer (§11.3: "TS {statementId}"). Short for bank apps. */
export const statementMemo = (id: string) => `TS ${id.replace(/-/g, '').slice(0, 10).toUpperCase()}`;
