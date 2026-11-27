import { createParamDecorator, ExecutionContext, SetMetadata, applyDecorators } from '@nestjs/common';
import { ApiBearerAuth, ApiHeader } from '@nestjs/swagger';
import { StaffRole } from '@prisma/client';
import { AppError } from '../errors/app-error';
import { AuthedRequest } from './auth.types';

export const IS_PUBLIC = 'comi:public';
export const ACTOR = 'comi:actor';
export const RESTAURANT_ROLES = 'comi:restaurantRoles';

export type ActorKind = 'user' | 'staff' | 'admin';

/** No login required. */
export const Public = () => SetMetadata(IS_PUBLIC, true);

export const CustomerOnly = () => applyDecorators(SetMetadata(ACTOR, 'user'), ApiBearerAuth());
export const StaffOnly = () => applyDecorators(SetMetadata(ACTOR, 'staff'), ApiBearerAuth());
export const AdminOnly = () => applyDecorators(SetMetadata(ACTOR, 'admin'), ApiBearerAuth());

/**
 * Staff endpoint scoped to the restaurant in the `X-Restaurant-Id` header.
 * The guard loads the membership and checks the role.
 */
export const RestaurantRoles = (...roles: readonly StaffRole[]) =>
  applyDecorators(
    SetMetadata(ACTOR, 'staff'),
    SetMetadata(RESTAURANT_ROLES, roles),
    ApiBearerAuth(),
    ApiHeader({ name: 'X-Restaurant-Id', required: true }),
  );

const req = (ctx: ExecutionContext) => ctx.switchToHttp().getRequest<AuthedRequest>();

export const CurrentUserId = createParamDecorator((_: unknown, ctx: ExecutionContext): string => {
  const p = req(ctx).principal;
  if (p?.kind !== 'user') throw new AppError('FORBIDDEN', 'Customer login required');
  return p.userId;
});

export const CurrentStaffId = createParamDecorator((_: unknown, ctx: ExecutionContext): string => {
  const p = req(ctx).principal;
  if (p?.kind !== 'staff') throw new AppError('FORBIDDEN', 'Staff login required');
  return p.staffId;
});

export const RestaurantId = createParamDecorator((_: unknown, ctx: ExecutionContext): string => {
  const id = req(ctx).restaurantId;
  if (!id) throw new AppError('RESTAURANT_HEADER_MISSING');
  return id;
});

export const MemberRole = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): StaffRole | undefined => req(ctx).memberRole,
);
