/**
 * Admin website API: 2FA login with replay protection, dashboard, guest search / block / unblock,
 * booking lookup by code, audit log.
 */
import { PrismaClient } from '@prisma/client';
import request from 'supertest';
import { totp } from '../src/modules/auth/totp';
import { adminSession, startServer } from './helpers';

jest.setTimeout(60_000);

describe('Admin (e2e)', () => {
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  let base: string;
  let stop: () => void;
  const api = () => request(base);
  let admin: { Authorization: string };
  let guest: Record<string, string>;
  let guestId: string;
  const phone = `+8493${String(Date.now()).slice(-7)}`;

  beforeAll(async () => {
    ({ base, stop } = await startServer(3995));
    await api().post('/api/v1/auth/staff/register').send({ email: `adm-${run}@test.comi.vn`, password: 'password123', name: 'Admin' }).expect(201);
    admin = await adminSession(base, prisma, `adm-${run}@test.comi.vn`);
    const g = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:adm-${run}:${phone}` }).expect(200);
    guest = { Authorization: `Bearer ${g.body.accessToken}` };
    guestId = (await api().get('/api/v1/me').set(guest).expect(200)).body.id;
  });

  afterAll(async () => {
    stop?.();
    await prisma.$disconnect();
  });

  it('2FA: wrong code refused, a code works only once, setup-only session cannot use admin routes', async () => {
    await api().post('/api/v1/auth/staff/register').send({ email: `adm2-${run}@test.comi.vn`, password: 'password123', name: 'A2' }).expect(201);
    await prisma.staffUser.update({ where: { email: `adm2-${run}@test.comi.vn` }, data: { isAdmin: true } });
    const setupSession = await api().post('/api/v1/auth/admin/login').send({ email: `adm2-${run}@test.comi.vn`, password: 'password123' }).expect(200);
    expect(setupSession.body.mfa).toBe(false);
    const blocked = await api().get('/api/v1/admin/dashboard').set('Authorization', `Bearer ${setupSession.body.accessToken}`).expect(403);
    expect(blocked.body.error.code).toBe('MFA_REQUIRED');

    const auth = { Authorization: `Bearer ${setupSession.body.accessToken}` };
    const { secret } = (await api().post('/api/v1/auth/admin/mfa/setup').set(auth).expect(200)).body;
    await api().post('/api/v1/auth/admin/mfa/enable').set(auth).send({ code: '000000' }).expect(401);
    await api().post('/api/v1/auth/admin/mfa/enable').set(auth).send({ code: totp(secret, new Date()) }).expect(204);
    await api().post('/api/v1/auth/admin/mfa/setup').set(auth).expect(409);

    const code = totp(secret, new Date());
    const ok = await api().post('/api/v1/auth/admin/login').send({ email: `adm2-${run}@test.comi.vn`, password: 'password123', code }).expect(200);
    expect(ok.body.mfa).toBe(true);
    const replay = await api().post('/api/v1/auth/admin/login').send({ email: `adm2-${run}@test.comi.vn`, password: 'password123', code }).expect(401);
    expect(replay.body.error.code).toBe('MFA_CODE_INVALID');

    // Refresh keeps the 2FA session.
    const r = await api().post('/api/v1/auth/refresh').send({ refreshToken: ok.body.refreshToken }).expect(200);
    await api().get('/api/v1/admin/dashboard').set('Authorization', `Bearer ${r.body.accessToken}`).expect(200);
    // Non-admin staff cannot use the admin login.
    await api().post('/api/v1/auth/staff/register').send({ email: `staff-${run}@test.comi.vn`, password: 'password123', name: 'S' }).expect(201);
    await api().post('/api/v1/auth/admin/login').send({ email: `staff-${run}@test.comi.vn`, password: 'password123' }).expect(401);
  });

  it('dashboard numbers', async () => {
    const d = await api().get('/api/v1/admin/dashboard').set(admin).expect(200);
    expect(d.body).toMatchObject({ bookingsToday: expect.any(Number), gmvMonth: expect.any(Number), restaurants: expect.any(Object) });
    expect(d.body.newUsersMonth).toBeGreaterThan(0);
  });

  it('find a guest by phone, block (sessions end), reset no-shows, unblock; audit shows it', async () => {
    const found = await api().get('/api/v1/admin/users').query({ q: `0${phone.slice(3)}` }).set(admin).expect(200);
    expect(found.body.map((u: { id: string }) => u.id)).toContain(guestId);

    await prisma.user.update({ where: { id: guestId }, data: { noShowCount: 3, mustPrepay: true } });
    const b = await api().post(`/api/v1/admin/users/${guestId}/block`).set(admin).send({ blocked: true, reason: 'fake bookings' }).expect(200);
    expect(b.body.status).toBe('BLOCKED');
    await api().get('/api/v1/me').set(guest).expect(401);

    const reset = await api().post(`/api/v1/admin/users/${guestId}/reset-no-show`).set(admin).expect(200);
    expect(reset.body).toMatchObject({ noShowCount: 0, mustPrepay: false });
    await api().post(`/api/v1/admin/users/${guestId}/block`).set(admin).send({ blocked: false }).expect(200);

    const audit = await api().get('/api/v1/admin/audit').query({ entity: 'User', entityId: guestId }).set(admin).expect(200);
    expect(audit.body.map((a: { action: string }) => a.action)).toEqual(expect.arrayContaining(['user.block', 'user.reset_no_show', 'user.unblock']));
  });

  it('booking lookup needs a filter', async () => {
    await api().get('/api/v1/admin/bookings').set(admin).expect(400);
    const r = await api().get('/api/v1/admin/bookings').query({ code: 'NOPE00' }).set(admin).expect(200);
    expect(r.body).toEqual([]);
  });
});
