import { Global, Injectable, Module } from '@nestjs/common';

/**
 * Never call `new Date()` / `Date.now()` in business code (§25).
 * Inject Clock so tests can move time with FakeClock.
 */
@Injectable()
export class Clock {
  now(): Date {
    return new Date();
  }
}

export class FakeClock extends Clock {
  constructor(private current = new Date('2026-12-01T03:00:00Z')) {
    super();
  }
  override now(): Date {
    return new Date(this.current);
  }
  set(d: Date | string) {
    this.current = new Date(d);
  }
  advance(ms: number) {
    this.current = new Date(this.current.getTime() + ms);
  }
}

@Global()
@Module({ providers: [Clock], exports: [Clock] })
export class ClockModule {}
