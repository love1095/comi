/**
 * Phase 4 (part 1) against real Postgres + Redis: launch fee plans on the first booking →
 * COD bill closed → fee record → monthly statement (admin run) → restaurant report →
 * VAT invoice request → restaurant marks it issued.
 */
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { adminSession, startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

describe('Phase 4 fees, statements, reports, VAT invoice (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);

  let owner: Record<string, string>;
  let admin: Record<string, string>;
  let guest: Record<string, string>;
  let rid: string;
  let bookingId: string;
  const day = vnDate(1);

  beforeAll(async () => {
    ({ base, stop } = await startServer(3995));
    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `p4-${run}@test.comi.vn`, password: 'password123', name: 'Owner' }).expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Phí ${run}`, phone: '0901234567', address: '2 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.7731, lng: 106.7006 })
      .expect(201);
    rid = r.body.id;
    owner['X-Restaurant-Id'] = rid;
    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(owner)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    const area = await api().post('/api/v1/restaurant/areas').set(owner).send({ name: 'Trong nhà' }).expect(201);
    await api().put(`/api/v1/restaurant/areas/${area.body.id}/layout`).set(owner).send({ tables: [{ code: 'A1', minSeats: 1, maxSeats: 4, posX: 0, posY: 0 }], elements: [] }).expect(200);
    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Cơm' }).expect(201);
    const dish = await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Cơm gà', price: 60000 }).expect(201);
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);
    await prisma.restaurant.update({ where: { id: rid }, data: { status: 'ACTIVE' } });

    await api().post('/api/v1/auth/staff/register').send({ email: `p4admin-${run}@test.comi.vn`, password: 'password123', name: 'Admin' }).expect(201);
    admin = await adminSession(base, prisma, `p4admin-${run}@test.comi.vn`);

    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:p4-${run}:+84905556677` }).expect(200);
    guest = { Authorization: `Bearer ${g.body.accessToken}` };
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: day, partySize: 2 }).expect(200);
    const noon = slots.body.find((s: { local: string }) => s.local === '12:00');
    const b = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `p4-${run}`)
      .send({ restaurantId: rid, arrivalAt: noon.time, partySize: 2, paymentMode: 'COD', items: [{ menuItemId: dish.body.id, quantity: 2 }] })
      .expect(200);
    bookingId = b.body.id;
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it('first booking starts the launch fee plans (1% for 3 months, then 2%)', async () => {
    const plans = await prisma.feePlan.findMany({ where: { restaurantId: rid }, orderBy: { effectiveFrom: 'asc' } });
    expect(plans.map((p) => p.rateBps)).toEqual([100, 200]);
    expect((await prisma.restaurant.findUniqueOrThrow({ where: { id: rid } })).firstOrderAt).not.toBeNull();
  });

  it('closing a COD bill records the fee on max(pre-order, final bill)', async () => {
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/check-in`).set(owner).expect(200);
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/close`).set(owner).send({ finalBillAmount: 300000 }).expect(200);
    const fee = await prisma.feeRecord.findUniqueOrThrow({ where: { bookingId } });
    expect(fee).toMatchObject({ baseAmount: 300000, rateBps: 100, feeAmount: 3000, status: 'FINAL' });
  });

  it('VAT invoice: customer requests, restaurant sees it and marks it issued', async () => {
    const bad = await api()
      .post(`/api/v1/bookings/${bookingId}/invoice`)
      .set(guest)
      .send({ companyName: 'Công ty ABC', taxCode: '123', address: '1 Nguyễn Huệ, Q1', email: 'ketoan@abc.vn' })
      .expect(400);
    expect(bad.body.error.code).toBe('VALIDATION_FAILED');
    const req = await api()
      .post(`/api/v1/bookings/${bookingId}/invoice`)
      .set(guest)
      .send({ companyName: 'Công ty ABC', taxCode: '0312345678', address: '1 Nguyễn Huệ, Q1', email: 'ketoan@abc.vn', saveProfile: true })
      .expect(200);
    expect(req.body).toMatchObject({ status: 'SENT_TO_RESTAURANT', amount: 300000 });
    const profiles = await api().get('/api/v1/me/invoice-profiles').set(guest).expect(200);
    expect(profiles.body[0]).toMatchObject({ taxCode: '0312345678', isDefault: true });

    const open = await api().get('/api/v1/restaurant/invoice-requests').set(owner).expect(200);
    expect(open.body.map((x: { id: string }) => x.id)).toContain(req.body.id);
    const issued = await api().post(`/api/v1/restaurant/invoice-requests/${req.body.id}/issued`).set(owner).send({ invoiceNo: '0000123' }).expect(200);
    expect(['ISSUED', 'EMAILED']).toContain(issued.body.status);
    await api().post(`/api/v1/bookings/${bookingId}/invoice`).set(guest).send({ companyName: 'X', taxCode: '0312345678', address: '1 Nguyễn Huệ', email: 'a@b.vn' }).expect(409);
  });

  it('report counts the closed bill and the fee', async () => {
    const rep = await api().get('/api/v1/restaurant/reports').set(owner).query({ from: day, to: day }).expect(200);
    expect(rep.body).toMatchObject({ completed: 1, guests: 2, revenue: 300000, platformFees: 3000 });
    expect(rep.body.topDishes[0]).toMatchObject({ name: 'Cơm gà', quantity: 2 });
  });

  it('monthly statement: admin run bills the fee once; restaurant can read it and its PDF', async () => {
    const month = day.slice(0, 7);
    const gen = await api().post('/api/v1/admin/statements/generate').set(admin).query({ month }).expect(200);
    expect(gen.body.created.length).toBeGreaterThanOrEqual(1);
    await api().post('/api/v1/admin/statements/generate').set(admin).query({ month }).expect(200); // idempotent

    const list = await api().get('/api/v1/restaurant/statements').set(owner).expect(200);
    expect(list.body).toHaveLength(1);
    expect(list.body[0]).toMatchObject({ periodMonth: month, bookingCount: 1, totalFee: 3000, amountDue: 3000, status: 'ISSUED' });
    expect(list.body[0].transferMemo).toMatch(/^TS [0-9A-F]{10}$/);

    const pdf = await api().get(`/api/v1/restaurant/statements/${list.body[0].id}/pdf`).set(owner).buffer(true).expect(200);
    expect(pdf.headers['content-type']).toMatch(/pdf/);
    expect((await prisma.feeRecord.findUniqueOrThrow({ where: { bookingId } })).status).toBe('BILLED');

    const paid = await api().post(`/api/v1/admin/statements/${list.body[0].id}/paid`).set(admin).expect(200);
    expect(paid.body.status).toBe('PAID');
  });
});
