// Many guests booking the same restaurant at once. Checks nobody gets a table twice (§8.3).
import http from 'k6/http';
import { check } from 'k6';
import { Counter } from 'k6/metrics';

const BASE = `${__ENV.BASE}/api/v1`;
const RID = __ENV.RESTAURANT_ID;
const conflicts = new Counter('booking_conflicts');

export const options = {
  scenarios: { rush: { executor: 'per-vu-iterations', vus: 100, iterations: 3, maxDuration: '3m' } },
  thresholds: { 'http_req_duration{kind:book}': ['p(95)<800'], http_req_failed: ['rate<0.05'] },
};

export function setup() {
  const date = new Date(Date.now() + 2 * 86_400_000).toISOString().slice(0, 10);
  const slots = http.get(`${BASE}/restaurants/${RID}/availability?date=${date}&partySize=2`).json();
  return { slots: slots.filter((s) => s.available).map((s) => s.time) };
}

export default function (data) {
  const uid = `load-${__VU}-${__ITER}`;
  const phone = `+849${String(10_000_000 + __VU * 10 + __ITER).slice(-8)}`;
  const login = http.post(`${BASE}/auth/customer/exchange`, JSON.stringify({ idToken: `dev:${uid}:${phone}` }), {
    headers: { 'Content-Type': 'application/json' },
  });
  if (!check(login, { login: (r) => r.status === 200 })) return;
  const slot = data.slots[Math.floor(Math.random() * data.slots.length)];
  const res = http.post(`${BASE}/bookings`, JSON.stringify({ restaurantId: RID, arrivalAt: slot, partySize: 2, paymentMode: 'COD' }), {
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${login.json('accessToken')}`, 'Idempotency-Key': uid },
    tags: { kind: 'book' },
  });
  // 200 booked, 409 full: both are correct answers under load. Anything else is a bug.
  check(res, { 'booked or full': (r) => r.status === 200 || r.status === 409 });
  if (res.status === 409) conflicts.add(1);
}

// After the run (overlapping bookings on one table must not exist):
//   SELECT a.id, b.id FROM "Booking" a JOIN "Booking" b ON a."tableId" = b."tableId" AND a.id < b.id
//   WHERE a.status IN ('PENDING','CONFIRMED') AND b.status IN ('PENDING','CONFIRMED')
//     AND a."arrivalAt" < b."arrivalAt" + interval '90 minutes' AND b."arrivalAt" < a."arrivalAt" + interval '90 minutes';  → no rows.
