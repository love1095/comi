/**
 * Response schemas for Swagger → generated Dart client. Only shapes, no logic.
 * Add `@ApiOkResponse({ type: X })` to an endpoint so the client returns typed data
 * instead of `Response<void>`.
 */
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { BookingStatus, Course, ItemKind, KitchenStatus, MapElementType, PaymentMode, RestaurantStatus, StaffRole, TableShape } from '@prisma/client';

export class RestaurantSummaryDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiProperty({ enum: RestaurantStatus, enumName: 'RestaurantStatus' }) status: RestaurantStatus;
  @ApiPropertyOptional({ nullable: true, type: String }) coverPhotoUrl: string | null;
}

export class MembershipDto {
  @ApiProperty({ enum: StaffRole, enumName: 'StaffRole' }) role: StaffRole;
  @ApiProperty({ type: RestaurantSummaryDto }) restaurant: RestaurantSummaryDto;
}

export class OpeningHoursDto {
  @ApiProperty() weekday: number;
  @ApiProperty() openMinute: number;
  @ApiProperty() closeMinute: number;
  @ApiPropertyOptional({ nullable: true, type: Number }) lastOrderMinute: number | null;
}

export class RestaurantProfileDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty() phone: string;
  @ApiProperty() address: string;
  @ApiProperty() provinceCode: string;
  @ApiPropertyOptional({ nullable: true, type: Number }) lat: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) lng: number | null;
  @ApiProperty() timezone: string;
  @ApiProperty({ type: [String] }) cuisineTags: string[];
  @ApiProperty({ type: [String] }) ambienceTags: string[];
  @ApiProperty() priceLevel: number;
  @ApiPropertyOptional({ nullable: true, type: String }) coverPhotoUrl: string | null;
  @ApiProperty({ enum: RestaurantStatus, enumName: 'RestaurantStatus' }) status: RestaurantStatus;
  @ApiPropertyOptional({ nullable: true, type: String }) rejectReason: string | null;
  @ApiProperty() slotMinutes: number;
  @ApiProperty() diningMinutes: number;
  @ApiProperty() graceMinutes: number;
  @ApiProperty() minLeadMinutes: number;
  @ApiProperty() maxDaysAhead: number;
  @ApiProperty() allowCod: boolean;
  @ApiProperty() servesLunch: boolean;
  @ApiProperty() servesNhau: boolean;
  @ApiProperty() maxGroupSize: number;
  @ApiProperty() confirmGroupsOver: number;
  @ApiProperty() allowTableChoice: boolean;
  @ApiProperty() cancelCutoffMinutes: number;
  @ApiProperty() startEarlyOnCheckIn: boolean;
  @ApiProperty() codStartOnDepart: boolean;
  @ApiProperty() allowTableOrdering: boolean;
  @ApiProperty() tableOrderingNeedsApproval: boolean;
  @ApiProperty() ratingAvg: number;
  @ApiProperty() ratingCount: number;
  @ApiProperty({ type: [OpeningHoursDto] }) openingHours: OpeningHoursDto[];
}

export class ChecklistDto {
  @ApiProperty() complete: boolean;
  @ApiProperty({ type: [String] }) missing: string[];
}

export class AreaSummaryDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() sortOrder: number;
  @ApiProperty() gridCols: number;
  @ApiProperty() gridRows: number;
  @ApiProperty() floor: number;
  @ApiPropertyOptional({ nullable: true, type: String }) backgroundUrl: string | null;
}

export class TableDto {
  @ApiProperty() id: string;
  @ApiProperty() areaId: string;
  @ApiProperty() code: string;
  @ApiProperty() minSeats: number;
  @ApiProperty() maxSeats: number;
  @ApiProperty() isActive: boolean;
  @ApiPropertyOptional({ nullable: true, type: Number }) posX: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) posY: number | null;
  @ApiProperty({ type: [String] }) features: string[];
  @ApiProperty({ enum: TableShape, enumName: 'TableShape' }) shape: TableShape;
  @ApiProperty() width: number;
  @ApiProperty() height: number;
  @ApiProperty() rotation: number;
  @ApiProperty() isSelectable: boolean;
  @ApiProperty() surcharge: number;
  @ApiPropertyOptional({ nullable: true, type: String }) joinGroup: string | null;
}

