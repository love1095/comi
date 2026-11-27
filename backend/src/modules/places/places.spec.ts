import { GooglePlaces, approxPrice } from './places';

describe('GooglePlaces rating (Places API New)', () => {
  it('asks for rating fields only and maps the answer', async () => {
    const calls: { url: string; headers: Record<string, string> }[] = [];
    const g = new GooglePlaces('KEY', (async (url: string, init: RequestInit) => {
      calls.push({ url, headers: init.headers as Record<string, string> });
      return new Response(JSON.stringify({ rating: 4.56, userRatingCount: 812 }), { status: 200 });
    }) as unknown as typeof fetch);
    await expect(g.rating('ChIJ123')).resolves.toEqual({ rating: 4.6, count: 812 });
    expect(calls[0].url).toBe('https://places.googleapis.com/v1/places/ChIJ123');
    expect(calls[0].headers['X-Goog-FieldMask']).toBe('rating,userRatingCount');
    expect(calls[0].headers['X-Goog-Api-Key']).toBe('KEY');
  });

  it('returns null for places without ratings or on errors', async () => {
    const empty = new GooglePlaces('KEY', (async () => new Response('{}', { status: 200 })) as unknown as typeof fetch);
    await expect(empty.rating('x')).resolves.toBeNull();
    const fail = new GooglePlaces('KEY', (async () => new Response('{"error":{}}', { status: 404 })) as unknown as typeof fetch);
    await expect(fail.rating('x')).resolves.toBeNull();
  });
});

describe('approxPrice (tourists)', () => {
  it('rounds to a friendly figure', () => {
    expect(approxPrice(150_000, 25_400, 'USD')).toBe('≈ $5.91');
    expect(approxPrice(150_000, 18.5, 'KRW')).toBe('≈ ₩8,100');
    expect(approxPrice(150_000, 165, 'JPY')).toBe('≈ ¥910');
    expect(approxPrice(150_000, 3500, 'CNY')).toBe('≈ ¥42.86');
  });
});
