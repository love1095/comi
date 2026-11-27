// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_booking_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerBookingDtoCWProxy {
  CustomerBookingDto id(String id);

  CustomerBookingDto code(String code);

  CustomerBookingDto restaurantId(String restaurantId);

  CustomerBookingDto partySize(num partySize);

  CustomerBookingDto arrivalAt(String arrivalAt);

  CustomerBookingDto endsAt(String endsAt);

  CustomerBookingDto paymentMode(PaymentMode paymentMode);

  CustomerBookingDto serveStyle(ServeStyle serveStyle);

  CustomerBookingDto status(BookingStatus status);

  CustomerBookingDto note(String? note);

  CustomerBookingDto needsApproval(bool needsApproval);

  CustomerBookingDto extraTableIds(List<String> extraTableIds);

  CustomerBookingDto cancelledAt(String? cancelledAt);

  CustomerBookingDto cancelReason(String? cancelReason);

  CustomerBookingDto cancelledBy(String? cancelledBy);

  CustomerBookingDto checkedInAt(String? checkedInAt);

  CustomerBookingDto createdAt(String createdAt);

  CustomerBookingDto restaurant(BookingRestaurantDto restaurant);

  CustomerBookingDto table(BookingTableDto? table);

  CustomerBookingDto order(CustomerOrderDto? order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CustomerBookingDto call({
    String id,
    String code,
    String restaurantId,
    num partySize,
    String arrivalAt,
    String endsAt,
    PaymentMode paymentMode,
    ServeStyle serveStyle,
    BookingStatus status,
    String? note,
    bool needsApproval,
    List<String> extraTableIds,
    String? cancelledAt,
    String? cancelReason,
    String? cancelledBy,
    String? checkedInAt,
    String createdAt,
    BookingRestaurantDto restaurant,
    BookingTableDto? table,
    CustomerOrderDto? order,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCustomerBookingDto.copyWith(...)` or call `instanceOfCustomerBookingDto.copyWith.fieldName(value)` for a single field.
class _$CustomerBookingDtoCWProxyImpl implements _$CustomerBookingDtoCWProxy {
  const _$CustomerBookingDtoCWProxyImpl(this._value);

  final CustomerBookingDto _value;

  @override
  CustomerBookingDto id(String id) => call(id: id);

  @override
  CustomerBookingDto code(String code) => call(code: code);

  @override
  CustomerBookingDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  CustomerBookingDto partySize(num partySize) => call(partySize: partySize);

  @override
  CustomerBookingDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  CustomerBookingDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  CustomerBookingDto paymentMode(PaymentMode paymentMode) =>
      call(paymentMode: paymentMode);

  @override
  CustomerBookingDto serveStyle(ServeStyle serveStyle) =>
      call(serveStyle: serveStyle);

  @override
  CustomerBookingDto status(BookingStatus status) => call(status: status);

  @override
  CustomerBookingDto note(String? note) => call(note: note);

  @override
  CustomerBookingDto needsApproval(bool needsApproval) =>
      call(needsApproval: needsApproval);

  @override
  CustomerBookingDto extraTableIds(List<String> extraTableIds) =>
      call(extraTableIds: extraTableIds);

  @override
  CustomerBookingDto cancelledAt(String? cancelledAt) =>
      call(cancelledAt: cancelledAt);

  @override
  CustomerBookingDto cancelReason(String? cancelReason) =>
      call(cancelReason: cancelReason);

  @override
  CustomerBookingDto cancelledBy(String? cancelledBy) =>
      call(cancelledBy: cancelledBy);

  @override
  CustomerBookingDto checkedInAt(String? checkedInAt) =>
      call(checkedInAt: checkedInAt);

  @override
  CustomerBookingDto createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  CustomerBookingDto restaurant(BookingRestaurantDto restaurant) =>
      call(restaurant: restaurant);

  @override
  CustomerBookingDto table(BookingTableDto? table) => call(table: table);

  @override
  CustomerBookingDto order(CustomerOrderDto? order) => call(order: order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CustomerBookingDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? paymentMode = const $CopyWithPlaceholder(),
    Object? serveStyle = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? needsApproval = const $CopyWithPlaceholder(),
    Object? extraTableIds = const $CopyWithPlaceholder(),
    Object? cancelledAt = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
    Object? cancelledBy = const $CopyWithPlaceholder(),
    Object? checkedInAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? restaurant = const $CopyWithPlaceholder(),
    Object? table = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return CustomerBookingDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      endsAt: endsAt == const $CopyWithPlaceholder() || endsAt == null
          ? _value.endsAt
          // ignore: cast_nullable_to_non_nullable
          : endsAt as String,
      paymentMode:
          paymentMode == const $CopyWithPlaceholder() || paymentMode == null
          ? _value.paymentMode
          // ignore: cast_nullable_to_non_nullable
          : paymentMode as PaymentMode,
      serveStyle:
          serveStyle == const $CopyWithPlaceholder() || serveStyle == null
          ? _value.serveStyle
          // ignore: cast_nullable_to_non_nullable
          : serveStyle as ServeStyle,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingStatus,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      needsApproval:
          needsApproval == const $CopyWithPlaceholder() || needsApproval == null
          ? _value.needsApproval
          // ignore: cast_nullable_to_non_nullable
          : needsApproval as bool,
      extraTableIds:
          extraTableIds == const $CopyWithPlaceholder() || extraTableIds == null
          ? _value.extraTableIds
          // ignore: cast_nullable_to_non_nullable
          : extraTableIds as List<String>,
      cancelledAt: cancelledAt == const $CopyWithPlaceholder()
          ? _value.cancelledAt
          // ignore: cast_nullable_to_non_nullable
          : cancelledAt as String?,
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
      cancelledBy: cancelledBy == const $CopyWithPlaceholder()
          ? _value.cancelledBy
          // ignore: cast_nullable_to_non_nullable
          : cancelledBy as String?,
      checkedInAt: checkedInAt == const $CopyWithPlaceholder()
          ? _value.checkedInAt
          // ignore: cast_nullable_to_non_nullable
          : checkedInAt as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
      restaurant:
          restaurant == const $CopyWithPlaceholder() || restaurant == null
          ? _value.restaurant
          // ignore: cast_nullable_to_non_nullable
          : restaurant as BookingRestaurantDto,
      table: table == const $CopyWithPlaceholder()
          ? _value.table
          // ignore: cast_nullable_to_non_nullable
          : table as BookingTableDto?,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as CustomerOrderDto?,
    );
  }
}

extension $CustomerBookingDtoCopyWith on CustomerBookingDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCustomerBookingDto.copyWith(...)` or `instanceOfCustomerBookingDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerBookingDtoCWProxy get copyWith =>
      _$CustomerBookingDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBookingDto _$CustomerBookingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CustomerBookingDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'restaurantId',
          'partySize',
          'arrivalAt',
          'endsAt',
          'paymentMode',
          'serveStyle',
          'status',
          'needsApproval',
          'extraTableIds',
          'createdAt',
          'restaurant',
        ],
      );
      final val = CustomerBookingDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        paymentMode: $checkedConvert(
          'paymentMode',
          (v) => $enumDecode(_$PaymentModeEnumMap, v),
        ),
        serveStyle: $checkedConvert(
          'serveStyle',
          (v) => $enumDecode(_$ServeStyleEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingStatusEnumMap, v),
        ),
        note: $checkedConvert('note', (v) => v as String?),
        needsApproval: $checkedConvert('needsApproval', (v) => v as bool),
        extraTableIds: $checkedConvert(
          'extraTableIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        cancelledAt: $checkedConvert('cancelledAt', (v) => v as String?),
        cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
        cancelledBy: $checkedConvert('cancelledBy', (v) => v as String?),
        checkedInAt: $checkedConvert('checkedInAt', (v) => v as String?),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        restaurant: $checkedConvert(
          'restaurant',
          (v) => BookingRestaurantDto.fromJson(v as Map<String, dynamic>),
        ),
        table: $checkedConvert(
          'table',
          (v) => v == null
              ? null
              : BookingTableDto.fromJson(v as Map<String, dynamic>),
        ),
        order: $checkedConvert(
          'order',
          (v) => v == null
              ? null
              : CustomerOrderDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CustomerBookingDtoToJson(CustomerBookingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'restaurantId': instance.restaurantId,
      'partySize': instance.partySize,
      'arrivalAt': instance.arrivalAt,
      'endsAt': instance.endsAt,
      'paymentMode': _$PaymentModeEnumMap[instance.paymentMode]!,
      'serveStyle': _$ServeStyleEnumMap[instance.serveStyle]!,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'note': ?instance.note,
      'needsApproval': instance.needsApproval,
      'extraTableIds': instance.extraTableIds,
      'cancelledAt': ?instance.cancelledAt,
      'cancelReason': ?instance.cancelReason,
      'cancelledBy': ?instance.cancelledBy,
      'checkedInAt': ?instance.checkedInAt,
      'createdAt': instance.createdAt,
      'restaurant': instance.restaurant.toJson(),
      'table': ?instance.table?.toJson(),
      'order': ?instance.order?.toJson(),
    };

const _$PaymentModeEnumMap = {
  PaymentMode.PREPAID: 'PREPAID',
  PaymentMode.COD: 'COD',
};

const _$ServeStyleEnumMap = {
  ServeStyle.BY_COURSE: 'BY_COURSE',
  ServeStyle.ALL_TOGETHER: 'ALL_TOGETHER',
};

const _$BookingStatusEnumMap = {
  BookingStatus.PENDING: 'PENDING',
  BookingStatus.CONFIRMED: 'CONFIRMED',
  BookingStatus.CHECKED_IN: 'CHECKED_IN',
  BookingStatus.COMPLETED: 'COMPLETED',
  BookingStatus.CANCELLED: 'CANCELLED',
  BookingStatus.NO_SHOW: 'NO_SHOW',
  BookingStatus.EXPIRED: 'EXPIRED',
};
