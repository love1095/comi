import { BookingStatus } from '@prisma/client';
import { AppError } from '../../common/errors/app-error';

/** Booking state machine (§6.1). Every status change goes through `assertTransition`. */
export const allowedTransitions: Record<BookingStatus, readonly BookingStatus[]> = {
  PENDING: ['CONFIRMED', 'EXPIRED', 'CANCELLED'], // CANCELLED: rejected / approval timeout / customer
  CONFIRMED: ['CHECKED_IN', 'CANCELLED', 'NO_SHOW'],
  CHECKED_IN: ['COMPLETED'],
  COMPLETED: [],
  CANCELLED: [],
  NO_SHOW: [],
  EXPIRED: ['CONFIRMED'], // late payment while the table is still free (§10.3)
};

export const ACTIVE_STATUSES: BookingStatus[] = ['PENDING', 'CONFIRMED', 'CHECKED_IN'];

export function canTransition(from: BookingStatus, to: BookingStatus): boolean {
  return allowedTransitions[from].includes(to);
}

export function assertTransition(from: BookingStatus, to: BookingStatus): void {
  if (!canTransition(from, to)) {
    throw new AppError('INVALID_STATUS', `Booking cannot go from ${from} to ${to}`, { from, to });
  }
}

export const GRACE_EXTENSION_MINUTES = 15;
export const NO_SHOW_LIMIT = 3; // §9.3: after 3 no-shows the account must prepay

/**
 * When a CONFIRMED booking becomes a no-show (§9.3): arrival — or a later "I'm leaving now"
 * ETA — plus the restaurant's grace, plus 15 min once if staff chose "guest is late, keep table".
 */
export function noShowDeadline(b: { arrivalAt: Date; etaAt: Date | null; graceExtendedAt: Date | null }, graceMinutes: number): Date {
  const base = b.etaAt && b.etaAt > b.arrivalAt ? b.etaAt : b.arrivalAt;
  return new Date(base.getTime() + (graceMinutes + (b.graceExtendedAt ? GRACE_EXTENSION_MINUTES : 0)) * 60_000);
}
