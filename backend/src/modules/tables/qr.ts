import { createHash } from 'crypto';
import { hmacBase64Url, safeEqual } from '../../common/utils/crypto';

/**
 * QR signatures (§9.1)
 *   table:    base64url(HMAC_SHA256(table.qrSecret, restaurantId + tableId)).slice(0, 16)
 *   entrance: same with a per-restaurant key derived from the server secret.
 * Rotating table.qrSecret invalidates printed QR codes for that table only.
 */
export function tableQrSignature(qrSecret: string, restaurantId: string, tableId: string): string {
  return hmacBase64Url(qrSecret, restaurantId + tableId).slice(0, 16);
}

export function entranceQrSignature(serverSecret: string, restaurantId: string): string {
  const key = createHash('sha256').update(`comi-entrance-qr:${serverSecret}`).digest('hex');
  return hmacBase64Url(key, restaurantId).slice(0, 16);
}

export function verifySignature(expected: string, given: string | undefined | null): boolean {
  return !!given && safeEqual(expected, given);
}

export function tableQrUrl(base: string, slug: string, tableCode: string, sig: string): string {
  return `${base.replace(/\/$/, '')}/c/${encodeURIComponent(slug)}/${encodeURIComponent(tableCode)}?s=${sig}`;
}

export function entranceQrUrl(base: string, slug: string, sig: string): string {
  return `${base.replace(/\/$/, '')}/c/${encodeURIComponent(slug)}?s=${sig}`;
}
