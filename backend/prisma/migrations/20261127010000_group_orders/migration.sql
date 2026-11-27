-- Phase 3b: group orders and split bill (§8.4, §8.5)
ALTER TABLE "BookingGuest" ADD COLUMN "paidAt" TIMESTAMP(3);
ALTER TABLE "BookingGuest" ADD COLUMN "accessKeyHash" TEXT;
ALTER TABLE "GroupInvite" ADD COLUMN "lockedAt" TIMESTAMP(3);
CREATE UNIQUE INDEX "GroupInvite_bookingId_key" ON "GroupInvite"("bookingId");
