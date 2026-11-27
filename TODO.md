# comi — TODO

Full design and details: [docs/TECHNICAL_SPEC.md](docs/TECHNICAL_SPEC.md) (section numbers § below point there).

First version (MVP) = **office lunch + nhậu groups** in one office district. Tourists in Phase 5. Special occasions and refunds come after.

---

## Phase 0 — Business setup (start now, alongside coding)

- [ ] Register company
- [ ] Apple Developer + Google Play Console accounts
- [ ] PayOS account for testing; MoMo / VNPay / ZaloPay merchant applications
- [ ] Register e-commerce platform with Ministry of Industry and Trade (online.gov.vn)
- [ ] Ask a lawyer: Decree 13/2023 (personal data), Decree 53/2022 (data in Vietnam), alcohol law, partner contract (fees, refunds)
- [ ] Choose app name + domain
- [ ] Choose launch district; list 20–30 target restaurants (lunch + nhậu)

## Phase 1 — Foundation (4–6 weeks)

- [x] Monorepo, Docker Compose (PostGIS, Redis, Mailpit) — Melos workspace config in root `pubspec.yaml`, Flutter packages not created yet
- [x] NestJS skeleton: config, Prisma, logging, Swagger, error format, Clock service, health check
- [x] Database schema §5.3 + §5.5 + raw SQL §5.4 + seed data
- [x] Login: Firebase (customers), email/password (staff), refresh tokens, roles §18 — ⬜ real Firebase projects (dev/staging/prod); local dev uses `dev:<uid>` tokens
- [x] Restaurants: profile, location (Goong), opening hours, closures, settings, submit for review — ⬜ real `GOONG_API_KEY`
- [x] Tables + areas + QR codes (PNG/PDF) — PDF uses bundled Be Vietnam Pro font (OFL)
- [x] Table map data + shared `TableMap` Flutter widget + map editor §8.6 — backend `PUT /restaurant/areas/:id/layout`, `shared_ui` TableMap, restaurant app editor (palette, inspector, undo, template, preview as customer, list view) — ⬜ room-photo background
- [x] Menu: categories, items, options, sold-out switch, Excel import (xlsx/csv template → preview → confirm)
- [x] Photos: Cloudinary signed upload, 4:3 crop, blurhash §16 — signature + verify + rules + BullMQ worker + blurhash job; restaurant app: pick → 4:3 crop (crop_your_image) → direct Cloudinary upload → verify; apps build URLs from `CLOUDINARY_CLOUD_NAME` dart-define — ⬜ real Cloudinary account
- [ ] AdminJS: approve restaurants — ✅ admin REST endpoints `/admin/restaurants`, ⬜ AdminJS UI + 2FA
- [x] Generate Dart API client from Swagger; shared_models + shared_ui packages — `packages/comi_api` (dart-dio, json_serializable; every endpoint the apps use now has a typed response), `packages/shared_ui` (theme, VND/time format, photo URLs, TableMap); shared_models dropped: apps use comi_api models directly
- [x] Restaurant app: login, onboarding wizard, menu editor, photo upload, table map editor — staff sign-up, register restaurant, setup checklist (location by Goong search or pasted coordinates, opening hours with presets, tables, menu, submit for review), menu editor (categories, dishes, options, sold-out switch, drag to reorder), Excel import with preview, dish photos; menu/media/geocode endpoints now typed in Swagger
- [ ] CI + staging server + first deploy — ✅ backend CI (lint, unit, e2e, build, OpenAPI), ✅ Flutter CI (format, analyze, test for shared_ui, restaurant_app, customer_app), ⬜ staging, deploy

## Phase 2 — Booking and ordering (5–7 weeks)

