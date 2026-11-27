# comi — Technical Specification

Dine-in booking + pre-order app for many restaurants in Vietnam.
Customer finds a restaurant → books a table → pre-orders food → pays now (prepaid) or at the restaurant (COD) → food is cooked so it is ready when they arrive.

Stack: **Flutter** (customer app + restaurant tablet app) · **NestJS** (API) · **PostgreSQL + PostGIS** · **Redis + BullMQ** · **Socket.IO**

Version: 0.2 (2026-11-23) — refocused on target customer groups

---

## Table of contents

0. [Target users and what they need](#0-target-users-and-what-they-need)
1. [System architecture](#1-system-architecture)
2. [Repository structure](#2-repository-structure)
3. [Tech stack and libraries](#3-tech-stack-and-libraries)
4. [Core rules (business logic)](#4-core-rules-business-logic)
5. [Database design](#5-database-design)
6. [State machines](#6-state-machines)
7. [Kitchen queue algorithm](#7-kitchen-queue-algorithm)
8. [Table availability and booking](#8-table-availability-and-booking)
9. [Check-in and no-show](#9-check-in-and-no-show)
10. [Payments and refunds](#10-payments-and-refunds)
11. [Platform fee and monthly statements](#11-platform-fee-and-monthly-statements)
12. [Vouchers](#12-vouchers)
13. [VAT invoice (red bill) requests](#13-vat-invoice-red-bill-requests)
14. [Search and map](#14-search-and-map)
15. [Reviews and ratings](#15-reviews-and-ratings)
16. [Photos](#16-photos)
17. [Multiple languages](#17-multiple-languages)
18. [Authentication and roles](#18-authentication-and-roles)
19. [Real-time events and push notifications](#19-real-time-events-and-push-notifications)
20. [Background jobs](#20-background-jobs)
21. [API endpoints](#21-api-endpoints)
22. [App screens](#22-app-screens)
23. [Security, privacy and legal](#23-security-privacy-and-legal)
24. [Infrastructure and deployment](#24-infrastructure-and-deployment)
25. [Testing](#25-testing)
26. [Technical task list by phase](#26-technical-task-list-by-phase)
27. [Open decisions](#27-open-decisions)

---

## 0. Target users and what they need

The app is built for **four customer groups**, in this order of priority. Every feature in this spec should serve at least one of them. Features that serve none are cut from v1.

| # | Group | When they eat | Typical bill | Main promise | Release |
|---|---|---|---|---|---|
| 1 | **Office workers – lunch** | Mon–Fri 11:00–13:30 | 40k–150k / person | "Order at 11:30, food on the table at 12:00" | **Launch (MVP)** |
| 2 | **Nhậu groups** (quán nhậu, beer clubs) | 17:00–23:00, peak Thu–Sat | 1–3 million / table | "Table saved, first round ready, easy to order more and split the bill" | **Launch (MVP)** |
| 3 | **Tourists** | Lunch + dinner, every day | 300k–1.5 million / table | "Read the menu in your language, see the photos, pay by card" | Phase 5 |
| 4 | **Couples and special occasions** | Evenings, holidays (14/2, 8/3, 20/10, 24/12) | 500k–3 million / table | "The right table, a set menu, a cake waiting, no awkward bill" | After launch |

Why this order: groups 1 and 2 use **the same restaurants in the same office areas** (many quán sell cơm trưa at noon and become nhậu spots at night). One sales effort in one district covers both, and gives daily usage (lunch) plus high fee revenue (nhậu).

### 0.1 Office workers – lunch

Problem: a 1-hour lunch break; 15–20 minutes is lost waiting for food.

| Feature | Why | Technical notes |
|---|---|---|
| **Prepaid by default** at lunch | COD waits for check-in, which kills the benefit | Checkout preselects PREPAID; COD shows "Cooking starts when you arrive" warning. Optional small prepaid voucher. |
| **"I'm leaving now"** button | People leave early/late; kitchen should follow real arrival | §7.5. Updates `etaAt` from GPS distance; reschedules fire times. |
| **Kitchen capacity limit** | At 12:00 the kitchen, not tables, is the bottleneck | §7.6. `KitchenCapacityRule`: max pre-ordered dishes per 15-minute window. Full slots hidden. |
| **Short table time at lunch** | Faster turnover | `DiningRule` per time window: lunch 45 min, evening 120 min (§5.5). |
| **Re-order in 2 taps** | Same habits every day | "Order again" on past bookings, favourite dishes, saved "usual order" per restaurant. |
| **Weekday lunch reminder** | Build the daily habit | Push at 10:30 Mon–Fri (user can turn off / change time). |
| **Group lunch with colleagues** | Brings new users for free | §8.4. Share link, each person adds dishes and pays own share. |
| **VAT invoice to company** | Lunch is often a company expense | Saved InvoiceProfile, one tap at checkout (§13). |
| **Quick filters** | Decide fast | "Ready in 15 min", "Under 60k", "Within 500 m", "Cơm văn phòng". |

### 0.2 Nhậu groups

Problem: good places are full on busy nights; large groups need joined tables; ordering more and paying at the end is slow and messy.

| Feature | Why | Technical notes |
|---|---|---|
| **Large group booking** (6–30 people) | Groups are the norm | Book multiple tables or a combined table (`TableCombo`, §5.5). Restaurant can require confirmation for > 12 people. |
| **First round ready on arrival** | Beer + quick snacks on the table at once | Pre-order with course DRINK / STARTER; same fire-time logic. |
| **Shared group order** | Everyone adds what they want | §8.4. Same as group lunch. |
| **Order more rounds at the table** | Most ordering happens during the night | After check-in, customer orders from the app → new `round`, goes straight to QUEUED. |
| **Call staff** | Beer, ice, bowls, bill | `ServiceRequest` (§5.5): "More ice", "Call waiter", "Bill please" → restaurant tablet with sound. |
| **Live bill + split bill** | No arguing over the total | Live running bill in app; split equally / by items / custom; each person pays their part by QR. Cashier still closes the bill (fee base). |
| **Book a ride home** | Strict drink-driving penalties | On bill close: buttons deep-linking to Grab / Be / Xanh SM. |
| **Filters** | Find the right place | "Groups 10+", "Private room", "Open late", "Outdoor", "Hotpot / grill / seafood". |

Legal limits (Law on Prevention and Control of Harmful Effects of Alcohol, 2019): no alcohol promotions or vouchers on alcohol in the app; no selling to under-18s (age confirmation when a booking contains alcohol items: `MenuItem.isAlcohol`); vouchers exclude alcohol items. Set App Store / Play age rating accordingly.

### 0.3 Tourists

| Feature | Technical notes |
|---|---|
| Menu in 5 languages + photos for every dish | §17 (machine translation + restaurant edits). Restaurant badge "Full menu translated". |
| International card payment | Visa / Mastercard / JCB via VNPay or MoMo card gateway. Apple Pay / Google Pay where the gateway supports it. |
| Dietary filters and tags | `MenuItem.tags`: vegetarian, vegan, halal, no pork, no peanuts, spicy level. Filter "English menu", "Halal", "Vegetarian options". |
| Email login, no Vietnamese phone number needed | Google / Apple / email sign-in; phone optional. |
| Address and directions | "Show to taxi driver" screen with address in Vietnamese; open in Google Maps / Grab. |
| Prices shown in VND + approximate USD/KRW/CNY/JPY | Daily exchange rates job; label "approx." — charged in VND only. |

### 0.4 Couples and special occasions

Not a dating / matchmaking app (different product with safety and moderation problems). Instead, support people who already have a date.

| Feature | Technical notes |
|---|---|
| Ambience filters | `Restaurant.ambienceTags`: romantic, rooftop, view, quiet, live music, private room. |
| Table requests | `Table.features`: window, view, private, outdoor. Customer picks a feature; restaurant confirms. |
| Add-ons | MenuItem with `kind = ADD_ON`: cake, flowers, candle, message on plate, decoration. Lead time per add-on (e.g. cake needs 24 h). |
| Set menus for two | MenuItem with `kind = SET` containing child items (`SetMenuItem`). |
| Occasion field | `Booking.occasion`: birthday, anniversary, date, business. Shown to restaurant. |
| Prepaid so no bill at the table | Prepaid default for occasions; "pay privately" note. |
| Holiday campaigns | Admin creates seasonal collections (14/2, 8/3, 20/10, 24/12) shown on home screen. |

### 0.5 What this changes in the build

- **MVP = groups 1 + 2.** Lunch and nhậu features go into Phases 2–4. Tourist features into Phase 5. Occasion features after launch.
- **Launch area:** one office district (e.g. District 1 or Bình Thạnh in HCMC, or Cầu Giấy in Hanoi), 20–30 restaurants that serve lunch and/or nhậu within walking distance of office buildings.
- **Fee on small lunch bills:** 2% of a 50k bill is 1,000 VND, so the 2,000 VND minimum is really 4%. Use a lower minimum for small bills (see Open decisions #9).
- **Home screen changes by time of day:** 10:00–13:30 shows "Lunch near you"; 16:00–23:00 shows "Tonight: tables for groups"; tourists (non-Vietnamese app language) see "Menus in your language".

## 1. System architecture

```
 ┌──────────────────┐     ┌──────────────────────┐     ┌──────────────┐
 │  Customer app    │     │  Restaurant app      │     │  Admin web   │
 │  Flutter (phone) │     │  Flutter (tablet)    │     │  AdminJS     │
 └────────┬─────────┘     └──────────┬───────────┘     └──────┬───────┘
          │  HTTPS (REST) + WebSocket (Socket.IO)              │
          └──────────────────────┬─────────────────────────────┘
                                 ▼
                  ┌──────────────────────────────┐
                  │   NestJS API (one service)   │
                  │   REST · Socket.IO · Swagger │
                  └──┬──────────┬──────────┬─────┘
                     │          │          │
          ┌──────────▼──┐  ┌────▼─────┐  ┌─▼─────────────────────┐
          │ PostgreSQL  │  │  Redis   │  │ BullMQ workers        │
          │ + PostGIS   │  │ cache,   │  │ (same codebase,       │
          │             │  │ sockets, │  │  separate process)    │
          └─────────────┘  │ queues   │  └───────────────────────┘
                           └──────────┘
 External services:
   Firebase Auth (OTP, Google, Apple) · FCM (push) · Cloudinary (photos)
   PayOS / MoMo / VNPay / ZaloPay (payments, webhooks) · Goong (map, geocode)
   Google Places (ratings, detail page only) · Resend or AWS SES (email)
   Google Translate / DeepL (menu translation) · Sentry (errors)
```

Principles for a solo developer:

- **One backend service** (modular monolith). Split into modules, not microservices.
- **Workers use the same code** as the API but run as a second process (`node dist/worker.js`), so a slow job never blocks API requests.
- **The server is the source of truth** for prices, fees, times and statuses. The apps only display and send intentions.
- **All money is integer VND** (no decimals, no floats).
- **All times stored in UTC** (`timestamptz`). Display in the restaurant's time zone (default `Asia/Ho_Chi_Minh`).

---

## 2. Repository structure

```
comi/
├── backend/
│   ├── prisma/
│   │   ├── schema.prisma
│   │   ├── migrations/              # includes raw SQL for PostGIS + exclusion constraints
│   │   └── seed.ts                  # demo restaurants, menus, users
│   ├── src/
│   │   ├── main.ts                  # API entry
│   │   ├── worker.ts                # BullMQ worker entry
│   │   ├── common/                  # guards, interceptors, filters, money utils, time utils
│   │   ├── config/                  # env validation (zod or class-validator)
│   │   ├── prisma/                  # PrismaService
│   │   └── modules/
│   │       ├── auth/
│   │       ├── users/
│   │       ├── restaurants/         # profile, hours, staff, settings
│   │       ├── menu/                # categories, items, options, translations
│   │       ├── tables/              # areas, tables, QR tokens
│   │       ├── availability/
│   │       ├── bookings/
│   │       ├── orders/
│   │       ├── kitchen/             # queue logic + socket gateway
│   │       ├── checkin/
│   │       ├── payments/            # provider adapters + webhooks
│   │       ├── fees/                # fee calc, statements
│   │       ├── vouchers/
│   │       ├── reviews/
│   │       ├── invoices/            # VAT invoice requests
│   │       ├── search/              # PostGIS queries
│   │       ├── media/               # Cloudinary signed uploads
│   │       ├── i18n/                # translation service
│   │       ├── notifications/       # FCM, email
│   │       └── admin/               # AdminJS
│   └── test/
├── customer_app/                    # Flutter
├── restaurant_app/                  # Flutter (tablet, landscape)
├── packages/
│   ├── shared_models/               # Dart: freezed models, enums, API client
│   └── shared_ui/                   # Dart: theme, price formatter, photo widgets
├── docs/
│   └── TECHNICAL_SPEC.md
├── docker-compose.yml               # postgis, redis, (mailpit for local email)
└── .github/workflows/               # CI
```

Use **Melos** to manage the Flutter packages in one repo.
Generate the Dart API client from the backend's OpenAPI (Swagger) file with `openapi-generator` (dart-dio), so the apps and API never drift apart.

---

## 3. Tech stack and libraries

### Backend

| Need | Choice |
|---|---|
| Runtime | Node.js 22 LTS, TypeScript strict mode |
| Framework | NestJS 11 |
| ORM | Prisma (raw SQL for PostGIS and locking) |
| Validation | class-validator + class-transformer |
| Jobs | BullMQ + Redis 7 |
| Real-time | `@nestjs/websockets` + Socket.IO + `@socket.io/redis-adapter` |
| Auth | Firebase Admin SDK (verify ID token) + own JWT (`@nestjs/jwt`) |
| Docs | `@nestjs/swagger` |
| Rate limit | `@nestjs/throttler` (Redis storage) |
| Logging | `nestjs-pino` |
| Errors | Sentry |
| Admin | AdminJS (`@adminjs/nestjs`, `@adminjs/prisma`) |
| Tests | Jest + Supertest + Testcontainers (real Postgres in tests) |

### Flutter (both apps)

| Need | Choice |
|---|---|
| State | flutter_riverpod (+ riverpod_generator) |
| Navigation | go_router |
| HTTP | dio (+ interceptor for token refresh) |
| Models | freezed + json_serializable |
| Photos | cached_network_image, flutter_blurhash |
| Map | maplibre_gl with Goong map tiles |
| Location | geolocator |
| QR scan | mobile_scanner |
| Real-time | socket_io_client |
| Push | firebase_messaging, flutter_local_notifications |
| Auth | firebase_auth, google_sign_in, sign_in_with_apple |
| i18n | flutter_localizations + intl (ARB files) |
| Local storage | flutter_secure_storage (tokens), shared_preferences (settings) |
| Payment open | url_launcher (payment link / deep link to MoMo, ZaloPay) |
| Errors | sentry_flutter |

---

## 4. Core rules (business logic)

These rules drive most of the code. Each one must have unit tests.

| # | Rule |
|---|---|
| R1 | Customer books a table for a date, time, party size, optional area. |
| R2 | Customer may pre-order dishes and choose serving style: **by course** (starter → main → dessert) or **all together**. |
| R3 | Payment mode: **PREPAID** (pay in app) or **COD** (pay at restaurant). |
| R4 | PREPAID: kitchen starts each dish at `arrivalAt − prepTime` (see §7). |
| R5 | COD: the order is listed in the kitchen at its time but **does not start cooking until the customer checks in**. Prepaid orders behind it move ahead. |
| R6 | Check-in = scan the table / restaurant QR in the app, or staff press "Check in". |
| R7 | No-show: if not checked in by `arrivalAt + graceMinutes` (default 30), booking becomes NO_SHOW, table is released, COD order is cancelled. |
| R8 | Customer with `noShowCount ≥ 3` (setting) can only book PREPAID. |
| R9 | Platform fee = `max(minFee, round(base × rate))`. Rate is per restaurant, stored in basis points (100 = 1%, 200 = 2%). |
| R10 | Fee base: PREPAID = paid order value. COD = `max(preOrderValue, finalBillEntered)`. |
| R11 | No fee is charged on bookings with no order and on cancelled bookings (unless setting changes). |
| R12 | Customer can request a VAT invoice; the restaurant issues it; the app passes the data and emails. |
| R13 | Only customers who checked in can write a review for that booking (one review per booking). |

---

## 5. Database design

### 5.1 Conventions

- Primary keys: `uuid` (v7 if possible, sortable by time).
- Money: `Int` VND (max ~2.1 billion, enough for one bill). Use `BigInt` for statement totals.
- Rates: `Int` basis points.
- Every table: `createdAt`, `updatedAt`. Important tables: `deletedAt` (soft delete).
- Order items **copy** name and price at order time (snapshot), so later menu edits do not change old orders.
- Enable extensions: `postgis`, `btree_gist`, `pg_trgm` (text search), `unaccent` (search without Vietnamese accents).

### 5.2 Entity overview

```
User ─┬─< Booking >── Restaurant ─┬─< TableArea ─< Table
      │      │                    ├─< MenuCategory ─< MenuItem ─< MenuItemPhoto
      │      ├── Order ─< OrderItem                ├─< MenuItemTranslation
      │      ├─< Payment                           └─< OptionGroup ─< Option
      │      ├── FeeRecord ──> Statement           
      │      ├── Review                            
      │      ├── InvoiceRequest                     
      │      └── VoucherRedemption ──> Voucher     
      └─< DeviceToken            Restaurant ─< RestaurantMember >── StaffUser
                                 Restaurant ─< FeePlan, OpeningHours, PaymentAccount
```

### 5.3 Prisma schema (first version)

```prisma
generator client { provider = "prisma-client-js"; previewFeatures = ["postgresqlExtensions"] }
datasource db {
  provider   = "postgresql"
  url        = env("DATABASE_URL")
  extensions = [postgis, btree_gist, pg_trgm, unaccent]
}

// ───────────── Users ─────────────
model User {
  id              String    @id @default(uuid())
  firebaseUid     String    @unique
  phone           String?   @unique
  email           String?
  name            String?
  avatarUrl       String?
  locale          String    @default("vi")       // vi, en, ko, zh, ja
  noShowCount     Int       @default(0)
  mustPrepay      Boolean   @default(false)
  status          UserStatus @default(ACTIVE)
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
  deletedAt       DateTime?
  bookings        Booking[]
  deviceTokens    DeviceToken[]
  invoiceProfiles InvoiceProfile[]
  reviews         Review[]
}
enum UserStatus { ACTIVE BLOCKED DELETED }

model DeviceToken {
  id        String   @id @default(uuid())
  userId    String?
  staffId   String?
  token     String   @unique
  platform  String   // ios | android
  createdAt DateTime @default(now())
  user      User?    @relation(fields: [userId], references: [id])
}

model StaffUser {
  id           String   @id @default(uuid())
  email        String   @unique
  passwordHash String
  name         String
  phone        String?
  createdAt    DateTime @default(now())
  memberships  RestaurantMember[]
}

model RestaurantMember {
  id           String     @id @default(uuid())
  restaurantId String
  staffId      String
  role         StaffRole
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  staff        StaffUser  @relation(fields: [staffId], references: [id])
  @@unique([restaurantId, staffId])
}
enum StaffRole { OWNER MANAGER CASHIER KITCHEN }

// ───────────── Restaurant ─────────────
model Restaurant {
  id                 String   @id @default(uuid())
  slug               String   @unique
  name               String
  description        String?
  phone              String
  address            String
  provinceCode       String               // Vietnam administrative codes
  wardCode           String?
  // location geography(Point,4326) is added by raw SQL migration
  timezone           String   @default("Asia/Ho_Chi_Minh")
  cuisineTags        String[]
  priceLevel         Int                  // 1..4
  coverPhotoUrl      String?
  googlePlaceId      String?
  status             RestaurantStatus @default(DRAFT)
  // settings
  slotMinutes        Int      @default(15)  // booking time step
  diningMinutes      Int      @default(90)  // how long a table is held
  graceMinutes       Int      @default(30)  // no-show timeout
  minLeadMinutes     Int      @default(60)  // earliest booking from now
  maxDaysAhead       Int      @default(30)
  allowCod           Boolean  @default(true)
  prepaidRefundRule  RefundRule @default(BEFORE_COOKING)
  // cached ratings
  ratingAvg          Decimal  @default(0) @db.Decimal(2,1)
  ratingCount        Int      @default(0)
  firstOrderAt       DateTime?
  createdAt          DateTime @default(now())
  updatedAt          DateTime @updatedAt
  deletedAt          DateTime?

  members         RestaurantMember[]
  translations    RestaurantTranslation[]
  openingHours    OpeningHours[]
  closures        Closure[]
  areas           TableArea[]
  tables          Table[]
  categories      MenuCategory[]
  items           MenuItem[]
  bookings        Booking[]
  feePlans        FeePlan[]
  paymentAccounts PaymentAccount[]
  statements      Statement[]
}
enum RestaurantStatus { DRAFT PENDING_REVIEW ACTIVE PAUSED REJECTED }
enum RefundRule { BEFORE_COOKING NEVER FULL_UNTIL_CUTOFF }

model RestaurantTranslation {
  restaurantId String
  locale       String
  name         String?
  description  String?
  isMachine    Boolean @default(true)
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  @@id([restaurantId, locale])
}

model OpeningHours {
  id           String @id @default(uuid())
  restaurantId String
  weekday      Int     // 0=Sunday..6
  openMinute   Int     // minutes from 00:00, e.g. 600 = 10:00
  closeMinute  Int     // may be > 1440 for after-midnight
  lastOrderMinute Int?
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
}

model Closure {             // holidays, Tết, private events
  id           String   @id @default(uuid())
  restaurantId String
  startsAt     DateTime
  endsAt       DateTime
  reason       String?
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
}

// ───────────── Tables ─────────────
model TableArea {
  id           String @id @default(uuid())
  restaurantId String
  name         String          // "Indoor", "Garden", "VIP room"
  sortOrder    Int    @default(0)
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  tables       Table[]
}

model Table {
  id           String  @id @default(uuid())
  restaurantId String
  areaId       String
  code         String          // "A1"
  minSeats     Int     @default(1)
  maxSeats     Int
  isActive     Boolean @default(true)
  qrSecret     String          // used to sign QR token, rotate if leaked
  posX         Int?            // floor-plan layout
  posY         Int?
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  area         TableArea  @relation(fields: [areaId], references: [id])
  @@unique([restaurantId, code])
}

// ───────────── Menu ─────────────
model MenuCategory {
  id           String @id @default(uuid())
  restaurantId String
  name         String
  sortOrder    Int    @default(0)
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  items        MenuItem[]
}

model MenuItem {
  id            String   @id @default(uuid())
  restaurantId  String
  categoryId    String
  name          String           // Vietnamese = source language
  description   String?
  price         Int              // VND
  course        Course   @default(MAIN)
  prepMinutes   Int      @default(15)
  isAvailable   Boolean  @default(true)   // sold out today toggle
  isPreorderable Boolean @default(true)   // some dishes only at table
  tags          String[]                  // spicy, vegetarian, ...
  sortOrder     Int      @default(0)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  deletedAt     DateTime?
  restaurant    Restaurant @relation(fields: [restaurantId], references: [id])
  category      MenuCategory @relation(fields: [categoryId], references: [id])
  photos        MenuItemPhoto[]
  translations  MenuItemTranslation[]
  optionGroups  OptionGroup[]
}
enum Course { DRINK STARTER MAIN DESSERT }

model MenuItemPhoto {
  id         String @id @default(uuid())
  itemId     String
  publicId   String          // Cloudinary id
  width      Int
  height     Int
  blurhash   String
  sortOrder  Int    @default(0)
  item       MenuItem @relation(fields: [itemId], references: [id])
}

model MenuItemTranslation {
  itemId      String
  locale      String
  name        String
  description String?
  isMachine   Boolean @default(true)
  item        MenuItem @relation(fields: [itemId], references: [id])
  @@id([itemId, locale])
}

model OptionGroup {            // "Size", "Spice level", "Add-ons"
  id        String @id @default(uuid())
  itemId    String
  name      String
  minSelect Int    @default(0)
  maxSelect Int    @default(1)
  item      MenuItem @relation(fields: [itemId], references: [id])
  options   Option[]
}

model Option {
  id         String @id @default(uuid())
  groupId    String
  name       String
  priceDelta Int    @default(0)
  group      OptionGroup @relation(fields: [groupId], references: [id])
}

// ───────────── Booking & order ─────────────
model Booking {
  id             String        @id @default(uuid())
  code           String        @unique     // short code shown to staff, e.g. "TS-8K2P"
  restaurantId   String
  userId         String
  tableId        String?
  areaId         String?
  partySize      Int
  arrivalAt      DateTime
  endsAt         DateTime                  // arrivalAt + diningMinutes
  paymentMode    PaymentMode
  serveStyle     ServeStyle    @default(BY_COURSE)
  status         BookingStatus @default(PENDING)
  note           String?
  checkedInAt    DateTime?
  checkInMethod  CheckInMethod?
  cancelledAt    DateTime?
  cancelReason   String?
  noShowAt       DateTime?
  completedAt    DateTime?
  finalBillAmount Int?                    // entered by restaurant (COD + extra orders)
  createdAt      DateTime      @default(now())
  updatedAt      DateTime      @updatedAt
  restaurant     Restaurant    @relation(fields: [restaurantId], references: [id])
  user           User          @relation(fields: [userId], references: [id])
  order          Order?
  payments       Payment[]
  fee            FeeRecord?
  review         Review?
  invoiceRequest InvoiceRequest?
  voucherRedemptions VoucherRedemption[]
  @@index([restaurantId, arrivalAt])
  @@index([userId, arrivalAt])
}
enum PaymentMode   { PREPAID COD }
enum ServeStyle    { BY_COURSE ALL_TOGETHER }
enum BookingStatus { PENDING CONFIRMED CHECKED_IN COMPLETED CANCELLED NO_SHOW EXPIRED }
enum CheckInMethod { QR STAFF }

model Order {
  id               String  @id @default(uuid())
  bookingId        String  @unique
  subtotal         Int
  restaurantDiscount Int   @default(0)    // voucher paid by restaurant
  platformDiscount Int     @default(0)    // voucher paid by platform
  total            Int                    // amount customer pays
  status           OrderStatus @default(DRAFT)
  createdAt        DateTime @default(now())
  updatedAt        DateTime @updatedAt
  booking          Booking  @relation(fields: [bookingId], references: [id])
  items            OrderItem[]
}
enum OrderStatus { DRAFT PLACED IN_KITCHEN SERVED CANCELLED }

model OrderItem {
  id            String  @id @default(uuid())
  orderId       String
  menuItemId    String
  nameSnapshot  String
  unitPrice     Int                     // price + option deltas at order time
  quantity      Int
  optionsSnapshot Json                  // [{group, option, priceDelta}]
  note          String?
  course        Course
  prepMinutes   Int
  kitchenStatus KitchenStatus @default(HOLD)
  scheduledStartAt DateTime?            // computed fire time
  releasedAt    DateTime?               // entered active queue
  startedAt     DateTime?
  readyAt       DateTime?
  servedAt      DateTime?
  order         Order   @relation(fields: [orderId], references: [id])
  @@index([kitchenStatus, scheduledStartAt])
}
enum KitchenStatus { HOLD SCHEDULED QUEUED COOKING READY SERVED CANCELLED }

// ───────────── Payments ─────────────
model PaymentAccount {          // restaurant's own merchant credentials
  id           String @id @default(uuid())
  restaurantId String
  provider     PaymentProvider
  credentialsEncrypted String   // AES-256-GCM, key from env/KMS
  isActive     Boolean @default(true)
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  @@unique([restaurantId, provider])
}
enum PaymentProvider { PAYOS MOMO VNPAY ZALOPAY }

model Payment {
  id              String  @id @default(uuid())
  bookingId       String
  provider        PaymentProvider
  providerOrderId String  @unique       // our reference sent to provider (numeric for PayOS)
  providerTxnId   String?
  amount          Int
  status          PaymentStatus @default(CREATED)
  checkoutUrl     String?
  expiresAt       DateTime
  paidAt          DateTime?
  refundedAmount  Int     @default(0)
  rawLastWebhook  Json?
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
  booking         Booking @relation(fields: [bookingId], references: [id])
}
enum PaymentStatus { CREATED PENDING PAID FAILED EXPIRED REFUNDED PARTIALLY_REFUNDED }

model WebhookEvent {            // idempotency + audit
  id          String   @id @default(uuid())
  provider    PaymentProvider
  eventKey    String               // provider txn id + status
  payload     Json
  processedAt DateTime?
  createdAt   DateTime @default(now())
  @@unique([provider, eventKey])
}

// ───────────── Fees ─────────────
model FeePlan {
  id           String   @id @default(uuid())
  restaurantId String
  rateBps      Int                  // 100 = 1%, 200 = 2%
  minFee       Int      @default(2000)
  fixedFee     Int      @default(0) // optional fixed part per booking
  effectiveFrom DateTime
  effectiveTo  DateTime?
  note         String?              // "Launch promo 1% for 3 months"
  restaurant   Restaurant @relation(fields: [restaurantId], references: [id])
  @@index([restaurantId, effectiveFrom])
}

model FeeRecord {
  id          String   @id @default(uuid())
  bookingId   String   @unique
  restaurantId String
  feePlanId   String
  baseAmount  Int
  rateBps     Int
  feeAmount   Int
  status      FeeStatus @default(PENDING)
  statementId String?
  computedAt  DateTime @default(now())
  booking     Booking  @relation(fields: [bookingId], references: [id])
  statement   Statement? @relation(fields: [statementId], references: [id])
}
enum FeeStatus { PENDING FINAL BILLED WAIVED }

model Statement {
  id              String  @id @default(uuid())
  restaurantId    String
  periodMonth     String                // "2026-12"
  bookingCount    Int
  totalBase       BigInt
  totalFee        BigInt
  platformVoucherCredit BigInt          // platform owes restaurant
  amountDue       BigInt                // totalFee - credit (can be negative)
  status          StatementStatus @default(DRAFT)
  pdfUrl          String?
  issuedAt        DateTime?
  paidAt          DateTime?
  restaurant      Restaurant @relation(fields: [restaurantId], references: [id])
  fees            FeeRecord[]
  @@unique([restaurantId, periodMonth])
}
enum StatementStatus { DRAFT ISSUED PAID OVERDUE }

// ───────────── Vouchers ─────────────
model Voucher {
  id            String  @id @default(uuid())
  code          String  @unique
  restaurantId  String?             // null = platform-wide
  fundedBy      VoucherFunder
  type          VoucherType
  value         Int                 // VND or bps for percent
  maxDiscount   Int?
  minOrder      Int     @default(0)
  startsAt      DateTime
  endsAt        DateTime
  totalLimit    Int?
  perUserLimit  Int     @default(1)
  firstOrderOnly Boolean @default(false)
  usedCount     Int     @default(0)
  isActive      Boolean @default(true)
  redemptions   VoucherRedemption[]
}
enum VoucherFunder { PLATFORM RESTAURANT }
enum VoucherType   { FIXED PERCENT }

model VoucherRedemption {
  id        String  @id @default(uuid())
  voucherId String
  bookingId String
  userId    String
  amount    Int
  status    String  @default("APPLIED")  // APPLIED | RELEASED
  voucher   Voucher @relation(fields: [voucherId], references: [id])
  booking   Booking @relation(fields: [bookingId], references: [id])
  @@unique([voucherId, bookingId])
}

// ───────────── Reviews ─────────────
model Review {
  id           String   @id @default(uuid())
  bookingId    String   @unique
  restaurantId String
  userId       String
  rating       Int                // 1..5
  foodRating   Int?
  serviceRating Int?
  text         String?
  photoIds     String[]
  status       ReviewStatus @default(PUBLISHED)
  reply        String?           // restaurant reply
  createdAt    DateTime @default(now())
  booking      Booking  @relation(fields: [bookingId], references: [id])
  user         User     @relation(fields: [userId], references: [id])
  @@index([restaurantId, createdAt])
}
enum ReviewStatus { PUBLISHED HIDDEN REPORTED }

// ───────────── VAT invoice ─────────────
model InvoiceProfile {          // saved by customer for reuse
  id          String @id @default(uuid())
  userId      String
  companyName String
  taxCode     String
  address     String
  email       String
  isDefault   Boolean @default(false)
  user        User    @relation(fields: [userId], references: [id])
}

model InvoiceRequest {
  id          String  @id @default(uuid())
  bookingId   String  @unique
  companyName String
  taxCode     String
  address     String
  email       String
  status      InvoiceStatus @default(REQUESTED)
  invoiceNo   String?
  pdfUrl      String?
  issuedAt    DateTime?
  booking     Booking @relation(fields: [bookingId], references: [id])
}
enum InvoiceStatus { REQUESTED SENT_TO_RESTAURANT ISSUED EMAILED REJECTED }

model AuditLog {
  id        String   @id @default(uuid())
  actorType String               // USER | STAFF | ADMIN | SYSTEM
  actorId   String?
  action    String               // "booking.check_in", "fee_plan.update"
  entity    String
  entityId  String
  data      Json?
  createdAt DateTime @default(now())
  @@index([entity, entityId])
}
```

### 5.4 Raw SQL migration (add after Prisma's first migration)

```sql
-- Location for map search
ALTER TABLE "Restaurant" ADD COLUMN location geography(Point, 4326) NOT NULL;
CREATE INDEX restaurant_location_gix ON "Restaurant" USING GIST (location);

-- Search without Vietnamese accents ("pho" finds "Phở")
CREATE INDEX restaurant_name_trgm ON "Restaurant"
  USING GIN (unaccent(lower(name)) gin_trgm_ops);   -- wrap unaccent in an IMMUTABLE function first

-- Never double-book a table (database-level guarantee)
ALTER TABLE "Booking" ADD CONSTRAINT booking_no_overlap
  EXCLUDE USING GIST (
    "tableId" WITH =,
    tstzrange("arrivalAt", "endsAt", '[)') WITH &&
  ) WHERE ("tableId" IS NOT NULL AND status IN ('PENDING','CONFIRMED','CHECKED_IN'));
```

The exclusion constraint is the key protection: even if two customers book the same table at the same moment, the database rejects the second one. The API catches error `23P01` and tries the next free table.

### 5.5 Additions for the target groups (§0)

Changes to existing models:

```prisma
model Restaurant {
  // ...existing fields
  ambienceTags   String[]      // romantic, rooftop, view, quiet, live_music, private_room, outdoor
  servesLunch    Boolean @default(false)
  servesNhau     Boolean @default(false)
  maxGroupSize   Int     @default(20)
  confirmGroupsOver Int  @default(12)   // bookings above this need restaurant approval
  menuFullyTranslated Boolean @default(false)
}

model Table {
  // ...existing fields
  features       String[]      // window, view, private, outdoor
  // table map (§8.6) — units are grid cells of the area's floor plan
  shape          TableShape @default(RECT)
  width          Int     @default(2)
  height         Int     @default(2)
  rotation       Int     @default(0)    // 0, 90, 180, 270
  seatLayout     Json?                  // optional: seats per side {top:2,bottom:2,left:0,right:0}
  isSelectable   Boolean @default(true) // false = restaurant assigns it only (e.g. reserved for walk-ins)
  surcharge      Int     @default(0)    // optional premium (VIP / view), 0 in v1
  joinGroup      String?                // tables with the same value can be joined for big groups
}
enum TableShape { RECT ROUND SQUARE BOOTH BAR_SEAT }

model TableArea {
  // ...existing fields
  gridCols       Int     @default(20)
  gridRows       Int     @default(14)
  floor          Int     @default(1)    // floor number for multi-storey places
  backgroundUrl  String?                // optional photo/sketch of the room
}

// Non-table things drawn on the map so customers can orient themselves
model MapElement {
  id        String @id @default(uuid())
  areaId    String
  type      MapElementType
  label     String?
  x         Int
  y         Int
  width     Int    @default(1)
  height    Int    @default(1)
  rotation  Int    @default(0)
}
enum MapElementType { ENTRANCE WINDOW WALL KITCHEN BAR STAGE RESTROOM STAIRS PLANT TV AIRCON SMOKING_AREA }

model Restaurant {
  // ...existing fields
  allowTableChoice Boolean @default(false)  // turns on the seat-map picker
}

model MenuItem {
  // ...existing fields
  kind           ItemKind @default(DISH)
  isAlcohol      Boolean  @default(false)
  leadHours      Int      @default(0)   // e.g. cake = 24
}
enum ItemKind { DISH DRINK SET ADD_ON }

model Booking {
  // ...existing fields
  occasion       Occasion?
  tableRequest   String[]                // requested table features
  departedAt     DateTime?               // "I'm leaving now"
  etaAt          DateTime?               // updated arrival estimate
  isGroupOrder   Boolean  @default(false)
  needsApproval  Boolean  @default(false)
  ageConfirmedAt DateTime?               // when alcohol is in the order
  extraTableIds  String[]                // joined tables for large groups
}
enum Occasion { DATE ANNIVERSARY BIRTHDAY BUSINESS CELEBRATION }

model OrderItem {
  // ...existing fields
  round          Int     @default(0)      // 0 = pre-order, 1..n = ordered at the table
  guestId        String?                  // who ordered it (group order / split bill)
}
```

New models:

```prisma
// Table hold time per time window (lunch 45 min, evening 120 min)
model DiningRule {
  id           String @id @default(uuid())
  restaurantId String
  weekdays     Int[]           // [1,2,3,4,5]
  startMinute  Int             // 600 = 10:00
  endMinute    Int
  diningMinutes Int
}

// Max pre-ordered dishes the kitchen accepts per window
model KitchenCapacityRule {
  id            String @id @default(uuid())
  restaurantId  String
  weekdays      Int[]
  startMinute   Int
  endMinute     Int
  windowMinutes Int    @default(15)
  maxItems      Int              // e.g. 20 dishes per 15 minutes
}

// Set menu contents
model SetMenuItem {
  setId     String
  itemId    String
  quantity  Int    @default(1)
  @@id([setId, itemId])
}

// Group order: people who joined one booking
model BookingGuest {
  id          String   @id @default(uuid())
  bookingId   String
  userId      String?             // null = guest without account (web link)
  displayName String
  isHost      Boolean  @default(false)
  joinedAt    DateTime @default(now())
  amountDue   Int      @default(0)
  amountPaid  Int      @default(0)
  @@unique([bookingId, userId])
}

model GroupInvite {
  token       String   @id        // random, in share link
  bookingId   String
  expiresAt   DateTime            // order cutoff
  maxGuests   Int
}

// Bill split
model BillSplit {
  id          String  @id @default(uuid())
  bookingId   String  @unique
  mode        SplitMode
  createdAt   DateTime @default(now())
}
enum SplitMode { EQUAL BY_ITEMS CUSTOM }

// Call staff during the meal
model ServiceRequest {
  id           String   @id @default(uuid())
  bookingId    String
  restaurantId String
  tableId      String?
  type         ServiceType
  note         String?
  status       String   @default("OPEN")   // OPEN | DONE
  createdAt    DateTime @default(now())
  doneAt       DateTime?
}
enum ServiceType { CALL_WAITER MORE_ICE MORE_BOWLS BILL_PLEASE OTHER }

// Lunch habits
model FavoriteItem {
  userId     String
  menuItemId String
  createdAt  DateTime @default(now())
  @@id([userId, menuItemId])
}

model SavedOrder {                 // "my usual" per restaurant
  id           String @id @default(uuid())
  userId       String
  restaurantId String
  name         String             // "My usual"
  items        Json               // [{menuItemId, quantity, options, note}]
  @@unique([userId, restaurantId, name])
}

model UserPreference {
  userId             String  @id
  lunchReminder      Boolean @default(true)
  lunchReminderMinute Int    @default(630)   // 10:30
  dietaryTags        String[]               // vegetarian, halal, ...
  showApproxCurrency String?                 // USD, KRW, CNY, JPY
}

// Holiday / seasonal collections on the home screen
model Collection {
  id        String   @id @default(uuid())
  slug      String   @unique
  title     Json                 // { vi: "...", en: "..." }
  coverUrl  String?
  startsAt  DateTime
  endsAt    DateTime
  restaurantIds String[]
  sortOrder Int @default(0)
}

model ExchangeRate {
  currency  String   @id         // USD, KRW, CNY, JPY
  vndPerUnit Decimal
  updatedAt DateTime
}
```

---

## 6. State machines

Put each state machine in one file (`booking.state.ts`, `kitchen.state.ts`) with an `allowedTransitions` map. Every status change goes through one function that checks the map, writes the change, writes `AuditLog`, and emits a socket event.

### 6.1 Booking

```
                 pay ok / COD confirm
   PENDING ───────────────────────────► CONFIRMED ──check-in──► CHECKED_IN ──bill closed──► COMPLETED
     │  payment timeout (15 min)          │    │                                  
     ▼                                    │    └─ grace time passed ──► NO_SHOW
   EXPIRED                                │
                       cancel (customer/restaurant) ──► CANCELLED
```

| From | To | Who / trigger |
|---|---|---|
| PENDING | CONFIRMED | Payment webhook PAID (prepaid) · immediately on create (COD) |
| PENDING | EXPIRED | Job `payment-timeout` after 15 min |
| CONFIRMED | CHECKED_IN | QR scan or staff button |
| CONFIRMED | CANCELLED | Customer (before cutoff) or restaurant |
| CONFIRMED | NO_SHOW | Job `no-show-check` at `arrivalAt + graceMinutes` |
| CHECKED_IN | COMPLETED | Cashier closes bill (enters final amount) |

### 6.2 Order item in the kitchen

```
HOLD ──(prepaid confirmed)──► SCHEDULED ──(fire time reached)──► QUEUED ──► COOKING ──► READY ──► SERVED
  │                                                                ▲
  └──(COD: customer checks in)────────────────────────────────────┘
any state before COOKING ──► CANCELLED
```

| Status | Meaning |
|---|---|
| HOLD | Waiting. COD stays here until check-in. Shown greyed out on kitchen screen. |
| SCHEDULED | Prepaid, has a fire time in the future. |
| QUEUED | Kitchen should cook now. Sorted in the active list. |
| COOKING | Cook pressed "Start". |
| READY | Cook pressed "Done". Waiter notified. |
| SERVED | Waiter delivered it. |

---

## 7. Kitchen queue algorithm

### 7.1 Computing fire times (prepaid)

Target serve times by course, relative to arrival (restaurant setting, defaults):

| Course | BY_COURSE target | ALL_TOGETHER target |
|---|---|---|
| DRINK | arrival + 0 min | arrival + 0 min |
| STARTER | arrival + 5 min | arrival + 10 min |
| MAIN | arrival + 20 min | arrival + 10 min |
| DESSERT | arrival + 45 min (or fire on request) | arrival + 10 min |

```
scheduledStartAt(item) = targetServeAt(course) − item.prepMinutes
if scheduledStartAt < now → scheduledStartAt = now
```

For ALL_TOGETHER, the longest dish starts first so all dishes finish together.

### 7.2 Releasing items

- **Prepaid:** when the booking is CONFIRMED, set items to SCHEDULED and add one delayed BullMQ job per booking per fire time: `kitchen-release` with `delay = scheduledStartAt − now`. When it runs: set matching items to QUEUED, set `releasedAt`, emit `kitchen.item_queued`.
- **COD:** items stay HOLD. On check-in, recompute fire times with `arrival = checkedInAt`, set items to SCHEDULED/QUEUED (drinks and starters usually QUEUED at once).
- **Dessert "fire on request":** waiter presses "Fire dessert" in the restaurant app.

### 7.3 Active queue order (what the kitchen screen shows)

```sql
SELECT ... FROM "OrderItem"
WHERE restaurant = $1 AND "kitchenStatus" IN ('QUEUED','COOKING')
ORDER BY
  CASE "kitchenStatus" WHEN 'COOKING' THEN 0 ELSE 1 END,
  "scheduledStartAt" ASC,
  "releasedAt" ASC;
```

Below the active list, a second section "Upcoming" shows SCHEDULED items (next 2 hours) and HOLD items (COD, "waiting for guest") so the kitchen can plan.

Example matching the agreed rule:

```
18:00 Order A  PREPAID  → released at its time, cooking
18:15 Order B  COD      → HOLD (guest not here)
18:30 Order C  PREPAID  → released, cooked before B
18:40 guest B checks in → B's items released now, join queue by time
```

### 7.4 Edge cases to handle

- Booking cancelled after jobs were scheduled → job checks the item status first and does nothing if CANCELLED (jobs must be **idempotent**).
- Restaurant marks a dish sold out after a prepaid order → alert in restaurant app; staff offer a replacement or refund that line (§10.10 A).
- Item refunded or cancelled while HOLD / SCHEDULED / QUEUED → remove from kitchen queue at once (`kitchen.item_updated` with CANCELLED). If already COOKING → kitchen sees a red "Cancelled — stop if possible" flag.
- Customer arrives early and checks in → recompute fire times from `checkedInAt` if earlier than planned (setting: "start early when guest arrives early").
- Customer adds dishes at the table → staff add them in the restaurant app as a new order round (OrderItem with `round = 2`, kitchenStatus QUEUED).
- Server restart → BullMQ delayed jobs survive in Redis. Also run a "safety sweep" job every minute: any SCHEDULED item with `scheduledStartAt <= now` → release.

### 7.5 "I'm leaving now" (lunch)

```
POST /bookings/:id/depart   { lat, lng }
1. Booking CONFIRMED, now within arrivalAt − 45 min … arrivalAt + grace.
2. travelMinutes = Goong Distance Matrix (walking if < 1.5 km, else motorbike) — fallback: distance / 4 km/h walking.
3. etaAt = now + travelMinutes. departedAt = now.
4. If |etaAt − arrivalAt| > 3 min → recompute fire times with arrival = etaAt,
   remove old kitchen-release jobs, add new ones (only for items not yet COOKING).
5. COD booking: departing counts as a "soft check-in" only if restaurant setting
   `codStartOnDepart = true` (default false; no-show risk stays with restaurant).
6. Move no-show job to etaAt + grace. Emit "booking.eta_updated" to restaurant.
```

Push at `arrivalAt − travelMinutes − 5 min`: "Time to leave for lunch? Tap when you go."

### 7.6 Kitchen capacity limit

When building available slots (§8.1) and when creating a booking:

```
window = floor(firstFireTime, windowMinutes)
used   = SUM(quantity) of OrderItems (kitchenStatus NOT IN CANCELLED, SERVED)
         with scheduledStartAt in [window, window + windowMinutes)
if used + newItems > rule.maxItems → slot not available for pre-order
```

- Booking without pre-order is still allowed (table only) if tables are free.
- Show "Pre-order full at 12:00 — try 11:45 or 12:15" with the nearest open windows.
- Check inside the booking transaction with an advisory lock per restaurant + window (`pg_advisory_xact_lock(hash(restaurantId, window))`) so two orders cannot both take the last capacity.

---

## 8. Table availability and booking

### 8.1 Available time slots

Input: restaurantId, date, partySize, areaId?

1. Build slots from opening hours, step `slotMinutes` (e.g. 15), last slot = `closeMinute − diningMinutes` (or `lastOrderMinute`).
2. Remove slots earlier than `now + minLeadMinutes`, and slots inside a Closure.
3. For each slot, a slot is available if at least one active table with `minSeats ≤ partySize ≤ maxSeats` (in the area if given) has no overlapping active booking in `[slot, slot + diningMinutes)`.
4. Do this in **one SQL query** per date, not one per slot:

```sql
SELECT s.slot
FROM generate_series($dayOpen, $dayLastSlot, ($step || ' minutes')::interval) AS s(slot)
WHERE EXISTS (
  SELECT 1 FROM "Table" t
  WHERE t."restaurantId" = $rid AND t."isActive"
    AND $party BETWEEN t."minSeats" AND t."maxSeats"
    AND ($area IS NULL OR t."areaId" = $area)
    AND NOT EXISTS (
      SELECT 1 FROM "Booking" b
      WHERE b."tableId" = t.id
        AND b.status IN ('PENDING','CONFIRMED','CHECKED_IN')
        AND tstzrange(b."arrivalAt", b."endsAt") && tstzrange(s.slot, s.slot + $dining)
    )
);
```

Cache the result in Redis for 30 seconds (key `avail:{rid}:{date}:{party}:{area}`), delete the key when a booking for that restaurant changes.

### 8.2 Creating a booking (transaction)

```
POST /bookings
1. Validate: restaurant ACTIVE, slot valid, partySize ok, user not BLOCKED.
2. If user.mustPrepay and paymentMode = COD → 422 "PREPAY_REQUIRED".
3. If restaurant.allowCod = false and COD → 422.
4. Validate order items: exist, available, preorderable, options valid. 
   Recalculate prices on the server (ignore prices sent by app).
5. Apply voucher (lock voucher row: SELECT ... FOR UPDATE, check limits).
6. Pick table: smallest maxSeats that fits and is free. Insert booking.
   On exclusion error 23P01 → try next table; none left → 409 "SLOT_TAKEN".
7. Prepaid → status PENDING, create Payment, return checkoutUrl. Schedule payment-timeout job.
   COD    → status CONFIRMED, items HOLD. Schedule no-show job.
8. Commit. Emit restaurant socket "booking.created". Send push to restaurant staff.
```

Use an `Idempotency-Key` header on `POST /bookings` and payment creation, stored in Redis 24h, so a double tap does not create two bookings.

### 8.3 Cancellation

- Customer can cancel until `arrivalAt − cancelCutoffMinutes` (setting, default 60).
- Prepaid refund depends on `prepaidRefundRule`: BEFORE_COOKING = full refund if no item started; NEVER; FULL_UNTIL_CUTOFF. Full flow and amounts: §10.8–10.9.
- Release voucher redemption (`usedCount − 1`) if cancelled before arrival.
- Remove scheduled BullMQ jobs (job ids are deterministic: `release:{bookingId}:{course}`, `noshow:{bookingId}`).

### 8.4 Group orders (lunch with colleagues, nhậu groups)

```
Host creates booking (party size, time) with isGroupOrder = true
  → GroupInvite token, link: https://comi.vn/g/{token}
Host shares the link (Zalo, Messenger)
Guest opens link → app (or web page if not installed: name + add dishes + pay by QR)
  → BookingGuest row, adds OrderItems with guestId
Everyone sees the shared cart live (socket room "g:{bookingId}")
Order cutoff (default arrivalAt − 20 min, or host taps "Lock order")
  → items checked against kitchen capacity → order PLACED
```

Payment options (host chooses when creating):

| Mode | How |
|---|---|
| **Host pays all** | One payment by host; split is only shown as info. |
| **Each pays own** | Each guest pays their items (+ equal share of shared items) before cutoff. Unpaid guest items at cutoff → removed, or host pays them (host choice). Booking becomes CONFIRMED when the host's part is paid; kitchen fires only paid items. |

Large groups:
- `partySize > largest table` → API combines free tables in the same area (`extraTableIds`); the exclusion constraint is checked for every table.
- `partySize > confirmGroupsOver` → `needsApproval = true`, status stays PENDING until restaurant taps Approve (timeout 2 h → auto-cancel + refund).

### 8.5 Ordering at the table and splitting the bill (nhậu)

- After check-in, menu screen shows "Order to table". New items get `round = n+1`, status QUEUED immediately, emit to kitchen.
- Restaurant setting `allowTableOrdering` (default true) and `tableOrderingNeedsApproval` (staff confirm each round — some quán want this).
- Live bill: `GET /bookings/:id/bill` = all rounds, per guest, totals.
- Split: EQUAL (by number of guests), BY_ITEMS (each guest's `guestId` items + equal share of untagged items), CUSTOM (amounts must sum to total).
- Each guest pays their part with the restaurant's PayOS QR; or cash to staff (staff marks guest paid).
- Cashier "Close bill" stays required; `finalBillAmount` = live bill total (editable for items added off-app). Fee base unchanged (§11).
- After close: show "Get home safe" with Grab / Be / Xanh SM deep links (destination prefilled if the user saved a home address).

### 8.6 Table map — choose your table (like choosing an airplane seat)

Optional per restaurant (`allowTableChoice`). If off, the server picks the table automatically (§8.2).

**What the customer sees**

```
 Floor 1 – Indoor        [Floor 1] [Floor 2] [Rooftop]        date 20/12 · 19:00 · 4 people
 ┌──────────────────────────────────────────────────────────┐
 │ ▓▓▓▓ WINDOW ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              │
 │  ┌────┐   ┌────┐    ( 2 )   ( 2 )        ┌──────────┐   │
 │  │ 4  │   │ 4  │                          │   10     │   │
 │  │ A1 │   │ A2 │    B1      B2            │   VIP1   │   │
 │  └────┘   └────┘                          └──────────┘   │
 │   green    grey      dim     dim             green        │
 │                                                           │
 │  ┌────────┐ ┌────────┐       ║ KITCHEN ║    🚪 ENTRANCE    │
 │  │   6    │ │   6    │       ║         ║                   │
 │  │  C1    │ │  C2    │                                     │
 │  └────────┘ └────────┘                                     │
 └──────────────────────────────────────────────────────────┘
  ■ Available  ■ Booked  ■ Selected  ■ Too small/large for 4   🪟 window  🔒 private
```

- Each table shows **its number of seats** (big number) and its code (A1).
- Colours:

| State | Colour | Can tap? |
|---|---|---|
| Available and fits party size | green | yes |
| Selected | brand colour + check mark | tap again to unselect |
| Booked / held at that time | grey | no |
| Does not fit party size (`partySize` outside `minSeats..maxSeats`) | dimmed | no (tooltip "For 6–8 people") |
| Not selectable (`isSelectable = false`) | not shown as choosable | no |

- Tap a table → bottom sheet: photo of the table (optional), seats, features (window, outdoor, private), surcharge if any, button **"Choose this table"**.
- Pinch to zoom and pan. Tabs for floors / areas. Show entrance, windows, kitchen, stage so people understand the room.
- "Let the restaurant choose" button is always available (fastest option, used by most lunch customers).
- Large groups: select several tables with the same `joinGroup` that are next to each other; total seats must be ≥ party size.

**Flow**

```
1. Customer picks date, time, party size (as now).
2. GET /restaurants/:id/table-map?areaId&arrivalAt&partySize
     → areas, map elements, tables with state for that time window.
3. Customer taps table → POST /restaurants/:id/table-holds { tableIds, arrivalAt, partySize }
     → hold for 5 minutes (like airline seat hold). Returns holdId + expiresAt.
     Holds live in Redis: key hold:{tableId}:{slot} with TTL 300 s, SET NX (first wins).
     Other customers see the table as grey while held.
4. Customer continues to menu / checkout with holdId.
5. POST /bookings { holdId, ... } → server checks the hold belongs to this user and is still valid,
     inserts booking with that tableId (exclusion constraint still protects it), deletes hold.
6. Hold expires → table free again. App shows a countdown "Table held for 4:32".
```

**Live updates:** while the map is open, the app joins socket room `map:{restaurantId}:{date}`; server emits `table.state` when a table is held, booked, or released, so two people do not fight for the same table.

**Rules**
- Restaurant can still move a booking to another table (e.g. broken table); customer gets a push "Your table changed to A3".
- Check-in by table QR (§9.2): if the guest sits at a different table, staff confirm the change.
- Table chosen is shown on the booking confirmation and in the kitchen / today board.
- Lunch mode: map is optional, default "Let the restaurant choose" to stay fast.

**Map editor (restaurant app)**
- Grid canvas per area (`gridCols × gridRows`), drag tables and elements, snap to grid, rotate, resize.
- Palette: rectangle table (2/4/6/8 seats), round table, booth, bar seat, plus elements (entrance, window, kitchen, stage, restroom, stairs).
- Set seats (`minSeats`, `maxSeats`), code, features, selectable on/off, join group.
- Templates to start quickly ("Small quán 10 tables", "Two floors + rooftop").
- "Preview as customer" button.
- Optional: upload a photo of the room as faint background to trace over.

**Flutter implementation**
- `InteractiveViewer` (zoom/pan) containing a `CustomPainter` (or `Stack` of positioned widgets) — tables drawn from grid coordinates × cell size.
- Same widget used in both apps: read-only + selectable in customer app, draggable in editor mode in restaurant app (put it in `packages/shared_ui`).
- Accessibility: list view alternative ("Show as list") with the same tables, seats and features.

---

## 9. Check-in and no-show

### 9.1 QR codes

Two kinds of QR, both printed by the restaurant from the restaurant app:

- **Table QR** (on each table): `https://comi.vn/c/{restaurantSlug}/{tableCode}?s={signature}`
- **Entrance QR** (one per restaurant): same, without table code.

`signature = base64url(HMAC_SHA256(table.qrSecret, restaurantId + tableId)).slice(0,16)`

The link is a **universal link / app link**: opens the app if installed, otherwise a web page asking to install.

### 9.2 Check-in request

```
POST /bookings/:id/check-in
body: { qrPayload, lat?, lng? }
```

Server checks:
1. Booking belongs to user and is CONFIRMED.
2. QR signature valid and restaurant matches booking.
3. Time window: `arrivalAt − 60 min ≤ now ≤ arrivalAt + graceMinutes`.
4. Optional: if GPS given, distance to restaurant < 300 m (log only, don't block — GPS indoors is bad).
5. If table QR differs from assigned table → reassign if that table is free, otherwise keep and log.

Then: status CHECKED_IN, `checkedInAt = now`, release COD items (§7.2), cancel no-show job, emit events.

Staff check-in: `POST /restaurant/bookings/:id/check-in` (role CASHIER+), method STAFF. Staff can search by booking code or phone.

### 9.3 No-show job

Scheduled at booking confirm: `noshow:{bookingId}` at `arrivalAt + graceMinutes`.

```
if booking.status != CONFIRMED → stop
booking.status = NO_SHOW; release table; cancel HOLD items
user.noShowCount += 1
if user.noShowCount >= NO_SHOW_LIMIT (3) → user.mustPrepay = true
if PREPAID → apply refund rule (items already cooking are not refunded)
     and compute FeeRecord on the paid amount kept by the restaurant
push to customer: "Your booking was marked as no-show"
```

Restaurant can also mark "Guest is late, keep table" → extend grace once by +15 min (reschedule job).
Rule to reset: `noShowCount` resets after 5 completed bookings in a row, or admin can reset.

---

## 10. Payments and refunds

### 10.1 Money flow (important for legal)

**Do not collect customers' money into the platform's bank account.** That needs a payment intermediary licence from the State Bank of Vietnam.

MVP approach: **each restaurant connects its own merchant account** (start with PayOS because sign-up is easy and it uses VietQR to the restaurant's own bank account). Money goes straight to the restaurant. The platform bills its fee monthly (§11).

Later: when volume is large, talk to MoMo / VNPay / a bank about a marketplace / split-payment product, so the fee is deducted automatically.

Store restaurant credentials (client id, api key, checksum key) encrypted with AES-256-GCM. The encryption key lives in env / a secret manager, never in the database.

### 10.2 Provider adapter interface

```ts
interface PaymentProviderAdapter {
  createPayment(input: {
    account: DecryptedCredentials;
    providerOrderId: string;      // PayOS needs a number: use a Postgres sequence
    amount: number;
    description: string;          // max 25 chars for PayOS: "TS 8K2P"
    returnUrl: string; cancelUrl: string;
    expiresAt: Date;
  }): Promise<{ checkoutUrl: string; qrCode?: string; deeplink?: string }>;

  verifyWebhook(headers: Record<string,string>, body: unknown, account: DecryptedCredentials): WebhookResult; // throws if bad signature
  getStatus(providerOrderId: string, account): Promise<PaymentStatus>;
  refund(payment: Payment, amount: number, account): Promise<RefundResult>;   // PayOS: may be manual bank transfer by restaurant
}
```

Implement in order: **PayOS → MoMo → VNPay → ZaloPay.** Card payments come through VNPay/MoMo.

### 10.3 Prepaid flow

```
App                      API                         Provider
 │ POST /bookings  ───►   create booking PENDING
 │                        create Payment (expires 15m)
 │                        adapter.createPayment ───► 
 │ ◄── checkoutUrl ─────                         ◄── link
 │ open link / bank app ─────────────────────────►  customer pays
 │                        POST /webhooks/payos ◄──── webhook
 │                        verify signature
 │                        insert WebhookEvent (unique → idempotent)
 │                        amount matches? → Payment PAID, Booking CONFIRMED
 │                        schedule kitchen + no-show jobs
 │ ◄── socket "booking.confirmed" / push
```

Rules:
- Webhook endpoint returns 200 quickly; heavy work goes into a BullMQ job.
- Never trust the app's "payment success" screen. Only the webhook (or a server status check) confirms.
- Job `payment-reconcile` every 5 minutes: for Payments PENDING > 3 min, call `getStatus` (in case a webhook was lost).
- Payment arrives after booking EXPIRED → if the slot is still free, confirm it; otherwise auto-refund and notify.
- Amount mismatch → mark FAILED, alert admin.

### 10.4 COD flow

Booking CONFIRMED immediately. At the end of the meal the cashier taps **"Close bill"** and enters the final amount (`finalBillAmount`). Payment happens outside the app (cash, restaurant's own QR). This creates the FeeRecord.

Reminder job: COD bookings CHECKED_IN for more than 6 hours without "Close bill" → push to restaurant; after 24 hours auto-close with `finalBillAmount = preOrderValue`.

### 10.5 Refunds — overview

Refunds are needed in two big situations:

1. **Cancel** — the whole booking/order is cancelled (by customer, restaurant, or system).
2. **Missing / wrong items** — one or more dishes are sold out, not served, wrong, or removed.

Principles:
- **Only prepaid money is refunded.** COD has no money in the app; a missing item is simply removed from the bill (`finalBillAmount` goes down) — no refund record needed, only an adjustment record for history.
- **Money is in the restaurant's merchant account** (§10.1), so **the restaurant funds every refund**. The platform never pays out of its own account (except optional goodwill, §10.12).
- **Refund goes back to the same method** the customer paid with (MoMo → MoMo wallet, card → card, VietQR bank transfer → bank account).
- **Every refund is a record** (`Refund` + `RefundItem`) with a reason, who started it, amount, and status. Never just edit numbers on `Payment`.
- **Refund amount is always calculated by the server** from what was actually paid for those items (including voucher share), never typed by the customer.
- **Idempotent:** each refund has an `idempotencyKey`; retries never refund twice.
- **Total refunded can never be more than total paid** (checked in the transaction with a row lock on Payment).

### 10.6 Data model

```prisma
model Refund {
  id              String       @id @default(uuid())
  bookingId       String
  paymentId       String               // which payment is refunded (group orders have several)
  amount          Int
  reason          RefundReason
  initiatedBy     ActorType             // CUSTOMER | RESTAURANT | SYSTEM | ADMIN
  initiatorId     String?
  method          RefundMethod          // API | MANUAL_TRANSFER
  status          RefundStatus @default(REQUESTED)
  providerRefundId String?
  idempotencyKey  String       @unique
  // for manual transfer (PayOS / bank QR without refund API)
  customerBankBin     String?
  customerAccountNo   String?           // encrypted
  customerAccountName String?
  proofUrl        String?               // screenshot of transfer uploaded by restaurant
  note            String?
  requestedAt     DateTime     @default(now())
  approvedAt      DateTime?
  completedAt     DateTime?
  failedReason    String?
  attempts        Int          @default(0)
  items           RefundItem[]
  booking         Booking      @relation(fields: [bookingId], references: [id])
  payment         Payment      @relation(fields: [paymentId], references: [id])
  @@index([status, requestedAt])
}

model RefundItem {
  id           String @id @default(uuid())
  refundId     String
  orderItemId  String
  quantity     Int
  amount       Int                     // paid amount for these units after voucher share
  refund       Refund @relation(fields: [refundId], references: [id])
}

model OrderIssue {                     // customer claim: missing / wrong / bad dish
  id           String   @id @default(uuid())
  bookingId    String
  orderItemId  String
  quantity     Int
  type         IssueType
  note         String?
  photoIds     String[]
  status       IssueStatus @default(OPEN)
  resolution   IssueResolution?
  refundId     String?
  restaurantNote String?
  createdAt    DateTime @default(now())
  respondedAt  DateTime?
}

enum RefundReason {
  CUSTOMER_CANCEL        // customer cancels before cutoff
  RESTAURANT_CANCEL      // restaurant cancels (closed, overbooked, etc.)
  GROUP_NOT_APPROVED     // large group not approved in time
  LATE_PAYMENT_NO_SLOT   // paid after expiry, slot gone
  ITEM_SOLD_OUT          // dish unavailable after prepaid
  ITEM_NOT_SERVED        // dish never came
  ITEM_WRONG             // wrong dish / wrong option
  ITEM_QUALITY           // restaurant agrees dish was bad
  ORDER_EDIT_DECREASE    // customer removed items before cutoff
  NO_SHOW_PARTIAL        // no-show: refund items not yet cooked (per rule)
  GROUP_GUEST_REMOVED    // group order: guest's paid items removed
  DUPLICATE_PAYMENT      // customer paid twice
  ADMIN_DISPUTE          // admin decision
}
enum ActorType       { CUSTOMER RESTAURANT SYSTEM ADMIN }
enum RefundMethod    { API MANUAL_TRANSFER }
enum RefundStatus    { REQUESTED APPROVED PROCESSING SUCCEEDED FAILED MANUAL_PENDING REJECTED CANCELLED }
enum IssueType       { MISSING WRONG_ITEM QUALITY }
enum IssueStatus     { OPEN ACCEPTED REJECTED ESCALATED RESOLVED }
enum IssueResolution { REFUND REMAKE REPLACE REJECTED }
```

Changes to existing models:

```prisma
model OrderItem {
  // ...existing fields
  paidAmount       Int @default(0)   // what the customer paid for this line after discount share
  refundedQuantity Int @default(0)
  refundedAmount   Int @default(0)
  removedReason    String?           // SOLD_OUT, NOT_SERVED, CUSTOMER_EDIT...
}

model Payment {
  // ...existing fields
  refundedAmount   Int @default(0)   // sum of SUCCEEDED + in-progress refunds (reserved)
  refunds          Refund[]
}

model Booking {
  // ...existing fields
  refundedTotal    Int @default(0)
}
```

### 10.7 Refund amount calculation

Voucher discount is shared across items in proportion to their price, so a refunded item returns exactly what was paid for it.

```ts
// refunds/refund-calculator.ts — pure function, 100% unit-tested
// At payment time, store paidAmount on each OrderItem:
//   lineTotal_i = unitPrice_i × qty_i
//   discountShare_i = round(totalDiscount × lineTotal_i / subtotal)   (last line takes the rounding remainder)
//   paidAmount_i = lineTotal_i − discountShare_i
export function refundForItem(
  item: { paidAmount: number; quantity: number; refundedQuantity: number; refundedAmount: number },
  qty: number,
): number {
  const remainingQty = item.quantity - item.refundedQuantity;
  if (qty <= 0 || qty > remainingQty) throw new Error('INVALID_QTY');
  const remainingPaid = item.paidAmount - item.refundedAmount;
  // Refunding the last units returns the exact remainder, so rounding never loses or adds 1 VND.
  return qty === remainingQty ? remainingPaid : Math.floor((item.paidAmount * qty) / item.quantity);
}
```

Voucher rules on refund:
- **Full cancel before arrival** → voucher released (`usedCount − 1`), customer can use it again.
- **Partial refund** → voucher stays used; refund = item's `paidAmount` share (already includes its part of the discount).
- If after a partial refund the order falls below the voucher's `minOrder` → still keep the voucher (simple, customer-friendly). Log it.
- **Platform-funded discount** part is not refunded to the customer as cash (they never paid it); the platform credit on the statement is reduced by the same share.

### 10.8 Refund policy table

| Situation | Who starts | Refund | Approval | Notes |
|---|---|---|---|---|
| Customer cancels **before cutoff** (`arrivalAt − cancelCutoffMinutes`) | Customer | 100% of paid | Automatic | Voucher released |
| Customer cancels **after cutoff**, nothing cooking | Customer | Per `prepaidRefundRule` (default: 100% if no item started) | Automatic | |
| Customer cancels, some items **COOKING / READY** | Customer | Only items still HOLD / SCHEDULED / QUEUED | Automatic | Cooked items are not refunded |
| **Restaurant cancels** (any reason) | Restaurant | **100% always** | Automatic | Counts against restaurant reliability score; customer gets apology voucher (optional, platform-funded) |
| Large group **not approved** in 2 h | System | 100% | Automatic | |
| Payment arrives after **expiry**, slot taken | System | 100% | Automatic | |
| **Duplicate payment** | System | Extra payment 100% | Automatic | Detected by reconcile job |
| **No-show** (prepaid) | System | Items not yet started, per rule (`NEVER` = 0) | Automatic | Started items kept by restaurant |
| Customer **removes items before cutoff** (edit order) | Customer | Removed items' paid amount | Automatic | Items removed from kitchen queue |
| Dish **sold out** after prepaid (before cooking) | Restaurant | That item's paid amount | Automatic when staff mark "Sold out – refund" | Or staff offer replacement (§10.10) |
| Dish **not served** / **missing** (customer claims) | Customer | That item's paid amount | **Restaurant approves** (auto-approve after 2 h no answer) | §10.10 |
| **Wrong dish** / wrong options | Customer | Item amount, or remake | Restaurant decides | |
| **Bad quality** | Customer | Item amount if restaurant agrees | Restaurant decides; can escalate to admin | |
| Group guest's items removed at cutoff | System | That guest's paid items | Automatic | Refund to that guest's payment |
| Dispute after restaurant rejects | Customer → Admin | Admin decides | Admin | §10.12 |

Restaurant settings that affect refunds: `cancelCutoffMinutes`, `prepaidRefundRule`, `autoApproveIssueAfterMinutes` (default 120, minimum 30).

### 10.9 Cancel flow (whole order)

```
POST /bookings/:id/cancel  (customer)   or   POST /restaurant/bookings/:id/cancel  (restaurant)
Transaction:
  1. Lock booking + payments (SELECT ... FOR UPDATE).
  2. Check status allows cancel (PENDING / CONFIRMED; CHECKED_IN only by restaurant).
  3. For each OrderItem:
       HOLD / SCHEDULED / QUEUED → CANCELLED (refundable)
       COOKING / READY / SERVED  → keep (not refundable on customer cancel; refundable on restaurant cancel)
  4. amount = Σ refundable items' (paidAmount − refundedAmount)   (restaurant cancel: all remaining paid)
  5. Create Refund(s) per Payment (largest-first), status APPROVED, idempotencyKey = "cancel:{bookingId}".
  6. Booking → CANCELLED, release table + holds, release voucher (if before arrival), remove BullMQ jobs.
  7. Payment.refundedAmount += amount (reserved).
  8. Emit kitchen events (items removed), push to customer and restaurant.
After commit: enqueue job refund-process(refundId).
```

Customer sees before confirming: **"You will get back 350.000 ₫ to MoMo. 2 dishes are already being cooked and cannot be refunded (120.000 ₫)."** — from `GET /bookings/:id/cancel-preview`.

### 10.10 Missing / wrong item flow

**A. Restaurant finds the problem first (sold out, can't make it)**

```
Restaurant app → booking → item → "Can't serve this dish"
  options:  [Refund this item]   [Offer replacement]
  Refund → OrderItem CANCELLED (removedReason SOLD_OUT) → Refund(reason ITEM_SOLD_OUT, auto-approved)
  Replace → choose dish of equal or lower price → customer gets push to accept/decline
            accept: swap item (price difference lower → refund difference; higher → restaurant absorbs)
            decline or no answer in 10 min / at arrival → refund the item
```

Also: when an item is set `isAvailable = false`, the restaurant app lists all upcoming prepaid bookings containing it and asks staff to resolve each one.

**B. Customer reports a problem (during or after the meal)**

```
Customer app → booking → "Report a problem" (from check-in until 24 h after bill close)
  choose item(s) + quantity, type (MISSING / WRONG_ITEM / QUALITY), note, optional photo
  → OrderIssue OPEN → push + sound on restaurant tablet
Restaurant responds:
  [Bring it now]      → issue RESOLVED (REMAKE), no refund; item goes back to QUEUED with high priority
  [Refund]            → Refund(reason ITEM_NOT_SERVED / ITEM_WRONG / ITEM_QUALITY), APPROVED
  [Reject + reason]   → issue REJECTED; customer can "Ask comi to review" → ESCALATED (admin)
No response in autoApproveIssueAfterMinutes (MISSING only) → auto-refund
```

Guards against abuse:
- Only items with `kitchenStatus` not SERVED can be auto-refunded as MISSING. If staff marked the item SERVED, the claim needs restaurant approval.
- Track `issueRate` per customer; above a threshold (e.g. > 20% of bookings with claims) → claims need manual review.
- Track per restaurant too (many MISSING claims = problem restaurant → admin alert).

**C. COD bookings**

No refund. Staff remove the item from the live bill; `OrderItem.removedReason` is set and `finalBillAmount` is reduced. The fee is calculated on the corrected bill.

### 10.11 Refund processing (money movement)

Provider support (check each provider's current docs before building):

| Provider | Refund method | Partial refund | Typical time to customer |
|---|---|---|---|
| MoMo | API | Yes | Minutes to 1 day |
| ZaloPay | API | Yes | Minutes to 1 day |
| VNPay | API (refund command) | Yes | Wallet/ATM: 1–3 days; international card: 5–15 working days |
| PayOS (VietQR bank transfer) | No standard refund API → **manual transfer by restaurant** (or PayOS payout API if the restaurant has it enabled) | Yes | When restaurant transfers |

**Job `refund-process` (BullMQ, retries with backoff: 1 min, 5 min, 30 min, 2 h, 12 h):**

```
load refund; if status not APPROVED/PROCESSING → stop (idempotent)
method API:
  status PROCESSING; call adapter.refund(payment, amount, idempotencyKey)
  success → SUCCEEDED, completedAt, Payment.status REFUNDED / PARTIALLY_REFUNDED
  pending → keep PROCESSING; job refund-status-poll checks later (and provider webhook if offered)
  error   → attempts++; retry; after last retry → FAILED + alert admin + restaurant
method MANUAL_TRANSFER:
  if customer bank info missing → push customer "Enter your bank account to receive refund"
        (prefill from the VietQR payer info when the provider gives it)
  status MANUAL_PENDING → restaurant app shows "Refunds to pay" with a VietQR code
        (bank BIN + account + amount + memo "TS REFUND {code}") so staff can pay in 1 scan
  restaurant taps "Done" + uploads proof → SUCCEEDED
  customer can tap "I didn't receive it" within 7 days → ESCALATED to admin
```

Reminders: `refund-manual-reminder` job — MANUAL_PENDING after 24 h → remind restaurant; after 72 h → escalate to admin, restaurant flagged.

### 10.12 Disputes and platform protection

- Admin screen: all FAILED / ESCALATED refunds and issues, with booking timeline (kitchen statuses with timestamps, check-in time, photos, chat notes).
- Admin decisions: approve refund (restaurant must pay), reject, or **goodwill credit** — the platform gives the customer an app voucher (not cash) at its own cost.
- If a restaurant refuses to pay a refund the admin approved: the platform may pay the customer and **deduct it from the restaurant's next statement** (`StatementAdjustment`). This must be written in the restaurant partner contract.
- Restaurant reliability score = f(restaurant cancels, rejected issues lost on appeal, slow refunds). Low score → lower search ranking, then PAUSED.

```prisma
model StatementAdjustment {
  id           String  @id @default(uuid())
  restaurantId String
  statementId  String?
  type         String              // REFUND_RECOVERY | FEE_CORRECTION | GOODWILL
  amount       Int                 // + restaurant owes platform, − platform owes restaurant
  refundId     String?
  bookingId    String?
  note         String?
  createdAt    DateTime @default(now())
}
```

### 10.13 Effect on platform fee

- Fee base is reduced by refunded amounts: `base = paid − refundedTotal` (prepaid) or the corrected `finalBillAmount` (COD).
- Refund before FeeRecord is FINAL → recalculate the FeeRecord.
- Refund after the fee was BILLED on a statement → `StatementAdjustment(FEE_CORRECTION, −feeDifference)` on the next statement.
- Full cancel → FeeRecord WAIVED.
- Gateway fees on refunded payments are usually **not** returned by the gateway — the restaurant bears them (state this in the partner contract and show it in reports).

### 10.14 Notifications and receipts

| Event | Customer | Restaurant |
|---|---|---|
| Refund created | Push + in-app: amount, method, expected time | Tablet notice (and "Refunds to pay" if manual) |
| Refund succeeded | Push + email receipt | — |
| Refund failed / delayed | Push "We're working on it" | Push + alert |
| Bank info needed (manual) | Push with form link | — |
| Issue reported | — | Push + sound |
| Issue answered | Push | — |

Booking detail screen shows a **money timeline**: Paid 500.000 ₫ (MoMo) → Refund 80.000 ₫ (dish sold out) — Completed → Total paid 420.000 ₫.

If a VAT invoice was requested, the restaurant is notified that the invoiced amount changed (it may need an adjustment invoice).

---

## 11. Platform fee and monthly statements

### 11.1 Calculation

```ts
// fees/fee-calculator.ts — pure function, 100% unit-tested
export function calculateFee(base: number, plan: { rateBps: number; minFee: number; fixedFee: number }): number {
  if (base <= 0) return 0;
  const pct = Math.round((base * plan.rateBps) / 10_000);
  return Math.max(plan.minFee, pct + plan.fixedFee);
}
```

Fee base:

| Case | Base |
|---|---|
| PREPAID completed | `order.subtotal − restaurantDiscount` (platform voucher does not lower the base: restaurant still sells at full value) |
| COD completed | `max(preOrderValue − restaurantDiscount, finalBillAmount)` |
| Prepaid no-show (money kept) | amount kept by restaurant |
| Booking without any order, COD | `finalBillAmount` if entered, else no fee (setting) |
| Cancelled / fully refunded | 0, record WAIVED |
| Partly refunded | base minus refunded amount (§10.13) |

When: FeeRecord created with status PENDING at payment (prepaid) or check-in; becomes FINAL when the booking is COMPLETED / NO_SHOW. The FeePlan used is the one active at `arrivalAt`.

### 11.2 Launch pricing as FeePlan rows

```
FeePlan 1: rateBps=100, minFee=2000, effectiveFrom=firstOrderAt,        effectiveTo=firstOrderAt+3 months
FeePlan 2: rateBps=200, minFee=2000, effectiveFrom=firstOrderAt+3 months, effectiveTo=null
```

Created automatically when the restaurant receives its first order (`firstOrderAt`). Admin can add special plans for partners.

The payment gateway fee (1–2%) is charged by the gateway to the restaurant's own merchant account, so it is separate from the platform fee. Show both in the restaurant report.

### 11.3 Monthly statement

Job `statement-generate` at 02:00 on the 1st of each month (Vietnam time):

```
for each restaurant with FINAL fee records in last month and statementId = null:
  totalFee  = sum(feeAmount)
  credit    = sum(platformDiscount) of completed bookings   // platform pays back its vouchers
  amountDue = totalFee − credit
  create Statement (ISSUED), link fee records (status BILLED)
  render PDF (puppeteer or pdfmake) → upload → email owner
  payment: VietQR to platform bank account with memo "TS {statementId}"
```

If `amountDue < 0`, platform transfers the money to the restaurant.
Overdue after 15 days → status OVERDUE → warning; after 30 days → restaurant PAUSED (hidden from search).

---

## 12. Vouchers

- Funder: PLATFORM (marketing budget) or RESTAURANT.
- Types: FIXED (e.g. 50,000 VND) or PERCENT (bps, with `maxDiscount`).
- Checks on apply: active, date range, `minOrder`, `totalLimit`, `perUserLimit`, `firstOrderOnly` (user has no COMPLETED booking), restaurant scope.
- Lock the voucher row (`SELECT ... FOR UPDATE`) when applying, to avoid going over the limit.
- Only one voucher per booking in v1.
- Platform-funded discounts are reimbursed on the monthly statement (§11.3).
- Anti-abuse: one account per phone number; flag many accounts from the same device id.

---

## 13. VAT invoice (red bill) requests

1. At checkout or within the same day after the meal, customer taps **"Request VAT invoice"**.
2. Form: company name, tax code (MST), address, email. Option "Save for next time" → InvoiceProfile.
3. Validate tax code format: `^\d{10}(-\d{3})?$`. (Later: look up company name by MST through a public API to auto-fill.)
4. Create InvoiceRequest → status SENT_TO_RESTAURANT → push + email to restaurant with all details and booking amount.
5. Restaurant issues the invoice in its own e-invoice system, then in the app taps "Mark issued" and optionally uploads the PDF / enters invoice number.
6. App emails the customer (if PDF uploaded) and shows it in booking history.

Reminder job: request not ISSUED after 3 days → remind restaurant.
Later phase: adapters for MISA meInvoice, Viettel S-Invoice, VNPT Invoice to issue automatically. The restaurant remains the legal issuer.

---

## 14. Search and map

### 14.1 Nearby search query

```sql
SELECT r.id, r.name, r."ratingAvg", r."ratingCount", r."priceLevel",
       ST_Distance(r.location, ST_MakePoint($lng, $lat)::geography) AS distance_m
FROM "Restaurant" r
WHERE r.status = 'ACTIVE'
  AND ST_DWithin(r.location, ST_MakePoint($lng, $lat)::geography, $radius_m)
  AND ($cuisine IS NULL OR r."cuisineTags" && $cuisine)
  AND ($priceMax IS NULL OR r."priceLevel" <= $priceMax)
  AND ($minRating IS NULL OR r."ratingAvg" >= $minRating)
ORDER BY <distance_m | ratingAvg DESC | score DESC>
LIMIT 20 OFFSET $offset;
```

Map view: use bounding box instead of radius (`r.location && ST_MakeEnvelope(...)`), max 200 pins, cluster on the app side.

Filters: distance, cuisine, price level, app rating, "open now", "has table at HH:mm for N people" (run §8.1 only for the top 20 results).

Default ranking score: `0.5 × normalized rating + 0.3 × closeness + 0.2 × popularity (bookings last 30 days)`.

### 14.2 Map provider

- **Goong**: map tiles (with maplibre_gl), geocoding addresses when restaurants register, place autocomplete for "search area".
- **Google Places API (New)**: store only `googlePlaceId` permanently. Fetch rating + review count **only on the restaurant detail page**, use field mask `rating,userRatingCount` (cheapest SKU). Cache briefly in Redis and show "Google" attribution as required by Google's terms (check current terms for allowed cache time).
- Never call Google for map list pins.

---

## 15. Reviews and ratings

- Allowed only when booking is COMPLETED (or CHECKED_IN for > 1 hour) and within 14 days.
- One review per booking (unique constraint).
- Push reminder 2 hours after check-in: "How was your meal?"
- Rating 1–5 overall, optional food/service, text, up to 5 photos.
- Update `Restaurant.ratingAvg` and `ratingCount` in the same transaction (or a job).
- Restaurant can reply once. Restaurant can report a review → admin decides HIDDEN or keep.
- Badge "Verified visit" on every review (all reviews are verified by design — a key selling point).

---

## 16. Photos

Photos are the main visual feature, so treat them carefully.

### 16.1 Upload flow (direct to Cloudinary)

```
App: GET /media/upload-signature?kind=menu_item  → { signature, timestamp, folder, uploadPreset }
App: upload file directly to Cloudinary (not through our API)
App: POST /menu/items/:id/photos { publicId }    → API checks it with Cloudinary Admin API, saves width/height
Job: compute blurhash (small thumbnail) → save
```

### 16.2 Photo rules (checked in app before upload)

| Kind | Aspect ratio | Min size |
|---|---|---|
| Dish | 4:3 (crop tool in app) | 1200 × 900 |
| Restaurant cover | 16:9 | 1600 × 900 |
| Review | any, cropped to 1:1 thumbnail | 800 px |

In-app guide screen: natural light, plate centred, plain background, no text on photo.

### 16.3 Delivery URLs

Build URLs on the app side from `publicId`:

```
https://res.cloudinary.com/{cloud}/image/upload/c_fill,ar_4:3,w_{W},q_auto,f_auto/{publicId}
```

Sizes: list thumbnail 400 px, detail 1080 px, full screen 2048 px. `f_auto` serves WebP/AVIF. Show blurhash while loading.

Moderation: Cloudinary moderation add-on or manual review for review photos in admin.

---

## 17. Multiple languages

### 17.1 App text

- ARB files: `app_vi.arb` (source), `app_en.arb`, `app_ko.arb`, `app_zh.arb`, `app_ja.arb`.
- Default = phone language, if not supported → English; Vietnamese phones → Vietnamese. User can change in settings (saved to `User.locale`).
- Price format: always VND, `150.000 ₫` (vi) / `150,000 VND` (en). Use `intl` NumberFormat.
- Date/time: 24-hour, restaurant time zone.

### 17.2 Restaurant content (menu, descriptions)

- Restaurant writes in Vietnamese (source).
- On save, a BullMQ job `translate-content` calls Google Cloud Translation or DeepL for the other 4 languages → rows with `isMachine = true`.
- Restaurant (or admin) can edit any translation → `isMachine = false`; machine translation never overwrites a human edit.
- Source text changed → re-translate only rows with `isMachine = true`.
- API: client sends `Accept-Language: ko`; server returns translated fields with fallback `ko → en → vi`.
- Show a small "Translated automatically" label + toggle "Show original".

### 17.3 Server messages

Error codes are stable strings (`SLOT_TAKEN`, `PREPAY_REQUIRED`); the **app** translates them. Push notification and email templates are stored per locale on the server.

---

## 18. Authentication and roles

### 18.1 Customers

- Firebase Auth on the phone: phone OTP, Google, Apple (Apple Sign-In is required on iOS if Google sign-in is offered).
- App sends Firebase ID token to `POST /auth/customer/exchange` → API verifies with Firebase Admin → creates/loads User → returns own **access token (JWT, 15 min)** + **refresh token (random, 30 days, stored hashed, rotated on each use)**.
- Note: Firebase phone OTP SMS in Vietnam has a cost per SMS; compare with eSMS / SpeedSMS / Zalo ZNS OTP later if cost is high.
- **Account deletion** inside the app is required by Apple and Google: `DELETE /me` → anonymize personal data, keep bookings/fees for accounting.

### 18.2 Restaurant staff

- Email + password (argon2 hash), or invite link sent by the owner.
- One staff user can belong to several restaurants (chains). Token contains `staffId`; active restaurant chosen in app and sent as header `X-Restaurant-Id`.
- Kitchen tablet: long-lived "device session" with role KITCHEN only, so cooks do not need to log in each shift. Owner can revoke devices.

### 18.3 Permissions

| Action | OWNER | MANAGER | CASHIER | KITCHEN |
|---|---|---|---|---|
| Edit restaurant info, settings, payment account | ✔ | | | |
| Staff management, fee statements | ✔ | | | |
| Menu, photos, tables | ✔ | ✔ | | |
| View/manage bookings, check-in, close bill | ✔ | ✔ | ✔ | |
| Kitchen screen, item status | ✔ | ✔ | ✔ | ✔ |
| Reply to reviews, VAT invoice requests | ✔ | ✔ | ✔ | |

Implement with a `@Roles()` decorator and a guard that loads the membership for `X-Restaurant-Id`.

### 18.4 Admin

Separate admin users table (or env-configured list), 2FA (TOTP) required, IP allowlist if possible.

---

## 19. Real-time events and push notifications

### 19.1 Socket.IO

Namespaces and rooms:

| Namespace | Room | Who joins |
|---|---|---|
| `/restaurant` | `r:{restaurantId}` | staff (any role) |
| `/restaurant` | `r:{restaurantId}:kitchen` | kitchen screens |
| `/customer` | `u:{userId}` | customer app |

Auth: JWT in the handshake `auth.token`; server checks membership before joining.

Events:

| Event | To | Payload |
|---|---|---|
| `booking.created` / `booking.updated` | restaurant | booking summary |
| `booking.checked_in` | restaurant | bookingId, table |
| `kitchen.item_queued` / `kitchen.item_updated` | kitchen | item(s) |
| `booking.status` | customer | status |
| `order.item_status` | customer | itemId, status (cooking / ready) |

**Reconnect rule:** after reconnect the app calls the REST endpoint to reload the full state (`GET /restaurant/kitchen/queue`). Socket events are only "something changed" hints; REST is the truth. This avoids lost updates on bad Wi-Fi.

### 19.2 Push (FCM)

| Trigger | To |
|---|---|
| New booking / cancel | restaurant staff |
| Booking confirmed, payment failed | customer |
| Reminder 2 h and 30 min before arrival | customer (includes "tap to check in when you arrive") |
| Food ready (optional) | customer |
| No-show marked | customer |
| Review reminder | customer |
| VAT invoice request / issued | restaurant / customer |
| Statement issued | owner (also email) |

Kitchen tablet must keep the screen on (`wakelock_plus`) and play a sound on new items.

---

## 20. Background jobs

All in BullMQ, run in `worker.ts`. Every job is idempotent (safe to run twice). Use deterministic job ids so they can be removed on cancel.

| Queue / job | When | Does |
|---|---|---|
| `payment-timeout` | booking create + 15 min | PENDING → EXPIRED, release table, release voucher |
| `payment-reconcile` | every 5 min | ask provider for status of stuck PENDING payments |
| `webhook-process` | on webhook | process payment event |
| `kitchen-release` | at fire time | SCHEDULED → QUEUED |
| `kitchen-sweep` | every 1 min | release any overdue SCHEDULED items (safety net) |
| `no-show-check` | arrival + grace | mark NO_SHOW (§9.3) |
| `booking-reminder` | arrival − 2 h, − 30 min | push to customer |
| `cod-close-reminder` | check-in + 6 h / 24 h | remind / auto-close |
| `review-reminder` | check-in + 2 h | push |
| `translate-content` | on menu save | machine translation |
| `photo-process` | on upload | blurhash, checks |
| `statement-generate` | 1st of month 02:00 | monthly statements + PDF + email |
| `statement-overdue` | daily | OVERDUE / pause restaurant |
| `invoice-reminder` | daily | remind restaurants of open VAT requests |
| `rating-recompute` | nightly | fix rating aggregates |
| `lunch-reminder` | every 5 min, Mon–Fri 9:30–11:30 | push to users whose `lunchReminderMinute` matches (skip if already booked today) |
| `leave-reminder` | arrival − travel − 5 min | "Time to leave? Tap I'm leaving now" |
| `group-cutoff` | arrivalAt − 20 min | lock group order, remove/assign unpaid items, place order |
| `group-approval-timeout` | create + 2 h | cancel unapproved large-group booking + refund |
| `exchange-rates` | daily | update ExchangeRate for approx. foreign prices |
| `refund-process` | on refund approved | call provider refund API or start manual flow; retries with backoff |
| `refund-status-poll` | every 10 min | check PROCESSING refunds with provider |
| `refund-manual-reminder` | hourly | MANUAL_PENDING > 24 h remind restaurant, > 72 h escalate |
| `issue-auto-approve` | issue created + `autoApproveIssueAfterMinutes` | auto-refund unanswered MISSING claims |
| `replacement-timeout` | offer + 10 min | customer didn't answer replacement offer → refund item |

Use Bull Board (`@bull-board/nestjs`) behind admin login to see failed jobs.

---

## 21. API endpoints

Base: `/api/v1`. JSON. Errors: `{ "error": { "code": "SLOT_TAKEN", "message": "...", "details": {} } }`. Pagination: cursor based (`?cursor=&limit=`).

### Auth & profile
```
POST   /auth/customer/exchange        Firebase token → our tokens
POST   /auth/staff/login
POST   /auth/refresh
POST   /auth/logout
GET    /me                            PATCH /me      DELETE /me
POST   /me/device-tokens
GET    /me/invoice-profiles           POST / PATCH / DELETE
```

### Customer: discovery
```
GET    /restaurants?lat&lng&radius&cuisine&priceMax&minRating&openNow&sort&cursor
GET    /restaurants/map?bbox=minLng,minLat,maxLng,maxLat
GET    /restaurants/:slug             detail (translated)
GET    /restaurants/:id/google-rating
GET    /restaurants/:id/menu          categories + items + photos + options
GET    /restaurants/:id/availability?date&partySize&areaId
GET    /restaurants/:id/reviews?cursor
GET    /search/suggest?q=             restaurant + dish names (accent-insensitive)
```

### Customer: booking
```
POST   /vouchers/validate             { code, restaurantId, subtotal }
POST   /bookings                      Idempotency-Key header
GET    /bookings?status=upcoming|past
GET    /bookings/:id
PATCH  /bookings/:id/order            change pre-order before cutoff (prepaid: pay the difference)
POST   /bookings/:id/cancel
POST   /bookings/:id/check-in
POST   /bookings/:id/payments         retry payment
GET    /bookings/:id/payments/:pid    status poll (fallback)
POST   /bookings/:id/invoice-request
POST   /bookings/:id/review
GET    /bookings/:id/cancel-preview   how much will be refunded and why
GET    /bookings/:id/refunds          money timeline
POST   /bookings/:id/issues           report missing / wrong / bad item { orderItemId, quantity, type, note, photoIds }
POST   /bookings/:id/issues/:iid/escalate
POST   /bookings/:id/replacements/:rid/accept | /decline
PUT    /refunds/:id/bank-account      for manual-transfer refunds
POST   /refunds/:id/not-received      within 7 days
POST   /bookings/:id/depart           "I'm leaving now" { lat, lng }
POST   /bookings/:id/reorder          create new booking draft from a past one
POST   /bookings/:id/group-invite     → share link
GET    /groups/:token                 preview (works without login for web page)
POST   /groups/:token/join
PUT    /bookings/:id/guests/me/items  my items in the shared cart
POST   /bookings/:id/guests/me/pay
POST   /bookings/:id/lock-order       host only
POST   /bookings/:id/table-order      order more at the table (new round)
POST   /bookings/:id/service-requests { type, note }
GET    /bookings/:id/bill             live bill per guest
PUT    /bookings/:id/split            { mode, custom? }
CRUD   /me/favorites                  CRUD /me/saved-orders
PATCH  /me/preferences
GET    /collections                   holiday / seasonal lists
GET    /restaurants/:id/table-map?areaId&arrivalAt&partySize   tables + state + map elements
POST   /restaurants/:id/table-holds   { tableIds, arrivalAt, partySize } → 5-min hold
DELETE /table-holds/:holdId           release when user goes back
GET    /home?lat&lng                  time-of-day sections
```

### Restaurant app
```
POST   /restaurant/register           creates DRAFT + OWNER
GET    /restaurant/me                 restaurants of this staff
PATCH  /restaurant/profile            info, location, hours, settings
POST   /restaurant/submit             DRAFT → PENDING_REVIEW
CRUD   /restaurant/closures
CRUD   /restaurant/areas
CRUD   /restaurant/tables             + GET /restaurant/tables/:id/qr (PNG/PDF)
CRUD   /restaurant/menu/categories
CRUD   /restaurant/menu/items         + PATCH /items/:id/availability
POST   /restaurant/menu/import        Excel/CSV upload → preview → confirm
PUT    /restaurant/menu/items/:id/translations/:locale
POST   /restaurant/menu/items/:id/photos       DELETE /photos/:pid   PATCH order
GET    /media/upload-signature
CRUD   /restaurant/staff              invite, change role, remove
PUT    /restaurant/payment-accounts/:provider
GET    /restaurant/bookings?date&status
GET    /restaurant/bookings/:id
POST   /restaurant/bookings/:id/check-in
POST   /restaurant/bookings/:id/extend-grace
POST   /restaurant/bookings/:id/cancel
POST   /restaurant/bookings/:id/close-bill    { finalBillAmount }
POST   /restaurant/bookings/:id/items         add items at table
POST   /restaurant/bookings/:id/fire-course   { course: DESSERT }
POST   /restaurant/bookings          walk-in / phone booking (optional)
GET    /restaurant/kitchen/queue
PATCH  /restaurant/kitchen/items/:id   { status: COOKING | READY | SERVED }
GET    /restaurant/invoice-requests    PATCH /:id (issued, pdf)
GET    /restaurant/reviews             POST /:id/reply   POST /:id/report
GET    /restaurant/reports/daily?from&to
GET    /restaurant/statements          GET /:id (PDF)
POST   /restaurant/bookings/:id/items/:itemId/unavailable   { action: REFUND | OFFER_REPLACEMENT, replacementItemId? }
POST   /restaurant/bookings/:id/items/:itemId/remove        COD: remove from bill
GET    /restaurant/issues?status=OPEN
POST   /restaurant/issues/:id/respond    { action: REMAKE | REFUND | REJECT, note }
GET    /restaurant/refunds?status=MANUAL_PENDING
POST   /restaurant/refunds/:id/mark-paid   { proofUrl }
PUT    /restaurant/areas/:id/layout   save whole map (tables positions + elements) in one request
CRUD   /restaurant/areas/:id/elements
POST   /restaurant/bookings/:id/move-table   { tableId }
CRUD   /restaurant/dining-rules
CRUD   /restaurant/capacity-rules
GET    /restaurant/service-requests?status=OPEN   PATCH /:id (DONE)
POST   /restaurant/bookings/:id/approve           large groups
POST   /restaurant/bookings/:id/rounds/:n/confirm (if table ordering needs approval)
POST   /restaurant/bookings/:id/guests/:gid/mark-paid   cash
```

### Webhooks
```
POST   /webhooks/payos/:restaurantId
POST   /webhooks/momo/:restaurantId
POST   /webhooks/vnpay/:restaurantId   (VNPay IPN is GET — support both)
POST   /webhooks/zalopay/:restaurantId
```

### Admin (AdminJS + a few custom endpoints)
Approve/reject restaurants, edit FeePlans, vouchers, hide reviews, view bookings/payments, statements (mark paid), reset no-show counter, block users, Bull Board.

---

## 22. App screens

### 22.1 Customer app

| # | Screen | Notes |
|---|---|---|
| 1 | Splash / language choice (first run) | |
| 2 | Login | phone OTP, Google, Apple; "continue as guest" to browse |
| 3 | Home | location, search bar, categories, "near you", "top rated", vouchers banner |
| 4 | Search results – list | big photos, filters sheet |
| 5 | Search results – map | pins with clustering, bottom card carousel |
| 6 | Restaurant detail | photo gallery, info, hours, app + Google rating, reviews, "Book" button |
| 7 | Menu | category tabs, **large photo cards**, swipe full-screen photo view, add to cart |
| 8 | Dish detail | photos, description, options, quantity, note |
| 9 | Booking form | date, time slots (chips), party size, area, note |
| 10 | Cart / pre-order review | items grouped by course, serving style toggle |
| 11 | Checkout | prepaid / COD (COD disabled with reason if mustPrepay), voucher, VAT invoice toggle, total |
| 12 | Payment | open PayOS/MoMo/etc., waiting screen with live status |
| 13 | Booking confirmed | code, QR, add to calendar, directions |
| 14 | My bookings | upcoming / past |
| 15 | Booking detail (live) | status timeline, scan to check in, dish progress (cooking / ready), cancel |
| 16 | QR scanner | check-in |
| 17 | Review form | stars, text, photos |
| 18 | Profile | language, invoice profiles, payment history, delete account, privacy |
| 19 | Vouchers wallet | |
| 20 | Notifications | |
| 21 | Home – time-of-day modes | Lunch (10:00–13:30), Tonight/groups (16:00–23:00), tourist mode by language, holiday collections |
| 22 | Order again / My usual | from past bookings and saved orders, 2 taps to book |
| 23 | Group order lobby | share link, guest list, shared cart live, who paid, lock order |
| 24 | Join group (also web page) | name, add dishes, pay my part |
| 25 | "I'm leaving now" | big button on booking screen, shows ETA and "food will be ready at …" |
| 26 | At the table | order more, call staff buttons, live bill |
| 27 | Split bill | equal / by items / custom, pay my part |
| 28 | Get home safe | ride-hailing buttons after bill closed |
| 29 | Occasion options | occasion type, table request, add-ons (cake, flowers), set menus |
| 30 | Settings – lunch reminder, dietary tags, currency display | |
| 31 | **Table map picker** | floors/areas tabs, tables with seat counts, colours by state, zoom, hold countdown, "Let the restaurant choose", list view |
| 32 | Cancel booking | shows refund preview (amount, method, items not refundable) before confirming |
| 33 | Report a problem | choose dish + quantity, missing / wrong / quality, note, photo; status of the claim |
| 34 | Replacement offer | accept / decline replacement dish (10-min timer) |
| 35 | Money timeline | paid, refunds, status, expected time; "I didn't receive it" |
| 36 | Refund bank account form | for manual-transfer refunds (bank picker by BIN + account) |

### 22.2 Restaurant app (tablet, also works on phone)

| # | Screen | Notes |
|---|---|---|
| 1 | Login / choose restaurant / device mode (Manager or Kitchen) | |
| 2 | Onboarding wizard | info → location pin → hours → tables → menu → photos → payment account → submit |
| 3 | Today board | timeline of bookings by table (Gantt-style), check-in buttons, search by code/phone |
| 4 | Booking detail | items, status, add items, fire dessert, close bill, VAT request |
| 5 | **Kitchen screen** | large cards, "Now cooking" / "Queued" / "Upcoming" / "Waiting for guest (COD)"; tap Start / Done; sound alert |
| 6 | Floor plan / table map editor | grid canvas, drag/rotate/resize tables, seats per table, map elements (entrance, window, kitchen…), templates, preview as customer, print QR codes |
| 7 | Menu editor | categories, items, sold-out switch, translations tab |
| 8 | Photo upload | camera with 4:3 frame overlay, photo tips |
| 9 | Menu import | upload Excel → preview table → confirm |
| 10 | Reviews | reply / report |
| 11 | Reports | revenue, bookings, no-shows, top dishes |
| 12 | Fees & statements | monthly list, PDF, pay via VietQR |
| 13 | Settings | staff, roles, booking rules (grace, dining time, COD on/off, refund rule), devices |
| 14 | Lunch & capacity settings | dining time per time window, kitchen max dishes per 15 min, `codStartOnDepart` |
| 15 | Service requests panel | "More ice", "Bill please"… with sound, tap Done |
| 16 | Live bill / split | see guests' parts, mark cash payments, close bill |
| 17 | Group approvals | approve large-group bookings, assign joined tables |
| 18 | Add-ons & set menus editor | cake/flowers with lead time, set contents |
| 19 | Problems inbox | customer claims with sound alert: Bring it now / Refund / Reject; sold-out items affecting upcoming bookings |
| 20 | Refunds to pay | manual refunds with VietQR to scan, upload proof, mark done; refund history |

---

## 23. Security, privacy and legal

### Security checklist
- HTTPS only; HSTS. Helmet headers.
- Validate every input with DTOs; whitelist mode (`forbidNonWhitelisted`).
- Rate limit: OTP exchange, login, booking create, voucher validate (anti brute force).
- All restaurant endpoints check membership + role; all customer endpoints check ownership (`booking.userId = me`). Write tests for "user A cannot read user B's booking".
- Webhooks: verify signature with the restaurant's checksum key, check amount, idempotent by WebhookEvent unique key.
- Secrets (merchant keys) encrypted at rest; never returned by the API (show only last 4 chars).
- Prices, discounts, fees always calculated on the server.
- Cloudinary uploads only via signed parameters, limited folder and size.
- Dependency scanning (GitHub Dependabot), Sentry for errors, audit log for money and status changes.
- Database backups daily, keep 30 days; test a restore once per month.

### Vietnam legal (check with a lawyer before launch)
- **Decree 13/2023/ND-CP (personal data protection)**: privacy policy in Vietnamese + English, clear consent checkbox at sign-up, purpose of each data type, process for data deletion requests, record of processing. Watch the newer Personal Data Protection Law and its decrees for changes.
- **Decree 53/2022/ND-CP**: some user data of Vietnamese users may need to be stored in Vietnam. Decide hosting (§24) with this in mind.
- **E-commerce**: an app that connects buyers and sellers is likely an "e-commerce service platform" — register with the Ministry of Industry and Trade (online.gov.vn) before launch.
- **Payments**: do not hold customer funds (§10.1).
- **Invoices**: restaurant issues VAT invoices; the platform issues its own invoice to restaurants for its monthly fee.
- **App stores**: account deletion in-app, privacy labels (Apple), data safety form (Google), Sign in with Apple.

---

## 24. Infrastructure and deployment

### 24.1 Environments

| Env | Where | Notes |
|---|---|---|
| local | Docker Compose: `postgis/postgis:16`, `redis:7`, `axllent/mailpit` | seed data |
| staging | 1 small VPS (2 vCPU, 4 GB) | payment sandbox keys, TestFlight / internal testing builds |
| production | VPS 4 vCPU / 8 GB to start, or AWS Singapore; managed Postgres if budget allows | |

Vietnamese providers (Viettel IDC, FPT Cloud, VNG Cloud, BizFly) are good if data must stay in Vietnam and latency matters.

### 24.2 Production layout (start)

```
Caddy (HTTPS, reverse proxy)
 ├── api       (NestJS, 2 instances via Docker, Socket.IO sticky sessions)
 ├── worker    (NestJS worker, 1 instance)
 ├── postgres  (PostGIS, daily pg_dump → object storage, or managed DB)
 └── redis     (AOF persistence ON — BullMQ delayed jobs must survive restarts)
```

### 24.3 CI/CD (GitHub Actions)

- On PR: lint, type-check, unit tests, integration tests (Testcontainers), `flutter analyze`, `flutter test`.
- On merge to `main`: build Docker image → push → deploy to staging (SSH + `docker compose pull && up -d`) → run `prisma migrate deploy`.
- Production deploy: manual approval or tag `v*`.
- Mobile builds: **Codemagic** or **Fastlane** — Android AAB to Play Console internal track, iOS to TestFlight. Use flavors `dev`, `staging`, `prod` (different API URL, Firebase project, app id suffix).

### 24.4 Monitoring

- Sentry (API + both apps).
- Uptime check on `/health` (UptimeRobot / Better Stack).
- Logs: pino JSON → Loki/Grafana or Better Stack.
- Alerts: failed jobs, webhook errors, payment mismatch, disk > 80%.

### 24.5 Environment variables (backend)

```
NODE_ENV, PORT, API_BASE_URL, APP_LINK_BASE_URL
DATABASE_URL, REDIS_URL
JWT_SECRET, REFRESH_TOKEN_PEPPER
FIREBASE_PROJECT_ID, FIREBASE_CLIENT_EMAIL, FIREBASE_PRIVATE_KEY
CREDENTIALS_ENCRYPTION_KEY            # 32 bytes base64, for merchant keys
CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET
GOONG_API_KEY, GOOGLE_PLACES_API_KEY
TRANSLATE_PROVIDER, TRANSLATE_API_KEY
EMAIL_PROVIDER, EMAIL_API_KEY, EMAIL_FROM
SENTRY_DSN
PLATFORM_BANK_ACCOUNT, PLATFORM_BANK_BIN   # for statement VietQR
NO_SHOW_LIMIT=3, PAYMENT_TIMEOUT_MINUTES=15
```

---

## 25. Testing

| Level | What | Tool |
|---|---|---|
| Unit (must be ~100%) | fee calculator, fire-time calculator, booking/kitchen state machines, voucher rules, slot generation, QR signature | Jest |
| Integration | booking create with real Postgres (double booking race: 20 parallel requests → exactly 1 success), check-in, no-show job, statement job | Jest + Testcontainers |
| API e2e | full prepaid flow with a fake payment adapter; COD flow; permissions (user A vs user B, kitchen vs owner) | Supertest |
| Payment sandbox | PayOS / MoMo / VNPay test environments, webhook via ngrok/cloudflared | manual + scripted |
| Flutter | widget tests for checkout, menu; golden tests for photo cards | flutter_test |
| App e2e | book → pay (fake) → check in → kitchen marks ready | Patrol or integration_test |
| Pilot | 1–3 real restaurants, real dinners, for 2–4 weeks | |

Time-based logic: inject a `Clock` service (never call `new Date()` directly in business code), so tests can move time forward.

---

## 26. Technical task list by phase

### Phase 1 — Foundation (4–6 weeks)

- [ ] Create monorepo, Melos, Docker Compose (PostGIS, Redis, Mailpit)
- [ ] NestJS skeleton: config validation, Prisma, pino logging, Swagger, error format, Clock service, health check
- [ ] Prisma schema §5.3 + raw SQL migration §5.4 + seed script
- [ ] Firebase project (dev/staging/prod); customer token exchange; staff login; refresh tokens; roles guard
- [ ] Restaurants module: register, profile, location (Goong geocode), opening hours, closures, settings, submit for review
- [ ] Tables module: areas, tables, floor plan positions, QR generation (PNG + printable PDF)
- [ ] Table map data: shape/size/rotation, MapElement, `PUT /areas/:id/layout`
- [ ] Shared Flutter widget `TableMap` (InteractiveViewer + painter) in `packages/shared_ui`
- [ ] Restaurant app: table map editor (drag, snap, rotate, templates, preview)
- [ ] Menu module: categories, items, option groups, sold-out toggle, sort order
- [ ] Media: Cloudinary signed upload, photo save, blurhash job
- [ ] Menu import from Excel/CSV (template file + preview)
- [ ] AdminJS: approve restaurants
- [ ] Generate Dart API client from OpenAPI; shared_models, shared_ui packages
- [ ] Restaurant app: login, onboarding wizard, menu editor, photo upload with 4:3 crop, tables + QR print
- [ ] CI pipeline; staging server; first deploy

### Phase 2 — Booking and ordering, lunch + nhậu basics (5–7 weeks)

- [ ] Search module: nearby, bounding box, filters, accent-insensitive text search
- [ ] Lunch / nhậu filters: "Under 60k", "Within 500 m", "Groups 10+", "Open late", "Private room"
- [ ] `DiningRule` (lunch 45 min / evening 120 min) used by availability
- [ ] Availability query §8.1 + Redis cache + invalidation
- [ ] Booking create transaction §8.2 with exclusion constraint retry + idempotency key
- [ ] Large groups: joined tables (`extraTableIds`), approval for > `confirmGroupsOver`
- [ ] **Table map picker**: table-map endpoint with per-time state, 5-min Redis holds (SET NX + TTL), hold → booking, live `table.state` socket events, multi-table select for groups, move-table by staff + push
- [ ] Order + OrderItem snapshot pricing; options validation; `isAlcohol` age confirmation
- [ ] Cancellation rules; job ids for removal
- [ ] Favorites, saved "my usual" order, "Order again"
- [ ] Customer app: home with lunch/tonight modes, list, map (maplibre + Goong), restaurant detail, menu with large photos, dish detail, cart grouped by course, booking form, checkout (COD only for now), my bookings, order again
- [ ] Restaurant app: today board (bookings timeline), booking detail, group approvals
- [ ] Push notifications (FCM) for new booking / confirmation; weekday lunch reminder
- [ ] Universal links / app links for QR and sharing

### Phase 3 — Kitchen queue, lunch speed, at-the-table (4–5 weeks)

- [ ] Kitchen state machine + fire-time calculator (unit tests first)
- [ ] BullMQ setup, worker process, Bull Board
- [ ] Jobs: kitchen-release, kitchen-sweep, no-show-check, booking-reminder, leave-reminder
- [ ] **Kitchen capacity limit** §7.6 (advisory lock, slot hiding, nearest-window suggestions)
- [ ] **"I'm leaving now"** §7.5 (Goong distance, reschedule fire times and no-show job)
- [ ] Check-in: QR signature, customer endpoint, staff endpoint, time window
- [ ] COD hold → release on check-in; no-show counter → mustPrepay
- [ ] Socket.IO gateway with Redis adapter; rooms; reconnect = REST reload
- [ ] **Order more at the table** (rounds) + **service requests** (call waiter, more ice, bill please)
- [ ] Restaurant app: kitchen screen (sections, sound, wakelock), service requests panel, fire dessert, close bill, lunch & capacity settings
- [ ] Customer app: QR scanner, live booking screen with dish status, "I'm leaving now", at-the-table screen
- [ ] Pilot with 1 lunch restaurant + 1 quán nhậu (COD only)

### Phase 3b — Group orders and split bill (2–3 weeks)

- [ ] GroupInvite link + BookingGuest + shared cart (socket room)
- [ ] Join-group web page for people without the app (name, dishes, pay by QR)
- [ ] Group cutoff job, host lock, unpaid-items rule
- [ ] Live bill per guest; split EQUAL / BY_ITEMS / CUSTOM; staff "mark paid (cash)"
- [ ] "Get home safe" ride-hailing deep links after bill close

### Phase 4 — Payment and fees (3–4 weeks)

- [ ] PaymentAccount with encrypted credentials; restaurant app screen to connect PayOS
- [ ] Payment adapter interface; PayOS adapter; webhook endpoint; WebhookEvent idempotency
- [ ] Prepaid flow: PENDING → payment → CONFIRMED; payment-timeout; payment-reconcile; late payment handling
- [ ] Prepaid as default at lunch; COD warning "cooking starts when you arrive"; optional prepaid voucher
- [ ] Group payments: each guest pays own part (multiple Payments per booking)
- [ ] Minimum refund before prepaid goes live: full refund on restaurant cancel / customer cancel before cutoff (manual is OK)
- [ ] **Refunds — full system (§10.5–10.14) — DEFERRED to "Later" in TODO.md:**
  - [ ] Refund, RefundItem, OrderIssue, StatementAdjustment models; `paidAmount` per OrderItem with voucher share
  - [ ] Refund calculator + policy engine (unit tests for every row of §10.8)
  - [ ] Cancel preview + cancel flow (customer and restaurant), voucher release, kitchen removal
  - [ ] Sold-out handling: refund item or offer replacement with timeout
  - [ ] Customer "Report a problem" → restaurant problems inbox → remake / refund / reject → escalate
  - [ ] `refund-process` job: MoMo, ZaloPay, VNPay refund APIs; status poll; retries; FAILED alerts
  - [ ] Manual-transfer refunds for PayOS: customer bank form, VietQR for staff, proof upload, reminders
  - [ ] Fee recalculation and statement adjustments after refunds
  - [ ] COD item removal (bill correction, no money movement)
  - [ ] Money timeline in customer app; refund receipts by email
  - [ ] Admin: disputes, goodwill voucher, refund recovery from statement
  - [ ] Integration tests: concurrent refunds never exceed paid amount; double job run refunds once
- [ ] MoMo adapter, then VNPay, then ZaloPay
- [ ] Fee calculator + FeePlan auto-creation on first order (1% → 2%, min 2,000)
- [ ] FeeRecord lifecycle; statement-generate job; PDF; email; VietQR for paying statements; overdue job
- [ ] VAT invoice request: customer form, saved profiles, restaurant inbox, mark issued, email to customer
- [ ] Restaurant reports: daily revenue, bookings, no-shows, fees

### Phase 5 — Growth + tourists (4–5 weeks)

- [ ] Reviews: create, verified only, photos, reply, report, rating aggregates, review reminder
- [ ] Google rating on detail page (Places API, field mask, cache, attribution)
- [ ] Map filters: rating, open now, "table available at time", ranking score
- [ ] Vouchers: platform + restaurant, validation, locking, wallet screen, statement credit; exclude alcohol items
- [ ] i18n: ARB files for 5 languages; content translation job; translation editor in restaurant app; fallback logic
- [ ] **Tourists:** international cards (VNPay/MoMo card gateway), dietary tags + filters, "English menu" badge, email login without phone, "show to taxi driver" screen, approx. foreign currency prices (exchange-rates job)
- [ ] Notification center screen

### Phase 6 — Launch (2–3 weeks)

- [ ] Security pass (§23 checklist), permission tests, rate limits
- [ ] Load test booking + availability (k6): 200 bookings/min, 2,000 concurrent sockets
- [ ] Privacy policy, terms, consent screens, account deletion
- [ ] Production server, backups, monitoring, alerts
- [ ] App Store + Google Play listings (screenshots, privacy labels), review submission
- [ ] Register e-commerce platform with MOIT
- [ ] Onboard first 20–30 restaurants in one office district (lunch + nhậu places); photo shoot support

### After launch
- [ ] **Occasions:** ambience tags + filters, table feature requests, add-ons with lead time (cake, flowers), set menus, occasion field, holiday collections (14/2, 8/3, 20/10, 24/12)
- [ ] Full admin website (Next.js)
- [ ] Automatic e-invoice integrations (MISA, Viettel, VNPT)
- [ ] POS integrations (iPOS, KiotViet, Sapo) to sync menus and bills
- [ ] Split payment / marketplace payments
- [ ] Waitlist, deposits for large groups, loyalty points
- [ ] Analytics (PostHog / Firebase Analytics), A/B tests

---

## 27. Open decisions

| # | Question | Default in this spec |
|---|---|---|
| 1 | Payment: each restaurant's own merchant account vs. platform split payment | Own account (PayOS) for MVP |
| 2 | Hosting in Vietnam or Singapore | Check Decree 53; staging anywhere |
| 3 | OTP provider | Firebase Auth; revisit cost |
| 4 | Fee on bookings with no pre-order (COD table only) | Fee on `finalBillAmount` if entered |
| 5 | Prepaid no-show refund policy | Restaurant setting, default BEFORE_COOKING |
| 6 | Grace time and no-show limit | 30 min, 3 no-shows |
| 7 | Can customers edit pre-order after paying? | Yes until cutoff; pay difference / partial refund |
| 8 | App name and domain | "comi", `comi.vn` (placeholder) |
| 9 | Minimum fee on small lunch bills | Lower min fee to 1,000 VND, or a lunch FeePlan (e.g. 2% with min 1,000 for 10:00–14:00) |
| 10 | COD lunch: start cooking on "I'm leaving now"? | Off by default; restaurant can turn on |
| 11 | Group order: what if a guest doesn't pay before cutoff | Host chooses: remove their items or host pays |
| 12 | Table ordering needs staff approval? | Off by default; per restaurant |
| 13 | Launch district | One office area in HCMC (District 1 / Bình Thạnh) or Hanoi (Cầu Giấy) |
| 14 | Charge extra for premium tables (VIP, view)? | Field exists (`surcharge`), set to 0 in v1; fee base would include it |
| 15 | Table hold time on the map | 5 minutes, then released |
| 16 | Auto-approve unanswered "missing item" claims after | 120 minutes (restaurant can set 30–240) |
| 17 | Who pays gateway fees on refunded payments | Restaurant (in partner contract) |
| 18 | Platform pays customer when a restaurant refuses an approved refund? | Yes, recovered from next statement (needs contract clause) |
| 19 | PayOS refunds | Manual transfer by restaurant in v1; check PayOS payout API later |
