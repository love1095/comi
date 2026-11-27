import { base32Decode, base32Encode, hotp, otpauthUrl, totp, verifyTotp } from './totp';

// RFC 6238 appendix B (SHA-1 seed "12345678901234567890").
const SEED = base32Encode(Buffer.from('12345678901234567890'));

describe('TOTP', () => {
  it('matches the RFC 6238 test vectors', () => {
    expect(hotp(Buffer.from('12345678901234567890'), 1, 8)).toBe('94287082');
    expect(totp(SEED, new Date(59_000), 8)).toBe('94287082');
    expect(totp(SEED, new Date(1_111_111_109_000), 8)).toBe('07081804');
    expect(totp(SEED, new Date(2_000_000_000_000), 8)).toBe('69279037');
  });

  it('base32 round-trips', () => {
    const b = Buffer.from([0, 1, 2, 250, 255, 7, 9]);
    expect(base32Decode(base32Encode(b))).toEqual(b);
    expect(base32Encode(Buffer.from('foobar'))).toBe('MZXW6YTBOI');
  });

  it('accepts ±1 step drift, refuses replay and garbage', () => {
    const now = new Date(1_700_000_000_000);
    const code = totp(SEED, now);
    const step = verifyTotp(SEED, code, now);
    expect(step).not.toBeNull();
    expect(verifyTotp(SEED, code, new Date(now.getTime() + 30_000))).toBe(step);
    expect(verifyTotp(SEED, code, new Date(now.getTime() + 90_000))).toBeNull();
    expect(verifyTotp(SEED, code, now, step)).toBeNull();
    expect(verifyTotp(SEED, '12a456', now)).toBeNull();
  });

  it('builds an authenticator URL', () => {
    expect(otpauthUrl('ABC', 'a@comi.vn')).toBe('otpauth://totp/comi%20admin%3Aa%40comi.vn?secret=ABC&issuer=comi%20admin&algorithm=SHA1&digits=6&period=30');
  });
});
