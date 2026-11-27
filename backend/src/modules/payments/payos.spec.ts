import { createHmac } from 'crypto';
import { PayOsAdapter, payOsDescription, payOsPaymentSignature, payOsWebhookSignature } from './payos';

const creds = { clientId: 'cid', apiKey: 'key', checksumKey: 'checksum-secret' };
const hmac = (s: string) => createHmac('sha256', creds.checksumKey).update(s).digest('hex');

describe('PayOS signatures (§10.2)', () => {
  it('payment request: amount, cancelUrl, description, orderCode, returnUrl in alphabetical order', () => {
    const sig = payOsPaymentSignature(
      { amount: 120000, cancelUrl: 'https://c', description: 'CM 8K2P', orderCode: 100001, returnUrl: 'https://r' },
      creds.checksumKey,
    );
    expect(sig).toBe(hmac('amount=120000&cancelUrl=https://c&description=CM 8K2P&orderCode=100001&returnUrl=https://r'));
  });

  it('webhook: every data field sorted by key, null/undefined as empty', () => {
    const data = { orderCode: 100001, amount: 120000, description: 'CM 8K2P', reference: 'FT123', counterAccountName: null, desc: 'success' };
    expect(payOsWebhookSignature(data, creds.checksumKey)).toBe(
      hmac('amount=120000&counterAccountName=&desc=success&description=CM 8K2P&orderCode=100001&reference=FT123'),
    );
  });

  it('description fits PayOS (25 chars, ASCII)', () => {
    expect(payOsDescription('CM-8K2PX')).toBe('CM 8K2PX');
    expect(payOsDescription('Quán Ốc Đêm - CM-8K2PX rất dài').length).toBeLessThanOrEqual(25);
    expect(payOsDescription('Đặt bàn')).toBe('Dat ban');
  });
});

describe('PayOsAdapter.verifyWebhook', () => {
  const adapter = new PayOsAdapter();
  const data = { orderCode: 100001, amount: 120000, description: 'CM 8K2P', reference: 'FT123', transactionDateTime: '2026-12-02 12:00:00', counterAccountBankId: '970436', counterAccountNumber: '0011', counterAccountName: 'NGUYEN VAN A' };

  it('accepts a correctly signed webhook and reads the payer account', () => {
    const r = adapter.verifyWebhook({ code: '00', success: true, data, signature: payOsWebhookSignature(data, creds.checksumKey) }, creds);
    expect(r).toMatchObject({ providerOrderId: '100001', amount: 120000, paid: true, eventKey: '100001:FT123', payer: { bankBin: '970436', accountNo: '0011', name: 'NGUYEN VAN A' } });
  });

  it('rejects a bad signature or a tampered amount', () => {
    expect(() => adapter.verifyWebhook({ code: '00', data, signature: 'nope' }, creds)).toThrow(expect.objectContaining({ code: 'FORBIDDEN' }));
    const sig = payOsWebhookSignature(data, creds.checksumKey);
    expect(() => adapter.verifyWebhook({ code: '00', data: { ...data, amount: 1 }, signature: sig }, creds)).toThrow(expect.objectContaining({ code: 'FORBIDDEN' }));
  });
});

describe('PayOsAdapter HTTP', () => {
  it('creates a payment link with the signed body and maps the response', async () => {
    const calls: { url: string; init: RequestInit }[] = [];
    const fetcher = jest.fn(async (url: string, init: RequestInit) => {
      calls.push({ url, init });
      return new Response(JSON.stringify({ code: '00', desc: 'success', data: { checkoutUrl: 'https://pay.payos.vn/web/abc', qrCode: '000201...', paymentLinkId: 'abc' } }), { status: 200 });
    });
    const adapter = new PayOsAdapter(fetcher as unknown as typeof fetch);
    const r = await adapter.createPayment({
      account: creds,
      providerOrderId: '100001',
      amount: 120000,
      description: 'CM 8K2P',
      returnUrl: 'https://r',
      cancelUrl: 'https://c',
      expiresAt: new Date('2026-12-02T05:15:00Z'),
    });
    expect(r).toEqual({ checkoutUrl: 'https://pay.payos.vn/web/abc', qrCode: '000201...' });
    expect(calls[0].url).toBe('https://api-merchant.payos.vn/v2/payment-requests');
    expect((calls[0].init.headers as Record<string, string>)['x-client-id']).toBe('cid');
    const body = JSON.parse(calls[0].init.body as string);
    expect(body).toMatchObject({ orderCode: 100001, amount: 120000, expiredAt: Math.floor(new Date('2026-12-02T05:15:00Z').getTime() / 1000) });
    expect(body.signature).toBe(payOsPaymentSignature(body, creds.checksumKey));
  });

  it('maps an error answer and the status check', async () => {
    const fail = new PayOsAdapter((async () => new Response(JSON.stringify({ code: '20', desc: 'Bad request' }), { status: 200 })) as unknown as typeof fetch);
    await expect(fail.createPayment({ account: creds, providerOrderId: '1', amount: 1, description: 'x', returnUrl: 'r', cancelUrl: 'c', expiresAt: new Date() })).rejects.toMatchObject({
      code: 'PAYMENT_PROVIDER_ERROR',
    });
    const ok = new PayOsAdapter((async () => new Response(JSON.stringify({ code: '00', data: { status: 'PAID', amountPaid: 120000 } }), { status: 200 })) as unknown as typeof fetch);
    await expect(ok.getStatus('100001', creds)).resolves.toEqual({ status: 'PAID', amountPaid: 120000 });
  });
});
