import { createHmac, randomBytes } from 'crypto';

/** TOTP (RFC 6238, SHA-1, 6 digits, 30 s) for admin 2FA — works with Google Authenticator, 1Password, Authy. */
const ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
export const TOTP_STEP_SECONDS = 30;

export function base32Encode(buf: Buffer): string {
  let bits = 0;
  let value = 0;
  let out = '';
  for (const byte of buf) {
    value = (value << 8) | byte;
    bits += 8;
    while (bits >= 5) {
      out += ALPHABET[(value >>> (bits - 5)) & 31];
      bits -= 5;
    }
  }
  if (bits > 0) out += ALPHABET[(value << (5 - bits)) & 31];
  return out;
}

export function base32Decode(s: string): Buffer {
  const clean = s.toUpperCase().replace(/[\s=-]/g, '');
  let bits = 0;
  let value = 0;
  const out: number[] = [];
  for (const ch of clean) {
    const idx = ALPHABET.indexOf(ch);
    if (idx < 0) throw new Error('invalid base32');
    value = (value << 5) | idx;
    bits += 5;
    if (bits >= 8) {
      out.push((value >>> (bits - 8)) & 255);
      bits -= 8;
    }
  }
  return Buffer.from(out);
}

export function newTotpSecret(): string {
  return base32Encode(randomBytes(20));
}

export function hotp(secret: Buffer, counter: number, digits = 6): string {
  const msg = Buffer.alloc(8);
  msg.writeBigUInt64BE(BigInt(counter));
  const h = createHmac('sha1', secret).update(msg).digest();
  const offset = h[h.length - 1] & 0xf;
  const bin = ((h[offset] & 0x7f) << 24) | (h[offset + 1] << 16) | (h[offset + 2] << 8) | h[offset + 3];
  return String(bin % 10 ** digits).padStart(digits, '0');
}

export const timeStep = (now: Date) => Math.floor(now.getTime() / 1000 / TOTP_STEP_SECONDS);

export function totp(secretBase32: string, now: Date, digits = 6): string {
  return hotp(base32Decode(secretBase32), timeStep(now), digits);
}

/**
 * Checks a code against the current step ± [window] (clock drift). Returns the matched step so the
 * caller can refuse the same code twice (replay), or null.
 */
export function verifyTotp(secretBase32: string, code: string, now: Date, lastUsedStep: number | null = null, window = 1): number | null {
  if (!/^\d{6}$/.test(code)) return null;
  const key = base32Decode(secretBase32);
  const step = timeStep(now);
  for (let d = -window; d <= window; d++) {
    const s = step + d;
    if (lastUsedStep !== null && s <= lastUsedStep) continue;
    if (hotp(key, s) === code) return s;
  }
  return null;
}

export function otpauthUrl(secretBase32: string, account: string, issuer = 'comi admin'): string {
  return `otpauth://totp/${encodeURIComponent(`${issuer}:${account}`)}?secret=${secretBase32}&issuer=${encodeURIComponent(issuer)}&algorithm=SHA1&digits=6&period=30`;
}
