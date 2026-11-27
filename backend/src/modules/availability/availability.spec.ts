import { tzOffsetMinutes, zonedMidnight, zonedParts, zonedTime, isValidDateString } from '../../common/utils/time';
import { choiceFits, FreeTable, pickTables } from './pick-tables';
import { buildSlots, diningMinutesFor, isOpenAt } from './slots';

const TZ = 'Asia/Ho_Chi_Minh';
const settings = { timezone: TZ, slotMinutes: 15, diningMinutes: 90, minLeadMinutes: 60, maxDaysAhead: 30 };
const hhmm = (d: Date) => zonedParts(d, TZ).date + ' ' + String(zonedParts(d, TZ).hour).padStart(2, '0') + ':' + String(zonedParts(d, TZ).minute).padStart(2, '0');

describe('time zone helpers', () => {
  it('Vietnam is UTC+7 and local midnight is 17:00Z the day before', () => {
    expect(tzOffsetMinutes(new Date('2026-12-01T00:00:00Z'), TZ)).toBe(420);
    expect(zonedMidnight('2026-12-02', TZ).toISOString()).toBe('2026-12-01T17:00:00.000Z');
    expect(zonedTime('2026-12-02', 12 * 60, TZ).toISOString()).toBe('2026-12-02T05:00:00.000Z');
    expect(zonedParts(new Date('2026-12-01T18:30:00Z'), TZ)).toMatchObject({ date: '2026-12-02', weekday: 3, minuteOfDay: 90 });
  });

  it('validates dates', () => {
    expect(isValidDateString('2026-12-31')).toBe(true);
    expect(isValidDateString('2026-02-30')).toBe(false);
    expect(isValidDateString('31/12/2026')).toBe(false);
  });
});

describe('buildSlots (§8.1)', () => {
  // 2026-12-02 is a Wednesday (weekday 3). "now" = Tue 01/12 10:00 local.
  const now = new Date('2026-12-01T03:00:00Z');

  it('lunch with 45-minute dining rule: 10:00 … 13:15 every 15 min', () => {
    const slots = buildSlots({
      date: '2026-12-02',
      now,
      settings,
      hours: [{ weekday: 3, openMinute: 600, closeMinute: 840, lastOrderMinute: null }],
      diningRules: [{ weekdays: [1, 2, 3, 4, 5], startMinute: 600, endMinute: 840, diningMinutes: 45 }],
      closures: [],
    });
    expect(slots.map((s) => hhmm(s.start)).at(0)).toBe('2026-12-02 10:00');
    expect(slots.map((s) => hhmm(s.start)).at(-1)).toBe('2026-12-02 13:15'); // 14:00 − 45
    expect(slots).toHaveLength(14);
    expect(slots[0].diningMinutes).toBe(45);
    expect(slots[0].end.getTime() - slots[0].start.getTime()).toBe(45 * 60_000);
  });

  it('respects lead time, lastOrderMinute and closures', () => {
    const slots = buildSlots({
      date: '2026-12-01',
      now, // 10:00 local, lead 60 → first slot 11:00
      settings,
      hours: [{ weekday: 2, openMinute: 600, closeMinute: 1320, lastOrderMinute: 1200 }],
      diningRules: [],
      closures: [{ startsAt: zonedTime('2026-12-01', 14 * 60, TZ), endsAt: zonedTime('2026-12-01', 16 * 60, TZ) }],
    });
    const times = slots.map((s) => hhmm(s.start).slice(11));
    expect(times[0]).toBe('11:00');
    expect(times.at(-1)).toBe('20:00'); // min(lastOrder 20:00, close 22:00 − 90 min = 20:30)
    expect(times).not.toContain('13:00'); // 13:00 + 90 overlaps closure 14:00
    expect(times).not.toContain('15:00');
    expect(times).toContain('16:00');
  });

  it('includes after-midnight slots from the previous day (nhậu open till 01:00)', () => {
    const slots = buildSlots({
      date: '2026-12-03', // Thursday
      now,
      settings: { ...settings, diningMinutes: 30 },
      hours: [{ weekday: 3, openMinute: 960, closeMinute: 1500, lastOrderMinute: null }], // Wed 16:00 → Thu 01:00
      diningRules: [],
      closures: [],
    });
    const times = slots.map((s) => hhmm(s.start));
    expect(times).toEqual(['2026-12-03 00:00', '2026-12-03 00:15', '2026-12-03 00:30']);
  });

  it('nothing beyond maxDaysAhead', () => {
    expect(
      buildSlots({ date: '2027-02-01', now, settings, hours: [{ weekday: 1, openMinute: 600, closeMinute: 1200, lastOrderMinute: null }], diningRules: [], closures: [] }),
    ).toEqual([]);
  });

  it('dining rule lookup and open-now check', () => {
    const rules = [{ weekdays: [1, 2, 3, 4, 5], startMinute: 600, endMinute: 840, diningMinutes: 45 }];
    expect(diningMinutesFor(rules, 3, 700, 90)).toBe(45);
    expect(diningMinutesFor(rules, 6, 700, 90)).toBe(90);
    const hours = [{ weekday: 5, openMinute: 960, closeMinute: 1500, lastOrderMinute: null }];
    expect(isOpenAt(hours, 5, 1000)).toBe(true);
    expect(isOpenAt(hours, 6, 30)).toBe(true); // Sat 00:30 from Fri's hours
    expect(isOpenAt(hours, 6, 90)).toBe(false);
  });
});

