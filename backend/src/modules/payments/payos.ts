import { createHmac } from 'crypto';
import { AppError } from '../../common/errors/app-error';
import { safeEqual } from '../../common/utils/crypto';
import { asciiFold } from '../../common/utils/pdf-fonts';
import { CreatePaymentInput, PaymentProviderAdapter, ProviderStatus, WebhookResult } from './provider';

/**
 * PayOS (payos.vn) — VietQR straight to the restaurant's own bank account (§10.1).
 * API: https://payos.vn/docs — create link, read status, webhook with HMAC-SHA256 signature.
 * ⬜ Before going live: re-check field names and statuses against the current PayOS docs
 * with a sandbox account (this was written from the public docs, not tested against PayOS).
 */
export interface PayOsCredentials {
  clientId: string;
  apiKey: string;
  checksumKey: string;
}

const DEFAULT_BASE = 'https://api-merchant.payos.vn';

const hmac = (key: string, data: string) => createHmac('sha256', key).update(data).digest('hex');

/** Signature of a payment request: these five fields, alphabetical, `k=v&…`. */
export function payOsPaymentSignature(
  p: { amount: number; cancelUrl: string; description: string; orderCode: number; returnUrl: string },
  checksumKey: string,
): string {
  return hmac(checksumKey, `amount=${p.amount}&cancelUrl=${p.cancelUrl}&description=${p.description}&orderCode=${p.orderCode}&returnUrl=${p.returnUrl}`);
}

/** Signature of webhook `data`: every key sorted, null/undefined → empty string. */
export function payOsWebhookSignature(data: Record<string, unknown>, checksumKey: string): string {
  const s = Object.keys(data)
    .sort()
    .map((k) => `${k}=${data[k] === null || data[k] === undefined ? '' : String(data[k])}`)
    .join('&');
  return hmac(checksumKey, s);
}

/** PayOS limits the transfer description to 25 characters; keep it ASCII for bank apps. */
export function payOsDescription(text: string): string {
  return asciiFold(text)
    .replace(/[^A-Za-z0-9 ]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 25)
    .trim();
}

type Fetch = typeof fetch;

export class PayOsAdapter implements PaymentProviderAdapter<PayOsCredentials> {
  constructor(
    private readonly fetcher: Fetch = fetch,
    private readonly base: string = DEFAULT_BASE,
  ) {}

  private async call<T>(account: PayOsCredentials, method: 'GET' | 'POST', path: string, body?: unknown): Promise<T> {
    let res: Response;
    try {
      res = await this.fetcher(`${this.base.replace(/\/$/, '')}${path}`, {
        method,
        headers: { 'x-client-id': account.clientId, 'x-api-key': account.apiKey, 'Content-Type': 'application/json' },
        body: body ? JSON.stringify(body) : undefined,
        signal: AbortSignal.timeout(15_000),
      });
    } catch (e) {
      throw new AppError('PAYMENT_PROVIDER_ERROR', `PayOS unreachable: ${(e as Error).message}`);
    }
    const json = (await res.json().catch(() => ({}))) as { code?: string; desc?: string; data?: T };
    if (!res.ok || json.code !== '00' || !json.data) {
      throw new AppError('PAYMENT_PROVIDER_ERROR', `PayOS: ${json.desc ?? res.status}`, { providerCode: json.code });
    }
    return json.data;
  }

  async createPayment(input: CreatePaymentInput<PayOsCredentials>) {
    const orderCode = Number(input.providerOrderId);
    const fields = { amount: input.amount, cancelUrl: input.cancelUrl, description: payOsDescription(input.description), orderCode, returnUrl: input.returnUrl };
    const data = await this.call<{ checkoutUrl: string; qrCode?: string }>(input.account, 'POST', '/v2/payment-requests', {
      ...fields,
      expiredAt: Math.floor(input.expiresAt.getTime() / 1000),
      signature: payOsPaymentSignature(fields, input.account.checksumKey),
    });
    return { checkoutUrl: data.checkoutUrl, qrCode: data.qrCode };
  }

  async getStatus(providerOrderId: string, account: PayOsCredentials): Promise<ProviderStatus> {
    const d = await this.call<{ status: string; amountPaid?: number }>(account, 'GET', `/v2/payment-requests/${encodeURIComponent(providerOrderId)}`);
    const status = d.status === 'PAID' ? 'PAID' : d.status === 'CANCELLED' || d.status === 'EXPIRED' ? 'CANCELLED' : 'PENDING';
    return { status, amountPaid: d.amountPaid ?? 0 };
  }

  /** Throws FORBIDDEN on a bad signature. `paid` is false for PayOS's non-success codes. */
  verifyWebhook(body: unknown, account: PayOsCredentials): WebhookResult {
    const b = body as { code?: string; success?: boolean; data?: Record<string, unknown>; signature?: string };
    if (!b?.data || typeof b.signature !== 'string') throw new AppError('FORBIDDEN', 'Malformed webhook');
    if (!safeEqual(payOsWebhookSignature(b.data, account.checksumKey), b.signature)) throw new AppError('FORBIDDEN', 'Bad webhook signature');
    const d = b.data;
    const str = (v: unknown) => (v === null || v === undefined || v === '' ? undefined : String(v));
    return {
      providerOrderId: String(d.orderCode),
      amount: Number(d.amount),
      paid: b.code === '00' && (d.code === undefined || d.code === '00'),
      eventKey: `${d.orderCode}:${str(d.reference) ?? str(d.paymentLinkId) ?? 'paid'}`,
      providerTxnId: str(d.reference),
      payer: { bankBin: str(d.counterAccountBankId), accountNo: str(d.counterAccountNumber), name: str(d.counterAccountName) },
    };
  }
}
