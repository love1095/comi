import { RedisService } from '../../common/redis';
import { Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { randomUUID } from 'crypto';
import { Clock } from '../../common/clock';
import { AccessTokenPayload, Principal, revokedKey } from '../../common/auth/auth.types';
import { AppError } from '../../common/errors/app-error';
import { randomToken, sha256 } from '../../common/utils/crypto';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';

export interface TokenPair {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
}

const DAY_MS = 86_400_000;

/**
 * Access token: JWT, 15 min. Refresh token: random, 30 days, stored hashed,
 * rotated on every use. Presenting an already-rotated token revokes its whole
 * family (stolen token detection).
 */
@Injectable()
export class TokenService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly clock: Clock,
    @Inject(ENV) private readonly env: Env,
    private readonly redis: RedisService,
  ) {}

  async issue(principal: Principal, familyId: string = randomUUID()): Promise<TokenPair> {
    const refreshToken = randomToken(32);
    await this.prisma.refreshToken.create({
      data: {
        tokenHash: this.hash(refreshToken),
        familyId,
        userId: principal.kind === 'user' ? principal.userId : null,
        staffId: principal.kind === 'staff' ? principal.staffId : null,
        expiresAt: new Date(this.clock.now().getTime() + this.env.REFRESH_TOKEN_TTL_DAYS * DAY_MS),
      },
    });
    return { accessToken: await this.signAccess(principal), refreshToken, expiresIn: this.env.ACCESS_TOKEN_TTL_SECONDS };
  }

  async rotate(refreshToken: string): Promise<TokenPair> {
    const now = this.clock.now();
    const row = await this.prisma.refreshToken.findUnique({
      where: { tokenHash: this.hash(refreshToken) },
      include: { staff: { select: { id: true, isAdmin: true } }, user: { select: { id: true, status: true } } },
    });
    if (!row) throw new AppError('REFRESH_TOKEN_INVALID');

    if (row.revokedAt) {
      await this.revokeFamily(row.familyId);
      throw new AppError('REFRESH_TOKEN_INVALID', 'Refresh token reuse detected');
    }
    if (row.expiresAt <= now) throw new AppError('REFRESH_TOKEN_INVALID', 'Refresh token expired');
    if (row.user && row.user.status !== 'ACTIVE') throw new AppError('USER_BLOCKED');

    // Conditional update: if two requests race with the same token, only one wins.
    const claimed = await this.prisma.refreshToken.updateMany({
      where: { id: row.id, revokedAt: null },
      data: { revokedAt: now },
    });
    if (claimed.count === 0) {
      await this.revokeFamily(row.familyId);
      throw new AppError('REFRESH_TOKEN_INVALID', 'Refresh token reuse detected');
    }

    const principal: Principal = row.staff
      ? { kind: 'staff', staffId: row.staff.id, isAdmin: row.staff.isAdmin }
      : { kind: 'user', userId: row.userId! };
    const pair = await this.issue(principal, row.familyId);
    const next = await this.prisma.refreshToken.findUnique({ where: { tokenHash: this.hash(pair.refreshToken) } });
    await this.prisma.refreshToken.update({ where: { id: row.id }, data: { replacedById: next?.id } });
    return pair;
  }

  async revoke(refreshToken: string): Promise<void> {
    const row = await this.prisma.refreshToken.findUnique({ where: { tokenHash: this.hash(refreshToken) } });
    if (row) await this.revokeFamily(row.familyId);
  }

  async revokeAllFor(principal: Principal): Promise<void> {
    await this.prisma.refreshToken.updateMany({
      where: {
        revokedAt: null,
        ...(principal.kind === 'user' ? { userId: principal.userId } : { staffId: principal.staffId }),
      },
      data: { revokedAt: this.clock.now() },
    });
    // Access tokens are stateless JWTs: remember the cut-off so the guard rejects older ones (§23).
    const id = principal.kind === 'user' ? principal.userId : principal.staffId;
    await this.redis.client
      .set(revokedKey(principal.kind, id), String(Math.floor(this.clock.now().getTime() / 1000)), 'EX', this.env.ACCESS_TOKEN_TTL_SECONDS)
      .catch(() => undefined);
  }

  private revokeFamily(familyId: string) {
    return this.prisma.refreshToken.updateMany({
      where: { familyId, revokedAt: null },
      data: { revokedAt: this.clock.now() },
    });
  }

  private signAccess(p: Principal): Promise<string> {
    const payload: AccessTokenPayload =
      p.kind === 'user' ? { sub: p.userId, typ: 'user' } : { sub: p.staffId, typ: 'staff', adm: p.isAdmin || undefined };
    return this.jwt.signAsync(payload, { expiresIn: this.env.ACCESS_TOKEN_TTL_SECONDS });
  }

  private hash(token: string) {
    return sha256(token, this.env.REFRESH_TOKEN_PEPPER);
  }
}

