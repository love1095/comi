# comi

Table booking + pre-order for **office lunch** and **nhậu groups** in Vietnam.
Design: [docs/TECHNICAL_SPEC.md](docs/TECHNICAL_SPEC.md) · Progress: [TODO.md](TODO.md)

```
backend/          NestJS 11 + Prisma 6 + PostGIS (modular monolith, API + worker)
customer_app/     Flutter (phone)              — browse, menu + cart, book (COD), table picker, my bookings
restaurant_app/   Flutter (tablet)             — sign-up + setup, bookings board, menu editor, table map editor
packages/         comi_api (generated client), shared_ui
docker-compose.yml  postgis :5433, redis :6379, mailpit :8025
```

## Run the backend locally

```bash
docker compose up -d                 # Postgres on host port 5433 (set POSTGRES_PORT to change)
cd backend
cp .env.example .env                 # already done if .env exists
npm install
npx prisma migrate deploy            # schema + PostGIS / exclusion-constraint migration
npm run db:seed                      # 2 demo restaurants + staff accounts
npm run start:dev                    # http://localhost:3100/api/v1 · Swagger at /docs
```

Demo logins (seed): `owner@comi.vn` / `comi12345` (owner), `admin@comi.vn` / `comi12345` (platform admin),
`bep@comi.vn` / `comi12345` (kitchen).
Customer login without Firebase (dev only): `POST /api/v1/auth/customer/exchange {"idToken":"dev:my-uid:+84901234567"}`.

Restaurant endpoints need `Authorization: Bearer <accessToken>` and `X-Restaurant-Id: <id>` (from `GET /restaurant/me`).

## Tests

```bash
npm test             # unit tests (layout geometry, QR signatures, money, validation, error format)
npm run test:e2e     # builds, starts dist/main.js on :3999 against the local DB, runs API flows
npm run lint         # tsc type-check
```

## Dart API client

```bash
cd backend && npm run openapi        # writes backend/openapi.json (no DB needed)
cd .. && melos run api:generate      # dart-dio client into packages/comi_api
```

## Run the apps

```bash
flutter pub get                      # once, at the repo root (pub workspace)
cd restaurant_app && flutter run     # staff: owner@comi.vn / comi12345, or "Chủ quán mới? Đăng ký"
cd customer_app && flutter run       # diners: any 0xxxxxxxxx phone logs in (dev token, no Firebase)
```

Optional `--dart-define`s: `API_URL` (default `http://localhost:3100`, `10.0.2.2` on the Android emulator),
`CLOUDINARY_CLOUD_NAME` (dish photos), `MAP_TILE_URL` (customer map; OSM tiles are for development only).
Flutter code is formatted with `dart format -l 140` (CI checks it).

## Conventions

- Money is integer VND; rates are basis points. Times stored in UTC.
- Business code never calls `new Date()` — inject `Clock`.
- Errors: `{ "error": { "code": "STABLE_CODE", "message": "...", "details": {} } }`; apps translate `code`.
- Status changes and money changes write `AuditLog`.
