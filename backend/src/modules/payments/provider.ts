/** Payment provider adapter (§10.2). Implement in order: PayOS → MoMo → VNPay → ZaloPay. */

export interface CreatePaymentInput<C> {
  account: C;
  /** PayOS needs a number: a Postgres sequence (payment_order_code_seq). */
  providerOrderId: string;
  amount: number;
  description: string;
  returnUrl: string;
  cancelUrl: string;
  expiresAt: Date;
}

export interface ProviderStatus {
  status: 'PENDING' | 'PAID' | 'CANCELLED';
  amountPaid: number;
}

export interface WebhookResult {
  providerOrderId: string;
  amount: number;
  paid: boolean;
  /** Unique per event → WebhookEvent (provider, eventKey) makes processing idempotent. */
  eventKey: string;
  providerTxnId?: string;
  /** Where a manual refund goes, when the provider tells us. */
  payer: { bankBin?: string; accountNo?: string; name?: string };
}

export interface PaymentProviderAdapter<C> {
  createPayment(input: CreatePaymentInput<C>): Promise<{ checkoutUrl: string; qrCode?: string }>;
  getStatus(providerOrderId: string, account: C): Promise<ProviderStatus>;
  verifyWebhook(body: unknown, account: C): WebhookResult;
  // refund(): PayOS has none — refunds are manual bank transfers tracked in the Refund table.
}
