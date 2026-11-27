/** Content languages (§17). Vietnamese is the source language for restaurant content. */
export const SUPPORTED_LOCALES = ['vi', 'en', 'ko', 'zh', 'ja'] as const;
export type Locale = (typeof SUPPORTED_LOCALES)[number];

/** "ko-KR,ko;q=0.9,en;q=0.8" → "ko". Unknown languages → "en"; no header → "vi". */
export function pickLocale(acceptLanguage?: string): Locale {
  if (!acceptLanguage) return 'vi';
  const tags = acceptLanguage
    .split(',')
    .map((part) => {
      const [tag, q] = part.trim().split(';q=');
      return { lang: tag.toLowerCase().split('-')[0], q: q ? Number(q) : 1 };
    })
    .sort((a, b) => b.q - a.q);
  for (const t of tags) if ((SUPPORTED_LOCALES as readonly string[]).includes(t.lang)) return t.lang as Locale;
  return 'en';
}

/**
 * Apply a translation with fallback locale → en → source (§17.2).
 * Returns the display text plus whether it came from a machine translation.
 */
export function translate<T extends { locale: string; name: string | null; description?: string | null; isMachine: boolean }>(
  source: { name: string; description?: string | null },
  translations: T[],
  locale: Locale,
): { name: string; description: string | null; translated: 'none' | 'human' | 'machine' } {
  if (locale === 'vi') return { name: source.name, description: source.description ?? null, translated: 'none' };
  const tr = translations.find((t) => t.locale === locale && t.name) ?? translations.find((t) => t.locale === 'en' && t.name);
  if (!tr) return { name: source.name, description: source.description ?? null, translated: 'none' };
  return {
    name: tr.name!,
    description: tr.description ?? source.description ?? null,
    translated: tr.isMachine ? 'machine' : 'human',
  };
}
