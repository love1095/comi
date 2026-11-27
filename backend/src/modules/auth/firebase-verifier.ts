import { Inject, Injectable, Logger } from '@nestjs/common';
import type { App } from 'firebase-admin/app';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { AppError } from '../../common/errors/app-error';

export interface VerifiedFirebaseUser {
  uid: string;
  phone?: string;
  email?: string;
  name?: string;
  picture?: string;
}

/**
 * Verifies Firebase ID tokens (§18.1).
 * Without FIREBASE_PROJECT_ID (local dev / tests) it accepts fake tokens
 * `dev:<uid>` or `dev:<uid>:<phone>` — never in production (env validation enforces it).
 */
@Injectable()
export class FirebaseVerifier {
  private readonly logger = new Logger(FirebaseVerifier.name);
  private app?: App;

  constructor(@Inject(ENV) private readonly env: Env) {
    if (env.FIREBASE_PROJECT_ID && env.FIREBASE_CLIENT_EMAIL && env.FIREBASE_PRIVATE_KEY) {
      // Loaded lazily: firebase-admin pulls in ESM-only deps and is not needed in dev/tests.
      // eslint-disable-next-line @typescript-eslint/no-require-imports
      const { cert, initializeApp } = require('firebase-admin/app') as typeof import('firebase-admin/app');
      this.app = initializeApp(
        {
          credential: cert({
            projectId: env.FIREBASE_PROJECT_ID,
            clientEmail: env.FIREBASE_CLIENT_EMAIL,
            privateKey: env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
          }),
        },
        'comi',
      );
    } else if (env.NODE_ENV !== 'production') {
      this.logger.warn('Firebase not configured: accepting dev tokens "dev:<uid>[:<phone>]"');
    }
  }

  async verify(idToken: string): Promise<VerifiedFirebaseUser> {
    if (!this.app) return this.verifyDevToken(idToken);
    try {
      // eslint-disable-next-line @typescript-eslint/no-require-imports
      const { getAuth } = require('firebase-admin/auth') as typeof import('firebase-admin/auth');
      const t = await getAuth(this.app).verifyIdToken(idToken, true);
      return { uid: t.uid, phone: t.phone_number, email: t.email, name: t.name, picture: t.picture };
    } catch {
      throw new AppError('INVALID_TOKEN', 'Firebase token is invalid or expired');
    }
  }

  private verifyDevToken(idToken: string): VerifiedFirebaseUser {
    if (this.env.NODE_ENV === 'production') throw new AppError('SERVICE_UNAVAILABLE', 'Firebase not configured');
    const [prefix, uid, contact] = idToken.split(':');
    if (prefix !== 'dev' || !uid) throw new AppError('INVALID_TOKEN', 'Expected dev token "dev:<uid>[:<phone or email>]"');
    // Third part: a phone (+84…) or, for tourists signing in with email, an address.
    if (contact?.includes('@')) return { uid, email: contact.toLowerCase() };
    return { uid, phone: contact || undefined };
  }
}
