import { LEGAL, legalHtml } from './legal-texts';

describe('legal pages', () => {
  it('vi and en have the same sections', () => {
    for (const doc of ['privacy', 'terms'] as const) expect(LEGAL[doc].vi.sections.length).toBe(LEGAL[doc].en.sections.length);
  });

  it('renders escaped HTML with the version', () => {
    const html = legalHtml('privacy', 'en');
    expect(html).toContain('<h1>Privacy policy</h1>');
    expect(html).toContain('Version 2026-12');
  });
});
