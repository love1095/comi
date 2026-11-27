import { footprint, overlaps, validateLayout } from './layout';

const t = (key: string, x: number, y: number, extra: Partial<{ width: number; height: number; rotation: number; minSeats: number; maxSeats: number }> = {}) => ({
  key,
  x,
  y,
  width: 2,
  height: 2,
  rotation: 0,
  minSeats: 1,
  maxSeats: 4,
  ...extra,
});
const grid = { cols: 20, rows: 14 };

describe('table map layout', () => {
  it('rotation 90/270 swaps width and height', () => {
    expect(footprint({ key: 'a', x: 0, y: 0, width: 4, height: 2, rotation: 90 })).toEqual({ x: 0, y: 0, w: 2, h: 4 });
    expect(footprint({ key: 'a', x: 0, y: 0, width: 4, height: 2, rotation: 180 })).toEqual({ x: 0, y: 0, w: 4, h: 2 });
  });

  it('touching edges is not an overlap', () => {
    expect(overlaps({ ...t('A', 0, 0) }, { ...t('B', 2, 0) })).toBe(false);
    expect(overlaps({ ...t('A', 0, 0) }, { ...t('B', 1, 1) })).toBe(true);
  });

  it('accepts a valid layout', () => {
    expect(validateLayout(grid, [t('A1', 0, 0), t('A2', 3, 0), t('VIP', 10, 5, { width: 4, height: 3, maxSeats: 10 })], [])).toEqual([]);
  });

  it('reports out of bounds, including after rotation', () => {
    const problems = validateLayout(grid, [t('A1', 19, 0), t('A2', 0, 12, { width: 1, height: 3, rotation: 0 }), t('A3', 10, 10, { width: 5, height: 1, rotation: 90 })], []);
    expect(problems).toEqual([
      { type: 'OUT_OF_BOUNDS', keys: ['A1'] },
      { type: 'OUT_OF_BOUNDS', keys: ['A2'] },
      { type: 'OUT_OF_BOUNDS', keys: ['A3'] },
    ]);
  });

  it('reports overlapping tables but lets elements overlap', () => {
    const problems = validateLayout(grid, [t('A1', 0, 0), t('A2', 1, 1)], [{ key: 'window', x: 0, y: 0, width: 20, height: 1, rotation: 0 }]);
    expect(problems).toEqual([{ type: 'OVERLAP', keys: ['A1', 'A2'] }]);
  });

  it('reports duplicate codes, bad seats and bad rotation', () => {
    const problems = validateLayout(grid, [t('A1', 0, 0), t('A1', 5, 5, { minSeats: 6, maxSeats: 4 }), t('B1', 9, 9, { rotation: 45 })], []);
    expect(problems.map((p) => p.type).sort()).toEqual(['BAD_ROTATION', 'BAD_SEATS', 'DUPLICATE_CODE']);
  });

  it('missing position (-1) counts as out of bounds', () => {
    expect(validateLayout(grid, [t('A1', -1, -1)], [])).toEqual([{ type: 'OUT_OF_BOUNDS', keys: ['A1'] }]);
  });
});
