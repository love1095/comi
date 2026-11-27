import { Course, KitchenStatus, ServeStyle } from '@prisma/client';
import { AppError } from '../../common/errors/app-error';

/** Kitchen status of one order item (§6.2). Every change goes through `assertKitchenTransition`. */
export const kitchenTransitions: Record<KitchenStatus, readonly KitchenStatus[]> = {
  HOLD: ['SCHEDULED', 'QUEUED', 'CANCELLED'], // COD waits here until check-in
  SCHEDULED: ['QUEUED', 'CANCELLED'],
  QUEUED: ['COOKING', 'CANCELLED'],
  COOKING: ['READY', 'QUEUED'], // QUEUED = cook undoes a mis-tapped "Start"
  READY: ['SERVED'],
  SERVED: [],
  CANCELLED: [],
};

/** Statuses the kitchen still has to deal with. */
export const OPEN_KITCHEN_STATUSES: KitchenStatus[] = ['HOLD', 'SCHEDULED', 'QUEUED', 'COOKING', 'READY'];

export function canKitchenTransition(from: KitchenStatus, to: KitchenStatus): boolean {
  return kitchenTransitions[from].includes(to);
}

export function assertKitchenTransition(from: KitchenStatus, to: KitchenStatus): void {
  if (!canKitchenTransition(from, to)) {
    throw new AppError('INVALID_STATUS', `Dish cannot go from ${from} to ${to}`, { from, to });
  }
}

/** Target serve time after arrival, in minutes (§7.1 defaults). */
export const COURSE_TARGETS: Record<ServeStyle, Record<Course, number>> = {
  BY_COURSE: { DRINK: 0, STARTER: 5, MAIN: 20, DESSERT: 45 },
  ALL_TOGETHER: { DRINK: 0, STARTER: 10, MAIN: 10, DESSERT: 10 },
};

/**
 * scheduledStartAt = arrival + target(course) − prepMinutes, never before now.
 * ALL_TOGETHER shares one target, so the longest dish naturally starts first.
 */
export function fireTimes(
  items: { id: string; course: Course; prepMinutes: number }[],
  p: { arrival: Date; serveStyle: ServeStyle; now: Date },
): Map<string, Date> {
  const out = new Map<string, Date>();
  for (const i of items) {
    const ms = p.arrival.getTime() + (COURSE_TARGETS[p.serveStyle][i.course] - i.prepMinutes) * 60_000;
    out.set(i.id, new Date(Math.max(ms, p.now.getTime())));
  }
  return out;
}

export interface CapacityRule {
  weekdays: number[];
  startMinute: number;
  endMinute: number;
  windowMinutes: number;
  maxItems: number;
}

/**
 * §7.6: dishes starting in the same window must not exceed the rule's maxItems.
 * `used(windowStart, windowMinutes)` returns dishes already planned in that window;
 * `parts` turns an instant into restaurant-local weekday + minute of day.
 * Returns the first overflow, or null when the pre-order fits.
 */
export function kitchenCapacityProblem(
  fire: { at: Date; quantity: number }[],
  rules: CapacityRule[],
  used: (windowStart: Date, windowMinutes: number) => number,
  parts: (d: Date) => { weekday: number; minuteOfDay: number },
): { windowStart: Date; used: number; adding: number; max: number } | null {
  const windows = new Map<string, { start: Date; rule: CapacityRule; adding: number }>();
  for (const f of fire) {
    const { weekday, minuteOfDay } = parts(f.at);
    const rule = rules.find((r) => r.weekdays.includes(weekday) && minuteOfDay >= r.startMinute && minuteOfDay < r.endMinute);
    if (!rule) continue;
    const size = rule.windowMinutes * 60_000;
    const start = new Date(Math.floor(f.at.getTime() / size) * size);
    const key = `${start.toISOString()}|${rule.windowMinutes}|${rule.maxItems}`;
    const w = windows.get(key) ?? { start, rule, adding: 0 };
    w.adding += f.quantity;
    windows.set(key, w);
  }
  for (const w of windows.values()) {
    const u = used(w.start, w.rule.windowMinutes);
    if (u + w.adding > w.rule.maxItems) return { windowStart: w.start, used: u, adding: w.adding, max: w.rule.maxItems };
  }
  return null;
}

/** §7.5 fallback without a distance API: walk (4 km/h) under 1.5 km, else motorbike (~20 km/h in town). */
export function travelMinutes(distanceM: number): number {
  const kmh = distanceM < 1500 ? 4 : 20;
  return Math.max(1, Math.round(distanceM / 1000 / kmh * 60));
}
