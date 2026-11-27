/**
 * API e2e: starts the compiled server (dist/main.js) as a real process against Postgres.
 * Prereqs: docker compose up -d, npm run db:deploy. Run: npm run test:e2e (builds first).
 * (Running the app in-process under Jest breaks on ESM-only deps of pdfkit / firebase-admin.)
 */
import { PrismaClient } from '@prisma/client';
import { ChildProcess, spawn } from 'child_process';
import { join } from 'path';
import request from 'supertest';

const PORT = 3999;
const BASE = `http://localhost:${PORT}`;

async function waitForHealth(timeoutMs = 20_000) {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    try {
      const res = await fetch(`${BASE}/api/v1/health`);
      if (res.ok) return;
    } catch {
      /* not up yet */
    }
    await new Promise((r) => setTimeout(r, 300));
  }
  throw new Error('API did not start');
}

describe('comi API (e2e)', () => {
  let server: ChildProcess;
  const prisma = new PrismaClient();
  const run = Date.now().toString(36);
  const api = () => request(BASE);

  beforeAll(async () => {
    server = spawn(process.execPath, [join(__dirname, '..', 'dist', 'main.js')], {
      env: { ...process.env, NODE_ENV: 'test', PORT: String(PORT) },
      stdio: ['ignore', 'ignore', 'inherit'],
    });
    await waitForHealth();
  });

  afterAll(async () => {
    server?.kill();
    await prisma.$disconnect();
  });

  async function staffToken(label: string) {
    const res = await api()
      .post('/api/v1/auth/staff/register')
      .send({ email: `${label}-${run}@test.comi.vn`, password: 'password123', name: label })
      .expect(201);
    return res.body as { accessToken: string; refreshToken: string };
  }

  it('GET /health', async () => {
    const res = await api().get('/api/v1/health').expect(200);
    expect(res.body.db).toBe('up');
  });

  it('rejects requests without a token using the standard error format', async () => {
    const res = await api().get('/api/v1/me').expect(401);
    expect(res.body).toEqual({ error: { code: 'UNAUTHENTICATED', message: 'UNAUTHENTICATED', details: {} } });
  });

  it('customer exchange (dev token) → /me → refresh rotation → reuse detection', async () => {
    const ex = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:u-${run}:+8490${run.slice(-7)}` }).expect(200);
    expect(ex.body.isNewUser).toBe(true);
    await api().get('/api/v1/me').set('Authorization', `Bearer ${ex.body.accessToken}`).expect(200);

    const r1 = await api().post('/api/v1/auth/refresh').send({ refreshToken: ex.body.refreshToken }).expect(200);
    expect(r1.body.refreshToken).not.toBe(ex.body.refreshToken);

    // Using the old token again revokes the family, including the new one.
    await api().post('/api/v1/auth/refresh').send({ refreshToken: ex.body.refreshToken }).expect(401);
    await api().post('/api/v1/auth/refresh').send({ refreshToken: r1.body.refreshToken }).expect(401);
  });

  it('staff: register restaurant → tables → menu → submit → admin approves', async () => {
    const owner = await staffToken('owner');
    const auth = { Authorization: `Bearer ${owner.accessToken}` };

    const reg = await api()
      .post('/api/v1/restaurant/register')
      .set(auth)
      .send({ name: `Quán Test ${run}`, phone: '0901234567', address: '1 Lê Lợi, Q1', provinceCode: '79', priceLevel: 2, lat: 10.77, lng: 106.7 })
      .expect(201);
    const rid: string = reg.body.id;
    expect(reg.body.status).toBe('DRAFT');
    expect(reg.body.lat).toBeCloseTo(10.77);
    const h = { ...auth, 'X-Restaurant-Id': rid };

    const check = await api().get('/api/v1/restaurant/checklist').set(h).expect(200);
    expect(check.body.missing).toEqual(['openingHours', 'tables', 'menuItems']);
    await api().post('/api/v1/restaurant/submit').set(h).expect(422);

    await api()
      .put('/api/v1/restaurant/opening-hours')
      .set(h)
      .send({ items: [{ weekday: 1, openMinute: 600, closeMinute: 1320 }] })
      .expect(200);

    const area = await api().post('/api/v1/restaurant/areas').set(h).send({ name: 'Indoor' }).expect(201);
    const layout = await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(h)
      .send({
        tables: [
          { code: 'a1', maxSeats: 4, posX: 0, posY: 0 },
          { code: 'A2', maxSeats: 4, posX: 3, posY: 0 },
        ],
        elements: [{ type: 'ENTRANCE', x: 18, y: 12 }],
      })
      .expect(200);
    expect(layout.body.tables.map((t: { code: string }) => t.code)).toEqual(['A1', 'A2']);
    expect(layout.body.tables[0].qrSecret).toBeUndefined();

    // Overlapping tables are rejected.
    const bad = await api()
      .put(`/api/v1/restaurant/areas/${area.body.id}/layout`)
      .set(h)
      .send({ tables: [{ code: 'A1', maxSeats: 4, posX: 0, posY: 0 }, { code: 'A2', maxSeats: 4, posX: 1, posY: 1 }], elements: [] })
      .expect(422);
    expect(bad.body.error.code).toBe('LAYOUT_INVALID');

    const qr = await api().get(`/api/v1/restaurant/tables/${layout.body.tables[0].id}/qr`).set(h).expect(200);
    expect(qr.headers['content-type']).toContain('image/png');
    const pdf = await api().get('/api/v1/restaurant/qr/print').set(h).expect(200);
    expect(pdf.headers['content-type']).toContain('application/pdf');

    const cat = await api().post('/api/v1/restaurant/menu/categories').set(h).send({ name: 'Món chính' }).expect(201);
    const item = await api()
      .post('/api/v1/restaurant/menu/items')
      .set(h)
      .send({
        categoryId: cat.body.id,
        name: 'Bò lúc lắc',
        price: 120000,
        optionGroups: [{ name: 'Size', minSelect: 1, maxSelect: 1, options: [{ name: 'Vừa' }, { name: 'Lớn', priceDelta: 30000 }] }],
      })
      .expect(201);
    expect(item.body.optionGroups[0].options).toHaveLength(2);
    await api().patch(`/api/v1/restaurant/menu/items/${item.body.id}/availability`).set(h).send({ isAvailable: false }).expect(200);

    const submitted = await api().post('/api/v1/restaurant/submit').set(h).expect(200);
    expect(submitted.body.status).toBe('PENDING_REVIEW');

    // Owner is not an admin.
    await api().post(`/api/v1/admin/restaurants/${rid}/approve`).set(auth).expect(403);

    const admin = await staffToken('admin');
    await prisma.staffUser.update({ where: { email: `admin-${run}@test.comi.vn` }, data: { isAdmin: true } });
    const adminLogin = await api()
      .post('/api/v1/auth/staff/login')
      .send({ email: `admin-${run}@test.comi.vn`, password: 'password123' })
      .expect(200);
    expect(admin.accessToken).toBeDefined();
    const approved = await api()
      .post(`/api/v1/admin/restaurants/${rid}/approve`)
      .set('Authorization', `Bearer ${adminLogin.body.accessToken}`)
      .expect(200);
    expect(approved.body.status).toBe('ACTIVE');
  });

  it('roles: another staff cannot touch a restaurant they do not belong to', async () => {
    const a = await staffToken('a');
    const b = await staffToken('b');
    const reg = await api()
      .post('/api/v1/restaurant/register')
      .set('Authorization', `Bearer ${a.accessToken}`)
      .send({ name: `Quán A ${run}`, phone: '0901234567', address: '2 Lê Lợi, Q1', provinceCode: '79', priceLevel: 1 })
      .expect(201);
    const res = await api()
      .get('/api/v1/restaurant/menu')
      .set({ Authorization: `Bearer ${b.accessToken}`, 'X-Restaurant-Id': reg.body.id })
      .expect(403);
    expect(res.body.error.code).toBe('NOT_A_MEMBER');
  });

  it('customers cannot call staff endpoints', async () => {
    const ex = await api().post('/api/v1/auth/customer/exchange').send({ idToken: `dev:c-${run}` }).expect(200);
    await api().get('/api/v1/restaurant/me').set('Authorization', `Bearer ${ex.body.accessToken}`).expect(403);
  });
});
