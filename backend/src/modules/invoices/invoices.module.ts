import { Body, Controller, Get, HttpCode, Injectable, Module, Param, ParseUUIDPipe, Post, Query } from '@nestjs/common';
import { ApiOkResponse, ApiProperty, ApiPropertyOptional, ApiQuery, ApiTags } from '@nestjs/swagger';
import { IsBoolean, IsEmail, IsOptional, IsString, Matches, MaxLength, MinLength } from 'class-validator';
import { Perm } from '../../common/auth/auth.types';
import { AuditService } from '../../common/audit.service';
import { CurrentStaffId, CurrentUserId, CustomerOnly, RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { Clock } from '../../common/clock';
import { AppError, notFound } from '../../common/errors/app-error';
import { MailService } from '../../common/mail';
import { PrismaService } from '../../prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';

/** Vietnamese tax code (MST): 10 digits, branches add -XXX (§13). */
export const TAX_CODE_RE = /^\d{10}(-\d{3})?$/;
const REQUEST_WINDOW_HOURS = 24; // "at checkout or within the same day after the meal"

class InvoiceRequestCreateDto {
  @ApiProperty() @IsString() @MinLength(2) @MaxLength(200) companyName: string;
  @ApiProperty({ example: '0312345678' }) @Matches(TAX_CODE_RE, { message: 'taxCode must be 10 digits (or 10-3)' }) taxCode: string;
  @ApiProperty() @IsString() @MinLength(5) @MaxLength(300) address: string;
  @ApiProperty() @IsEmail() @MaxLength(200) email: string;
  @ApiPropertyOptional({ description: 'Save for next time' }) @IsOptional() @IsBoolean() saveProfile?: boolean;
}

class MarkIssuedDto {
  @ApiPropertyOptional({ description: 'Invoice number from the e-invoice system' }) @IsOptional() @IsString() @MaxLength(50) invoiceNo?: string;
}

export class InvoiceRequestDto {
  @ApiProperty() id: string;
  @ApiProperty() bookingId: string;
  @ApiProperty() bookingCode: string;
  @ApiProperty() companyName: string;
  @ApiProperty() taxCode: string;
  @ApiProperty() address: string;
  @ApiProperty() email: string;
  @ApiProperty({ enum: ['REQUESTED', 'SENT_TO_RESTAURANT', 'ISSUED', 'EMAILED', 'REJECTED'] }) status: string;
  @ApiPropertyOptional({ nullable: true, type: String }) invoiceNo: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) issuedAt: string | null;
  @ApiProperty({ description: 'Bill amount to invoice (VND)' }) amount: number;
  @ApiProperty() arrivalAt: string;
}

export class InvoiceProfileDto {
  @ApiProperty() id: string;
  @ApiProperty() companyName: string;
  @ApiProperty() taxCode: string;
  @ApiProperty() address: string;
  @ApiProperty() email: string;
  @ApiProperty() isDefault: boolean;
}

const INCLUDE = {
  booking: { select: { code: true, arrivalAt: true, finalBillAmount: true, userId: true, restaurantId: true, order: { select: { total: true } } } },
} as const;

type Row = { id: string; bookingId: string; companyName: string; taxCode: string; address: string; email: string; status: string; invoiceNo: string | null; issuedAt: Date | null } & {
  booking: { code: string; arrivalAt: Date; finalBillAmount: number | null; order: { total: number } | null };
};

const dto = (r: Row): InvoiceRequestDto => ({
  id: r.id,
  bookingId: r.bookingId,
  bookingCode: r.booking.code,
  companyName: r.companyName,
  taxCode: r.taxCode,
  address: r.address,
  email: r.email,
  status: r.status,
  invoiceNo: r.invoiceNo,
  issuedAt: r.issuedAt?.toISOString() ?? null,
  amount: r.booking.finalBillAmount ?? r.booking.order?.total ?? 0,
  arrivalAt: r.booking.arrivalAt.toISOString(),
});

