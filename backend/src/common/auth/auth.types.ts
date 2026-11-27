import { StaffRole } from '@prisma/client';
import { Request } from 'express';

export type Principal =
  | { kind: 'user'; userId: string }
  | { kind: 'staff'; staffId: string; isAdmin: boolean };

/** JWT access-token payload. `typ` separates customers from restaurant staff. */
export interface AccessTokenPayload {
  sub: string;
  typ: 'user' | 'staff';
  adm?: boolean;
}

export interface AuthedRequest extends Request {
  principal?: Principal;
  restaurantId?: string;
  memberRole?: StaffRole;
}

/** Permission table §18.3. */
export const Perm = {
  RESTAURANT_ADMIN: ['OWNER'], // info, settings, payment account, staff, statements
  MENU_TABLES: ['OWNER', 'MANAGER'],
  BOOKINGS: ['OWNER', 'MANAGER', 'CASHIER'],
  KITCHEN: ['OWNER', 'MANAGER', 'CASHIER', 'KITCHEN'],
  REVIEWS_INVOICES: ['OWNER', 'MANAGER', 'CASHIER'],
} as const satisfies Record<string, readonly StaffRole[]>;
