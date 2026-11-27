import { BadRequestException, NotFoundException } from '@nestjs/common';
import { loadEnv } from '../../config/env';
import { AppError } from './app-error';
import { toErrorBody } from './all-exceptions.filter';

describe('error format (§21)', () => {
  it('maps AppError to its code and status', () => {
    expect(toErrorBody(new AppError('TABLE_CODE_TAKEN', 'taken', { code: 'A1' }))).toEqual([
      409,
      { error: { code: 'TABLE_CODE_TAKEN', message: 'taken', details: { code: 'A1' } } },
    ]);
  });

  it('maps class-validator errors to VALIDATION_FAILED with fields', () => {
    const [status, body] = toErrorBody(new BadRequestException(['name must be a string']));
    expect(status).toBe(400);
    expect(body.error).toEqual({ code: 'VALIDATION_FAILED', message: 'Invalid input', details: { fields: ['name must be a string'] } });
  });

  it('maps Nest HTTP errors and unknown errors', () => {
    expect(toErrorBody(new NotFoundException())[1].error.code).toBe('NOT_FOUND');
    expect(toErrorBody(new Error('boom'))).toEqual([500, { error: { code: 'INTERNAL', message: 'Something went wrong', details: {} } }]);
  });
});

describe('env validation', () => {
  const base = { DATABASE_URL: 'postgresql://x', JWT_SECRET: 'x'.repeat(32), REFRESH_TOKEN_PEPPER: 'y'.repeat(16) };

  it('applies defaults and treats empty strings as unset', () => {
    const env = loadEnv({ ...base, PORT: '', FIREBASE_PROJECT_ID: '' });
    expect(env.PORT).toBe(3100);
    expect(env.FIREBASE_PROJECT_ID).toBeUndefined();
    expect(env.NO_SHOW_LIMIT).toBe(3);
  });

  it('rejects short secrets and requires Firebase in production', () => {
    expect(() => loadEnv({ ...base, JWT_SECRET: 'short' })).toThrow('JWT_SECRET');
    expect(() => loadEnv({ ...base, NODE_ENV: 'production' })).toThrow('FIREBASE_PROJECT_ID');
  });
});
