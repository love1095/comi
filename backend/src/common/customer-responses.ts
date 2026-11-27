/**
 * Customer-facing response schemas for Swagger → generated Dart client. Only shapes, no logic.
 * Staff shapes live in responses.ts.
 */
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { BookingStatus, Course, ItemKind, OrderStatus, PaymentMode, ServeStyle, TableShape } from '@prisma/client';
import { BoardOrderItemDto, MapElementResponseDto, OpeningHoursDto } from './responses';

// ───── discovery ─────

export class RestaurantCardDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiProperty() address: string;
  @ApiProperty() priceLevel: number;
  @ApiProperty() ratingAvg: number;
  @ApiProperty() ratingCount: number;
  @ApiPropertyOptional({ nullable: true, type: String }) coverPhotoUrl: string | null;
  @ApiProperty({ type: [String] }) cuisineTags: string[];
  @ApiProperty() servesLunch: boolean;
  @ApiProperty() servesNhau: boolean;
  @ApiProperty() allowTableChoice: boolean;
  @ApiProperty() lat: number;
  @ApiProperty() lng: number;
  @ApiPropertyOptional({ nullable: true, type: Number }) distanceM: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number, description: 'Cheapest main dish (VND)' }) minMainPrice: number | null;
}

export class RestaurantPageDto {
  @ApiProperty({ type: [RestaurantCardDto] }) items: RestaurantCardDto[];
  @ApiPropertyOptional({ nullable: true, type: Number, description: 'Pass as cursor for the next page' }) nextCursor: number | null;
}

export class HomeSectionDto {
  @ApiProperty({ description: 'lunch_near_you | under_60k | tonight_groups | open_late | top_rated | menus_in_your_language' })
  key: string;
  @ApiProperty({ type: [RestaurantCardDto] }) items: RestaurantCardDto[];
}

export class HomeDto {
  @ApiProperty({ enum: ['lunch', 'tonight', 'explore'] }) mode: string;
  @ApiProperty({ type: [HomeSectionDto] }) sections: HomeSectionDto[];
}

export class MapPinDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiProperty() lat: number;
  @ApiProperty() lng: number;
  @ApiProperty() priceLevel: number;
  @ApiProperty() ratingAvg: number;
}

export class SuggestRestaurantDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
}

export class SuggestDishDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() price: number;
  @ApiProperty() restaurantId: string;
  @ApiProperty() restaurantSlug: string;
  @ApiProperty() restaurantName: string;
}

export class SuggestDto {
  @ApiProperty({ type: [SuggestRestaurantDto] }) restaurants: SuggestRestaurantDto[];
  @ApiProperty({ type: [SuggestDishDto] }) dishes: SuggestDishDto[];
}

export class ClosureInfoDto {
  @ApiProperty() startsAt: string;
  @ApiProperty() endsAt: string;
  @ApiPropertyOptional({ nullable: true, type: String }) reason: string | null;
}

export class AreaBriefDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() floor: number;
}

export class RestaurantDetailDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty({ description: 'True when name/description were translated to the requested language' }) translated: boolean;
  @ApiProperty() phone: string;
  @ApiProperty() address: string;
  @ApiPropertyOptional({ nullable: true, type: Number }) lat: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) lng: number | null;
  @ApiProperty() timezone: string;
  @ApiProperty({ type: [String] }) cuisineTags: string[];
  @ApiProperty({ type: [String] }) ambienceTags: string[];
  @ApiProperty() priceLevel: number;
  @ApiPropertyOptional({ nullable: true, type: String }) coverPhotoUrl: string | null;
  @ApiProperty() ratingAvg: number;
  @ApiProperty() ratingCount: number;
  @ApiProperty() servesLunch: boolean;
  @ApiProperty() servesNhau: boolean;
  @ApiProperty() allowTableChoice: boolean;
  @ApiProperty() allowCod: boolean;
  @ApiProperty() maxGroupSize: number;
  @ApiProperty() confirmGroupsOver: number;
  @ApiProperty() cancelCutoffMinutes: number;
  @ApiProperty() isOpenNow: boolean;
  @ApiProperty({ type: [OpeningHoursDto] }) openingHours: OpeningHoursDto[];
  @ApiProperty({ type: [ClosureInfoDto] }) closures: ClosureInfoDto[];
  @ApiProperty({ type: [AreaBriefDto] }) areas: AreaBriefDto[];
}

