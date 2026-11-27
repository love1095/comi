import { JobAlerts } from './alerts';

describe('JobAlerts', () => {
  it('alerts only on the final attempt, once per job name per window', async () => {
    let t = 0;
    const sent: string[] = [];
    const a = new JobAlerts(async (s) => sent.push(s), 60_000, () => t);
    const job = (attemptsMade: number) => ({ name: 'statement-generate', id: '1', attemptsMade, opts: { attempts: 5 } });
    expect(await a.failed(job(3), 'billing', new Error('x'))).toBe(false);
    expect(await a.failed(job(5), 'billing', new Error('x'))).toBe(true);
    t = 30_000;
    expect(await a.failed(job(5), 'billing', new Error('x'))).toBe(false);
    t = 61_000;
    expect(await a.failed(job(5), 'billing', new Error('x'))).toBe(true);
    expect(sent).toEqual(['[comi] job failed: billing/statement-generate', '[comi] job failed: billing/statement-generate']);
  });
});
