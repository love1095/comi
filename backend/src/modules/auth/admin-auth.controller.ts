import { createHash } from 'crypto';
import { Body, Controller, HttpCode, Inject, Post } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiTags } from '@nestjs/swagger';
import { Throttle } from '@nestjs/throttler';
import * as argon2 from 'argon2';
import { IsEmail, IsOptional, IsString, Matches, MaxLength } from 'class-validator';
import { AuditService } from '../../common/audit.service';
import { CurrentStaffId, Public, StaffOnly } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError } from '../../common/errors/app-error';
import { decryptSecret, encryptSecret } from '../../common/utils/crypto';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { PrismaService } from '../../prisma/prisma.service';
import { TokenService } from './token.service';
import { newTotpSecret, otpauthUrl, verifyTotp } from './totp';

class AdminLoginDto {
  @ApiProperty() @IsEmail() email: string;
  @ApiProperty() @IsString() @MaxLength(200) password: string;
  @ApiPropertyOptional({ description: '6-digit authenticator code (required once 2FA is on)' })
  @IsOptional()
  @Matches(/^\d{6}$/)
  code?: string;
}

class MfaCodeDto {
  @ApiProperty() @Matches(/^\d{6}$/) code: string;
}

export class AdminLoginResultDto {
  @ApiProperty() accessToken: string;
  @ApiProperty() refreshToken: string;
  @ApiProperty() expiresIn: number;
  @ApiProperty({ description: 'false = this session can only set up 2FA, not use admin routes' }) mfa: boolean;
}

export class MfaSetupDto {
  @ApiProperty({ description: 'Base32 secret (type it in if the QR cannot be scanned)' }) secret: string;
  @ApiProperty({ description: 'otpauth:// URL for the QR code' }) otpauthUrl: string;
}

/**
 * Admin sign-in with TOTP 2FA (§23). Admin routes only accept sessions opened here with a valid code.
 * First time: log in without a code → set up → enable → log in again with a code.
 */
@ApiTags('auth')
@Controller('auth/admin')
export class AdminAuthController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tokens: TokenService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    @Inject(ENV) private readonly env: Env,
  ) {}

  /** Secrets are encrypted with CREDENTIALS_ENCRYPTION_KEY; dev/test fall back to a key derived from JWT_SECRET. */
  private key(): string {
    if (this.env.CREDENTIALS_ENCRYPTION_KEY) return this.env.CREDENTIALS_ENCRYPTION_KEY;
    if (this.env.NODE_ENV === 'production') throw new AppError('SERVICE_UNAVAILABLE', 'CREDENTIALS_ENCRYPTION_KEY is not set');
    return createHash('sha256').update(`totp:${this.env.JWT_SECRET}`).digest('base64');
  }

  @Public()
  @Post('login')
  @HttpCode(200)
  @Throttle({ default: { limit: 5, ttl: 60_000 } })
  @ApiOkResponse({ type: AdminLoginResultDto })
  async login(@Body() dto: AdminLoginDto) {
    const staff = await this.prisma.staffUser.findUnique({ where: { email: dto.email.trim().toLowerCase() } });
    const ok = staff ? await argon2.verify(staff.passwordHash, dto.password).catch(() => false) : false;
    if (!staff || !ok || !staff.isAdmin || staff.deletedAt) throw new AppError('INVALID_CREDENTIALS');

    if (!staff.totpEnabledAt) {
      // Setup-only session: the guard refuses admin routes until 2FA is on.
      const pair = await this.tokens.issue({ kind: 'staff', staffId: staff.id, isAdmin: true, mfa: false });
      return { ...pair, mfa: false };
    }
    if (!dto.code) throw new AppError('MFA_CODE_REQUIRED');
    const step = verifyTotp(decryptSecret(staff.totpSecretEnc!, this.key()), dto.code, this.clock.now(), staff.totpLastStep);
    if (step === null) {
      await this.audit.log({ actorType: 'STAFF', actorId: staff.id, action: 'admin.mfa_failed', entity: 'StaffUser', entityId: staff.id });
      throw new AppError('MFA_CODE_INVALID');
    }
    // Conditional update: the same code cannot open two sessions.
    const claimed = await this.prisma.staffUser.updateMany({
      where: { id: staff.id, OR: [{ totpLastStep: null }, { totpLastStep: { lt: step } }] },
      data: { totpLastStep: step },
    });
    if (claimed.count === 0) throw new AppError('MFA_CODE_INVALID');
    await this.audit.log({ actorType: 'STAFF', actorId: staff.id, action: 'admin.login', entity: 'StaffUser', entityId: staff.id });
    const pair = await this.tokens.issue({ kind: 'staff', staffId: staff.id, isAdmin: true, mfa: true });
    return { ...pair, mfa: true };
  }

  /** New secret (not active until confirmed with a code). Allowed only while 2FA is off. */
  @StaffOnly()
  @Post('mfa/setup')
  @HttpCode(200)
  @ApiOkResponse({ type: MfaSetupDto })
  async setup(@CurrentStaffId() staffId: string) {
    const staff = await this.prisma.staffUser.findUniqueOrThrow({ where: { id: staffId } });
    if (!staff.isAdmin) throw new AppError('FORBIDDEN', 'Admin only');
    if (staff.totpEnabledAt) throw new AppError('MFA_ALREADY_ENABLED');
    const secret = newTotpSecret();
    await this.prisma.staffUser.update({ where: { id: staffId }, data: { totpSecretEnc: encryptSecret(secret, this.key()), totpLastStep: null } });
    return { secret, otpauthUrl: otpauthUrl(secret, staff.email) };
  }

  @StaffOnly()
  @Post('mfa/enable')
  @HttpCode(204)
  async enable(@CurrentStaffId() staffId: string, @Body() dto: MfaCodeDto) {
    const staff = await this.prisma.staffUser.findUniqueOrThrow({ where: { id: staffId } });
    if (!staff.isAdmin) throw new AppError('FORBIDDEN', 'Admin only');
    if (staff.totpEnabledAt) throw new AppError('MFA_ALREADY_ENABLED');
    if (!staff.totpSecretEnc) throw new AppError('VALIDATION_FAILED', 'Call mfa/setup first');
    // Proves the authenticator works; the first login with a code is what marks a step as used.
    const step = verifyTotp(decryptSecret(staff.totpSecretEnc, this.key()), dto.code, this.clock.now());
    if (step === null) throw new AppError('MFA_CODE_INVALID');
    await this.prisma.staffUser.update({ where: { id: staffId }, data: { totpEnabledAt: this.clock.now() } });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'admin.mfa_enabled', entity: 'StaffUser', entityId: staffId });
  }
}
