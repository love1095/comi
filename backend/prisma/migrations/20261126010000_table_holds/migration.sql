-- AlterTable
ALTER TABLE "Booking" ADD COLUMN     "cancelledBy" TEXT;

-- AlterTable
ALTER TABLE "Restaurant" ADD COLUMN     "cancelCutoffMinutes" INTEGER NOT NULL DEFAULT 60;

-- CreateTable
CREATE TABLE "TableHold" (
    "id" TEXT NOT NULL,
    "holdId" TEXT NOT NULL,
    "restaurantId" TEXT NOT NULL,
    "tableId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "partySize" INTEGER NOT NULL,
    "startsAt" TIMESTAMP(3) NOT NULL,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TableHold_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "TableHold_holdId_idx" ON "TableHold"("holdId");

-- CreateIndex
CREATE INDEX "TableHold_restaurantId_startsAt_idx" ON "TableHold"("restaurantId", "startsAt");

-- AddForeignKey
ALTER TABLE "TableHold" ADD CONSTRAINT "TableHold_tableId_fkey" FOREIGN KEY ("tableId") REFERENCES "Table"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- A table can be held by only one customer for overlapping times (§8.6).
ALTER TABLE "TableHold" ADD CONSTRAINT table_hold_no_overlap
  EXCLUDE USING GIST ("tableId" WITH =, tsrange("startsAt", "endsAt", '[)') WITH &&);
