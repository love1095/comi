import { INestApplicationContext, Logger, Module } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { IoAdapter } from '@nestjs/platform-socket.io';
import { ConnectedSocket, MessageBody, OnGatewayConnection, SubscribeMessage, WebSocketGateway } from '@nestjs/websockets';
import { createAdapter } from '@socket.io/redis-adapter';
import Redis from 'ioredis';
import { Server, ServerOptions, Socket } from 'socket.io';
import { PrismaService } from '../../prisma/prisma.service';
import { AccessTokenPayload } from '../../common/auth/auth.types';
import { NS, rooms } from './realtime.service';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;

async function principalOf(jwt: JwtService, socket: Socket): Promise<AccessTokenPayload | null> {
  const token = (socket.handshake.auth?.token as string | undefined) ?? undefined;
  if (!token) return null;
  try {
    return await jwt.verifyAsync<AccessTokenPayload>(token);
  } catch {
    return null;
  }
}

/**
 * Staff sockets: `io('/restaurant', { auth: { token, restaurantId, kitchen? } })`.
 * Joins `r:{id}` after checking membership; kitchen screens also join `r:{id}:kitchen`.
 */
@WebSocketGateway({ namespace: NS.RESTAURANT, cors: { origin: true } })
export class RestaurantGateway implements OnGatewayConnection {
  constructor(
    private readonly jwt: JwtService,
    private readonly prisma: PrismaService,
  ) {}

  async handleConnection(socket: Socket) {
    const p = await principalOf(this.jwt, socket);
    const restaurantId = socket.handshake.auth?.restaurantId as string | undefined;
    if (!p || p.typ !== 'staff' || !restaurantId || !UUID_RE.test(restaurantId)) return socket.disconnect(true);
    const member = await this.prisma.restaurantMember.findUnique({
      where: { restaurantId_staffId: { restaurantId, staffId: p.sub } },
      select: { role: true },
    });
    if (!member && !p.adm) return socket.disconnect(true);
    await socket.join(rooms.restaurant(restaurantId));
    if (socket.handshake.auth?.kitchen === true || member?.role === 'KITCHEN') await socket.join(rooms.kitchen(restaurantId));
  }
}

/**
 * Customer sockets: `io('/customer', { auth: { token? } })`. Logged-in users join `u:{id}`.
 * Anyone may watch a table map (`map.join` { restaurantId, date }) — it only carries table states.
 */
@WebSocketGateway({ namespace: NS.CUSTOMER, cors: { origin: true } })
export class CustomerGateway implements OnGatewayConnection {
  constructor(
    private readonly jwt: JwtService,
    private readonly prisma: PrismaService,
  ) {}

  /** Watch a group order's shared cart (§8.4). The share token is the permission. */
  @SubscribeMessage('group.join')
  async joinGroup(@ConnectedSocket() socket: Socket, @MessageBody() body: { token?: string }) {
    if (!body?.token || body.token.length > 64) return { ok: false };
    const inv = await this.prisma.groupInvite.findUnique({ where: { token: body.token }, select: { bookingId: true } });
    if (!inv) return { ok: false };
    await socket.join(rooms.group(inv.bookingId));
    return { ok: true };
  }

  async handleConnection(socket: Socket) {
    const p = await principalOf(this.jwt, socket);
    if (p?.typ === 'user') await socket.join(rooms.user(p.sub));
  }

  @SubscribeMessage('map.join')
  async joinMap(@ConnectedSocket() socket: Socket, @MessageBody() body: { restaurantId?: string; date?: string }) {
    if (!body?.restaurantId || !UUID_RE.test(body.restaurantId) || !body.date || !DATE_RE.test(body.date)) return { ok: false };
    for (const r of socket.rooms) if (r.startsWith('map:')) await socket.leave(r);
    await socket.join(rooms.map(body.restaurantId, body.date));
    return { ok: true };
  }

  @SubscribeMessage('map.leave')
  async leaveMap(@ConnectedSocket() socket: Socket) {
    for (const r of socket.rooms) if (r.startsWith('map:')) await socket.leave(r);
    return { ok: true };
  }
}

/** Socket.IO with the Redis adapter, so events published by the worker reach clients of every API instance. */
export class RedisIoAdapter extends IoAdapter {
  private readonly log = new Logger(RedisIoAdapter.name);

  constructor(
    app: INestApplicationContext,
    private readonly redisUrl: string,
  ) {
    super(app);
  }

  createIOServer(port: number, options?: ServerOptions): Server {
    const server = super.createIOServer(port, options) as Server;
    const pub = new Redis(this.redisUrl, { lazyConnect: false, maxRetriesPerRequest: null });
    const sub = pub.duplicate();
    for (const c of [pub, sub]) c.on('error', (e) => this.log.warn(`socket redis: ${e.message}`));
    server.adapter(createAdapter(pub, sub));
    return server;
  }
}

@Module({ providers: [RestaurantGateway, CustomerGateway] })
export class RealtimeGatewayModule {}
