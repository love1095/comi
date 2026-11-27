import { vnPeriods } from './admin.module';

describe('vnPeriods', () => {
  it('uses Vietnam midnight and the 1st of the month (UTC+7)', () => {
    // 2026-12-01 18:30 UTC = 2026-12-02 01:30 in Vietnam
    const p = vnPeriods(new Date('2026-12-01T18:30:00Z'));
    expect(p.dayStart.toISOString()).toBe('2026-12-01T17:00:00.000Z');
    expect(p.dayEnd.toISOString()).toBe('2026-12-02T17:00:00.000Z');
    expect(p.monthStart.toISOString()).toBe('2026-11-30T17:00:00.000Z');
  });
});
