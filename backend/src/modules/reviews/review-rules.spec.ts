import { reviewWindowProblem, roundRating } from './review-rules';

const h = (n: number) => new Date(Date.UTC(2026, 11, 2, 5) + n * 3_600_000);

describe('who may review (§15)', () => {
  it('completed within 14 days', () => {
    expect(reviewWindowProblem({ status: 'COMPLETED', checkedInAt: h(0), completedAt: h(2) }, h(24))).toBeNull();
    expect(reviewWindowProblem({ status: 'COMPLETED', checkedInAt: h(0), completedAt: h(2) }, h(2 + 14 * 24 + 1))).toBe('TOO_LATE');
  });
  it('seated for more than an hour also counts; not before', () => {
    expect(reviewWindowProblem({ status: 'CHECKED_IN', checkedInAt: h(0), completedAt: null }, h(1.5))).toBeNull();
    expect(reviewWindowProblem({ status: 'CHECKED_IN', checkedInAt: h(0), completedAt: null }, h(0.5))).toBe('TOO_EARLY');
  });
  it('nobody reviews a visit that did not happen', () => {
    for (const status of ['PENDING', 'CONFIRMED', 'CANCELLED', 'NO_SHOW', 'EXPIRED'] as const) {
      expect(reviewWindowProblem({ status, checkedInAt: null, completedAt: null }, h(1))).toBe('NOT_VISITED');
    }
  });
});

describe('roundRating', () => {
  it('one decimal, 0 when no reviews', () => {
    expect(roundRating(4.449)).toBe(4.4);
    expect(roundRating(4.45)).toBe(4.5);
    expect(roundRating(null)).toBe(0);
  });
});