export class PublicPhotoDto {
  @ApiProperty() id: string;
  @ApiProperty() publicId: string;
  @ApiProperty() width: number;
  @ApiProperty() height: number;
  @ApiPropertyOptional({ nullable: true, type: String }) blurhash: string | null;
}

export class PublicOptionDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() priceDelta: number;
}

export class PublicOptionGroupDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() minSelect: number;
  @ApiProperty() maxSelect: number;
  @ApiProperty({ type: [PublicOptionDto] }) options: PublicOptionDto[];
}

export class PublicMenuItemDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiPropertyOptional({ nullable: true, type: String }) description: string | null;
  @ApiProperty() translated: boolean;
  @ApiProperty({ description: 'Vietnamese name (show to staff / taxi)' }) originalName: string;
  @ApiProperty() price: number;
  @ApiProperty({ enum: Course, enumName: 'Course' }) course: Course;
  @ApiProperty({ enum: ItemKind, enumName: 'ItemKind' }) kind: ItemKind;
  @ApiProperty() prepMinutes: number;
  @ApiProperty() isAvailable: boolean;
  @ApiProperty() isPreorderable: boolean;
  @ApiProperty() isAlcohol: boolean;
  @ApiProperty() leadHours: number;
  @ApiProperty({ type: [String] }) tags: string[];
  @ApiProperty({ type: [PublicPhotoDto] }) photos: PublicPhotoDto[];
  @ApiProperty({ type: [PublicOptionGroupDto] }) optionGroups: PublicOptionGroupDto[];
}

export class PublicMenuCategoryDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty({ type: [PublicMenuItemDto] }) items: PublicMenuItemDto[];
}

// ───── availability ─────

export class SlotDto {
  @ApiProperty({ description: 'Slot start (ISO, UTC) — send as arrivalAt' }) time: string;
  @ApiProperty({ description: 'HH:mm in the restaurant time zone' }) local: string;
  @ApiProperty() available: boolean;
  @ApiProperty() diningMinutes: number;
}

// ───── bookings ─────

export class BookingRestaurantDto {
  @ApiProperty() id: string;
  @ApiProperty() slug: string;
  @ApiProperty() name: string;
  @ApiProperty() address: string;
  @ApiProperty() phone: string;
  @ApiPropertyOptional({ nullable: true, type: String }) coverPhotoUrl: string | null;
  @ApiProperty() timezone: string;
}

export class BookingTableDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiProperty() areaId: string;
}

export class CustomerOrderDto {
  @ApiProperty() id: string;
  @ApiProperty() subtotal: number;
  @ApiProperty() restaurantDiscount: number;
  @ApiProperty() platformDiscount: number;
  @ApiProperty() total: number;
  @ApiProperty({ enum: OrderStatus, enumName: 'OrderStatus' }) status: OrderStatus;
  @ApiProperty({ type: [BoardOrderItemDto] }) items: BoardOrderItemDto[];
}

export class CustomerBookingDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiProperty() restaurantId: string;
  @ApiProperty() partySize: number;
  @ApiProperty() arrivalAt: string;
  @ApiProperty() endsAt: string;
  @ApiProperty({ enum: PaymentMode, enumName: 'PaymentMode' }) paymentMode: PaymentMode;
  @ApiProperty({ enum: ServeStyle, enumName: 'ServeStyle' }) serveStyle: ServeStyle;
  @ApiProperty({ enum: BookingStatus, enumName: 'BookingStatus' }) status: BookingStatus;
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
  @ApiProperty() needsApproval: boolean;
  @ApiProperty({ type: [String] }) extraTableIds: string[];
  @ApiPropertyOptional({ nullable: true, type: String }) cancelledAt: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) cancelReason: string | null;
  @ApiPropertyOptional({ nullable: true, type: String, description: 'USER | RESTAURANT | SYSTEM' }) cancelledBy: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) checkedInAt: string | null;
  @ApiProperty() createdAt: string;
  @ApiProperty({ type: BookingRestaurantDto }) restaurant: BookingRestaurantDto;
  @ApiPropertyOptional({ nullable: true, type: BookingTableDto }) table: BookingTableDto | null;
  @ApiPropertyOptional({ nullable: true, type: CustomerOrderDto }) order: CustomerOrderDto | null;
}

