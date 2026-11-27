/**
 * Phase 2 flow against real Postgres + Redis: discovery → availability → booking
 * (COD, pre-order, options, alcohol) → race → joined tables + approval → table map hold →
 * cancel → restaurant board → menu import.
 */
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { adminSession, startServer, vnDate } from './helpers';

jest.setTimeout(60_000);

describe('Phase 2 booking flow (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);

  // shared state
  let owner: Record<string, string>;
  let rid: string;
  let slug: string;
  const tables: Record<string, string> = {};
  let dishId: string;
  let sizeL: string;
  let beerId: string;
  let slots: { time: string; local: string; available: boolean }[];
  const tomorrow = vnDate(1);

  const customer = async (label: string) => {
    const res = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:${label}-${run}` }).expect(200);
    return { Authorization: `Bearer ${res.body.accessToken}` };
  };
  const slotAt = (local: string) => {
    const s = slots.find((x) => x.local === local);
    if (!s) throw new Error(`no slot ${local}`);
    return s.time;
  };

  beforeAll(async () => {
    ({ base, stop } = await startServer(3998));

    // Owner + restaurant + hours + tables + menu, then admin approval.
    const reg = await api()
      .post('/api/v1/auth/staff/register')
      .send({ email: `p2owner-${run}@test.comi.vn`, password: 'password123', name: 'Owner' })
      .expect(201);
    owner = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(owner)
      .send({ name: `Quán Ốc Phở ${run}`, phone: '0901234567', address: '5 Lê Lợi, Q1', provinceCode: '79', priceLevel: 2, lat: 10.7731, lng: 106.7006, cuisineTags: ['nhau'] })
      .expect(201);
    rid = r.body.id;
    slug = r.body.slug;
    owner['X-Restaurant-Id'] = rid;

    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(owner)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    await api().patch('/api/v1/restaurant/settings').set(owner).send({ servesNhau: true, confirmGroupsOver: 8, diningMinutes: 90 }).expect(200);

    const area = await api().post('/api/v1/restaurant/areas').set(owner).send({ name: 'Trong nhà' }).expect(201);
    const layout = await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(owner)
      .send({
        tables: [
          { code: 'A1', minSeats: 2, maxSeats: 4, posX: 0, posY: 0 },
          { code: 'A2', minSeats: 2, maxSeats: 4, posX: 3, posY: 0 },
          { code: 'B1', minSeats: 4, maxSeats: 6, posX: 0, posY: 4, width: 3, joinGroup: 'b' },
          { code: 'B2', minSeats: 4, maxSeats: 6, posX: 4, posY: 4, width: 3, joinGroup: 'b' },
        ],
        elements: [],
      })
      .expect(200);
    for (const t of layout.body.tables) tables[t.code] = t.id;

    const cat = await api().post('/api/v1/restaurant/menu/categories').set(owner).send({ name: 'Món chính' }).expect(201);
    const dish = await api()
      .post('/api/v1/restaurant/menu/items')
      .set(owner)
      .send({
        categoryId: cat.body.id,
        name: 'Phở bò',
        price: 55000,
        optionGroups: [{ name: 'Size', minSelect: 1, maxSelect: 1, options: [{ name: 'Thường' }, { name: 'Lớn', priceDelta: 10000 }] }],
      })
      .expect(201);
    dishId = dish.body.id;
    sizeL = dish.body.optionGroups[0].options.find((o: { name: string }) => o.name === 'Lớn').id;
    const beer = await api()
      .post('/api/v1/restaurant/menu/items')
      .set(owner)
      .send({ categoryId: cat.body.id, name: 'Bia Tiger', price: 22000, course: 'DRINK', kind: 'DRINK', isAlcohol: true })
      .expect(201);
    beerId = beer.body.id;
    await api().put(`/api/v1/restaurant/menu/items/${dishId}/translations/en`).set(owner).send({ name: 'Beef pho' }).expect(200);
    await api().post('/api/v1/restaurant/submit').set(owner).expect(200);

    await api().post('/api/v1/auth/staff/register').send({ email: `p2admin-${run}@test.comi.vn`, password: 'password123', name: 'Admin' }).expect(201);
    const admin = await adminSession(base, prisma, `p2admin-${run}@test.comi.vn`);
    await api().post(`/api/v1/admin/restaurants/${rid}/approve`).set(admin).expect(200);
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it('discovery: nearby with filters, detail, translated menu, accent-insensitive suggest', async () => {
    const near = await api().get('/api/v1/restaurants').query({ lat: 10.7735, lng: 106.701, radius: 500, mode: 'nhau', maxMainPrice: 60000 }).expect(200);
    const card = near.body.items.find((x: { id: string }) => x.id === rid);
    expect(card).toMatchObject({ slug, minMainPrice: 55000 });
    expect(card.distanceM).toBeLessThan(200);

    const tooCheap = await api().get('/api/v1/restaurants').query({ lat: 10.7735, lng: 106.701, maxMainPrice: 30000 }).expect(200);
    expect(tooCheap.body.items.some((x: { id: string }) => x.id === rid)).toBe(false);

    const detail = await api().get(`/api/v1/restaurants/${slug}`).expect(200);
    expect(detail.body).toMatchObject({ id: rid, servesNhau: true, lat: expect.closeTo(10.7731, 4) });

    const menuEn = await api().get(`/api/v1/restaurants/${rid}/menu`).set('Accept-Language', 'en-US,en;q=0.9').expect(200);
    expect(menuEn.body[0].items.find((i: { id: string }) => i.id === dishId)).toMatchObject({ name: 'Beef pho', originalName: 'Phở bò', translated: 'human' });

    const sug = await api().get('/api/v1/search/suggest').query({ q: 'pho bo' }).expect(200);
    expect(sug.body.dishes.some((d: { id: string }) => d.id === dishId)).toBe(true);
  });

  it('availability for tomorrow lists 15-minute slots', async () => {
    const res = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: tomorrow, partySize: 2 }).expect(200);
    slots = res.body;
    expect(slots[0].local).toBe('10:00');
    expect(slots.at(-1)!.local).toBe('20:30'); // 22:00 − 90 min
    expect(slots.every((s) => s.available)).toBe(true);
  });

  it('books with a pre-order: server prices options, needs age confirmation for beer', async () => {
    const me = await customer('alice');
    const body = {
      restaurantId: rid,
      arrivalAt: slotAt('12:00'),
      partySize: 3,
      paymentMode: 'COD',
      items: [
        { menuItemId: dishId, quantity: 2, optionIds: [sizeL] },
        { menuItemId: beerId, quantity: 6 },
      ],
    };
    const noAge = await api().post('/api/v1/bookings').set(me).send(body).expect(422);
    expect(noAge.body.error.code).toBe('AGE_CONFIRMATION_REQUIRED');

    const prepaid = await api().post('/api/v1/bookings').set(me).send({ ...body, paymentMode: 'PREPAID' }).expect(422);
    expect(prepaid.body.error.code).toBe('PAYMENT_NOT_AVAILABLE');

    const ok = await api().post('/api/v1/bookings').set(me).send({ ...body, ageConfirmed: true }).expect(201);
    expect(ok.body).toMatchObject({ status: 'CONFIRMED', paymentMode: 'COD', partySize: 3 });
    expect(ok.body.code).toMatch(/^CM-[A-Z2-9]{5}$/);
    expect(ok.body.order.subtotal).toBe(2 * 65000 + 6 * 22000);
    expect(ok.body.order.items.every((i: { kitchenStatus: string }) => i.kitchenStatus === 'HOLD')).toBe(true);
    expect(['A1', 'A2']).toContain(ok.body.table.code); // smallest table that fits 3

    const bad = await api().post('/api/v1/bookings').set(me).send({ ...body, arrivalAt: slotAt('12:00').replace(':00.000Z', ':07.000Z'), ageConfirmed: true }).expect(422);
    expect(bad.body.error.code).toBe('SLOT_INVALID');
  });

  it('race: 6 parallel bookings for 3 people → exactly 2 succeed (A1, A2), never double-booked', async () => {
    const users = await Promise.all([0, 1, 2, 3, 4, 5].map((i) => customer(`race${i}`)));
    const results = await Promise.all(
      users.map((u) => api().post('/api/v1/bookings').set(u).send({ restaurantId: rid, arrivalAt: slotAt('18:00'), partySize: 3, paymentMode: 'COD' })),
    );
    const ok = results.filter((r) => r.status === 201);
    expect(ok).toHaveLength(2);
    expect(new Set(ok.map((r) => r.body.table.code))).toEqual(new Set(['A1', 'A2']));
    expect(results.filter((r) => r.status === 409).every((r) => r.body.error.code === 'SLOT_TAKEN')).toBe(true);

    // party of 3 at 18:00 now unavailable, still available at 10:00
    const av = await api().get(`/api/v1/restaurants/${rid}/availability`).query({ date: tomorrow, partySize: 3 }).expect(200);
    expect(av.body.find((s: { local: string }) => s.local === '18:00').available).toBe(false);
    expect(av.body.find((s: { local: string }) => s.local === '10:00').available).toBe(true);
  });

  it('idempotency key returns the same booking on retry', async () => {
    const me = await customer('idem');
    const send = () =>
      api().post('/api/v1/bookings').set(me).set('Idempotency-Key', `key-${run}-abc`).send({ restaurantId: rid, arrivalAt: slotAt('10:00'), partySize: 2, paymentMode: 'COD' });
    const a = await send().expect(201);
    const b = await send().expect(201);
    expect(b.body.id).toBe(a.body.id);
  });

  it('large group (20:30): joins B1+B2 and waits for restaurant approval', async () => {
    const me = await customer('group');
    const res = await api().post('/api/v1/bookings').set(me).send({ restaurantId: rid, arrivalAt: slotAt('20:30'), partySize: 10, paymentMode: 'COD' }).expect(201);
    expect(res.body).toMatchObject({ status: 'PENDING', needsApproval: true });
    expect([res.body.tableId, ...res.body.extraTableIds].sort()).toEqual([tables.B1, tables.B2].sort());

    // B2 is now busy even though it is only a joined table
    const other = await customer('group2');
    const clash = await api().post('/api/v1/bookings').set(other).send({ restaurantId: rid, arrivalAt: slotAt('20:30'), partySize: 5, paymentMode: 'COD' }).expect(409);
    expect(clash.body.error.code).toBe('SLOT_TAKEN');

    const approved = await api().post(`/api/v1/restaurant/bookings/${res.body.id}/approve`).set(owner).expect(200);
    expect(approved.body.status).toBe('CONFIRMED');
  });

  it('table map: hold blocks others, booking with holdId gets that table', async () => {
    await api().patch('/api/v1/restaurant/settings').set(owner).send({ allowTableChoice: true }).expect(200);
    const bob = await customer('bob');
    const carol = await customer('carol');
    const time = slotAt('16:30'); // free window: the 12:00 booking holds A1 until 13:30

    const hold = await api().post(`/api/v1/restaurants/${rid}/table-holds`).set(bob).send({ tableIds: [tables.A2], arrivalAt: time, partySize: 2 }).expect(201);
    expect(new Date(hold.body.expiresAt).getTime() - Date.now()).toBeGreaterThan(4 * 60_000);

    const map = await api().get(`/api/v1/restaurants/${rid}/table-map`).set(carol).query({ arrivalAt: time, partySize: 2 }).expect(200);
    const state = Object.fromEntries(map.body.tables.map((t: { code: string; state: string }) => [t.code, t.state]));
    expect(state).toEqual({ A1: 'available', A2: 'held', B1: 'available', B2: 'available' }); // B: joinable

    const steal = await api().post(`/api/v1/restaurants/${rid}/table-holds`).set(carol).send({ tableIds: [tables.A2], arrivalAt: time, partySize: 2 }).expect(409);
    expect(steal.body.error.code).toBe('TABLE_TAKEN');

    const mine = await api().get(`/api/v1/restaurants/${rid}/table-map`).set(bob).query({ arrivalAt: time, partySize: 2 }).expect(200);
    expect(mine.body.tables.find((t: { code: string }) => t.code === 'A2').state).toBe('mine');

    const booked = await api().post('/api/v1/bookings').set(bob).send({ restaurantId: rid, arrivalAt: time, partySize: 2, paymentMode: 'COD', holdId: hold.body.holdId }).expect(201);
    expect(booked.body.table.code).toBe('A2');
    expect(await prisma.tableHold.count({ where: { holdId: hold.body.holdId } })).toBe(0);

    const reuse = await api().post('/api/v1/bookings').set(bob).send({ restaurantId: rid, arrivalAt: time, partySize: 2, paymentMode: 'COD', holdId: hold.body.holdId }).expect(409);
    expect(reuse.body.error.code).toBe('HOLD_INVALID');
  });

  it('cancel frees the table; others cannot see or cancel my booking', async () => {
    const dave = await customer('dave');
    const eve = await customer('eve');
    const b = await api().post('/api/v1/bookings').set(dave).send({ restaurantId: rid, arrivalAt: slotAt('14:00'), partySize: 4, paymentMode: 'COD' }).expect(201);

    await api().get(`/api/v1/bookings/${b.body.id}`).set(eve).expect(404);
    await api().post(`/api/v1/bookings/${b.body.id}/cancel`).set(eve).send({}).expect(404);

    const list = await api().get('/api/v1/bookings').set(dave).query({ status: 'upcoming' }).expect(200);
    expect(list.body.items.map((x: { id: string }) => x.id)).toContain(b.body.id);

    const c = await api().post(`/api/v1/bookings/${b.body.id}/cancel`).set(dave).send({ reason: 'Đổi kế hoạch' }).expect(200);
    expect(c.body).toMatchObject({ status: 'CANCELLED', cancelledBy: 'USER' });
    await api().post(`/api/v1/bookings/${b.body.id}/cancel`).set(dave).send({}).expect(409); // already cancelled
  });

  it('restaurant board: list by day, search by code, move table', async () => {
    const board = await api().get('/api/v1/restaurant/bookings').set(owner).query({ date: tomorrow }).expect(200);
    expect(board.body.length).toBeGreaterThanOrEqual(5);
    const first = board.body.find((b: { status: string; table: { code: string } }) => b.status === 'CONFIRMED' && b.table.code === 'A1');

    const byCode = await api().get('/api/v1/restaurant/bookings').set(owner).query({ date: tomorrow, q: first.code }).expect(200);
    expect(byCode.body).toHaveLength(1);

    // 18:00 has A1+A2 taken → moving the 18:00 A1 booking to A2 must fail
    const at18 = board.body.find((b: { arrivalAt: string; table: { code: string } }) => b.arrivalAt === slotAt('18:00') && b.table.code === 'A1');
    const busy = await api().post(`/api/v1/restaurant/bookings/${at18.id}/move-table`).set(owner).send({ tableId: tables.A2 }).expect(409);
    expect(busy.body.error.code).toBe('TABLE_TAKEN');

    const moved = await api().post(`/api/v1/restaurant/bookings/${at18.id}/move-table`).set(owner).send({ tableId: tables.B1 }).expect(200);
    expect(moved.body.table.code).toBe('B1');
  });

  it('menu import: preview shows errors, confirm creates dishes and categories', async () => {
    const csv = 'Danh mục,Tên món,Giá,Loại\nMồi nhậu,Ốc hương,120k,Khai vị\nĐồ uống,Trà đá,5000,Đồ uống\n';
    const bad = 'Danh mục,Tên món,Giá\nMồi nhậu,Ốc len,abc\n';
    const preview = await api().post('/api/v1/restaurant/menu/import/preview').set(owner).attach('file', Buffer.from(bad), 'menu.csv').expect(200);
    expect(preview.body.errors[0]).toMatchObject({ row: 2, column: 'price' });
    await api().post('/api/v1/restaurant/menu/import/confirm').set(owner).attach('file', Buffer.from(bad), 'menu.csv').expect(400);

    const done = await api().post('/api/v1/restaurant/menu/import/confirm').set(owner).attach('file', Buffer.from(csv), 'menu.csv').expect(201);
    expect(done.body).toEqual({ created: 2, categories: 3 });
    const tpl = await api().get('/api/v1/restaurant/menu/import/template').set(owner).expect(200);
    expect(tpl.headers['content-type']).toContain('spreadsheetml');
  });

  it('favorites and "my usual"', async () => {
    const me = await customer('fav');
    await api().post('/api/v1/me/favorites').set(me).send({ menuItemId: dishId }).expect(204);
    const favs = await api().get('/api/v1/me/favorites').set(me).expect(200);
    expect(favs.body[0].menuItem.id).toBe(dishId);
    const saved = await api()
      .put('/api/v1/me/saved-orders')
      .set(me)
      .send({ restaurantId: rid, items: [{ menuItemId: dishId, quantity: 1, optionIds: [sizeL] }] })
      .expect(200);
    expect(saved.body.name).toBe('My usual');
  });
});
