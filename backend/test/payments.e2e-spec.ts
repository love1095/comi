/**
 * Phase 4 (part 2) against real Postgres + Redis, with a local stub standing in for PayOS:
 * owner connects PayOS → prepaid booking waits → payment link → signed webhook confirms
 * (duplicates ignored, bad signatures refused) → restaurant cancels → manual refund → done.
 */
import { PrismaClient } from '@prisma/client';
import { createHmac, randomBytes } from 'crypto';
import { createServer, Server } from 'http';
import request from 'supertest';
import { startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

const CHECKSUM = 'checksum-key-for-tests';
const sign = (data: Record<string, unknown>) =>
  createHmac('sha256', CHECKSUM)
    .update(
      Object.keys(data)
        .sort()
        .map((k) => `${k}=${data[k] ?? ''}`)
        .join('&'),
    )
    .digest('hex');

describe('Phase 4 PayOS prepaid + refunds (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  let stub: Server;
  const created: { orderCode: number; amount: number; signature: string }[] = [];
  const api = () => request(base);

  let owner: Record<string, string>;
  let guest: Record<string, string>;
  let rid: string;
  let slug: string;
  let dishId: string;
  let bookingId: string;
  let orderCode: number;

  beforeAll(async () => {
    // Stub PayOS: accepts payment requests, says PENDING on status checks.
    stub = createServer((req, res) => {
      let body = '';
      req.on('data', (c) => (body += c));
      req.on('end', () => {
        res.setHeader('Content-Type', 'application/json');
        if (req.method === 'POST' && req.url === '/v2/payment-requests') {
          const b = JSON.parse(body);
          created.push(b);
          res.end(JSON.stringify({ code: '00', desc: 'success', data: { checkoutUrl: `https://pay.stub/${b.orderCode}`, qrCode: '000201010212' } }));
        } else res.end(JSON.stringify({ code: '00', data: { status: 'PENDING', amountPaid: 0 } }));
      });
    }).listen(3989);
    process.env.PAYOS_API_URL = 'http://localhost:3989';
    process.env.CREDENTIALS_ENCRYPTION_KEY = randomBytes(32).toString('base64');
    ({ base, stop } = await startServer(3994));

    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `p4pay-${run}@test.comi.vn`, password: 'password123', name: 'Owner' }).expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Trả Trước ${run}`, phone: '0901234567', address: '3 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.7731, lng: 106.7006 })
      .expect(201);
    rid = r.body.id;
    slug = r.body.slug;
    owner['X-Restaurant-Id'] = rid;
    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(owner)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    const area = await api().post('/api/v1/restaurant/areas').set(owner).send({ name: 'Trong nhà' }).expect(201);
    await api().put(`/api/v1/restaurant/areas/${area.body.id}/layout`).set(owner).send({ tables: [{ code: 'A1', minSeats: 1, maxSeats: 4, posX: 0, posY: 0 }], elements: [] }).expect(200);
    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Cơm' }).expect(201);
    dishId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Cơm sườn', price: 50000 }).expect(201)).body.id;
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);
    await prisma.restaurant.update({ where: { id: rid }, data: { status: 'ACTIVE' } });
    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:p4pay-${run}:+84907778899` }).expect(200);
    guest = { Authorization: `Bearer ${g.body.accessToken}` };
  });

  afterAll(async () => {
    stop?.();
    stub?.close();
    await prisma.$disconnect();
  });

  const book = async (key: string, time = '12:00') => {
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: vnDate(1), partySize: 2 }).expect(200);
    const s = slots.body.find((x: { local: string }) => x.local === time);
    return api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `${key}-${run}`)
      .send({ restaurantId: rid, arrivalAt: s.time, partySize: 2, paymentMode: 'PREPAID', items: [{ menuItemId: dishId, quantity: 2 }] });
  };

  it('prepaid is refused until the owner connects PayOS', async () => {
    const res = await book('before');
    expect(res.status).toBe(422);
    expect(res.body.error.code).toBe('PAYMENT_NOT_CONNECTED');
    const status = await api().put('/api/v1/restaurant/payment-account').set(owner).send({ clientId: 'client-id-123', apiKey: 'api-key-12345', checksumKey: CHECKSUM }).expect(200);
    expect(status.body).toMatchObject({ connected: true, clientIdHint: '…-123', serverReady: true });
    const detail = await api().get(`/api/v1/restaurants/${slug}`).expect(200);
    expect(detail.body.prepaidAvailable).toBe(true);
  });

  it('prepaid booking waits for payment; pay returns a link (re-used while open)', async () => {
    const b = await book('pay');
    expect(b.status).toBe(200);
    bookingId = b.body.id;
    expect(b.body.status).toBe('PENDING');
    const p1 = await api().post(`/api/v1/bookings/${bookingId}/pay`).set(guest).expect(200);
    expect(p1.body).toMatchObject({ amount: 100000, status: 'PENDING', checkoutUrl: expect.stringContaining('https://pay.stub/') });
    const p2 = await api().post(`/api/v1/bookings/${bookingId}/pay`).set(guest).expect(200);
    expect(p2.body.id).toBe(p1.body.id);
    expect(created).toHaveLength(1);
    orderCode = created[0].orderCode;
    expect(created[0].signature).toMatch(/^[0-9a-f]{64}$/);
  });

  it('signed webhook confirms the booking once; a forged one is refused', async () => {
    const data = { orderCode, amount: 100000, description: 'CM', reference: 'FT0001', counterAccountBankId: '970436', counterAccountNumber: '0011223344', counterAccountName: 'NGUYEN VAN A' };
    await api().post('/api/v1/webhooks/payos').send({ code: '00', success: true, data, signature: 'forged' }).expect(403);
    await api().post('/api/v1/webhooks/payos').send({ code: '00', success: true, data, signature: sign(data) }).expect(200);
    await api().post('/api/v1/webhooks/payos').send({ code: '00', success: true, data, signature: sign(data) }).expect(200); // retry

    const b = await api().get(`/api/v1/bookings/${bookingId}`).set(guest).expect(200);
    expect(b.body.status).toBe('CONFIRMED');
    expect(b.body.payments[0]).toMatchObject({ status: 'PAID', amount: 100000 });
    const items = await prisma.orderItem.findMany({ where: { order: { bookingId } } });
    expect(items.every((i) => i.kitchenStatus === 'SCHEDULED' || i.kitchenStatus === 'QUEUED')).toBe(true);
    expect(await prisma.webhookEvent.count({ where: { eventKey: `${orderCode}:FT0001` } })).toBe(1);

    // PayOS's "test webhook" for an unknown order is accepted quietly.
    await api().post('/api/v1/webhooks/payos').send({ code: '00', data: { orderCode: 123 }, signature: 'x' }).expect(200);
  });

  it('restaurant cancels → full refund to the payer, marked done by staff', async () => {
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/cancel`).set(owner).send({ reason: 'Quán đóng cửa đột xuất' }).expect(200);
    const pending = await api().get('/api/v1/restaurant/refunds').set(owner).query({ status: 'PENDING' }).expect(200);
    const refund = pending.body.find((r: { bookingId: string }) => r.bookingId === bookingId);
    expect(refund).toMatchObject({ amount: 100000, reason: 'RESTAURANT_CANCELLED', toBankBin: '970436', toAccountNo: '0011223344' });

    const done = await api().post(`/api/v1/restaurant/refunds/${refund.id}/done`).set(owner).send({ note: 'FT9999' }).expect(200);
    expect(done.body.status).toBe('DONE');
    const pay = await prisma.payment.findFirstOrThrow({ where: { bookingId } });
    expect(pay).toMatchObject({ status: 'REFUNDED', refundedAmount: 100000 });
    const b = await api().get(`/api/v1/bookings/${bookingId}`).set(guest).expect(200);
    expect(b.body.refunds[0]).toMatchObject({ status: 'DONE', amount: 100000 });
  });
});