export class MapElementResponseDto {
  @ApiProperty() id: string;
  @ApiProperty({ enum: MapElementType, enumName: 'MapElementType' }) type: MapElementType;
  @ApiPropertyOptional({ nullable: true, type: String }) label: string | null;
  @ApiProperty() x: number;
  @ApiProperty() y: number;
  @ApiProperty() width: number;
  @ApiProperty() height: number;
  @ApiProperty() rotation: number;
}

export class AreaLayoutDto extends AreaSummaryDto {
  @ApiProperty({ type: [TableDto] }) tables: TableDto[];
  @ApiProperty({ type: [MapElementResponseDto] }) elements: MapElementResponseDto[];
}

export class BoardUserDto {
  @ApiProperty() id: string;
  @ApiPropertyOptional({ nullable: true, type: String }) name: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) phone: string | null;
  @ApiProperty() noShowCount: number;
}

export class BoardTableDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
}

export class BoardOrderDto {
  @ApiProperty() total: number;
}

export class BoardBookingDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiProperty() partySize: number;
  @ApiProperty() arrivalAt: string;
  @ApiProperty() endsAt: string;
  @ApiProperty({ enum: BookingStatus, enumName: 'BookingStatus' }) status: BookingStatus;
  @ApiProperty({ enum: PaymentMode, enumName: 'PaymentMode' }) paymentMode: PaymentMode;
  @ApiProperty() needsApproval: boolean;
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) tableId: string | null;
  @ApiProperty({ type: [String] }) extraTableIds: string[];
  @ApiPropertyOptional({ nullable: true, type: BoardTableDto }) table: BoardTableDto | null;
  @ApiProperty({ type: BoardUserDto }) user: BoardUserDto;
  @ApiPropertyOptional({ nullable: true, type: BoardOrderDto }) order: BoardOrderDto | null;
}

export class OptionSnapshotDto {
  @ApiProperty() group: string;
  @ApiProperty() option: string;
  @ApiProperty() priceDelta: number;
}

export class BoardOrderItemDto {
  @ApiProperty() id: string;
  @ApiProperty() nameSnapshot: string;
  @ApiProperty() unitPrice: number;
  @ApiProperty() quantity: number;
  @ApiProperty({ type: [OptionSnapshotDto] }) optionsSnapshot: OptionSnapshotDto[];
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
  @ApiProperty({ enum: Course, enumName: 'Course' }) course: Course;
  @ApiProperty({ enum: KitchenStatus, enumName: 'KitchenStatus' }) kitchenStatus: KitchenStatus;
  @ApiProperty({ description: '0 = pre-order, 1..n = ordered at the table' }) round: number;
}

export class BookingDetailOrderDto extends BoardOrderDto {
  @ApiProperty() id: string;
  @ApiProperty() subtotal: number;
  @ApiProperty() restaurantDiscount: number;
  @ApiProperty() platformDiscount: number;
  @ApiProperty({ type: [BoardOrderItemDto] }) items: BoardOrderItemDto[];
}

// ───── payments on a booking (§10) ─────

export class BookingPaymentDto {
  @ApiProperty() id: string;
  @ApiProperty() amount: number;
  @ApiProperty({ enum: ['CREATED', 'PENDING', 'PAID', 'FAILED', 'EXPIRED', 'REFUNDED', 'PARTIALLY_REFUNDED'] }) status: string;
  @ApiProperty({ enum: ['BOOKING', 'SHARE'] }) purpose: string;
  @ApiPropertyOptional({ nullable: true, type: String }) guestId: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) checkoutUrl: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) qrCode: string | null;
  @ApiProperty() expiresAt: string;
  @ApiPropertyOptional({ nullable: true, type: String }) paidAt: string | null;
  @ApiProperty() refundedAmount: number;
}

export class BookingRefundDto {
  @ApiProperty() id: string;
  @ApiProperty() amount: number;
  @ApiProperty({ enum: ['PENDING', 'DONE'] }) status: string;
  @ApiProperty() reason: string;
  @ApiProperty() createdAt: string;
  @ApiPropertyOptional({ nullable: true, type: String }) doneAt: string | null;
}

/** One booking for staff (GET :id and actions): board fields + full order lines. */
export class BookingDetailDto extends BoardBookingDto {
  @ApiPropertyOptional({ nullable: true, type: BookingDetailOrderDto }) override order: BookingDetailOrderDto | null;
  @ApiProperty({ type: [BookingPaymentDto] }) payments: BookingPaymentDto[];
  @ApiProperty({ type: [BookingRefundDto] }) refunds: BookingRefundDto[];
}

