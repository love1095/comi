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
  EXPIRED: [],
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
