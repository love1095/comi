import { SplitMode } from '@prisma/client';
import { AppError } from '../../common/errors/app-error';

export interface SplitGuest {
  id: string;
  isHost: boolean;
}

export interface SplitItem {
  /** unitPrice × quantity, VND */
  amount: number;
  /** who ordered it; null = shared */
  guestId: string | null;
}

/** `amount` split as evenly as integer VND allows; the leftover đồng go to the host (first guest if none). */
function evenly(amount: number, guests: SplitGuest[]): Record<string, number> {
  const base = Math.floor(amount / guests.length);
  let rest = amount - base * guests.length;
  const order = [...guests].sort((a, b) => Number(b.isHost) - Number(a.isHost));
  const out: Record<string, number> = {};
  for (const g of order) {
    out[g.id] = base + (rest > 0 ? 1 : 0);
    if (rest > 0) rest--;
  }
  return out;
}

/**
 * Who pays what (§8.5). EQUAL by head; BY_ITEMS = own dishes + equal share of
 * shared/untagged dishes and of anything added outside the app; CUSTOM = given amounts.
 * Every result sums exactly to `total`.
 */
export function splitBill(p: {
  total: number;
  guests: SplitGuest[];
  items: SplitItem[];
  mode: SplitMode;
  custom?: Record<string, number>;
}): Record<string, number> {
  const { total, guests } = p;
  if (!guests.length) throw new AppError('SPLIT_MISMATCH', 'Nobody to split with');
  if (!Number.isInteger(total) || total < 0) throw new AppError('SPLIT_MISMATCH', 'Invalid total');

  if (p.mode === 'EQUAL') return evenly(total, guests);

  if (p.mode === 'BY_ITEMS') {
    const ids = new Set(guests.map((g) => g.id));
    const own: Record<string, number> = Object.fromEntries(guests.map((g) => [g.id, 0]));
    for (const i of p.items) if (i.guestId && ids.has(i.guestId)) own[i.guestId] += i.amount;
    const tagged = Object.values(own).reduce((s, v) => s + v, 0);
    if (tagged > total) throw new AppError('SPLIT_MISMATCH', 'Total is less than the dishes ordered', { total, tagged });
    const shared = evenly(total - tagged, guests);
    return Object.fromEntries(guests.map((g) => [g.id, own[g.id] + shared[g.id]]));
  }

  const custom = p.custom ?? {};
  const missing = guests.filter((g) => !Number.isInteger(custom[g.id]) || custom[g.id] < 0);
  const sum = guests.reduce((s, g) => s + (custom[g.id] ?? 0), 0);
  if (missing.length || sum !== total) {
    throw new AppError('SPLIT_MISMATCH', 'Amounts must be given for everyone and add up to the total', {
      total,
      sum,
      missing: missing.map((g) => g.id),
    });
  }
  return Object.fromEntries(guests.map((g) => [g.id, custom[g.id]]));
}
