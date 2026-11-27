/**
 * Phase 3 flow against real Postgres + Redis: COD pre-order → planned fire times (HOLD) →
 * QR check-in rules → staff check-in releases the kitchen → cook statuses → fire a course →
 * order more at the table → call staff → live bill → close bill → kitchen capacity limit.
 */
import { PrismaClient } from '@prisma/client';
import { createHmac } from 'crypto';
import request from 'supertest';
import { startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

const qrSig = (secret: string, rid: string, tid: string) => createHmac('sha256', secret).update(rid + tid).digest('base64url').slice(0, 16);

describe('Phase 3 kitchen + at the table (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);

  let owner: Record<string, string>;
  let guest: Record<string, string>;
  let rid: string;
  let slug: string;
  let tableA1: string;
  let phoId: string;
  let teaId: string;
  let bookingId: string;
  const tomorrow = vnDate(1);

  type Item = { id: string; nameSnapshot: string; kitchenStatus: string; course: string; scheduledStartAt: string | null; bookingId: string };
  const queue = async () => (await api().get('/api/v1/restaurant/kitchen/queue').set(owner).expect(200)).body as { active: Item[]; upcoming: Item[]; ready: Item[] };
  const mine = (items: Item[]) => items.filter((i) => i.bookingId === bookingId);

  beforeAll(async () => {
    ({ base, stop } = await startServer(3997));
    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `p3owner-${run}@test.comi.vn`, password: 'password123', name: 'Owner' }).expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Bếp ${run}`, phone: '0901234567', address: '9 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.7731, lng: 106.7006 })
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
    const layout = await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(owner)
      .send({ tables: [{ code: 'A1', minSeats: 1, maxSeats: 4, posX: 0, posY: 0 }, { code: 'A2', minSeats: 1, maxSeats: 4, posX: 3, posY: 0 }], elements: [] })
      .expect(200);
    tableA1 = layout.body.tables.find((t: { code: string }) => t.code === 'A1').id;
    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Cơm' }).expect(201);
    phoId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Phở bò', price: 55000, prepMinutes: 15 }).expect(201)).body.id;
    teaId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Trà đá', price: 5000, course: 'DRINK', kind: 'DRINK', prepMinutes: 1 }).expect(201)).body.id;
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);
    await prisma.restaurant.update({ where: { id: rid }, data: { status: 'ACTIVE' } });

    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:p3-${run}:+84901112233` }).expect(200);
    guest = { Authorization: `Bearer ${g.body.accessToken}` };
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it('COD pre-order: dishes stay HOLD with planned fire times', async () => {
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: tomorrow, partySize: 2 }).expect(200);
    const noon = slots.body.find((s: { local: string }) => s.local === '12:00');
    const b = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `p3-${run}`)
      .send({ restaurantId: rid, arrivalAt: noon.time, partySize: 2, paymentMode: 'COD', items: [{ menuItemId: phoId, quantity: 2 }, { menuItemId: teaId, quantity: 2 }] })
      .expect(200);
    bookingId = b.body.id;
    expect(b.body.status).toBe('CONFIRMED');

    const items = await prisma.orderItem.findMany({ where: { order: { bookingId } } });
    expect(items.map((i) => i.kitchenStatus)).toEqual(['HOLD', 'HOLD']);
    const pho = items.find((i) => i.nameSnapshot === 'Phở bò')!;
    // MAIN: arrival + 20 − 15 prep = 5 minutes after arrival.
    expect(pho.scheduledStartAt!.getTime() - new Date(noon.time).getTime()).toBe(5 * 60_000);
    // Tomorrow's guest is not on today's kitchen screen yet (upcoming shows the next 3 h).
    const q = await queue();
    expect(mine(q.active)).toHaveLength(0);
    expect(mine(q.upcoming)).toHaveLength(0);
  });

  it('QR check-in checks the signature and the time window', async () => {
    const t = await prisma.table.findUniqueOrThrow({ where: { id: tableA1 } });
    const bad = await api().post(`/api/v1/bookings/${bookingId}/check-in`).set(guest).send({ qrPayload: `https://comi.vn/c/${slug}/A1?s=wrongsignature00` }).expect(422);
    expect(bad.body.error.code).toBe('QR_INVALID');
    const other = await api().post(`/api/v1/bookings/${bookingId}/check-in`).set(guest).send({ qrPayload: `https://comi.vn/c/another-quan/A1?s=x` }).expect(422);
    expect(other.body.error.code).toBe('QR_INVALID');
    const early = await api()
      .post(`/api/v1/bookings/${bookingId}/check-in`)
      .set(guest)
      .send({ qrPayload: `https://comi.vn/c/${slug}/A1?s=${qrSig(t.qrSecret, rid, tableA1)}` })
      .expect(422);
    expect(early.body.error.code).toBe('CHECK_IN_TOO_EARLY'); // booking is tomorrow
  });

  it('staff check-in releases COD dishes: drinks now, mains on their fire time', async () => {
    const res = await api().post(`/api/v1/restaurant/bookings/${bookingId}/check-in`).set(owner).expect(200);
    expect(res.body.status).toBe('CHECKED_IN');
    const q = await queue();
    expect(mine(q.active).map((i) => i.nameSnapshot)).toEqual(['Trà đá']);
    expect(mine(q.upcoming).map((i) => [i.nameSnapshot, i.kitchenStatus])).toEqual([['Phở bò', 'SCHEDULED']]);
  });

  it('kitchen: fire mains now, cook → ready → served; no going back', async () => {
    const fired = await api().post(`/api/v1/restaurant/kitchen/bookings/${bookingId}/fire`).set(owner).send({ course: 'MAIN' }).expect(200);
    expect(fired.body.queued).toBe(1);
    const pho = mine((await queue()).active).find((i) => i.nameSnapshot === 'Phở bò')!;

    const set = (status: string) => api().post(`/api/v1/restaurant/kitchen/items/${pho.id}/status`).set(owner).send({ status });
    expect((await set('COOKING').expect(200)).body.kitchenStatus).toBe('COOKING');
    expect(mine((await queue()).active)[0].nameSnapshot).toBe('Phở bò'); // cooking first
    await set('READY').expect(200);
    expect(mine((await queue()).ready).map((i) => i.nameSnapshot)).toEqual(['Phở bò']);
    await set('SERVED').expect(200);
    const back = await set('COOKING').expect(422);
    expect(back.body.error.code).toBe('INVALID_STATUS');
  });

  it('guest orders more at the table, calls staff once, sees the live bill', async () => {
    const round = await api().post(`/api/v1/bookings/${bookingId}/orders`).set(guest).send({ items: [{ menuItemId: teaId, quantity: 3 }] }).expect(200);
    expect(round.body).toMatchObject({ round: 1, needsApproval: false, total: 15000 });
    expect(mine((await queue()).active).filter((i) => i.nameSnapshot === 'Trà đá')).toHaveLength(2);

    const r1 = await api().post(`/api/v1/bookings/${bookingId}/service-requests`).set(guest).send({ type: 'MORE_ICE' }).expect(200);
    const r2 = await api().post(`/api/v1/bookings/${bookingId}/service-requests`).set(guest).send({ type: 'MORE_ICE' }).expect(200);
    expect(r2.body.id).toBe(r1.body.id); // no double ring
    const open = await api().get('/api/v1/restaurant/service-requests').set(owner).expect(200);
    expect(open.body.find((x: { id: string }) => x.id === r1.body.id)).toMatchObject({ type: 'MORE_ICE', tableCode: 'A1', status: 'OPEN' });
    await api().post(`/api/v1/restaurant/service-requests/${r1.body.id}/done`).set(owner).expect(200);

    const bill = await api().get(`/api/v1/bookings/${bookingId}/bill`).set(guest).expect(200);
    expect(bill.body.rounds.map((r: { round: number }) => r.round)).toEqual([0, 1]);
    expect(bill.body.total).toBe(2 * 55000 + 2 * 5000 + 15000);
  });

  it('cashier closes the bill', async () => {
    const closed = await api().post(`/api/v1/restaurant/bookings/${bookingId}/close`).set(owner).send({}).expect(200);
    expect(closed.body.status).toBe('COMPLETED');
    const b = await prisma.booking.findUniqueOrThrow({ where: { id: bookingId } });
    expect(b.finalBillAmount).toBe(135000);
    const late = await api().post(`/api/v1/bookings/${bookingId}/orders`).set(guest).send({ items: [{ menuItemId: teaId, quantity: 1 }] }).expect(422);
    expect(late.body.error.code).toBe('NOT_CHECKED_IN');
  });

  it('kitchen capacity: a pre-order that overflows the window is refused, table-only still works', async () => {
    await prisma.kitchenCapacityRule.create({ data: { restaurantId: rid, weekdays: [0, 1, 2, 3, 4, 5, 6], startMinute: 0, endMinute: 1440, windowMinutes: 15, maxItems: 3 } });
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: tomorrow, partySize: 2 }).expect(200);
    const one = slots.body.find((s: { local: string }) => s.local === '13:00');
    const full = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `p3-full-${run}`)
      .send({ restaurantId: rid, arrivalAt: one.time, partySize: 2, paymentMode: 'COD', items: [{ menuItemId: phoId, quantity: 4 }] })
      .expect(409);
    expect(full.body.error.code).toBe('KITCHEN_FULL');
    await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `p3-table-${run}`)
      .send({ restaurantId: rid, arrivalAt: one.time, partySize: 2, paymentMode: 'COD' })
      .expect(200);
  });
});
