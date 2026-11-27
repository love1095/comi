/**
 * Table-map geometry (§8.6). Units are grid cells of the area's floor plan.
 * Pure functions, shared by the layout endpoint and tests.
 */

export interface Box {
  key: string; // table code or element label, used in error details
  x: number;
  y: number;
  width: number;
  height: number;
  rotation: number; // 0, 90, 180, 270
}

export interface LayoutProblem {
  type: 'OUT_OF_BOUNDS' | 'OVERLAP' | 'BAD_ROTATION' | 'DUPLICATE_CODE' | 'BAD_SEATS';
  keys: string[];
}

/** Footprint after rotation: 90/270 swap width and height. */
export function footprint(b: Box): { x: number; y: number; w: number; h: number } {
  const swap = b.rotation === 90 || b.rotation === 270;
  return { x: b.x, y: b.y, w: swap ? b.height : b.width, h: swap ? b.width : b.height };
}

export function overlaps(a: Box, b: Box): boolean {
  const fa = footprint(a);
  const fb = footprint(b);
  return fa.x < fb.x + fb.w && fb.x < fa.x + fa.w && fa.y < fb.y + fb.h && fb.y < fa.y + fa.h;
}

export function validateLayout(
  grid: { cols: number; rows: number },
  tables: (Box & { minSeats: number; maxSeats: number })[],
  elements: Box[],
): LayoutProblem[] {
  const problems: LayoutProblem[] = [];

  const seen = new Set<string>();
  for (const t of tables) {
    if (seen.has(t.key)) problems.push({ type: 'DUPLICATE_CODE', keys: [t.key] });
    seen.add(t.key);
    if (t.minSeats < 1 || t.maxSeats < t.minSeats) problems.push({ type: 'BAD_SEATS', keys: [t.key] });
  }

  for (const b of [...tables, ...elements]) {
    if (![0, 90, 180, 270].includes(b.rotation)) {
      problems.push({ type: 'BAD_ROTATION', keys: [b.key] });
      continue;
    }
    const f = footprint(b);
    if (f.x < 0 || f.y < 0 || f.w < 1 || f.h < 1 || f.x + f.w > grid.cols || f.y + f.h > grid.rows) {
      problems.push({ type: 'OUT_OF_BOUNDS', keys: [b.key] });
    }
  }

  // Tables must not overlap each other. Elements (windows, walls) may touch/overlap anything.
  for (let i = 0; i < tables.length; i++) {
    for (let j = i + 1; j < tables.length; j++) {
      if (overlaps(tables[i], tables[j])) problems.push({ type: 'OVERLAP', keys: [tables[i].key, tables[j].key] });
    }
  }
  return problems;
}
