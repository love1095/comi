-- Phase 3: kitchen queue, check-in, at-the-table ordering (§7, §8.5, §9)
ALTER TABLE "Restaurant" ADD COLUMN "startEarlyOnCheckIn" BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE "Restaurant" ADD COLUMN "codStartOnDepart" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "Restaurant" ADD COLUMN "allowTableOrdering" BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE "Restaurant" ADD COLUMN "tableOrderingNeedsApproval" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "Booking" ADD COLUMN "graceExtendedAt" TIMESTAMP(3);
