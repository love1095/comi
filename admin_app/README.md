# comi admin (Flutter web)

Admin website: dashboard, restaurant approval, reported reviews, guests (block / reset no-shows),
booking lookup, monthly fee statements, platform vouchers, exchange rates, audit log.

```sh
flutter run -d chrome --dart-define=API_URL=http://localhost:3100
flutter build web --dart-define=API_URL=https://api.comi.vn   # → build/web, serve behind Caddy
```

Sign-in needs an admin account (`StaffUser.isAdmin`) **with 2FA**: the first sign-in without a code
opens the authenticator setup; after that every sign-in asks for the 6-digit code. Tokens are kept
in memory only — reloading the page signs out.
