/** Google Places API (New): rating + count for the detail page. Field mask keeps the call cheap. */
export class GooglePlaces {
  constructor(
    private readonly apiKey: string,
    private readonly fetcher: typeof fetch = fetch,
  ) {}

  async rating(placeId: string): Promise<{ rating: number; count: number } | null> {
    try {
      const res = await this.fetcher(`https://places.googleapis.com/v1/places/${encodeURIComponent(placeId)}`, {
        headers: { 'X-Goog-Api-Key': this.apiKey, 'X-Goog-FieldMask': 'rating,userRatingCount' },
        signal: AbortSignal.timeout(10_000),
      });
      if (!res.ok) return null;
      const d = (await res.json()) as { rating?: number; userRatingCount?: number };
      if (typeof d.rating !== 'number') return null;
      return { rating: Math.round(d.rating * 10) / 10, count: d.userRatingCount ?? 0 };
    } catch {
      return null;
    }
  }
}

const SYMBOL: Record<string, string> = { USD: '$', KRW: '₩', CNY: '¥', JPY: '¥' };
const WHOLE = new Set(['KRW', 'JPY']);

/** "≈ $5.91" — approximate foreign price for tourists (VND stays the real price). */
export function approxPrice(vnd: number, vndPerUnit: number, currency: string): string {
  const v = vnd / vndPerUnit;
  const s = SYMBOL[currency] ?? `${currency} `;
  if (WHOLE.has(currency)) {
    const step = v >= 1000 ? 100 : 10;
    return `≈ ${s}${(Math.round(v / step) * step).toLocaleString('en-US')}`;
  }
  return `≈ ${s}${v.toFixed(2)}`;
}
