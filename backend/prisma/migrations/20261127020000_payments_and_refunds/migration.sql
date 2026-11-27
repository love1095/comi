-- Phase 4 (part 2): PayOS prepaid, guest share payments, minimum manual refunds (§10)
ALTER TABLE "Payment" ADD COLUMN "qrCode" TEXT;
ALTER TABLE "Payment" ADD COLUMN "guestId" TEXT;
ALTER TABLE "Payment" ADD COLUMN "purpose" TEXT NOT NULL DEFAULT 'BOOKING';
ALTER TABLE "Payment" ADD COLUMN "payerBankBin" TEXT;
ALTER TABLE "Payment" ADD COLUMN "payerAccountNo" TEXT;
ALTER TABLE "Payment" ADD COLUMN "payerName" TEXT;
CREATE INDEX "Payment_status_createdAt_idx" ON "Payment"("status", "createdAt");

-- PayOS needs a numeric orderCode (§10.2): one sequence for every payment.
CREATE SEQUENCE IF NOT EXISTS "payment_order_code_seq" START 100001;

CREATE TYPE "RefundStatus" AS ENUM ('PENDING', 'DONE');
CREATE TABLE "Refund" (
    "id" TEXT NOT NULL,
    "paymentId" TEXT NOT NULL,
    "bookingId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,
    "status" "RefundStatus" NOT NULL DEFAULT 'PENDING',
    "toBankBin" TEXT,
    "toAccountNo" TEXT,
    "toAccountName" TEXT,
    "note" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "doneAt" TIMESTAMP(3),
    "doneByStaffId" TEXT,
    CONSTRAINT "Refund_pkey" PRIMARY KEY ("id")
);
CREATE INDEX "Refund_status_idx" ON "Refund"("status");
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "Payment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Refund" ADD CONSTRAINT "Refund_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