- [x] Search: nearby, map bounding box, filters (Under 60k, Within 500 m, Groups 10+, Open late…) §14 + suggest + translated detail/menu + `/home` time-of-day sections
- [x] Dining time per time window (lunch 45 min / evening 120 min)
- [x] Available time slots + cache §8.1 (Redis 30 s, version-key invalidation)
- [x] Create booking transaction, no double booking, idempotency key §8.2 (race test: 6 parallel → exactly 2)
- [ ] Table map picker for customers + 5-minute table hold §8.6 — ✅ backend (holds in Postgres with exclusion constraint), ✅ Flutter picker (areas, legend, joined tables of one group, hold countdown, holdId sent with the booking), ⬜ live `table.state` socket events
- [x] Large groups: joined tables, restaurant approval (+ 2 h auto-cancel job)
- [x] Order with price snapshot; age confirmation for alcohol items
- [x] Cancel booking (COD / no money yet) — customer cutoff, restaurant cancel, move table
- [x] Favorites, "My usual", "Order again"
- [x] Customer app: home (lunch / tonight modes), list, map, restaurant detail, menu with big photos, cart by course, booking form, checkout (COD), my bookings — also search suggest, filter chips, order again, cancel; dev phone login (⬜ Firebase OTP), OSM tiles in dev (⬜ Goong tiles)
- [x] Restaurant app: today board, booking detail, group approvals — board by hour (date picker, search, status chips, 30 s refresh), approve / reject with reason, cancel, move table; staff detail endpoint typed (`BookingDetailDto`) — ⬜ live socket updates instead of polling
- [ ] Push notifications + weekday lunch reminder
- [ ] Universal links / app links

## Phase 3 — Kitchen queue and at-the-table (4–5 weeks)

- [x] Kitchen status flow + fire-time calculator (tests first) §6.2, §7 — `kitchen.state.ts` (transitions, fire times, capacity, travel time) + KitchenService (plan, release, queue, cook taps, fire a course)
- [ ] BullMQ worker + Bull Board; jobs: kitchen-release, kitchen-sweep, no-show-check, reminders — ✅ kitchen-release, kitchen-sweep (every minute), no-show-check; ⬜ Bull Board, reminders (need push)
- [x] Kitchen capacity limit per 15 min §7.6 — checked at booking (KITCHEN_FULL; table-only still allowed), rules editable in the restaurant app
- [x] "I'm leaving now" §7.5 — distance from PostGIS, walk/motorbike estimate (⬜ Goong Distance Matrix), re-plans fire times, moves the no-show deadline
- [x] Check-in by QR + staff button §9 — signed table/entrance QR, time window, takes the scanned table if free
- [x] COD waits for check-in; no-show counter → must prepay — COD dishes HOLD with planned times; no-show at arrival/ETA + grace (+15 once by staff), 3 → mustPrepay
- [x] Socket.IO real-time §19 — `/restaurant` + `/customer` namespaces, JWT + membership check, Redis adapter/emitter (worker can emit), apps reload over REST on hints and on reconnect
- [x] Order more at the table + call staff (more ice, bill please) §8.5 — rounds (optional staff approval), live bill, service requests (no double ring), close bill
- [x] Restaurant app: kitchen screen, service requests, close bill, lunch & capacity settings — kitchen display (3 columns, late flags, sound, screen kept on), bell with requests, guest arrived / keep table / add dishes / fire / close bill, settings screen
- [x] Customer app: QR scanner, live booking screen, "I'm leaving now", at-the-table screen — scanner with typed-link fallback, live dish status, order more (table-only dishes allowed), call staff
- [ ] Pilot: 1 lunch restaurant + 1 quán nhậu (COD only)

## Phase 3b — Group orders and split bill (2–3 weeks)

