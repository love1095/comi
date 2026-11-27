import { assertKitchenTransition, canKitchenTransition, fireTimes, kitchenCapacityProblem, travelMinutes } from './kitchen.state';

const at = (hhmm: string) => new Date(`2026-12-02T${hhmm}:00.000Z`);
const item = (id: string, course: 'DRINK' | 'STARTER' | 'MAIN' | 'DESSERT', prepMinutes: number) => ({ id, course, prepMinutes });

describe('kitchen state machine (§6.2)', () => {
  it('follows HOLD → SCHEDULED → QUEUED → COOKING → READY → SERVED', () => {
    expect(canKitchenTransition('HOLD', 'SCHEDULED')).toBe(true);
    expect(canKitchenTransition('HOLD', 'QUEUED')).toBe(true); // COD at check-in
    expect(canKitchenTransition('SCHEDULED', 'QUEUED')).toBe(true);
    expect(canKitchenTransition('QUEUED', 'COOKING')).toBe(true);
    expect(canKitchenTransition('COOKING', 'READY')).toBe(true);
    expect(canKitchenTransition('READY', 'SERVED')).toBe(true);
  });

  it('cancels only before cooking; no going back', () => {
    for (const s of ['HOLD', 'SCHEDULED', 'QUEUED'] as const) expect(canKitchenTransition(s, 'CANCELLED')).toBe(true);
    expect(canKitchenTransition('COOKING', 'CANCELLED')).toBe(false);
    expect(canKitchenTransition('READY', 'COOKING')).toBe(false);
    expect(canKitchenTransition('SERVED', 'READY')).toBe(false);
    expect(() => assertKitchenTransition('SERVED', 'COOKING')).toThrow(expect.objectContaining({ code: 'INVALID_STATUS' }));
  });

  it('lets the cook undo "start" (COOKING → QUEUED) for a mis-tap', () => {
    expect(canKitchenTransition('COOKING', 'QUEUED')).toBe(true);
  });
});

describe('fire times (§7.1)', () => {
  const arrival = at('12:00');

  it('BY_COURSE: drinks at arrival, starters +5, mains +20, desserts +45, minus prep', () => {
    const t = fireTimes([item('d', 'DRINK', 2), item('s', 'STARTER', 10), item('m', 'MAIN', 15), item('x', 'DESSERT', 5)], {
      arrival,
      serveStyle: 'BY_COURSE',
      now: at('09:00'),
    });
    expect(t.get('d')).toEqual(at('11:58'));
    expect(t.get('s')).toEqual(at('11:55'));
    expect(t.get('m')).toEqual(at('12:05'));
    expect(t.get('x')).toEqual(at('12:40'));
  });

  it('ALL_TOGETHER: everything served at +10, longest dish starts first', () => {
    const t = fireTimes([item('s', 'STARTER', 5), item('m', 'MAIN', 25), item('x', 'DESSERT', 3)], {
      arrival,
      serveStyle: 'ALL_TOGETHER',
      now: at('09:00'),
    });
    expect(t.get('m')).toEqual(at('11:45'));
    expect(t.get('s')).toEqual(at('12:05'));
    expect(t.get('x')).toEqual(at('12:07'));
  });

  it('never schedules in the past', () => {
    const now = at('12:10');
    const t = fireTimes([item('m', 'MAIN', 30), item('d', 'DRINK', 1)], { arrival, serveStyle: 'BY_COURSE', now });
    expect(t.get('m')).toEqual(now);
    expect(t.get('d')).toEqual(now);
  });
});

describe('kitchen capacity (§7.6)', () => {
  const rule = { weekdays: [3], startMinute: 0, endMinute: 1440, windowMinutes: 15, maxItems: 20 };

  it('blocks a pre-order that would overflow a 15-minute window', () => {
    // 2026-12-02 is a Wednesday (weekday 3); times are restaurant-local here.
    const fire = [{ at: at('11:50'), quantity: 6 }];
    expect(kitchenCapacityProblem(fire, [rule], () => 14, (d) => ({ weekday: 3, minuteOfDay: d.getUTCHours() * 60 + d.getUTCMinutes() }))).toBeNull();
    const busy = kitchenCapacityProblem(fire, [rule], () => 15, (d) => ({ weekday: 3, minuteOfDay: d.getUTCHours() * 60 + d.getUTCMinutes() }));
    expect(busy).toEqual({ windowStart: at('11:45'), used: 15, adding: 6, max: 20 });
  });

  it('ignores rules for other weekdays or hours', () => {
    const fire = [{ at: at('11:50'), quantity: 50 }];
    const parts = () => ({ weekday: 4, minuteOfDay: 710 });
    expect(kitchenCapacityProblem(fire, [rule], () => 0, parts)).toBeNull();
  });
});

describe('"I\'m leaving now" travel time (§7.5)', () => {
  it('walks under 1.5 km (4 km/h), rides a motorbike beyond (20 km/h), at least 1 min', () => {
    expect(travelMinutes(400)).toBe(6);
    expect(travelMinutes(3000)).toBe(9);
    expect(travelMinutes(10)).toBe(1);
  });
});
