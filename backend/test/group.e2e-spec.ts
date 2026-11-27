/**
 * Phase 3b flow against real Postgres + Redis: host starts a group order → friend joins by
 * name (no account) → everyone adds dishes → keys protect each person's dishes → web page →
 * host locks → staff check-in + close → split by items → "paid in cash".
 */
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

describe('Phase 3b group order + split bill (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);

  let owner: Record<string, string>;
  let host: Record<string, string>;
  let rid: string;
  let phoId: string;
  let teaId: string;
  let bookingId: string;
  let token: string;
  let hostKey: string;
  let friendKey: string;
  let friendId: string;

  beforeAll(async () => {
    ({ base, stop } = await startServer(3996));
    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `p3b-${run}@test.comi.vn`, password: 'password123', name: 'Owner' }).expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Nhóm ${run}`, phone: '0901234567', address: '1 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.7731, lng: 106.7006 })
      .expect(201);
    rid = r.body.id;
    owner['X-Restaurant-Id'] = rid;
    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(owner)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    await api().patch('/api/v1/restaurant/settings').set(owner).send({ confirmGroupsOver: 20 }).expect(200);
    const area = await api().post('/api/v1/restaurant/areas').set(owner).send({ name: 'Trong nhà' }).expect(201);
    await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(owner)
      .send({ tables: [{ code: 'A1', minSeats: 1, maxSeats: 6, posX: 0, posY: 0 }], elements: [] })
      .expect(200);
    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Cơm' }).expect(201);
    phoId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Phở bò', price: 55000 }).expect(201)).body.id;
    teaId = (await api().post('/api/v1/restaurant/menu/items').set(owner).send({ categoryId: cat.body.id, name: 'Trà đá', price: 5000, course: 'DRINK' }).expect(201)).body.id;
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);
    await prisma.restaurant.update({ where: { id: rid }, data: { status: 'ACTIVE' } });

    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:p3b-${run}:+84903334455` }).expect(200);
    host = { Authorization: `Bearer ${g.body.accessToken}` };
    const slots = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: vnDate(1), partySize: 3 }).expect(200);
    const noon = slots.body.find((s: { local: string }) => s.local === '12:00');
    const b = await api()
      .post('/api/v1/bookings')
      .set(host)
      .set('Idempotency-Key', `p3b-${run}`)
      .send({ restaurantId: rid, arrivalAt: noon.time, partySize: 3, paymentMode: 'COD', items: [{ menuItemId: teaId, quantity: 3 }] })
      .expect(200);
    bookingId = b.body.id;
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it('host starts a group order; the pre-order becomes the host\'s', async () => {
    const res = await api().post(`/api/v1/bookings/${bookingId}/group`).set(host).send({}).expect(200);
    token = res.body.token;
    hostKey = res.body.guestKey;
    expect(res.body.link).toMatch(new RegExp(`/g/${token}$`));
    expect(res.body.guests).toHaveLength(1);
    expect(res.body.guests[0]).toMatchObject({ isHost: true, subtotal: 15000 });
    const again = await api().post(`/api/v1/bookings/${bookingId}/group`).set(host).send({}).expect(200);
    expect(again.body.token).toBe(token); // idempotent
    hostKey = again.body.guestKey; // re-issued
  });

  it('a friend joins by name and adds dishes; keys protect each person\'s dishes', async () => {
    const joined = await api().post(`/api/v1/groups/${token}/join`).send({ displayName: 'Lan' }).expect(200);
    friendKey = joined.body.guestKey;
    friendId = joined.body.guestId;

    const added = await api().post(`/api/v1/groups/${token}/items`).send({ guestKey: friendKey, items: [{ menuItemId: phoId, quantity: 1 }] }).expect(200);
    expect(added.body.guests.find((g: { id: string }) => g.id === friendId).subtotal).toBe(55000);
    expect(added.body.total).toBe(70000);

    const bad = await api().post(`/api/v1/groups/${token}/items`).send({ guestKey: 'not-a-real-key-123', items: [{ menuItemId: phoId, quantity: 1 }] }).expect(403);
    expect(bad.body.error.code).toBe('GUEST_KEY_INVALID');

    const hostDish = added.body.items.find((i: { guestId: string }) => i.guestId !== friendId);
    await api().post(`/api/v1/groups/${token}/items/${hostDish.id}/remove`).send({ guestKey: friendKey }).expect(404); // not hers

    const planned = await prisma.orderItem.findMany({ where: { order: { bookingId }, guestId: friendId } });
    expect(planned[0]).toMatchObject({ kitchenStatus: 'HOLD' });
    expect(planned[0].scheduledStartAt).not.toBeNull();
  });

  it('serves the join page with a strict CSP and rejects odd tokens', async () => {
    const page = await api().get(`/g/${token}`).expect(200);
    expect(page.headers['content-type']).toMatch(/html/);
    expect(page.headers['content-security-policy']).toMatch(/script-src 'nonce-/);
    await api().get('/g/%3Cscript%3E').expect(404);
  });

  it('host locks the order; nobody can join or add after that', async () => {
    const locked = await api().post(`/api/v1/bookings/${bookingId}/group/lock`).set(host).expect(200);
    expect(locked.body.locked).toBe(true);
    const late = await api().post(`/api/v1/groups/${token}/join`).send({ displayName: 'Minh' }).expect(409);
    expect(late.body.error.code).toBe('GROUP_LOCKED');
    await api().post(`/api/v1/groups/${token}/items`).send({ guestKey: hostKey, items: [{ menuItemId: phoId, quantity: 1 }] }).expect(409);
  });

  it('after the meal: split by items, staff marks one guest paid in cash', async () => {
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/check-in`).set(owner).expect(200);
    await api().post(`/api/v1/restaurant/bookings/${bookingId}/close`).set(owner).send({ finalBillAmount: 80000 }).expect(200);

    const split = await api().post(`/api/v1/restaurant/bookings/${bookingId}/split`).set(owner).send({ mode: 'BY_ITEMS' }).expect(200);
    // 10k added off-app is shared: host 15k + 5k, Lan 55k + 5k.
    expect(split.body.total).toBe(80000);
    const lan = split.body.guests.find((g: { id: string }) => g.id === friendId);
    const hostGuest = split.body.guests.find((g: { isHost: boolean }) => g.isHost);
    expect([hostGuest.amountDue, lan.amountDue]).toEqual([20000, 60000]);

    const paid = await api().post(`/api/v1/restaurant/bookings/${bookingId}/guests/${friendId}/paid`).set(owner).send({ paid: true }).expect(200);
    expect(paid.body.paid).toBe(60000);

    const custom = await api().post(`/api/v1/bookings/${bookingId}/split`).set(host).send({ mode: 'CUSTOM', amounts: { [hostGuest.id]: 1000, [friendId]: 1000 } }).expect(422);
    expect(custom.body.error.code).toBe('SPLIT_MISMATCH');
  });
});
