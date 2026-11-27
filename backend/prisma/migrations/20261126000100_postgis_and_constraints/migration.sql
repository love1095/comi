-- §5.4 raw SQL that Prisma cannot express.

-- unaccent() is STABLE, so it cannot be used in an index directly. Wrap it in an
-- IMMUTABLE function that pins the dictionary.
CREATE OR REPLACE FUNCTION immutable_unaccent(text)
  RETURNS text
  LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT
AS $$ SELECT public.unaccent('public.unaccent'::regdictionary, $1) $$;

-- Accent-insensitive search ("pho" finds "Phở"). Vietnamese đ/Đ is not decomposed
-- by unaccent, so map it explicitly.
CREATE OR REPLACE FUNCTION search_norm(text)
  RETURNS text
  LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT
AS $$ SELECT translate(lower(immutable_unaccent($1)), 'đ', 'd') $$;

CREATE INDEX restaurant_name_trgm ON "Restaurant" USING GIN (search_norm(name) gin_trgm_ops);
CREATE INDEX menu_item_name_trgm  ON "MenuItem"   USING GIN (search_norm(name) gin_trgm_ops);

-- Never double-book a table (database-level guarantee). API catches SQLSTATE 23P01.
-- Prisma DateTime = timestamp(3) without time zone, always written as UTC → tsrange.
ALTER TABLE "Booking" ADD CONSTRAINT booking_no_overlap
  EXCLUDE USING GIST (
    "tableId" WITH =,
    tsrange("arrivalAt", "endsAt", '[)') WITH &&
  ) WHERE ("tableId" IS NOT NULL AND status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN'));

-- Sanity checks on money and settings.
ALTER TABLE "MenuItem"   ADD CONSTRAINT menu_item_price_nonneg CHECK (price >= 0);
ALTER TABLE "Table"      ADD CONSTRAINT table_seats_valid CHECK ("minSeats" >= 1 AND "maxSeats" >= "minSeats");
ALTER TABLE "Restaurant" ADD CONSTRAINT restaurant_price_level CHECK ("priceLevel" BETWEEN 1 AND 4);
ALTER TABLE "Booking"    ADD CONSTRAINT booking_time_order CHECK ("endsAt" > "arrivalAt");
