import { Injectable } from '@nestjs/common';
import { AppError } from '../../common/errors/app-error';
import { addDays, zonedMidnight, zonedParts } from '../../common/utils/time';
import { PrismaService } from '../../prisma/prisma.service';

const MAX_DAYS = 93;

/** Restaurant report (§Phase 4 "Restaurant reports"): bookings, guests, revenue, fees, best dishes. */
@Injectable()
export class ReportsService {
  constructor(private readonly prisma: PrismaService) {}

  async summary(restaurantId: string, from: string, to: string) {
    const r = await this.prisma.restaurant.findUniqueOrThrow({ where: { id: restaurantId }, select: { timezone: true } });
    const start = zonedMidnight(from, r.timezone);
    const end = zonedMidnight(addDays(to, 1), r.timezone);
    if (end <= start) throw new AppError('VALIDATION_FAILED', '"to" must not be before "from"');
    if (end.getTime() - start.getTime() > MAX_DAYS * 86_400_000) throw new AppError('VALIDATION_FAILED', `At most ${MAX_DAYS} days`);

    const bookings = await this.prisma.booking.findMany({
      where: { restaurantId, arrivalAt: { gte: start, lt: end } },
      select: {
        arrivalAt: true,
        status: true,
        partySize: true,
        finalBillAmount: true,
        paymentMode: true,
        fee: { select: { feeAmount: true, status: true } },
        order: { select: { items: { where: { kitchenStatus: { not: 'CANCELLED' } }, select: { nameSnapshot: true, unitPrice: true, quantity: true, round: true } } } },
      },
    });

    const count = (s: string) => bookings.filter((b) => b.status === s).length;
    const completed = bookings.filter((b) => b.status === 'COMPLETED');
    const revenue = completed.reduce((s, b) => s + (b.finalBillAmount ?? 0), 0);
    const preOrder = bookings
      .filter((b) => b.status !== 'CANCELLED' && b.status !== 'EXPIRED')
      .reduce((s, b) => s + (b.order?.items ?? []).filter((i) => i.round === 0).reduce((x, i) => x + i.unitPrice * i.quantity, 0), 0);
    const fees = bookings.reduce((s, b) => s + (b.fee && (b.fee.status === 'FINAL' || b.fee.status === 'BILLED') ? b.fee.feeAmount : 0), 0);
    const ended = completed.length + count('NO_SHOW');

    const days = new Map<string, { date: string; bookings: number; guests: number; revenue: number }>();
    for (const b of bookings) {
      const date = zonedParts(b.arrivalAt, r.timezone).date;
      const d = days.get(date) ?? { date, bookings: 0, guests: 0, revenue: 0 };
      if (b.status !== 'CANCELLED' && b.status !== 'EXPIRED') {
        d.bookings++;
        d.guests += b.partySize;
      }
      if (b.status === 'COMPLETED') d.revenue += b.finalBillAmount ?? 0;
      days.set(date, d);
    }

    const dishes = new Map<string, { name: string; quantity: number; revenue: number }>();
    for (const b of completed) {
      for (const i of b.order?.items ?? []) {
        const d = dishes.get(i.nameSnapshot) ?? { name: i.nameSnapshot, quantity: 0, revenue: 0 };
        d.quantity += i.quantity;
        d.revenue += i.unitPrice * i.quantity;
        dishes.set(i.nameSnapshot, d);
      }
    }

    return {
      from,
      to,
      bookings: bookings.length,
      completed: completed.length,
      cancelled: count('CANCELLED'),
      noShows: count('NO_SHOW'),
      noShowRate: ended ? Math.round((count('NO_SHOW') / ended) * 1000) / 10 : 0,
      guests: completed.reduce((s, b) => s + b.partySize, 0),
      revenue,
      averageBill: completed.length ? Math.round(revenue / completed.length) : 0,
      preOrderValue: preOrder,
      platformFees: fees,
      byDay: [...days.values()].sort((a, b) => a.date.localeCompare(b.date)),
      topDishes: [...dishes.values()].sort((a, b) => b.quantity - a.quantity).slice(0, 10),
    };
  }
}
