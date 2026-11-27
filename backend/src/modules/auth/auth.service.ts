import { Injectable } from '@nestjs/common';
import * as argon2 from 'argon2';
import { AppError } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { StaffLoginDto, StaffRegisterDto } from './auth.dto';
import { FirebaseVerifier } from './firebase-verifier';
import { TokenPair, TokenService } from './token.service';

// Verified against when the email does not exist, so login timing does not leak which emails exist.
let dummyHash: Promise<string> | undefined;
const getDummyHash = () => (dummyHash ??= argon2.hash('comi-dummy-password'));

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly firebase: FirebaseVerifier,
    private readonly tokens: TokenService,
  ) {}

  /** Firebase ID token → create/load User → our token pair (§18.1). */
  async exchangeCustomer(idToken: string): Promise<TokenPair & { isNewUser: boolean }> {
    const fb = await this.firebase.verify(idToken);
    const existing = await this.prisma.user.findUnique({ where: { firebaseUid: fb.uid } });
    if (existing && existing.status !== 'ACTIVE') throw new AppError('USER_BLOCKED');

    const user =
      existing ??
      (await this.prisma.user.create({
        data: {
          firebaseUid: fb.uid,
          phone: fb.phone,
          email: fb.email,
          name: fb.name,
          avatarUrl: fb.picture,
          preference: { create: {} },
        },
      }));
    const pair = await this.tokens.issue({ kind: 'user', userId: user.id });
    return { ...pair, isNewUser: !existing };
  }

  async registerStaff(dto: StaffRegisterDto): Promise<TokenPair> {
    const email = dto.email.trim().toLowerCase();
    if (await this.prisma.staffUser.findUnique({ where: { email } })) throw new AppError('EMAIL_TAKEN');
    const staff = await this.prisma.staffUser.create({
      data: { email, name: dto.name, phone: dto.phone, passwordHash: await argon2.hash(dto.password) },
    });
    return this.tokens.issue({ kind: 'staff', staffId: staff.id, isAdmin: false });
  }

  async loginStaff(dto: StaffLoginDto): Promise<TokenPair> {
    const staff = await this.prisma.staffUser.findUnique({ where: { email: dto.email.trim().toLowerCase() } });
    const hash = staff?.passwordHash ?? (await getDummyHash());
    const ok = await argon2.verify(hash, dto.password).catch(() => false);
    if (!staff || !ok) throw new AppError('INVALID_CREDENTIALS');
    return this.tokens.issue({ kind: 'staff', staffId: staff.id, isAdmin: staff.isAdmin });
  }
}
