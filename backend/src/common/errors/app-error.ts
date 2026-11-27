import { HttpStatus } from '@nestjs/common';

/**
 * Stable error codes (§17.3). The apps translate them, so never rename an existing code.
 */
export const ErrorCode = {
  VALIDATION_FAILED: HttpStatus.BAD_REQUEST,
  BAD_REQUEST: HttpStatus.BAD_REQUEST,
  UNAUTHENTICATED: HttpStatus.UNAUTHORIZED,
  INVALID_CREDENTIALS: HttpStatus.UNAUTHORIZED,
  INVALID_TOKEN: HttpStatus.UNAUTHORIZED,
  REFRESH_TOKEN_INVALID: HttpStatus.UNAUTHORIZED,
  FORBIDDEN: HttpStatus.FORBIDDEN,
  USER_BLOCKED: HttpStatus.FORBIDDEN,
  RESTAURANT_HEADER_MISSING: HttpStatus.BAD_REQUEST,
  NOT_A_MEMBER: HttpStatus.FORBIDDEN,
  ROLE_NOT_ALLOWED: HttpStatus.FORBIDDEN,
  NOT_FOUND: HttpStatus.NOT_FOUND,
  EMAIL_TAKEN: HttpStatus.CONFLICT,
  TABLE_CODE_TAKEN: HttpStatus.CONFLICT,
  CONFLICT: HttpStatus.CONFLICT,
  INVALID_STATUS: HttpStatus.CONFLICT,
  RESTAURANT_INCOMPLETE: HttpStatus.UNPROCESSABLE_ENTITY,
  LAYOUT_INVALID: HttpStatus.UNPROCESSABLE_ENTITY,
  OPTION_GROUP_INVALID: HttpStatus.UNPROCESSABLE_ENTITY,
  // booking (§8, §17.3)
  RESTAURANT_NOT_AVAILABLE: HttpStatus.UNPROCESSABLE_ENTITY,
  SLOT_INVALID: HttpStatus.UNPROCESSABLE_ENTITY,
  SLOT_TAKEN: HttpStatus.CONFLICT,
  TABLE_TAKEN: HttpStatus.CONFLICT,
  HOLD_INVALID: HttpStatus.CONFLICT,
  PARTY_TOO_LARGE: HttpStatus.UNPROCESSABLE_ENTITY,
  ITEM_UNAVAILABLE: HttpStatus.UNPROCESSABLE_ENTITY,
  OPTIONS_INVALID: HttpStatus.UNPROCESSABLE_ENTITY,
  AGE_CONFIRMATION_REQUIRED: HttpStatus.UNPROCESSABLE_ENTITY,
  PREPAY_REQUIRED: HttpStatus.UNPROCESSABLE_ENTITY,
  COD_NOT_ALLOWED: HttpStatus.UNPROCESSABLE_ENTITY,
  PAYMENT_NOT_AVAILABLE: HttpStatus.UNPROCESSABLE_ENTITY,
  CANCEL_TOO_LATE: HttpStatus.UNPROCESSABLE_ENTITY,
  REQUEST_IN_PROGRESS: HttpStatus.CONFLICT,
  SERVICE_UNAVAILABLE: HttpStatus.SERVICE_UNAVAILABLE,
  RATE_LIMITED: HttpStatus.TOO_MANY_REQUESTS,
  INTERNAL: HttpStatus.INTERNAL_SERVER_ERROR,
} as const;

export type ErrorCodeName = keyof typeof ErrorCode;

export class AppError extends Error {
  constructor(
    public readonly code: ErrorCodeName,
    message?: string,
    public readonly details: Record<string, unknown> = {},
  ) {
    super(message ?? code);
  }
  get status(): number {
    return ErrorCode[this.code];
  }
}

export const notFound = (entity: string) => new AppError('NOT_FOUND', `${entity} not found`, { entity });
