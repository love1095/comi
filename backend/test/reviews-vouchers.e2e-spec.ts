/**
 * Phase 5 (part 1) against real Postgres + Redis: restaurant voucher → preview → booking with
 * discount (alcohol excluded) → per-user limit → released on cancel; verified review after the
 * meal → rating → reply once → report → admin hides → rating recomputed.
 */
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { adminSession, startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

describe('Phase 5 reviews + vouchers (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);

  let owner: Record<string, string>;
  let admin: Record<string, string>;
  let guest: Record<string, string>;
  let rid: string;
  let foodId: string;
  let beerId: string;
  const code = `TRUA${run.slice(-4).toUpperCase()}`;

  const slot = async (time: string) => {
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: vnDate(1), partySize: 2 }).expect(200);
    return slots.body.find((s: { local: string }) => s.local === time).time as string;
  };

  beforeAll(async () => {
    ({ base, stop } = await startServer(3993));
    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `p5-${run}@test.comi.vn`, password: 'password123', name: 'Owner' }).expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Khen ${run}`, phone: '0901234567', address: '4 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.7731, lng: 106.7006 })
      .expect(201);
    rid = r.body.id;
    owner['X-Restaurant-Id'] = rid;
    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(owner)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    const area = await api().post('/api/v1/restaurant/areas').set(owner).send({ name: 'Trong nhà' }).expect(201);
    await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(owner)
      .send({ tables: [1, 2, 3].map((n) => ({ code: `A${n}`, minSeats: 1, maxSeats: 4, posX: n * 3, posY: 0 })), elements: [] })
      .expect(200);
    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Món' }).expect(201);
    foodId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Lẩu', price: 100000 }).expect(201)).body.id;
    beerId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Bia', price: 50000, course: 'DRINK', isAlcohol: true }).expect(201)).body.id;
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);
    await prisma.restaurant.update({ where: { id: rid }, data: { status: 'ACTIVE' } });

    await api().post('/api/v1/auth/staff/register').send({ email: `p5admin-${run}@test.comi.vn`, password: 'password123', name: 'Admin' }).expect(201);
    admin = await adminSession(base, prisma, `p5admin-${run}@test.comi.vn`);
    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:p5-${run}:+84908889900` }).expect(200);
    guest = { Authorization: `Bearer ${g.body.accessToken}` };
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  let bookingId: string;

  it('restaurant voucher: preview, discount without alcohol, one use per guest, released on cancel', async () => {
    const now = Date.now();
    await api()
      .post('/api/v1/restaurant/vouchers')
      .set(owner)
      .send({ code, type: 'PERCENT', value: 2000, maxDiscount: 30000, minOrder: 50000, startsAt: new Date(now - 3600_000).toISOString(), endsAt: new Date(now + 7 * 86_400_000).toISOString() })
      .expect(201);
    const items = [{ menuItemId: foodId, quantity: 1 }, { menuItemId: beerId, quantity: 2 }];
    const check = await api().post('/api/v1/vouchers/check').set(guest).send({ code, restaurantId: rid, items }).expect(200);
    expect(check.body).toMatchObject({ valid: true, discount: 20000 }); // 20% of 100k food, beer excluded

    const b = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `v1-${run}`)
      .send({ restaurantId: rid, arrivalAt: await slot('12:00'), partySize: 2, paymentMode: 'COD', items, voucherCode: code })
      .expect(200);
    bookingId = b.body.id;
    expect(b.body.order).toMatchObject({ subtotal: 200000, restaurantDiscount: 20000, platformDiscount: 0, total: 180000 });

    const again = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `v2-${run}`)
      .send({ restaurantId: rid, arrivalAt: await slot('13:00'), partySize: 2, paymentMode: 'COD', items, voucherCode: code })
      .expect(422);
    expect(again.body.error).toMatchObject({ code: 'VOUCHER_INVALID', details: { problem: 'ALREADY_USED' } });

    const temp = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `v3-${run}`)
      .send({ restaurantId: rid, arrivalAt: await slot('14:00'), partySize: 2, paymentMode: 'COD', items: [{ menuItemId: foodId, quantity: 1 }] })
      .expect(200);
    await api().post(`/api/v1/bookings/${bookingId}/cancel`).set(guest).send({}).expect(200);
    expect((await prisma.voucher.findUniqueOrThrow({ where: { code } })).usedCount).toBe(0);
    expect(temp.body.order.total).toBe(100000);
  });

  it('platform voucher created by admin is paid back on the statement (platformDiscount)', async () => {
    const now = Date.now();
    const pcode = `COMI${run.slice(-4).toUpperCase()}`;
    await api()
      .post('/api/v1/admin/vouchers')
      .set(admin)
      .send({ code: pcode, type: 'FIXED', value: 15000, startsAt: new Date(now - 3600_000).toISOString(), endsAt: new Date(now + 86_400_000).toISOString() })
      .expect(201);
    const b = await api()
      .post('/api/v1/bookings')
      .set(guest)
      .set('Idempotency-Key', `v4-${run}`)
      .send({ restaurantId: rid, arrivalAt: await slot('12:00'), partySize: 2, paymentMode: 'COD', items: [{ menuItemId: foodId, quantity: 1 }], voucherCode: pcode })
      .expect(200);
    expect(b.body.order).toMatchObject({ platformDiscount: 15000, restaurantDiscount: 0, total: 85000 });
    bookingId = b.body.id;
  });

  it('reviews: only after the visit, rating updates, one reply, report → admin hides', async () => {
    const early = await api().post(`/api/v1/bookings/${bookingId}/review`).set(guest).send({ rating: 5 }).expect(422);
    expect(early.body.error.code).toBe('REVIEW_NOT_ALLOWED');

    await api().post(`/api/v1/restaurant/bookings/${bookingId}/check-in`).set(owner).expect(200);
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/close`).set(owner).send({}).expect(200);
    const review = await api().post(`/api/v1/bookings/${bookingId}/review`).set(guest).send({ rating: 4, foodRating: 5, text: 'Lẩu ngon, phục vụ nhanh' }).expect(200);
    expect(review.body).toMatchObject({ rating: 4, verifiedVisit: true });
    await api().post(`/api/v1/bookings/${bookingId}/review`).set(guest).send({ rating: 1 }).expect(409);

    const page = await api().get(`/api/v1/restaurants/${rid}/reviews`).expect(200);
    expect(page.body).toMatchObject({ ratingAvg: 4, ratingCount: 1, histogram: [0, 0, 0, 1, 0] });

    await api().post(`/api/v1/restaurant/reviews/${review.body.id}/reply`).set(owner).send({ reply: 'Cảm ơn anh chị!' }).expect(200);
    await api().post(`/api/v1/restaurant/reviews/${review.body.id}/reply`).set(owner).send({ reply: 'Lần 2' }).expect(409);
    await api().post(`/api/v1/restaurant/reviews/${review.body.id}/report`).set(owner).send({ reason: 'Khách không ăn ở đây' }).expect(200);

    const reported = await api().get('/api/v1/admin/reviews/reported').set(admin).expect(200);
    expect(reported.body.map((r: { id: string }) => r.id)).toContain(review.body.id);
    await api().post(`/api/v1/admin/reviews/${review.body.id}/decision`).set(admin).send({ hide: true }).expect(200);
    const after = await api().get(`/api/v1/restaurants/${rid}/reviews`).expect(200);
    expect(after.body).toMatchObject({ ratingAvg: 0, ratingCount: 0, items: [] });
  });

  it('notification center: review prompt after the meal, none for the guest’s own cancel, mark read', async () => {
    const page = await api().get('/api/v1/notifications').set(guest).expect(200);
    const types = page.body.items.map((n: { type: string }) => n.type);
    expect(types).toContain('review.ask');
    expect(types).not.toContain('booking.cancelled');
    expect(page.body.unread).toBeGreaterThan(0);
    const r = await api().post('/api/v1/notifications/read-all').set(guest).expect(200);
    expect(r.body.unread).toBe(0);
  });

  it('translation editor: rows per dish, human translation shown to English guests', async () => {
    const before = await api().get('/api/v1/restaurant/menu/translations').query({ locale: 'en' }).set(owner).expect(200);
    expect(before.body.find((r: { itemId: string }) => r.itemId === foodId)).toMatchObject({ sourceName: 'Lẩu', state: 'none' });
    await api().put(`/api/v1/restaurant/menu/items/${foodId}/translations/en`).set(owner).send({ name: 'Hotpot' }).expect(200);
    const after = await api().get('/api/v1/restaurant/menu/translations').query({ locale: 'en' }).set(owner).expect(200);
    expect(after.body.find((r: { itemId: string }) => r.itemId === foodId)).toMatchObject({ name: 'Hotpot', state: 'human' });
    const menu = await api().get(`/api/v1/restaurants/${rid}/menu`).set('Accept-Language', 'en').expect(200);
    const dish = menu.body.flatMap((c: { items: unknown[] }) => c.items).find((i: { id: string }) => i.id === foodId);
    expect(dish).toMatchObject({ name: 'Hotpot', originalName: 'Lẩu', translated: 'human' });
  });
});
