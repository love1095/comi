// Browsing at lunch peak: home → nearby list → restaurant detail + menu → availability.
import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE = `${__ENV.BASE}/api/v1`;
const RID = __ENV.RESTAURANT_ID;

export const options = {
  stages: [
    { duration: '1m', target: 50 },
    { duration: '3m', target: 200 },
    { duration: '1m', target: 0 },
  ],
  thresholds: { http_req_failed: ['rate<0.01'], 'http_req_duration{kind:read}': ['p(95)<300'] },
};

const tags = { kind: 'read' };

export default function () {
  const lat = 10.77 + Math.random() * 0.02;
  const lng = 106.69 + Math.random() * 0.02;
  check(http.get(`${BASE}/home?lat=${lat}&lng=${lng}`, { tags }), { home: (r) => r.status === 200 });
  check(http.get(`${BASE}/restaurants?lat=${lat}&lng=${lng}&mode=lunch`, { tags }), { nearby: (r) => r.status === 200 });
  check(http.get(`${BASE}/restaurants/${RID}/menu`, { tags }), { menu: (r) => r.status === 200 });
  const date = new Date(Date.now() + 86_400_000).toISOString().slice(0, 10);
  check(http.get(`${BASE}/restaurants/${RID}/availability?date=${date}&partySize=4`, { tags }), { slots: (r) => r.status === 200 });
  sleep(1 + Math.random() * 2);
}
