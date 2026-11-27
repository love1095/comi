import { z } from 'zod';

const bool = z
  .enum(['true', 'false', '1', '0'])
  .transform((v) => v === 'true' || v === '1');

export const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'staging', 'production']).default('development'),
  PORT: z.coerce.number().int().default(3100),
  API_BASE_URL: z.string().url().default('http://localhost:3100'),
  APP_LINK_BASE_URL: z.string().url().default('https://comi.vn'),

  DATABASE_URL: z.string().min(1),
  REDIS_URL: z.string().default('redis://localhost:6379'),

  JWT_SECRET: z.string().min(32),
  REFRESH_TOKEN_PEPPER: z.string().min(16),
  ACCESS_TOKEN_TTL_SECONDS: z.coerce.number().int().positive().default(900),
  REFRESH_TOKEN_TTL_DAYS: z.coerce.number().int().positive().default(30),

  FIREBASE_PROJECT_ID: z.string().optional(),
  FIREBASE_CLIENT_EMAIL: z.string().optional(),
  FIREBASE_PRIVATE_KEY: z.string().optional(),

  CREDENTIALS_ENCRYPTION_KEY: z.string().optional(),
  PAYOS_API_URL: z.string().url().default('https://api-merchant.payos.vn'), // tests point this at a stub

  CLOUDINARY_CLOUD_NAME: z.string().optional(),
  CLOUDINARY_API_KEY: z.string().optional(),
  CLOUDINARY_API_SECRET: z.string().optional(),

  GOONG_API_KEY: z.string().optional(),
  GOOGLE_PLACES_API_KEY: z.string().optional(),
  GOOGLE_TRANSLATE_API_KEY: z.string().optional(),

  EMAIL_FROM: z.string().default('comi <no-reply@comi.vn>'),
  SMTP_URL: z.string().optional(), // dev: smtp://localhost:1025 (Mailpit)
  ALERT_EMAIL: z.string().optional(), // ops alerts: failed jobs (§24.4)

  // Where restaurants pay their monthly statement (VietQR, §11.3)
  PLATFORM_BANK_BIN: z.string().optional(), // e.g. 970436 = Vietcombank
  PLATFORM_BANK_ACCOUNT: z.string().optional(),
  PLATFORM_BANK_ACCOUNT_NAME: z.string().optional(),
  SENTRY_DSN: z.string().optional(),

  NO_SHOW_LIMIT: z.coerce.number().int().default(3),
  PAYMENT_TIMEOUT_MINUTES: z.coerce.number().int().default(15),
  SWAGGER_ENABLED: bool.optional(),
});

export type Env = z.infer<typeof envSchema>;

/** Validates env at boot. Empty strings in .env count as "not set". */
export function loadEnv(source: NodeJS.ProcessEnv = process.env): Env {
  const cleaned = Object.fromEntries(Object.entries(source).filter(([, v]) => v !== ''));
  const parsed = envSchema.safeParse(cleaned);
  if (!parsed.success) {
    const issues = parsed.error.issues.map((i) => `  ${i.path.join('.')}: ${i.message}`).join('\n');
    throw new Error(`Invalid environment variables:\n${issues}`);
  }
  if (parsed.data.NODE_ENV === 'production' && !parsed.data.FIREBASE_PROJECT_ID) {
    throw new Error('FIREBASE_PROJECT_ID is required in production');
  }
  return parsed.data;
}
