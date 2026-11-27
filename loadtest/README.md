# Load tests (k6)

Run against **staging** (never production) with seed data. Install k6: https://k6.io/docs/get-started/installation/

```sh
k6 run -e BASE=https://staging-api.comi.vn -e RESTAURANT_ID=<id> loadtest/discovery.js
k6 run -e BASE=https://staging-api.comi.vn -e RESTAURANT_ID=<id> loadtest/booking.js
k6 run -e BASE=https://staging-api.comi.vn loadtest/sockets.js
```

Targets for launch (§24, 20–30 restaurants, lunch peak): p95 < 300 ms for discovery and availability at
200 virtual users; booking p95 < 800 ms with **no double booking** (the script checks every confirmed table
slot is unique); 2 000 socket connections held for 5 minutes on 2 API instances.

`NODE_ENV=staging` keeps the dev token login (`dev:<uid>:<phone>`), which the booking script uses —
production refuses it.
