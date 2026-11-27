import { Course, ItemKind } from '@prisma/client';
import ExcelJS from 'exceljs';

/**
 * Menu import from Excel/CSV (§22.2 #9): upload → preview (rows + errors) → confirm.
 * Column headers are Vietnamese (what owners see in the template); English aliases also work.
 */
export const IMPORT_COLUMNS = [
  { key: 'category', header: 'Danh mục', aliases: ['category'], example: 'Món chính' },
  { key: 'name', header: 'Tên món', aliases: ['name', 'dish'], example: 'Cơm tấm sườn' },
  { key: 'price', header: 'Giá (VND)', aliases: ['giá', 'gia', 'price'], example: '55000' },
  { key: 'course', header: 'Loại', aliases: ['course', 'loai'], example: 'Món chính' },
  { key: 'description', header: 'Mô tả', aliases: ['description', 'mo ta'], example: 'Sườn nướng than' },
  { key: 'prepMinutes', header: 'Thời gian làm (phút)', aliases: ['prep', 'prepminutes', 'thoi gian'], example: '10' },
  { key: 'isAlcohol', header: 'Có cồn', aliases: ['alcohol', 'co con'], example: 'không' },
  { key: 'tags', header: 'Tags', aliases: ['tags', 'nhãn'], example: 'cay, chay' },
] as const;

export type ImportKey = (typeof IMPORT_COLUMNS)[number]['key'];

export interface ImportedItem {
  row: number;
  category: string;
  name: string;
  price: number;
  course: Course;
  kind: ItemKind;
  description?: string;
  prepMinutes: number;
  isAlcohol: boolean;
  tags: string[];
}

export interface ImportError {
  row: number;
  column?: string;
  message: string;
}

export const MAX_IMPORT_ROWS = 500;

const fold = (s: string) =>
  s.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/đ/gi, 'd').toLowerCase().trim();

const COURSE_WORDS: Record<string, Course> = {
  'do uong': 'DRINK', 'nuoc': 'DRINK', 'bia': 'DRINK', drink: 'DRINK',
  'khai vi': 'STARTER', 'mon khai vi': 'STARTER', starter: 'STARTER', 'moi': 'STARTER',
  'mon chinh': 'MAIN', 'chinh': 'MAIN', main: 'MAIN', '': 'MAIN',
  'trang mieng': 'DESSERT', dessert: 'DESSERT',
};
const YES = new Set(['co', 'yes', 'y', 'x', '1', 'true']);

/** Map a header cell to a column key, or undefined if unknown. */
export function matchHeader(cell: string): ImportKey | undefined {
  const h = fold(cell).replace(/\(.*\)/, '').trim();
  for (const c of IMPORT_COLUMNS) {
    if (fold(c.header).replace(/\(.*\)/, '').trim() === h) return c.key;
    if (c.aliases.some((a) => fold(a) === h)) return c.key;
  }
  return undefined;
}

/** "55.000", "55,000", "55000đ", "55k" → 55000 */
export function parseVnd(raw: string): number | undefined {
  const s = fold(raw).replace(/vnd|\s|d/g, '');
  if (!s) return undefined;
  const k = /^(\d+(?:[.,]\d+)?)k$/.exec(s);
  if (k) return Math.round(Number(k[1].replace(',', '.')) * 1000);
  const digits = s.replace(/[.,]/g, '');
  return /^\d+$/.test(digits) ? Number(digits) : undefined;
}

