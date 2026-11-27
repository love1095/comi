-- Consent records (Decree 13/2023) and staff account deletion
ALTER TABLE "User" ADD COLUMN "termsVersion" TEXT;
ALTER TABLE "User" ADD COLUMN "termsAcceptedAt" TIMESTAMP(3);
ALTER TABLE "User" ADD COLUMN "marketingOptIn" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "StaffUser" ADD COLUMN "termsVersion" TEXT;
ALTER TABLE "StaffUser" ADD COLUMN "termsAcceptedAt" TIMESTAMP(3);
ALTER TABLE "StaffUser" ADD COLUMN "deletedAt" TIMESTAMP(3);