/** VAT invoice ("hoá đơn đỏ") requests (§13). The restaurant stays the legal issuer. */
@Injectable()
export class InvoicesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly audit: AuditService,
    private readonly clock: Clock,
    private readonly mail: MailService,
    private readonly realtime: RealtimeService,
  ) {}

  async request(userId: string, bookingId: string, p: InvoiceRequestCreateDto) {
    const b = await this.prisma.booking.findFirst({
      where: { id: bookingId, userId },
      include: { invoiceRequest: true, restaurant: { select: { name: true, members: { where: { role: { in: ['OWNER', 'MANAGER'] } }, select: { staff: { select: { email: true } } } } } } },
    });
    if (!b) throw notFound('Booking');
    if (b.invoiceRequest) throw new AppError('CONFLICT', 'An invoice was already requested for this booking');
    const now = this.clock.now();
    const open = b.status === 'CHECKED_IN' || (b.status === 'COMPLETED' && (!b.completedAt || now.getTime() - b.completedAt.getTime() <= REQUEST_WINDOW_HOURS * 3_600_000));
    if (!open) throw new AppError('INVALID_STATUS', `Request a VAT invoice during the meal or within ${REQUEST_WINDOW_HOURS} h after`);

    const created = await this.prisma.$transaction(async (tx) => {
      if (p.saveProfile) {
        const existing = await tx.invoiceProfile.findFirst({ where: { userId, taxCode: p.taxCode } });
        const data = { companyName: p.companyName, address: p.address, email: p.email, isDefault: true };
        await tx.invoiceProfile.updateMany({ where: { userId }, data: { isDefault: false } });
        if (existing) await tx.invoiceProfile.update({ where: { id: existing.id }, data });
        else await tx.invoiceProfile.create({ data: { ...data, userId, taxCode: p.taxCode } });
      }
      const r = await tx.invoiceRequest.create({
        data: { bookingId, companyName: p.companyName.trim(), taxCode: p.taxCode, address: p.address.trim(), email: p.email.trim(), status: 'SENT_TO_RESTAURANT' },
        include: INCLUDE,
      });
      await this.audit.log({ actorType: 'USER', actorId: userId, action: 'invoice.requested', entity: 'InvoiceRequest', entityId: r.id }, tx);
      return r;
    });

    this.realtime.toRestaurant(b.restaurantId, 'booking.updated', { bookingId, invoice: 'requested' });
    const staff = b.restaurant.members.map((m) => m.staff.email).filter(Boolean).join(', ');
    const d = dto(created);
    if (staff) {
      await this.mail.send({
        to: staff,
        subject: `comi — Yêu cầu xuất hoá đơn VAT · đơn ${d.bookingCode}`,
        text: [
          `${b.restaurant.name} có yêu cầu xuất hoá đơn VAT:`,
          `Đơn: ${d.bookingCode} · Số tiền: ${d.amount.toLocaleString('vi-VN')} đ`,
          `Công ty: ${d.companyName}`,
          `MST: ${d.taxCode}`,
          `Địa chỉ: ${d.address}`,
          `Email nhận hoá đơn: ${d.email}`,
          '',
          'Xuất hoá đơn trên hệ thống hoá đơn điện tử của quán, rồi bấm "Đã xuất" trong ứng dụng comi.',
        ].join('\n'),
      });
    }
    // TODO(phase2/push): push to restaurant staff.
    return d;
  }

  async forBooking(userId: string, bookingId: string) {
    const r = await this.prisma.invoiceRequest.findFirst({ where: { bookingId, booking: { userId } }, include: INCLUDE });
    if (!r) throw notFound('Invoice request');
    return dto(r);
  }

  async profiles(userId: string) {
    return this.prisma.invoiceProfile.findMany({
      where: { userId },
      orderBy: [{ isDefault: 'desc' }, { companyName: 'asc' }],
      select: { id: true, companyName: true, taxCode: true, address: true, email: true, isDefault: true },
    });
  }

  async forRestaurant(restaurantId: string, openOnly: boolean) {
    const rows = await this.prisma.invoiceRequest.findMany({
      where: { booking: { restaurantId }, ...(openOnly ? { status: { in: ['REQUESTED', 'SENT_TO_RESTAURANT'] } } : {}) },
      include: INCLUDE,
      orderBy: { booking: { arrivalAt: 'desc' } },
      take: 200,
    });
    return rows.map(dto);
  }

  private async ofRestaurant(restaurantId: string, id: string) {
    const r = await this.prisma.invoiceRequest.findFirst({ where: { id, booking: { restaurantId } }, include: INCLUDE });
    if (!r) throw notFound('Invoice request');
    return r;
  }

  async markIssued(restaurantId: string, staffId: string, id: string, invoiceNo?: string) {
    const r = await this.ofRestaurant(restaurantId, id);
    if (r.status === 'REJECTED') throw new AppError('INVALID_STATUS', 'Request was rejected');
    const updated = await this.prisma.invoiceRequest.update({
      where: { id },
      data: { status: 'ISSUED', invoiceNo: invoiceNo ?? r.invoiceNo, issuedAt: r.issuedAt ?? this.clock.now() },
      include: INCLUDE,
    });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'invoice.issued', entity: 'InvoiceRequest', entityId: id, data: { invoiceNo } });
    const sent = await this.mail.send({
      to: updated.email,
      subject: `comi — Hoá đơn VAT đơn ${updated.booking.code} đã được xuất`,
      text: [
        `Nhà hàng đã xuất hoá đơn VAT cho ${updated.companyName} (MST ${updated.taxCode}).`,
        invoiceNo ? `Số hoá đơn: ${invoiceNo}.` : '',
        'Hoá đơn điện tử được gửi từ hệ thống của nhà hàng; liên hệ quán nếu chưa nhận được.',
      ].join('\n'),
    });
    this.realtime.toUser(r.booking.userId, 'booking.status', { bookingId: r.bookingId, invoice: 'issued' });
    if (sent) await this.prisma.invoiceRequest.update({ where: { id }, data: { status: 'EMAILED' } });
    return dto({ ...updated, status: sent ? 'EMAILED' : 'ISSUED' });
  }

  async reject(restaurantId: string, staffId: string, id: string) {
    const r = await this.ofRestaurant(restaurantId, id);
    if (r.status === 'ISSUED' || r.status === 'EMAILED') throw new AppError('INVALID_STATUS', 'Already issued');
    const updated = await this.prisma.invoiceRequest.update({ where: { id }, data: { status: 'REJECTED' }, include: INCLUDE });
    await this.audit.log({ actorType: 'STAFF', actorId: staffId, action: 'invoice.rejected', entity: 'InvoiceRequest', entityId: id });
    this.realtime.toUser(r.booking.userId, 'booking.status', { bookingId: r.bookingId, invoice: 'rejected' });
    return dto(updated);
  }
}