/** Pure: header row + data rows (strings) → items and errors. */
export function parseMenuRows(header: string[], rows: string[][]): { items: ImportedItem[]; errors: ImportError[] } {
  const items: ImportedItem[] = [];
  const errors: ImportError[] = [];
  const colIndex = new Map<ImportKey, number>();
  header.forEach((h, i) => {
    const key = matchHeader(h ?? '');
    if (key && !colIndex.has(key)) colIndex.set(key, i);
  });
  for (const required of ['category', 'name', 'price'] as const) {
    if (!colIndex.has(required)) {
      errors.push({ row: 1, column: required, message: `Missing column "${IMPORT_COLUMNS.find((c) => c.key === required)!.header}"` });
    }
  }
  if (errors.length) return { items, errors };
  if (rows.length > MAX_IMPORT_ROWS) {
    return { items, errors: [{ row: 0, message: `At most ${MAX_IMPORT_ROWS} rows per import` }] };
  }

  const get = (r: string[], k: ImportKey) => {
    const i = colIndex.get(k);
    return i === undefined ? '' : String(r[i] ?? '').trim();
  };
  const seen = new Set<string>();

  rows.forEach((r, idx) => {
    const row = idx + 2; // 1-based, after header
    if (r.every((c) => !String(c ?? '').trim())) return; // blank line
    const rowErrors: ImportError[] = [];
    const category = get(r, 'category');
    const name = get(r, 'name');
    const price = parseVnd(get(r, 'price'));
    const courseWord = fold(get(r, 'course'));
    const course = COURSE_WORDS[courseWord];
    const prepRaw = get(r, 'prepMinutes');
    const prep = prepRaw ? Number(prepRaw) : 15;

    if (!category) rowErrors.push({ row, column: 'category', message: 'Category is empty' });
    if (!name) rowErrors.push({ row, column: 'name', message: 'Name is empty' });
    if (name.length > 120) rowErrors.push({ row, column: 'name', message: 'Name is longer than 120 characters' });
    if (price === undefined || price > 100_000_000) rowErrors.push({ row, column: 'price', message: `Invalid price "${get(r, 'price')}"` });
    if (!course) rowErrors.push({ row, column: 'course', message: `Unknown course "${get(r, 'course')}"` });
    if (!Number.isInteger(prep) || prep < 0 || prep > 240) rowErrors.push({ row, column: 'prepMinutes', message: `Invalid prep time "${prepRaw}"` });
    const dupKey = `${fold(category)}|${fold(name)}`;
    if (name && seen.has(dupKey)) rowErrors.push({ row, column: 'name', message: 'Duplicate dish in the same category' });
    seen.add(dupKey);

    if (rowErrors.length) {
      errors.push(...rowErrors);
      return;
    }
    items.push({
      row,
      category,
      name,
      price: price!,
      course: course!,
      kind: course === 'DRINK' ? 'DRINK' : 'DISH',
      description: get(r, 'description') || undefined,
      prepMinutes: prep,
      isAlcohol: YES.has(fold(get(r, 'isAlcohol'))),
      tags: get(r, 'tags')
        .split(/[,;]/)
        .map((t) => fold(t).replace(/\s+/g, '_'))
        .filter(Boolean)
        .slice(0, 10),
    });
  });
  return { items, errors };
}

/** Read the first sheet of an .xlsx, or a .csv, into string cells. */
export async function readSheet(buffer: Buffer, filename: string): Promise<{ header: string[]; rows: string[][] }> {
  const wb = new ExcelJS.Workbook();
  if (/\.csv$/i.test(filename)) {
    const { Readable } = await import('stream');
    await wb.csv.read(Readable.from(buffer.toString('utf8').replace(/^﻿/, '')));
  } else {
    await wb.xlsx.load(buffer as unknown as ArrayBuffer);
  }
  const ws = wb.worksheets[0];
  if (!ws) return { header: [], rows: [] };
  const all: string[][] = [];
  ws.eachRow({ includeEmpty: true }, (row) => {
    const values = (row.values as unknown[]).slice(1); // exceljs is 1-based
    all.push(values.map(cellText));
  });
  const [header = [], ...rows] = all;
  return { header, rows };
}

function cellText(v: unknown): string {
  if (v === null || v === undefined) return '';
  if (typeof v === 'object') {
    const o = v as { text?: string; result?: unknown; richText?: { text: string }[] };
    if (o.richText) return o.richText.map((t) => t.text).join('');
    if (o.text !== undefined) return String(o.text);
    if (o.result !== undefined) return String(o.result);
  }
  return String(v);
}

/** Template file the owner downloads, fills in and uploads. */
export async function buildTemplate(): Promise<Buffer> {
  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Thực đơn');
  ws.columns = IMPORT_COLUMNS.map((c) => ({ header: c.header, key: c.key, width: Math.max(14, c.header.length + 4) }));
  ws.getRow(1).font = { bold: true };
  ws.addRow(Object.fromEntries(IMPORT_COLUMNS.map((c) => [c.key, c.example])));
  ws.addRow({ category: 'Đồ uống', name: 'Bia Sài Gòn', price: '22000', course: 'Đồ uống', prepMinutes: '1', isAlcohol: 'có' });
  const help = wb.addWorksheet('Hướng dẫn');
  help.addRows([
    ['Loại: Đồ uống / Khai vị / Món chính / Tráng miệng (trống = Món chính)'],
    ['Giá: số nguyên VND, ví dụ 55000 hoặc 55k'],
    ['Có cồn: "có" cho bia, rượu (khách phải xác nhận đủ 18 tuổi)'],
    ['Tags: cách nhau bằng dấu phẩy, ví dụ: cay, chay'],
  ]);
  return Buffer.from(await wb.xlsx.writeBuffer());
}
