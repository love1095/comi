import { BookingStatus } from '@prisma/client';

export const REVIEW_DAYS = 14;
const SEATED_MIN_MS = 3_600_000;

/**
 * §15: only real visits — COMPLETED (or seated for more than an hour) and within 14 days.
 * Returns why not, or null when the guest may review.
 */
export function reviewWindowProblem(
  b: { status: BookingStatus; checkedInAt: Date | null; completedAt: Date | null },
  now: Date,
): 'NOT_VISITED' | 'TOO_EARLY' | 'TOO_LATE' | null {
  if (b.status !== 'COMPLETED' && b.status !== 'CHECKED_IN') return 'NOT_VISITED';
  if (b.status === 'CHECKED_IN' && (!b.checkedInAt || now.getTime() - b.checkedInAt.getTime() < SEATED_MIN_MS)) return 'TOO_EARLY';
  const from = b.completedAt ?? b.checkedInAt;
  if (from && now.getTime() - from.getTime() > REVIEW_DAYS * 86_400_000) return 'TOO_LATE';
  return null;
}

/** Restaurant.ratingAvg is Decimal(2,1). */
export const roundRating = (avg: number | null) => (avg === null ? 0 : Math.round(avg * 10 + 1e-9) / 10);