export class MyBookingsPageDto {
  @ApiProperty({ type: [CustomerBookingDto] }) items: CustomerBookingDto[];
  @ApiPropertyOptional({ nullable: true, type: String }) nextCursor: string | null;
}

export class ReorderLineDto {
  @ApiProperty() menuItemId: string;
  @ApiProperty() name: string;
  @ApiProperty() price: number;
  @ApiProperty() quantity: number;
  @ApiPropertyOptional({ nullable: true, type: String }) note: string | null;
}

export class UnavailableLineDto {
  @ApiProperty() menuItemId: string;
  @ApiProperty() name: string;
}

export class ReorderDraftDto {
  @ApiProperty({ type: BookingRestaurantDto }) restaurant: BookingRestaurantDto;
  @ApiProperty() partySize: number;
  @ApiProperty({ enum: ServeStyle, enumName: 'ServeStyle' }) serveStyle: ServeStyle;
  @ApiProperty({ type: [ReorderLineDto] }) items: ReorderLineDto[];
  @ApiProperty({ type: [UnavailableLineDto] }) unavailable: UnavailableLineDto[];
}

// ───── me ─────

export class MeDto {
  @ApiProperty() id: string;
  @ApiPropertyOptional({ nullable: true, type: String }) phone: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) email: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) name: string | null;
  @ApiPropertyOptional({ nullable: true, type: String }) avatarUrl: string | null;
  @ApiProperty() locale: string;
  @ApiProperty() noShowCount: number;
  @ApiProperty({ description: 'Too many no-shows: bookings must be prepaid' }) mustPrepay: boolean;
  @ApiProperty() createdAt: string;
}

// ───── table map + holds (§8.6) ─────

export class MapAreaDto {
  @ApiProperty() id: string;
  @ApiProperty() name: string;
  @ApiProperty() floor: number;
  @ApiProperty() gridCols: number;
  @ApiProperty() gridRows: number;
  @ApiPropertyOptional({ nullable: true, type: String }) backgroundUrl: string | null;
}

export class MapAreaWithElementsDto extends MapAreaDto {
  @ApiProperty({ type: [MapElementResponseDto] }) elements: MapElementResponseDto[];
}

export class MyHoldDto {
  @ApiProperty() holdId: string;
  @ApiProperty() expiresAt: string;
  @ApiProperty({ type: [String] }) tableIds: string[];
}

export class MapTableStateDto {
  @ApiProperty() id: string;
  @ApiProperty() code: string;
  @ApiProperty() minSeats: number;
  @ApiProperty() maxSeats: number;
  @ApiProperty({ enum: TableShape, enumName: 'TableShape' }) shape: TableShape;
  @ApiPropertyOptional({ nullable: true, type: Number }) posX: number | null;
  @ApiPropertyOptional({ nullable: true, type: Number }) posY: number | null;
  @ApiProperty() width: number;
  @ApiProperty() height: number;
  @ApiProperty() rotation: number;
  @ApiProperty({ type: [String] }) features: string[];
  @ApiProperty() isSelectable: boolean;
  @ApiProperty() surcharge: number;
  @ApiPropertyOptional({ nullable: true, type: String }) joinGroup: string | null;
  @ApiProperty({ enum: ['available', 'booked', 'held', 'mine', 'unfit', 'unavailable'] }) state: string;
}

export class TableMapDto {
  @ApiProperty() allowTableChoice: boolean;
  @ApiProperty() arrivalAt: string;
  @ApiProperty() diningMinutes: number;
  @ApiProperty({ type: [MapAreaDto] }) areas: MapAreaDto[];
  @ApiProperty({ type: MapAreaWithElementsDto }) area: MapAreaWithElementsDto;
  @ApiPropertyOptional({ nullable: true, type: MyHoldDto }) myHold: MyHoldDto | null;
  @ApiProperty({ type: [MapTableStateDto] }) tables: MapTableStateDto[];
}

export class HoldDto {
  @ApiProperty() holdId: string;
  @ApiProperty({ description: 'Hold lasts 5 minutes' }) expiresAt: string;
  @ApiProperty({ type: [String] }) tableIds: string[];
  @ApiProperty() arrivalAt: string;
}
