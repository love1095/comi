import { addDays, addMinutes, weekdayOf, zonedTime, DAY_MS } from '../../common/utils/time';

/**
 * Booking time slots for one local date (§8.1 steps 1–2). Pure — table checks are done
 * by one SQL query afterwards.
 */

export interface HoursRow {
  weekday: number;
  openMinute: number;
  closeMinute: number; // may be > 1440 (after midnight)
  lastOrderMinute: number | null;
}

export interface DiningRuleRow {
  weekdays: number[];
  startMinute: number;
  endMinute: number;
  diningMinutes: number;
}

export interface SlotSettings {
  timezone: string;
  slotMinutes: number;
  diningMinutes: number;
  minLeadMinutes: number;
  maxDaysAhead: number;
}

export interface Slot {
  start: Date;
  end: Date;
  diningMinutes: number;
  localMinute: number; // minutes from local midnight of the requested date
}

/** Dining time per time window (lunch 45 / evening 120), falls back to the restaurant default. */
export function diningMinutesFor(rules: DiningRuleRow[], weekday: number, minute: number, fallback: number): number {
  const m = ((minute % 1440) + 1440) % 1440;
  const rule = rules.find((r) => r.weekdays.includes(weekday) && m >= r.startMinute && m < r.endMinute);
  return rule?.diningMinutes ?? fallback;
}

export function buildSlots(input: {
  date: string;
  now: Date;
  settings: SlotSettings;
  hours: HoursRow[];
  diningRules: DiningRuleRow[];
  closures: { startsAt: Date; endsAt: Date }[];
}): Slot[] {
  const { date, now, settings, hours, diningRules, closures } = input;
  const weekday = weekdayOf(date);
  const prevWeekday = (weekday + 6) % 7;
  const step = settings.slotMinutes;

  // Ranges for this date in local minutes: today's hours + yesterday's after-midnight tail.
  const ranges: { open: number; close: number; lastStart: number; ruleWeekday: number }[] = [];
  for (const h of hours) {
    if (h.weekday === weekday) {
      ranges.push({ open: h.openMinute, close: h.closeMinute, lastStart: h.lastOrderMinute ?? Infinity, ruleWeekday: weekday });
    }
    if (h.weekday === prevWeekday && h.closeMinute > 1440) {
      ranges.push({
        open: Math.max(0, h.openMinute - 1440),
        close: h.closeMinute - 1440,
        lastStart: h.lastOrderMinute === null ? Infinity : h.lastOrderMinute - 1440,
        ruleWeekday: prevWeekday,
      });
    }
  }

  const earliest = addMinutes(now, settings.minLeadMinutes).getTime();
  const latest = now.getTime() + settings.maxDaysAhead * DAY_MS;
  const seen = new Set<number>();
  const slots: Slot[] = [];

  for (const r of ranges) {
    // Align to the step from the opening time (10:00, 10:15, ...).
    for (let m = r.open; m < 1440 && m < r.close; m += step) {
      const ruleMinute = r.ruleWeekday === weekday ? m : m + 1440;
      const dining = diningMinutesFor(diningRules, r.ruleWeekday, ruleMinute, settings.diningMinutes);
      const lastStart = Math.min(r.lastStart, r.close - dining);
      if (m > lastStart) continue; // dining time can differ per window, so later slots may still fit
      const start = zonedTime(date, m, settings.timezone);
      const t = start.getTime();
      if (t < earliest || t > latest || seen.has(t)) continue;
      const end = addMinutes(start, dining);
      if (closures.some((c) => c.startsAt < end && c.endsAt > start)) continue;
      seen.add(t);
      slots.push({ start, end, diningMinutes: dining, localMinute: m });
    }
  }
  return slots.sort((a, b) => a.start.getTime() - b.start.getTime());
}

/** Is the restaurant open at instant `at`? Checks today's ranges and yesterday's after-midnight tail. */
export function isOpenAt(hours: HoursRow[], localWeekday: number, localMinute: number): boolean {
  const prev = (localWeekday + 6) % 7;
  return hours.some(
    (h) =>
      (h.weekday === localWeekday && localMinute >= h.openMinute && localMinute < h.closeMinute) ||
      (h.weekday === prev && h.closeMinute > 1440 && localMinute < h.closeMinute - 1440),
  );
}

export { addDays };
