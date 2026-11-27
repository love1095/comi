import { Controller, Get, Module, Res } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import type { Response } from 'express';
import { Public } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { RedisService } from '../../common/redis';
import { PrismaService } from '../../prisma/prisma.service';

@ApiTags('health')
@Controller('health')
export class HealthController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly redis: RedisService,
    private readonly clock: Clock,
  ) {}

  /** Liveness + DB + Redis, used by uptime monitors and the load balancer (§24.4). 503 when degraded. */
  @Public()
  @Get()
  async check(@Res({ passthrough: true }) res: Response) {
    const [db, redis] = await Promise.all([
      this.prisma.$queryRaw`SELECT 1`.then(
        () => 'up' as const,
        () => 'down' as const,
      ),
      this.redis.client.ping().then(
        () => 'up' as const,
        () => 'down' as const,
      ),
    ]);
    const ok = db === 'up' && redis === 'up';
    if (!ok) res.status(503);
    return { status: ok ? 'ok' : 'degraded', db, redis, time: this.clock.now().toISOString() };
  }
}

@Module({ controllers: [HealthController] })
export class HealthModule {}
