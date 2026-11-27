/** Machine translation for restaurant content (§17.2). Vietnamese is always the source. */
export interface Translator {
  translate(texts: string[], target: string): Promise<string[]>;
}

const TARGET: Record<string, string> = { en: 'en', ko: 'ko', zh: 'zh-CN', ja: 'ja' };

const ENTITIES: Record<string, string> = { '&amp;': '&', '&quot;': '"', '&#39;': "'", '&lt;': '<', '&gt;': '>' };

/** Google Cloud Translation v2 (API key). Batches up to 128 strings per call. */
export class GoogleTranslator implements Translator {
  constructor(
    private readonly apiKey: string,
    private readonly fetcher: typeof fetch = fetch,
  ) {}

  async translate(texts: string[], target: string): Promise<string[]> {
    if (!texts.length) return [];
    const res = await this.fetcher(`https://translation.googleapis.com/language/translate/v2?key=${encodeURIComponent(this.apiKey)}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ q: texts, source: 'vi', target: TARGET[target] ?? target, format: 'text' }),
      signal: AbortSignal.timeout(20_000),
    });
    if (!res.ok) throw new Error(`translate ${res.status}`);
    const d = (await res.json()) as { data: { translations: { translatedText: string }[] } };
    return d.data.translations.map((t) => t.translatedText.replace(/&(amp|quot|#39|lt|gt);/g, (m) => ENTITIES[m]));
  }
}

export function chunk<T>(xs: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < xs.length; i += size) out.push(xs.slice(i, i + size));
  return out;
}
