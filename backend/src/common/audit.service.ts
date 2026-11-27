import { Global, Injectable, Module } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

export type ActorType = 'USER' | 'STAFF' | 'ADMIN' | 'SYSTEM';

@Injectable()
export class AuditService {
  constructor(private readonly prisma: PrismaService) {}

  log(
    entry: { actorType: ActorType; actorId?: string; action: string; entity: string; entityId: string; data?: unknown },
    tx: Prisma.TransactionClient = this.prisma,
  ) {
    return tx.auditLog.create({
      data: { ...entry, data: (entry.data ?? undefined) as Prisma.InputJsonValue | undefined },
    });
  }
}

@Global()
@Module({ providers: [AuditService], exports: [AuditService] })
export class AuditModule {}
