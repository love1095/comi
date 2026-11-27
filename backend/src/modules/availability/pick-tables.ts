/**
 * Choosing tables for a party (§8.2 step 6, §8.4 large groups). Pure, shared by
 * availability (is there any fit?) and booking creation (which tables?).
 */

export interface FreeTable {
  id: string;
  code: string;
  areaId: string;
  minSeats: number;
  maxSeats: number;
  joinGroup: string | null;
}

export interface TablePick {
  tableIds: string[]; // first = main table, rest = extraTableIds
  seats: number;
}

/**
 * 1. A single table where minSeats ≤ party ≤ maxSeats — the smallest that fits.
 * 2. Otherwise join free tables that share a joinGroup (same area): fewest tables, then least spare seats.
 */
export function pickTables(free: FreeTable[], partySize: number, areaId?: string | null): TablePick | null {
  const pool = areaId ? free.filter((t) => t.areaId === areaId) : free;

  const singles = pool
    .filter((t) => t.minSeats <= partySize && partySize <= t.maxSeats)
    .sort((a, b) => a.maxSeats - b.maxSeats || a.code.localeCompare(b.code));
  if (singles.length) return { tableIds: [singles[0].id], seats: singles[0].maxSeats };

  const groups = new Map<string, FreeTable[]>();
  for (const t of pool) {
    if (!t.joinGroup) continue;
    const key = `${t.areaId}|${t.joinGroup}`;
    groups.set(key, [...(groups.get(key) ?? []), t]);
  }

  let best: TablePick | null = null;
  for (const tables of groups.values()) {
    const sorted = [...tables].sort((a, b) => b.maxSeats - a.maxSeats || a.code.localeCompare(b.code));
    const chosen: FreeTable[] = [];
    let seats = 0;
    for (const t of sorted) {
      if (seats >= partySize) break;
      chosen.push(t);
      seats += t.maxSeats;
    }
    if (seats < partySize || chosen.length < 2) continue;
    // Drop tables that are not needed (greedy may overshoot with a big last table).
    for (let i = chosen.length - 1; i >= 0; i--) {
      if (seats - chosen[i].maxSeats >= partySize) {
        seats -= chosen[i].maxSeats;
        chosen.splice(i, 1);
      }
    }
    const candidate = { tableIds: chosen.map((t) => t.id), seats };
    if (
      !best ||
      candidate.tableIds.length < best.tableIds.length ||
      (candidate.tableIds.length === best.tableIds.length && candidate.seats < best.seats)
    ) {
      best = candidate;
    }
  }
  return best;
}

/** Validate a customer's own choice from the table map (§8.6). */
export function choiceFits(tables: FreeTable[], partySize: number): boolean {
  if (tables.length === 0) return false;
  if (tables.length === 1) return tables[0].minSeats <= partySize && partySize <= tables[0].maxSeats;
  const group = tables[0].joinGroup;
  const area = tables[0].areaId;
  if (!group || tables.some((t) => t.joinGroup !== group || t.areaId !== area)) return false;
  return tables.reduce((s, t) => s + t.maxSeats, 0) >= partySize;
}
