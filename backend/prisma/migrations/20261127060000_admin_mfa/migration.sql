-- Admin two-factor login (TOTP)
ALTER TABLE "StaffUser" ADD COLUMN "totpSecretEnc" TEXT;
ALTER TABLE "StaffUser" ADD COLUMN "totpEnabledAt" TIMESTAMP(3);
ALTER TABLE "StaffUser" ADD COLUMN "totpLastStep" INTEGER;
ALTER TABLE "RefreshToken" ADD COLUMN "mfa" BOOLEAN NOT NULL DEFAULT false;