// ───── menu (staff) ─────

export class MenuOptionResponseDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() priceDelta: number;
  @ApiProperty() sortOrder: number;
}

export class OptionGroupResponseDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() minSelect: number;
  @ApiProperty() maxSelect: number;
  @ApiProperty() sortOrder: number;
  @ApiProperty({ type: [MenuOptionResponseDto] }) options: MenuOptionResponseDto[];
}

export class MenuPhotoDto {
  @ApiProperty() id: string;
  @ApiProperty({ description: 'Cloudinary public_id; apps build the delivery URL' }) publicId: string;
  @ApiProperty() width: number;
  @ApiProperty() height: number;
  @ApiPropertyOptional({ nullable: true, type: String }) blurhash: string | null;
  @ApiProperty() sortOrder: number;
}

export class MenuTranslationDto {
  @ApiProperty() locale: string;
  @ApiProperty() name: string;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty() isMachine: boolean;
}

export class StaffMenuItemDto {
  @ApiProperty() id: string;
  @ApiProperty() categoryId: string;
  @ApiProperty() name: string;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty() price: number;
  @ApiProperty({ enum: Course, enumName: 'Course' }) course: Course;
  @ApiProperty({ enum: ItemKind, enumName: 'ItemKind' }) kind: ItemKind;
  @ApiProperty() prepMinutes: number;
  @ApiProperty() isAvailable: boolean;
  @ApiProperty() isPreorderable: boolean;
  @ApiProperty() isAlcohol: boolean;
  @ApiProperty() leadHours: number;
  @ApiProperty({ type: [String] }) tags: string[];
  @ApiProperty() sortOrder: number;
  @ApiProperty({ type: [MenuPhotoDto] }) photos: MenuPhotoDto[];
  @ApiProperty({ type: [OptionGroupResponseDto] }) optionGroups: OptionGroupResponseDto[];
  @ApiProperty({ type: [MenuTranslationDto] }) translations: MenuTranslationDto[];
}

export class MenuCategoryResponseDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() sortOrder: number;
}

export class StaffMenuCategoryDto extends MenuCategoryResponseDto {
  @ApiProperty({ type: [StaffMenuItemDto] }) items: StaffMenuItemDto[];
}

export class AvailabilityResultDto {
  @ApiProperty() id: string;
  @ApiProperty() isAvailable: boolean;
}

export class ImportedItemDto {
  @ApiProperty() row: number;
  @ApiProperty() category: string;
  @ApiProperty() name: string;
  @ApiProperty() price: number;
  @ApiProperty({ enum: Course, enumName: 'Course' }) course: Course;
  @ApiProperty({ enum: ItemKind, enumName: 'ItemKind' }) kind: ItemKind;
  @ApiPropertyOptional() description?: string;
  @ApiProperty() prepMinutes: number;
  @ApiProperty() isAlcohol: boolean;
  @ApiProperty({ type: [String] }) tags: string[];
}

export class ImportErrorDto {
  @ApiProperty() row: number;
  @ApiPropertyOptional() column?: string;
  @ApiProperty() message: string;
}

export class ImportPreviewDto {
  @ApiProperty({ type: [ImportedItemDto] }) items: ImportedItemDto[];
  @ApiProperty({ type: [ImportErrorDto] }) errors: ImportErrorDto[];
}

export class ImportResultDto {
  @ApiProperty() created: number;
  @ApiProperty() categories: number;
}

export class UploadSignatureDto {
  @ApiProperty() cloudName: string;
  @ApiProperty() apiKey: string;
  @ApiProperty() timestamp: number;
  @ApiProperty() folder: string;
  @ApiProperty() signature: string;
}

export class GeocodeResultDto {
  @ApiProperty() address: string;
  @ApiProperty() lat: number;
  @ApiProperty() lng: number;
  @ApiPropertyOptional() placeId?: string;
}

// ───── kitchen (§7) ─────

