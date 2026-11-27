import { ChildProcess, spawn } from 'child_process';
import { join } from 'path';

/** Starts the compiled API (dist/main.js) on `port` and waits for /health. */
export async function startServer(port: number): Promise<{ base: string; stop: () => void }> {
  const proc: ChildProcess = spawn(process.execPath, [join(__dirname, '..', 'dist', 'main.js')], {
    env: { ...process.env, NODE_ENV: 'test', PORT: String(port) },
    stdio: ['ignore', 'ignore', 'inherit'],
  });
  const base = `http://localhost:${port}`;
  const start = Date.now();
  while (Date.now() - start < 20_000) {
    try {
      if ((await fetch(`${base}/api/v1/health`)).ok) return { base, stop: () => proc.kill() };
    } catch {
      /* not up yet */
    }
    await new Promise((r) => setTimeout(r, 300));
  }
  proc.kill();
  throw new Error('API did not start');
}

/** Local YYYY-MM-DD in Vietnam, `days` from today. */
export function vnDate(days: number): string {
  return new Date(Date.now() + 7 * 3600_000 + days * 86_400_000).toISOString().slice(0, 10);
}

/**
 * Makes `email` (an existing staff account) a platform admin with 2FA, through the real flow:
 * login → mfa/setup → mfa/enable → login with a TOTP code. Returns the Authorization header.
 */
export async function adminSession(
  base: string,
  prisma: { staffUser: { update(args: { where: { email: string }; data: { isAdmin: boolean } }): Promise<unknown> } },
  email: string,
  password = 'password123',
): Promise<{ Authorization: string }> {
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  const { totp } = require('../src/modules/auth/totp') as typeof import('../src/modules/auth/totp');
  await prisma.staffUser.update({ where: { email }, data: { isAdmin: true } });
  const post = async (path: string, body: unknown, token?: string) => {
    const res = await fetch(`${base}/api/v1${path}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) },
      body: JSON.stringify(body),
    });
    if (!res.ok) throw new Error(`${path} → ${res.status} ${await res.text()}`);
    return res.status === 204 ? {} : ((await res.json()) as Record<string, string>);
  };
  const setupSession = await post('/auth/admin/login', { email, password });
  const { secret } = await post('/auth/admin/mfa/setup', {}, setupSession.accessToken);
  await post('/auth/admin/mfa/enable', { code: totp(secret, new Date()) }, setupSession.accessToken);
  const s = await post('/auth/admin/login', { email, password, code: totp(secret, new Date()) });
  return { Authorization: `Bearer ${s.accessToken}` };
}
