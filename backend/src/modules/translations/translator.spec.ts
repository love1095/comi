import { GoogleTranslator, chunk } from './translator';

describe('GoogleTranslator (Cloud Translation v2)', () => {
  it('sends Vietnamese source texts in one request and maps the target code', async () => {
    const bodies: Record<string, unknown>[] = [];
    let url = '';
    const t = new GoogleTranslator('KEY', (async (u: string, init: RequestInit) => {
      url = u;
      bodies.push(JSON.parse(init.body as string));
      return new Response(JSON.stringify({ data: { translations: [{ translatedText: 'Snail hotpot' }, { translatedText: 'Beer &amp; ice' }] } }));
    }) as unknown as typeof fetch);
    await expect(t.translate(['Lẩu ốc', 'Bia & đá'], 'zh')).resolves.toEqual(['Snail hotpot', 'Beer & ice']);
    expect(url).toBe('https://translation.googleapis.com/language/translate/v2?key=KEY');
    expect(bodies[0]).toEqual({ q: ['Lẩu ốc', 'Bia & đá'], source: 'vi', target: 'zh-CN', format: 'text' });
  });

  it('throws on API errors so the job retries', async () => {
    const t = new GoogleTranslator('KEY', (async () => new Response('{}', { status: 403 })) as unknown as typeof fetch);
    await expect(t.translate(['a'], 'en')).rejects.toThrow('translate 403');
  });

  it('chunks big menus', () => {
    expect(chunk([1, 2, 3, 4, 5], 2)).toEqual([[1, 2], [3, 4], [5]]);
  });
});