const uuid = new ParseUUIDPipe();

@ApiTags('customer / VAT invoice')
@CustomerOnly()
@Controller()
export class CustomerInvoiceController {
  constructor(private readonly invoices: InvoicesService) {}

  @Post('bookings/:id/invoice')
  @HttpCode(200)
  @ApiOkResponse({ type: InvoiceRequestDto })
  request(@CurrentUserId() userId: string, @Param('id', uuid) id: string, @Body() dto: InvoiceRequestCreateDto) {
    return this.invoices.request(userId, id, dto);
  }

  @Get('bookings/:id/invoice')
  @ApiOkResponse({ type: InvoiceRequestDto })
  get(@CurrentUserId() userId: string, @Param('id', uuid) id: string) {
    return this.invoices.forBooking(userId, id);
  }

  @Get('me/invoice-profiles')
  @ApiOkResponse({ type: [InvoiceProfileDto] })
  profiles(@CurrentUserId() userId: string) {
    return this.invoices.profiles(userId);
  }
}

@ApiTags('restaurant / VAT invoice')
@Controller('restaurant/invoice-requests')
export class RestaurantInvoiceController {
  constructor(private readonly invoices: InvoicesService) {}

  @RestaurantRoles(...Perm.BOOKINGS)
  @Get()
  @ApiQuery({ name: 'all', required: false, description: 'true = include issued and rejected' })
  @ApiOkResponse({ type: [InvoiceRequestDto] })
  list(@RestaurantId() rid: string, @Query('all') all?: string) {
    return this.invoices.forRestaurant(rid, all !== 'true');
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/issued')
  @HttpCode(200)
  @ApiOkResponse({ type: InvoiceRequestDto })
  issued(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string, @Body() dto: MarkIssuedDto) {
    return this.invoices.markIssued(rid, staffId, id, dto.invoiceNo);
  }

  @RestaurantRoles(...Perm.BOOKINGS)
  @Post(':id/reject')
  @HttpCode(200)
  @ApiOkResponse({ type: InvoiceRequestDto })
  reject(@RestaurantId() rid: string, @CurrentStaffId() staffId: string, @Param('id', uuid) id: string) {
    return this.invoices.reject(rid, staffId, id);
  }
}

@Module({ controllers: [CustomerInvoiceController, RestaurantInvoiceController], providers: [InvoicesService] })
export class InvoicesModule {}
