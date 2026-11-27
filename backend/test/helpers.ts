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
