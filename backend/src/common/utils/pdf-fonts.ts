import { existsSync } from 'fs';
import { join } from 'path';

/** Be Vietnam Pro (OFL, src/assets/fonts). Copied to dist/assets by nest-cli. */
const FONT_DIR = join(__dirname, '..', '..', 'assets', 'fonts');

export function registerVietnameseFonts(doc: PDFKit.PDFDocument) {
  const regular = join(FONT_DIR, 'BeVietnamPro-Regular.ttf');
  const bold = join(FONT_DIR, 'BeVietnamPro-Bold.ttf');
  if (existsSync(regular) && existsSync(bold)) {
    doc.registerFont('vi', regular);
    doc.registerFont('vi-bold', bold);
    return { regular: 'vi', bold: 'vi-bold', text: (s: string) => s };
  }
  // Fallback: built-in fonts have no Vietnamese glyphs, so strip accents rather than print garbage.
  return { regular: 'Helvetica', bold: 'Helvetica-Bold', text: asciiFold };
}

export function asciiFold(s: string): string {
  return s.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/đ/g, 'd').replace(/Đ/g, 'D');
}
