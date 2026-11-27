import { randomBytes } from 'crypto';
import { decryptSecret, encryptSecret } from './crypto';
import { applyBps, assertVnd } from './money';
import { slugify } from './slug';

describe('money', () => {
  it('applies basis points with integer rounding (half away from zero)', () => {
    expect(applyBps(50_000, 200)).toBe(1_000); // 2% of 50k
    expect(applyBps(123_456, 100)).toBe(1_235); // 1234.56 → 1235
    expect(applyBps(150, 100)).toBe(2); // 1.5 → 2
    expect(applyBps(149, 100)).toBe(1);
    expect(applyBps(-150, 100)).toBe(-2);
  });

  it('rejects non-integer money', () => {
    expect(() => assertVnd(10.5)).toThrow();
    expect(() => applyBps(100, 1.5)).toThrow();
  });
});

describe('slugify', () => {
  it('removes Vietnamese accents including đ', () => {
    expect(slugify('Quán Nhậu Đức Béo')).toBe('quan-nhau-duc-beo');
    expect(slugify('  Phở 24 — Lê Lợi!! ')).toBe('pho-24-le-loi');
  });
});

describe('credential encryption', () => {
  it('round-trips and detects tampering', () => {
    const key = randomBytes(32).toString('base64');
    const enc = encryptSecret('{"clientId":"x","apiKey":"y"}', key);
    expect(decryptSecret(enc, key)).toBe('{"clientId":"x","apiKey":"y"}');
    const tampered = Buffer.from(enc, 'base64');
    tampered[tampered.length - 1] ^= 1;
    expect(() => decryptSecret(tampered.toString('base64'), key)).toThrow();
  });

  it('requires a 32-byte key', () => {
    expect(() => encryptSecret('x', Buffer.alloc(16).toString('base64'))).toThrow();
  });
});
