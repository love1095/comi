import { CanActivate, ExecutionContext, Inject, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { StaffRole } from '@prisma/client';
import { PrismaService } from '../../prisma/prisma.service';
import { AppError } from '../errors/app-error';
import { AccessTokenPayload, AuthedRequest } from './auth.types';
import { ACTOR, ActorKind, IS_PUBLIC, RESTAURANT_ROLES } from './decorators';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * Global guard. Every route needs a valid access token unless marked @Public().
 * Then checks the actor kind (@CustomerOnly / @StaffOnly / @AdminOnly) and,
 * for @RestaurantRoles, the membership for X-Restaurant-Id.
 */
@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly jwt: JwtService,
    @Inject(PrismaService) private readonly prisma: PrismaService,
  ) {}

  async canActivate(ctx: ExecutionContext): Promise<boolean> {
    if (ctx.getType() !== 'http') return true;
    const targets = [ctx.getHandler(), ctx.getClass()];
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC, targets);
    const req = ctx.switchToHttp().getRequest<AuthedRequest>();

    const token = this.extractToken(req);
    if (!token) {
      if (isPublic) return true;
      throw new AppError('UNAUTHENTICATED');
    }

    let payload: AccessTokenPayload;
    try {
      payload = await this.jwt.verifyAsync<AccessTokenPayload>(token);
    } catch {
      if (isPublic) return true; // public routes ignore a stale token
      throw new AppError('INVALID_TOKEN');
    }

    req.principal =
      payload.typ === 'user'
        ? { kind: 'user', userId: payload.sub }
        : { kind: 'staff', staffId: payload.sub, isAdmin: !!payload.adm };

    if (isPublic) return true;

    const actor = this.reflector.getAllAndOverride<ActorKind>(ACTOR, targets);
    if (actor === 'user' && req.principal.kind !== 'user') throw new AppError('FORBIDDEN', 'Customer only');
    if (actor === 'staff' && req.principal.kind !== 'staff') throw new AppError('FORBIDDEN', 'Staff only');
    if (actor === 'admin' && !(req.principal.kind === 'staff' && req.principal.isAdmin)) {
      throw new AppError('FORBIDDEN', 'Admin only');
    }

    const roles = this.reflector.getAllAndOverride<StaffRole[]>(RESTAURANT_ROLES, targets);
    if (roles && req.principal.kind === 'staff') {
      const restaurantId = req.header('x-restaurant-id');
      if (!restaurantId || !UUID_RE.test(restaurantId)) throw new AppError('RESTAURANT_HEADER_MISSING');
      const member = await this.prisma.restaurantMember.findUnique({
        where: { restaurantId_staffId: { restaurantId, staffId: req.principal.staffId } },
        select: { role: true },
      });
      if (!member) throw new AppError('NOT_A_MEMBER');
      if (!roles.includes(member.role)) {
        throw new AppError('ROLE_NOT_ALLOWED', undefined, { role: member.role, allowed: roles });
      }
      req.restaurantId = restaurantId;
      req.memberRole = member.role;
    }
    return true;
  }

  private extractToken(req: AuthedRequest): string | undefined {
    const [type, value] = (req.headers.authorization ?? '').split(' ');
    return type === 'Bearer' && value ? value : undefined;
  }
}
