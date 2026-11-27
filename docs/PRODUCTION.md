# comi — production runbook

How to run comi in production (§24). Files live in [`deploy/`](../deploy) and [`loadtest/`](../loadtest).

## 1. Server

- One VPS to start: 4 vCPU / 8 GB, Ubuntu 24.04, Docker + compose plugin. A Vietnamese provider
  (Viettel IDC, FPT Cloud, VNG Cloud, BizFly) keeps data in Vietnam, which suits Decree 13/2023.
- Firewall: open 22 (your IP only), 80 and 443. Postgres and Redis are **not** published.
- DNS: `api.comi.vn` → server. Caddy gets the HTTPS certificate on first start.

## 2. First deploy

```sh
git clone https://github.com/love1095/comi /opt/comi && cd /opt/comi/deploy
cp .env.prod.example .env.prod          # fill every secret (openssl rand -base64 48 / 32)
docker compose -f docker-compose.prod.yml pull
docker compose -f docker-compose.prod.yml run --rm migrate
docker compose -f docker-compose.prod.yml up -d
curl -fsS https://api.comi.vn/api/v1/health    # {"status":"ok","db":"up","redis":"up"}
```

The image is built from `backend/Dockerfile` (CI pushes it; set `COMI_IMAGE` to pin a version).

## 3. Updating

```sh
export COMI_IMAGE=ghcr.io/love1095/comi-backend:v1.2.0
docker compose -f docker-compose.prod.yml pull
docker compose -f docker-compose.prod.yml run --rm migrate     # migrations are additive; run before the new code
docker compose -f docker-compose.prod.yml up -d api1 && sleep 20 && docker compose -f docker-compose.prod.yml up -d api2 worker
```

Restarting `api1` then `api2` keeps the API up (Caddy health-checks `/api/v1/health` and skips a
restarting instance). Rollback = the same steps with the previous tag (do not roll back migrations;
write a new one).

## 4. Backups

- `deploy/backup.sh` — `pg_dump -Fc` daily at 03:15, keeps 14 days, copies to `BACKUP_S3` if set.
  Cron: `15 3 * * * /opt/comi/deploy/backup.sh >> /var/log/comi-backup.log 2>&1`
- Redis runs with AOF (`appendfsync everysec`): delayed jobs (no-show checks, payment timeouts,
  kitchen fire times) survive restarts. Losing Redis is not data loss — sweep jobs re-create work —
  but back up `redisdata` weekly anyway.
- **Test a restore every month** on a scratch machine:
  `pg_restore -U comi -d comi_restore --clean --if-exists backups/comi-YYYYMMDD-HHMM.dump`

## 5. Monitoring and alerts (§24.4)

| What | How |
|---|---|
| Uptime | UptimeRobot / Better Stack on `https://api.comi.vn/api/v1/health` every minute. It returns **503** when Postgres or Redis is down. |
| Failed background jobs | The worker emails `ALERT_EMAIL` when a job uses up all retries (one mail per job type per 15 min). |
| Logs | pino JSON on stdout (tokens, passwords, cookies redacted). Ship with Better Stack / Loki, or `docker compose logs -f api1`. |
| Errors | ⬜ Sentry: add `@sentry/nestjs` + `SENTRY_DSN` once the account exists (apps: `sentry_flutter`). |
| Disk | Alert at 80 % (provider alert or `node_exporter`). Postgres + backups are the growth. |
| Payments | `payment-reconcile` runs every 5 min and logs mismatches; review PayOS dashboard weekly. |

## 6. Security checklist before launch (§23)

- [x] Every protected route refuses anonymous calls — `backend/test/security.e2e-spec.ts` walks the whole OpenAPI spec in CI.
- [x] Staff are scoped to their restaurant (`X-Restaurant-Id` membership check); owners are not admins.
- [x] Rate limits: global 300/min per IP, tighter on login, OTP exchange, booking, voucher check, reviews, group join, account deletion. Counters in Redis in production.
- [x] Revoked sessions (account deleted / blocked) kill access tokens immediately, not after 15 min.
- [x] Merchant payment keys encrypted with AES-256-GCM (`CREDENTIALS_ENCRYPTION_KEY`); webhooks verified by signature and stored once.
- [x] Helmet headers, HSTS at Caddy, request logs redact secrets.
- [x] Account deletion (customer + staff), data export, consent record with version.
- [ ] Lawyer review of `backend/src/modules/legal/legal-texts.ts` (privacy + terms are drafts).
- [ ] Register the app with the Ministry of Industry and Trade (online.gov.vn) — required for e-commerce apps in Vietnam.
- [ ] Rotate all secrets that ever lived in a dev `.env`.
- [ ] Run `loadtest/` against staging and record the numbers here.

## 7. Store submission

- **Privacy**: privacy policy URL `https://api.comi.vn/api/v1/legal/privacy?lang=en`; in-app account deletion is under Account → Xoá tài khoản (both apps).
- **Apple**: phone sign-in is fine; if Google/Facebook sign-in is ever added, Sign in with Apple becomes mandatory. Alcohol is shown → age rating 17+ (or 18+ in VN listing). Location is "when in use" only.
- **Google Play**: Data safety form — phone/email, name, approximate location, purchase history; data encrypted in transit; deletion available in app and on request.
- Test accounts for reviewers: a staging-free production restaurant "Quán Demo" and a guest number, written in the review notes.

## 8. Admin website

- Build: `cd admin_app && flutter build web --dart-define=API_URL=https://api.comi.vn`, copy `build/web/*`
  to `deploy/admin-web/` on the server; Caddy serves it at `admin.comi.vn` (see `deploy/Caddyfile`).
- **First admin**: register a normal staff account (restaurant app or `POST /api/v1/auth/staff/register`), then
  ```sh
  docker compose -f docker-compose.prod.yml exec postgres psql -U comi -c "UPDATE \"StaffUser\" SET \"isAdmin\" = true WHERE email = 'you@comi.vn';"
  ```
  Sign in at admin.comi.vn without a code → set up the authenticator → sign in again with the code.
- Admin routes **only** accept sessions opened with a TOTP code (`POST /auth/admin/login`); a code works once.
- **Lost phone**: another admin (or psql) clears 2FA, then the admin sets it up again at next sign-in:
  ```sql
  UPDATE "StaffUser" SET "totpSecretEnc" = NULL, "totpEnabledAt" = NULL, "totpLastStep" = NULL WHERE email = 'you@comi.vn';
  ```
  Every 2FA change and admin sign-in is in the audit log (Nhật ký).