export class KitchenItemDto {
  @ApiProperty() id: string;
  @ApiProperty() bookingId: string;
  @ApiProperty() bookingCode: string;
  @ApiPropertyOptional({ nullable: true, type: String }) tableCode: string | null;
  @ApiProperty() partySize: number;
  @ApiProperty() arrivalAt: string;
  @ApiProperty({ description: 'Booking is CHECKED_IN' }) guestArrived: boolean;
  @ApiProperty() nameSnapshot: string;
  @ApiProperty() quantity: number;
  @ApiProperty({ type: [OptionSnapshotDto] }) optionsSnapshot: OptionSnapshotDto[];
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
  @ApiProperty({ enum: Course, enumName: 'Course' }) course: Course;
  @ApiProperty() prepMinutes: number;
  @ApiProperty({ enum: KitchenStatus, enumName: 'KitchenStatus' }) kitchenStatus: KitchenStatus;
  @ApiProperty({ description: '0 = pre-order, 1..n = ordered at the table' }) round: number;
  @ApiPropertyOptional({ nullable: true, type: String }) scheduledStartAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) releasedAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) startedAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) readyAt: string | null;
}

export class KitchenQueueDto {
  @ApiProperty({ description: 'Server time, for "late by" timers' }) now: string;
  @ApiProperty({ type: [KitchenItemDto], description: 'COOKING first, then by fire time' }) active: KitchenItemDto[];
  @ApiProperty({ type: [KitchenItemDto], description: 'Done, waiting for a waiter' }) ready: KitchenItemDto[];
  @ApiProperty({ type: [KitchenItemDto], description: 'SCHEDULED (next 2 h) and HOLD (COD guest not here yet)' }) upcoming: KitchenItemDto[];
}

export class FireResultDto {
  @ApiProperty() queued: number;
}

export class CapacityRuleDto {
  @ApiProperty({ type: [Number], description: '0 = Sunday' }) weekdays: number[];
  @ApiProperty({ description: 'Minutes from 00:00' }) startMinute: number;
  @ApiProperty() endMinute: number;
  @ApiProperty() windowMinutes: number;
  @ApiProperty({ description: 'Most pre-ordered dishes starting in one window' }) maxItems: number;
}

// ───── fees, statements, reports (§11) ─────

export class StatementDto {
  @ApiProperty() id: string;
  @ApiProperty() restaurantId: string;
  @ApiProperty({ example: '2026-12' }) periodMonth: string;
  @ApiProperty() bookingCount: number;
  @ApiProperty() totalBase: number;
  @ApiProperty() totalFee: number;
  @ApiProperty() platformVoucherCredit: number;
  @ApiProperty({ description: 'Negative = comi pays the restaurant' }) amountDue: number;
  @ApiProperty({ enum: ['DRAFT', 'ISSUED', 'PAID', 'OVERDUE'] }) status: string;
  @ApiPropertyOptional({ nullable: true, type: String }) issuedAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) paidAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) dueAt: string | null;
  @ApiProperty({ description: 'Write this on the bank transfer' }) transferMemo: string;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'VietQR image to scan with a bank app' }) vietQrUrl: string | null;
}

export class StatementLineDto {
  @ApiProperty() bookingId: string;
  @ApiProperty() bookingCode: string;
  @ApiProperty() arrivalAt: string;
  @ApiProperty() partySize: number;
  @ApiProperty() baseAmount: number;
  @ApiProperty() rateBps: number;
  @ApiProperty() feeAmount: number;
}

export class StatementDetailDto extends StatementDto {
  @ApiProperty({ type: [StatementLineDto] }) lines: StatementLineDto[];
}

export class ReportDayDto {
  @ApiProperty() date: string;
  @ApiProperty() bookings: number;
  @ApiProperty() guests: number;
  @ApiProperty() revenue: number;
}

export class ReportDishDto {
  @ApiProperty() name: string;
  @ApiProperty() quantity: number;
  @ApiProperty() revenue: number;
}

export class ReportDto {
  @ApiProperty() from: string;
  @ApiProperty() to: string;
  @ApiProperty() bookings: number;
  @ApiProperty() completed: number;
  @ApiProperty() cancelled: number;
  @ApiProperty() noShows: number;
  @ApiProperty({ description: 'Percent of ended bookings' }) noShowRate: number;
  @ApiProperty() guests: number;
  @ApiProperty({ description: 'Sum of closed bills (VND)' }) revenue: number;
  @ApiProperty() averageBill: number;
  @ApiProperty() preOrderValue: number;
  @ApiProperty() platformFees: number;
  @ApiProperty({ type: [ReportDayDto] }) byDay: ReportDayDto[];
  @ApiProperty({ type: [ReportDishDto] }) topDishes: ReportDishDto[];
}
