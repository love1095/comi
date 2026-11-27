/** Ops alerts (§24.4): a job that used up all its retries, sent at most once per job name per window. */
export class JobAlerts {
  private readonly lastSent = new Map<string, number>();

  constructor(
    private readonly send: (subject: string, text: string) => Promise<unknown>,
    private readonly windowMs = 15 * 60_000,
    private readonly now: () => number = Date.now,
  ) {}

  /** Call from the worker's `failed` event. Returns true when an alert was sent. */
  async failed(job: { name: string; id?: string; attemptsMade: number; opts: { attempts?: number } } | undefined, queue: string, err: Error) {
    if (!job) return false;
    const final = job.attemptsMade >= (job.opts.attempts ?? 1);
    if (!final) return false;
    const key = `${queue}/${job.name}`;
    const t = this.now();
    if ((this.lastSent.get(key) ?? -Infinity) > t - this.windowMs) return false;
    this.lastSent.set(key, t);
    await this.send(`[comi] job failed: ${key}`, `Job ${job.id} (${key}) failed after ${job.attemptsMade} attempts.\n\n${err.stack ?? err.message}`);
    return true;
  }
}