- [x] Group invite link + shared cart §8.4 — host starts from a booking (pre-order becomes the host's), friends join by name without an account (secret guest key), add/remove own dishes, capacity checked, live over socket room `g:{bookingId}`; customer app group screen
- [x] Join-group web page (no app needed) — `/g/{token}` served by the API, strict CSP with nonce, no HTML injection
- [x] Group cutoff job — `group-cutoff` at arrival − 20 min (or host taps "Chốt đơn")
- [x] Live bill + split (equal / by items / custom) + staff "mark paid (cash)" — `splitBill` (tests first, exact to the đồng); tables without the group link split by head count; split in both apps
- [x] "Get home safe" ride buttons (Grab / Be / Xanh SM) — opens their websites (⬜ partner deep links with destination)

## Phase 4 — Payment and fees (3–4 weeks)

- [ ] Restaurant connects PayOS account (credentials encrypted) §10.1
- [ ] Payment adapter + PayOS + webhook + idempotency §10.2–10.3
- [ ] Prepaid flow, payment timeout, reconcile job, late payment
- [ ] Prepaid as default at lunch; COD warning
- [ ] Group payments (each guest pays own part)
- [ ] MoMo, then VNPay, then ZaloPay
- [ ] Fee calculator + fee plans (1% first 3 months → 2%, min fee) §11
- [ ] Monthly statements: job, PDF, email, VietQR to pay
- [ ] VAT invoice requests §13
- [ ] Restaurant reports
- [ ] ⚠️ **Minimum refund before prepaid goes live:** at least full refund when the restaurant cancels or the customer cancels before cutoff (can be manual by restaurant + admin tracking). Full refund system is in "Later" below.

## Phase 5 — Growth + tourists (4–5 weeks)

- [ ] Reviews (verified visits only), replies, reports §15
- [ ] Google rating on detail page
- [ ] Map filters: rating, open now, table available at time, ranking
- [ ] Vouchers (platform + restaurant, exclude alcohol) §12
- [ ] 5 languages: app text + menu translation + editor §17
- [ ] Tourists: card payments, dietary filters, email login, "show to taxi driver", approx. foreign prices
- [ ] Notification center

## Phase 6 — Launch (2–3 weeks)

- [ ] Security pass + permission tests + rate limits §23
- [ ] Load test (booking, availability, sockets)
- [ ] Privacy policy, terms, consent, account deletion
- [ ] Production server, backups, monitoring, alerts §24
- [ ] App Store + Google Play submission
- [ ] Onboard first 20–30 restaurants + photo shoots

---

## Later (planned, not scheduled yet)

### Refunds — full system (§10.5–10.14)

- [ ] Refund, RefundItem, OrderIssue, StatementAdjustment tables; `paidAmount` per dish with voucher share
- [ ] Refund calculator + policy rules (tests for every row of §10.8)
- [ ] Cancel preview ("You will get back …") + cancel flow for customer and restaurant
- [ ] Sold-out dish: refund or offer replacement (10-min timeout)
- [ ] "Report a problem" (missing / wrong / bad dish) → restaurant: bring now / refund / reject → escalate to admin
- [ ] Auto-refund unanswered "missing dish" claims after 2 h
- [ ] Automatic refunds via MoMo, ZaloPay, VNPay APIs + retries + status check
- [ ] PayOS manual refunds: customer bank form, VietQR for staff, proof upload, reminders (check PayOS docs for refund/payout API first)
- [ ] Fee recalculation + statement adjustments after refunds
- [ ] COD: remove dish from bill
- [ ] Money timeline in customer app + refund email receipts
- [ ] Admin: disputes, goodwill voucher, recover refund from restaurant statement
- [ ] Tests: parallel refunds never exceed paid amount; job runs twice → refunds once
- [ ] Add refund + gateway-fee clauses to restaurant partner contract

### Special occasions (couples, birthdays, holidays)

- [ ] Ambience tags + filters (romantic, rooftop, view…)
- [ ] Table requests (window, private)
- [ ] Add-ons with lead time (cake, flowers, message)
- [ ] Set menus for two
- [ ] Occasion field on booking
- [ ] Holiday collections (14/2, 8/3, 20/10, 24/12)

### Other

- [ ] Full admin website (Next.js)
- [ ] Automatic e-invoices (MISA, Viettel, VNPT)
- [ ] POS integrations (iPOS, KiotViet, Sapo)
- [ ] Split payments / marketplace payments
- [ ] Premium table surcharge (VIP, view)
- [ ] Waitlist, group deposits, loyalty points
- [ ] Analytics + A/B tests
- [ ] More cities

---

## Open decisions (see §27)

- [ ] Min fee for small lunch bills (suggest 1,000 VND)
- [ ] Hosting: Vietnam or Singapore (Decree 53)
- [ ] Launch district
- [ ] Prepaid no-show refund rule (default: refund dishes not yet cooking)
- [ ] Group order: unpaid guest at cutoff → remove items or host pays
- [ ] Refund rules: auto-approve time, who pays gateway fee, platform recovery from statement, PayOS manual refunds
