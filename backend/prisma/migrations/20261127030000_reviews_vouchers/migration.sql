-- Phase 5: review replies/reports (§15)
ALTER TABLE "Review" ADD COLUMN "repliedAt" TIMESTAMP(3);
ALTER TABLE "Review" ADD COLUMN "reportReason" TEXT;

-- Google rating on the detail page
ALTER TABLE "Restaurant" ADD COLUMN "googleRating" DECIMAL(2,1);
ALTER TABLE "Restaurant" ADD COLUMN "googleRatingCount" INTEGER;
ALTER TABLE "Restaurant" ADD COLUMN "googleRatingAt" TIMESTAMP(3);

-- Approximate foreign prices for tourists (admin keeps them fresh)
INSERT INTO "ExchangeRate" ("currency", "vndPerUnit", "updatedAt") VALUES
  ('USD', 25400, now()), ('KRW', 18.5, now()), ('CNY', 3500, now()), ('JPY', 165, now())
ON CONFLICT ("currency") DO NOTHING;
