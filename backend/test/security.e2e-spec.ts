/**
 * Phase 6 security pass (§23): every protected route in the OpenAPI spec refuses anonymous
 * calls; customers cannot use staff routes (and the reverse); staff cannot reach another
 * restaurant; guests cannot see each other's bookings; owners are not admins; account deletion.
 */
import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { startServer, vnDate } from './helpers';

jest.setTimeout(120_000);

type Spec = { paths: Record<string, Record<string, { security?: unknown[] }>> };
const spec = JSON.parse(readFileSync(join(__dirname, '..', 'openapi.json'), 'utf8')) as Spec;
const ZERO = '00000000-0000-4000-8000-000000000000';
const fill = (path: string) => path.replace(/\{[^}]+\}/g, ZERO);

const protectedOps = Object.entries(spec.paths).flatMap(([path, ops]) =>
  Object.entries(ops)
    .filter(([, op]) => op.security)
    .map(([method, op]) => ({ method, path, staff: JSON.stringify(op).includes('X-Restaurant-Id') })),
);

describe('Phase 6 security (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);
  const call = (method: string, path: string) => (api() as unknown as Record<string, (p: string) => request.Test>)[method](path);

  let ownerA: Record<string, string>;
  let ownerB: Record<string, string>;
  let guest1: Record<string, string>;
  let guest2: Record<string, string>;
  let ridA: string;
  let ridB: string;

  const register = async (tag: string) => {
    const reg = await api().post('/api/v1/auth/staff/register').send({ email: `${tag}-${run}@test.comi.vn`, password: 'password123', name: tag }).expect(201);
    const h: Record<string, string> = { Authorization: `Bearer ${reg.body.accessToken}` };
    const r = await api()
      .post('/api/v1/restaurant/register')
      .set(h)
      .send({ name: `Quán ${tag} ${run}`, phone: '0901234567', address: '1 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1, lat: 10.77, lng: 106.7 })
      .expect(201);
    h['X-Restaurant-Id'] = r.body.id;
    return { h, rid: r.body.id as string };
  };

  const guest = async (n: string) => {
    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:sec${n}-${run}:+8490${n}${run.slice(-5).replace(/\D/g, '0').padEnd(6, '0').slice(0, 6)}` }).expect(200);
    return { Authorization: `Bearer ${g.body.accessToken}` };
  };

  beforeAll(async () => {
    ({ base, stop } = await startServer(3994));
    ({ h: ownerA, rid: ridA } = await register('secA'));
    ({ h: ownerB, rid: ridB } = await register('secB'));
    guest1 = await guest('1');
    guest2 = await guest('2');
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it(`all ${protectedOps.length} protected routes answer 401 without a token`, async () => {
    expect(protectedOps.length).toBeGreaterThan(100);
    const leaks: string[] = [];
    for (const op of protectedOps) {
      const res = await call(op.method, `${fill(op.path)}`).send({});
      if (res.status !== 401) leaks.push(`${op.method.toUpperCase()} ${op.path} → ${res.status}`);
    }
    expect(leaks).toEqual([]);
  });

  it('a garbage or customer token cannot use staff routes', async () => {
    const leaks: string[] = [];
    for (const op of protectedOps.filter((o) => o.staff && o.method === 'get')) {
      const res = await call(op.method, fill(op.path)).set({ ...guest1, 'X-Restaurant-Id': ridA });
      if (![401, 403].includes(res.status)) leaks.push(`${op.path} → ${res.status}`);
    }
    expect(leaks).toEqual([]);
    await api().get('/api/v1/me').set({ Authorization: 'Bearer not-a-jwt' }).expect(401);
  });

  it('staff tokens cannot use customer routes', async () => {
    const res = await api().get('/api/v1/me').set({ Authorization: ownerA.Authorization });
    expect([401, 403]).toContain(res.status);
  });

  it('staff of restaurant A cannot read or change restaurant B', async () => {
    const asAforB = { Authorization: ownerA.Authorization, 'X-Restaurant-Id': ridB };
    await api().get('/api/v1/restaurant/profile').set(asAforB).expect(403);
    await api().get('/api/v1/restaurant/bookings').set(asAforB).expect(403);
    await api().patch('/api/v1/restaurant/profile').set(asAforB).send({ name: 'hacked' }).expect(403);
    await api().get('/api/v1/restaurant/profile').set(ownerB).expect(200);
  });

  it('an owner is not a platform admin', async () => {
    await api().get('/api/v1/admin/restaurants').set({ Authorization: ownerA.Authorization }).expect(403);
    await api().get('/api/v1/admin/reviews/reported').set({ Authorization: ownerA.Authorization }).expect(403);
  });

  it("guests cannot see each other's bookings; deletion waits for active bookings", async () => {
    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(ownerA)
      .send({ items: [0, 1, 2, 3, 4, 5, 6].map((weekday) => ({ weekday, openMinute: 600, closeMinute: 1320 })) })
      .expect(200);
    const area = await api().post('/api/v1/restaurant/areas').set(ownerA).send({ name: 'Trong nhà' }).expect(201);
    await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(ownerA)
      .send({ tables: [{ code: 'A1', minSeats: 1, maxSeats: 4, posX: 0, posY: 0 }], elements: [] })
      .expect(200);
    await prisma.restaurant.update({ where: { id: ridA }, data: { status: 'ACTIVE' } });
    const slots = await api().get(`/api/v1/restaurants/${ridA}/availability`).query({ date: vnDate(1), partySize: 2 }).expect(200);
    const b = await api()
      .post('/api/v1/bookings')
      .set(guest1)
      .set('Idempotency-Key', `sec-${run}`)
      .send({ restaurantId: ridA, arrivalAt: slots.body[0].time, partySize: 2, paymentMode: 'COD' })
      .expect(200);
    await api().get(`/api/v1/bookings/${b.body.id}`).set(guest2).expect(404);
    await api().post(`/api/v1/bookings/${b.body.id}/cancel`).set(guest2).send({}).expect(404);

    const del = await api().delete('/api/v1/me').set(guest1).expect(409);
    expect(del.body.error.code).toBe('ACTIVE_BOOKINGS');
    await api().post(`/api/v1/bookings/${b.body.id}/cancel`).set(guest1).send({}).expect(200);
    await api().post('/api/v1/me/consent').set(guest1).send({ termsVersion: '2026-12', marketing: false }).expect(200);
    const exp = await api().get('/api/v1/me/export').set(guest1).expect(200);
    expect(exp.body.user.bookings).toHaveLength(1);
    await api().delete('/api/v1/me').set(guest1).expect(204);
    await api().get('/api/v1/me').set(guest1).expect(401);
  });

  it('staff account deletion: sole owner must hand over first', async () => {
    const res = await api().delete('/api/v1/auth/staff/me').set({ Authorization: ownerB.Authorization }).expect(409);
    expect(res.body.error.code).toBe('SOLE_OWNER');
    const extra = await api().post('/api/v1/auth/staff/register').send({ email: `secC-${run}@test.comi.vn`, password: 'password123', name: 'C' }).expect(201);
    await api().delete('/api/v1/auth/staff/me').set({ Authorization: `Bearer ${extra.body.accessToken}` }).expect(204);
    await api().post('/api/v1/auth/staff/login').send({ email: `secC-${run}@test.comi.vn`, password: 'password123' }).expect(401);
  });

  it('legal pages are public HTML', async () => {
    const res = await api().get('/api/v1/legal/privacy').query({ lang: 'en' }).expect(200);
    expect(res.headers['content-type']).toContain('text/html');
    expect(res.text).toContain('Privacy policy');
  });
});
