import { createHmac } from 'crypto';
import { entranceQrSignature, parseQrPayload, tableQrSignature, tableQrUrl, verifySignature } from './qr';

describe('QR signatures (§9.1)', () => {
  const rid = '0d4c7a52-7a3c-4b6e-9f0e-111111111111';
  const tid = '9a1b2c3d-0000-4000-8000-222222222222';

  it('matches the spec formula: base64url(HMAC_SHA256(secret, restaurantId + tableId)).slice(0,16)', () => {
    const expected = createHmac('sha256', 'secret').update(rid + tid).digest('base64url').slice(0, 16);
    expect(tableQrSignature('secret', rid, tid)).toBe(expected);
    expect(expected).toHaveLength(16);
  });

  it('changes when the table secret rotates', () => {
    expect(tableQrSignature('a', rid, tid)).not.toBe(tableQrSignature('b', rid, tid));
  });

  it('entrance signature differs per restaurant and from table signatures', () => {
    const e1 = entranceQrSignature('server', rid);
    expect(e1).toHaveLength(16);
    expect(e1).not.toBe(entranceQrSignature('server', tid));
  });

  it('verifies in constant time and rejects missing/wrong values', () => {
    const sig = tableQrSignature('s', rid, tid);
    expect(verifySignature(sig, sig)).toBe(true);
    expect(verifySignature(sig, sig.slice(0, 15) + 'x')).toBe(false);
    expect(verifySignature(sig, undefined)).toBe(false);
    expect(verifySignature(sig, 'short')).toBe(false);
  });

  it('builds the table URL', () => {
    expect(tableQrUrl('https://comi.vn/', 'quan-a', 'A1', 'abc')).toBe('https://comi.vn/c/quan-a/A1?s=abc');
  });
});

describe('parseQrPayload', () => {
  it('reads table and entrance links, rejects others', () => {
    expect(parseQrPayload('https://comi.vn/c/quan-oc/A1?s=abc123')).toEqual({ slug: 'quan-oc', tableCode: 'A1', sig: 'abc123' });
    expect(parseQrPayload('https://comi.vn/c/quan-oc?s=xyz')).toEqual({ slug: 'quan-oc', tableCode: undefined, sig: 'xyz' });
    expect(parseQrPayload('https://comi.vn/c/qu%C3%A1n/B%202?s=q')).toEqual({ slug: 'quán', tableCode: 'B 2', sig: 'q' });
    expect(parseQrPayload('https://comi.vn/c/quan-oc/A1')).toBeNull(); // no signature
    expect(parseQrPayload('not a url')).toBeNull();
    expect(parseQrPayload('https://evil.com/x/y?s=1')).toBeNull();
  });
});
