import { ArgumentsHost, Catch, ExceptionFilter, HttpException, HttpStatus, Logger } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { Response } from 'express';
import { AppError, ErrorCodeName } from './app-error';

export interface ErrorBody {
  error: { code: string; message: string; details: Record<string, unknown> };
}

/** Every error leaves the API as `{ error: { code, message, details } }` (§21). */
@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger('Errors');

  catch(exception: unknown, host: ArgumentsHost) {
    const res = host.switchToHttp().getResponse<Response>();
    const [status, body] = toErrorBody(exception);
    if (status >= 500) this.logger.error(exception);
    res.status(status).json(body);
  }
}

export function toErrorBody(e: unknown): [number, ErrorBody] {
  const make = (status: number, code: string, message: string, details: Record<string, unknown> = {}) =>
    [status, { error: { code, message, details } }] as [number, ErrorBody];

  if (e instanceof AppError) return make(e.status, e.code, e.message, e.details);

  if (e instanceof Prisma.PrismaClientKnownRequestError) {
    if (e.code === 'P2002') return make(409, 'CONFLICT', 'Already exists', { target: e.meta?.target });
    if (e.code === 'P2025') return make(404, 'NOT_FOUND', 'Not found');
  }

  if (e instanceof HttpException) {
    const status = e.getStatus();
    const resp = e.getResponse() as string | { message?: string | string[] };
    const raw = typeof resp === 'string' ? resp : resp.message;
    if (status === HttpStatus.BAD_REQUEST && Array.isArray(raw)) {
      return make(status, 'VALIDATION_FAILED', 'Invalid input', { fields: raw });
    }
    const code: ErrorCodeName =
      status === 401
        ? 'UNAUTHENTICATED'
        : status === 403
          ? 'FORBIDDEN'
          : status === 404
            ? 'NOT_FOUND'
            : status === 429
              ? 'RATE_LIMITED'
              : status >= 500
                ? 'INTERNAL'
                : 'BAD_REQUEST';
    return make(status, code, Array.isArray(raw) ? raw.join(', ') : (raw ?? e.message));
  }

  return make(500, 'INTERNAL', 'Something went wrong');
}
