/**
 * Time-zone helpers. Stored times are UTC; restaurant hours are local minutes (§1).
 * Uses Intl, so it works for any IANA zone (Vietnam has no DST, others might).
 */

const MINUTE = 60_000;
export const DAY_MS = 86_400_000;

const fmtCache = new Map<string, Intl.DateTimeFormat>();
function fmt(tz: string) {
  let f = fmtCache.get(tz);
  if (!f) {
    f = new Intl.DateTimeFormat('en-US', {
      timeZone: tz,
      hourCycle: 'h23',
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      weekday: 'short',
    });
    fmtCache.set(tz, f);
  }
  return f;
}

const WEEKDAYS: Record<string, number> = { Sun: 0, Mon: 1, Tue: 2, Wed: 3, Thu: 4, Fri: 5, Sat: 6 };

export interface ZonedParts {
  year: number;
  month: number;
  day: number;
  hour: number;
  minute: number;
  weekday: number; // 0 = Sunday
  minuteOfDay: number;
  date: string; // YYYY-MM-DD
}

export function zonedParts(d: Date, tz: string): ZonedParts {
  const p = Object.fromEntries(fmt(tz).formatToParts(d).map((x) => [x.type, x.value]));
  const year = Number(p.year);
  const month = Number(p.month);
  const day = Number(p.day);
  const hour = Number(p.hour);
  const minute = Number(p.minute);
  return {
    year,
    month,
    day,
    hour,
    minute,
    weekday: WEEKDAYS[p.weekday],
    minuteOfDay: hour * 60 + minute,
    date: `${p.year}-${p.month}-${p.day}`,
  };
}

/** Offset of `tz` from UTC at instant `d`, in minutes (Vietnam = +420). */
export function tzOffsetMinutes(d: Date, tz: string): number {
  const p = zonedParts(d, tz);
  const asUtc = Date.UTC(p.year, p.month - 1, p.day, p.hour, p.minute);
  return Math.round((asUtc - Math.floor(d.getTime() / MINUTE) * MINUTE) / MINUTE);
}

export function isValidDateString(s: string): boolean {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(s)) return false;
  const d = new Date(`${s}T00:00:00Z`);
  return !Number.isNaN(d.getTime()) && d.toISOString().slice(0, 10) === s;
}

/** UTC instant of local midnight for a YYYY-MM-DD in `tz`. */
export function zonedMidnight(date: string, tz: string): Date {
  const guess = Date.parse(`${date}T00:00:00Z`);
  let ts = guess - tzOffsetMinutes(new Date(guess), tz) * MINUTE;
  ts = guess - tzOffsetMinutes(new Date(ts), tz) * MINUTE; // second pass for DST edges
  return new Date(ts);
}

/** Local date + minutes-from-midnight (may be ≥ 1440 or negative) → UTC instant. */
export function zonedTime(date: string, minuteOfDay: number, tz: string): Date {
  return new Date(zonedMidnight(date, tz).getTime() + minuteOfDay * MINUTE);
}

export function weekdayOf(date: string): number {
  return new Date(`${date}T00:00:00Z`).getUTCDay();
}

export function addDays(date: string, n: number): string {
  return new Date(Date.parse(`${date}T00:00:00Z`) + n * DAY_MS).toISOString().slice(0, 10);
}

export const addMinutes = (d: Date, m: number) => new Date(d.getTime() + m * MINUTE);
