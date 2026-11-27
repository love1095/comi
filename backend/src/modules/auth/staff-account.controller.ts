import { randomBytes } from 'node:crypto';
import { Controller, Delete, HttpCode } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Throttle } from '@nestjs/throttler';
import * as argon2 from 'argon2';
import { AuditService } from '../../common/audit.service';
import { CurrentStaffId, StaffOnly } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError } from '../../common/errors/app-error';
import { PrismaService } from '../../prisma/prisma.service';
import { TokenService } from './token.service';

/** Staff account deletion (App Store / Google Play rule). Restaurants keep their data. */
@ApiTags('auth')
@StaffOnly()
@Controller('auth/staff/me')
export class StaffAccountController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tokens: TokenService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
  ) {}

  @Delete()
  @HttpCode(204)
  @Throttle({ default: { limit: 3, ttl: 60_000 } })
  async remove(@CurrentStaffId() staffId: string) {
    // A restaurant must always have an owner: hand it over (or close it) first.
    const owned = await this.prisma.restaurantMember.findMany({ where: { staffId, role: 'OWNER' }, select: { restaurantId: true } });
    for (const { restaurantId } of owned) {
      const owners = await this.prisma.restaurantMember.count({ where: { restaurantId, role: 'OWNER' } });
      if (owners === 1) throw new AppError('SOLE_OWNER', 'Add another owner before deleting your account', { restaurantId });
    }
    await this.prisma.$transaction(async (tx) => {
      await tx.restaurantMember.deleteMany({ where: { staffId } });
      await tx.deviceToken.deleteMany({ where: { staffId } });
      await tx.staffUser.update({
        where: { id: staffId },
        data: {
          email: `deleted+${staffId}@deleted.comi.vn`,
          name: 'Đã xoá',
          phone: null,
          isAdmin: false,
          passwordHash: await argon2.hash(randomBytes(32).toString('hex')),
          deletedAt: this.clock.now(),
        },
      });
      await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'staff.delete', entity: 'StaffUser', entityId: staffId }, tx);
    });
    await this.tokens.revokeAllFor({ kind: 'staff', staffId, isAdmin: false });
  }
}