describe('pickTables (§8.2, §8.4)', () => {
  const t = (code: string, min: number, max: number, extra: Partial<FreeTable> = {}): FreeTable => ({
    id: code,
    code,
    areaId: 'indoor',
    minSeats: min,
    maxSeats: max,
    joinGroup: null,
    ...extra,
  });

  it('picks the smallest table that fits', () => {
    expect(pickTables([t('B1', 4, 6), t('A1', 1, 2), t('A3', 2, 4)], 3)).toEqual({ tableIds: ['A3'], seats: 4 });
  });

  it('respects minSeats and area', () => {
    expect(pickTables([t('VIP', 8, 16)], 2)).toBeNull();
    expect(pickTables([t('A1', 1, 4), t('G1', 1, 4, { areaId: 'garden' })], 2, 'garden')).toEqual({ tableIds: ['G1'], seats: 4 });
  });

  it('joins tables of the same joinGroup for big groups, fewest tables first', () => {
    const free = [
      t('C1', 4, 6, { joinGroup: 'c' }),
      t('C2', 4, 6, { joinGroup: 'c' }),
      t('C3', 4, 6, { joinGroup: 'c' }),
      t('D1', 2, 4, { joinGroup: 'd' }),
      t('D2', 2, 4, { joinGroup: 'd' }),
    ];
    expect(pickTables(free, 11)).toEqual({ tableIds: ['C1', 'C2'], seats: 12 });
    expect(pickTables(free, 20)).toBeNull();
  });

  it('never joins tables across areas or without a joinGroup', () => {
    expect(pickTables([t('A', 2, 4), t('B', 2, 4)], 7)).toBeNull();
    expect(pickTables([t('A', 2, 4, { joinGroup: 'x' }), t('B', 2, 4, { joinGroup: 'x', areaId: 'garden' })], 7)).toBeNull();
  });

  it('validates a customer choice', () => {
    expect(choiceFits([t('A', 2, 4)], 3)).toBe(true);
    expect(choiceFits([t('A', 2, 4)], 5)).toBe(false);
    expect(choiceFits([t('A', 2, 4, { joinGroup: 'x' }), t('B', 2, 4, { joinGroup: 'x' })], 7)).toBe(true);
    expect(choiceFits([t('A', 2, 4), t('B', 2, 4)], 7)).toBe(false);
  });
});
