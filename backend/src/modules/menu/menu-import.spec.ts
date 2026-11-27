import { buildTemplate, matchHeader, parseMenuRows, parseVnd, readSheet } from './menu-import';

describe('menu import (§22.2 #9)', () => {
  it('parses VND in common formats', () => {
    expect(parseVnd('55000')).toBe(55000);
    expect(parseVnd('55.000')).toBe(55000);
    expect(parseVnd('55,000 đ')).toBe(55000);
    expect(parseVnd('55000 VND')).toBe(55000);
    expect(parseVnd('55k')).toBe(55000);
    expect(parseVnd('1,5k')).toBe(1500);
    expect(parseVnd('abc')).toBeUndefined();
    expect(parseVnd('')).toBeUndefined();
  });

  it('matches Vietnamese and English headers, with or without accents', () => {
    expect(matchHeader('Danh mục')).toBe('category');
    expect(matchHeader('danh muc')).toBe('category');
    expect(matchHeader('Giá (VND)')).toBe('price');
    expect(matchHeader('Price')).toBe('price');
    expect(matchHeader('Có cồn')).toBe('isAlcohol');
    expect(matchHeader('Ghi chú')).toBeUndefined();
  });

  it('parses rows and reports errors per row', () => {
    const header = ['Danh mục', 'Tên món', 'Giá', 'Loại', 'Có cồn', 'Tags'];
    const { items, errors } = parseMenuRows(header, [
      ['Món chính', 'Cơm tấm', '55k', 'Món chính', '', 'Cay, Món Chay'],
      ['Đồ uống', 'Bia Tiger', '22.000', 'Đồ uống', 'có', ''],
      ['', '', '', '', '', ''], // blank line skipped
      ['Món chính', 'Cơm tấm', '50000', '', '', ''], // duplicate
      ['Món chính', 'Phở', 'free', 'Lẩu??', '', ''],
    ]);
    expect(items).toHaveLength(2);
    expect(items[0]).toMatchObject({ row: 2, price: 55000, course: 'MAIN', kind: 'DISH', tags: ['cay', 'mon_chay'], isAlcohol: false });
    expect(items[1]).toMatchObject({ course: 'DRINK', kind: 'DRINK', isAlcohol: true });
    expect(errors).toEqual([
      { row: 5, column: 'name', message: 'Duplicate dish in the same category' },
      { row: 6, column: 'price', message: 'Invalid price "free"' },
      { row: 6, column: 'course', message: 'Unknown course "Lẩu??"' },
    ]);
  });

  it('requires category, name and price columns', () => {
    expect(parseMenuRows(['Tên món'], [['x']]).errors.map((e) => e.column)).toEqual(['category', 'price']);
  });

  it('the downloadable template round-trips without errors', async () => {
    const sheet = await readSheet(await buildTemplate(), 'comi-thuc-don.xlsx');
    const { items, errors } = parseMenuRows(sheet.header, sheet.rows);
    expect(errors).toEqual([]);
    expect(items.map((i) => i.name)).toEqual(['Cơm tấm sườn', 'Bia Sài Gòn']);
  });

  it('reads CSV with a BOM', async () => {
    const csv = '﻿Danh mục,Tên món,Giá\nMón chính,Bún bò,45000\n';
    const sheet = await readSheet(Buffer.from(csv, 'utf8'), 'menu.csv');
    expect(parseMenuRows(sheet.header, sheet.rows).items[0]).toMatchObject({ name: 'Bún bò', price: 45000 });
  });
});
