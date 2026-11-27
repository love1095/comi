// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_booking_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminBookingDtoCWProxy {
  AdminBookingDto id(String id);

  AdminBookingDto code(String code);

  AdminBookingDto status(String status);

  AdminBookingDto arrivalAt(String arrivalAt);

  AdminBookingDto partySize(num partySize);

  AdminBookingDto restaurantName(String restaurantName);

  AdminBookingDto restaurantId(String restaurantId);

  AdminBookingDto guestName(String? guestName);

  AdminBookingDto guestPhone(String? guestPhone);

  AdminBookingDto total(num? total);

  AdminBookingDto paymentMode(String paymentMode);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminBookingDto call({
    String id,
    String code,
    String status,
    String arrivalAt,
    num partySize,
    String restaurantName,
    String restaurantId,
    String? guestName,
    String? guestPhone,
    num? total,
    String paymentMode,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminBookingDto.copyWith(...)` or call `instanceOfAdminBookingDto.copyWith.fieldName(value)` for a single field.
class _$AdminBookingDtoCWProxyImpl implements _$AdminBookingDtoCWProxy {
  const _$AdminBookingDtoCWProxyImpl(this._value);

  final AdminBookingDto _value;

  @override
  AdminBookingDto id(String id) => call(id: id);

  @override
  AdminBookingDto code(String code) => call(code: code);

  @override
  AdminBookingDto status(String status) => call(status: status);

  @override
  AdminBookingDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  AdminBookingDto partySize(num partySize) => call(partySize: partySize);

  @override
  AdminBookingDto restaurantName(String restaurantName) =>
      call(restaurantName: restaurantName);

  @override
  AdminBookingDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  AdminBookingDto guestName(String? guestName) => call(guestName: guestName);

  @override
  AdminBookingDto guestPhone(String? guestPhone) =>
      call(guestPhone: guestPhone);

  @override
  AdminBookingDto total(num? total) => call(total: total);

  @override
  AdminBookingDto paymentMode(String paymentMode) =>
      call(paymentMode: paymentMode);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminBookingDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? restaurantName = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? guestName = const $CopyWithPlaceholder(),
    Object? guestPhone = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? paymentMode = const $CopyWithPlaceholder(),
  }) {
    return AdminBookingDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      restaurantName:
          restaurantName == const $CopyWithPlaceholder() ||
              restaurantName == null
          ? _value.restaurantName
          // ignore: cast_nullable_to_non_nullable
          : restaurantName as String,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      guestName: guestName == const $CopyWithPlaceholder()
          ? _value.guestName
          // ignore: cast_nullable_to_non_nullable
          : guestName as String?,
      guestPhone: guestPhone == const $CopyWithPlaceholder()
          ? _value.guestPhone
          // ignore: cast_nullable_to_non_nullable
          : guestPhone as String?,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num?,
      paymentMode:
          paymentMode == const $CopyWithPlaceholder() || paymentMode == null
          ? _value.paymentMode
          // ignore: cast_nullable_to_non_nullable
          : paymentMode as String,
    );
  }
}

extension $AdminBookingDtoCopyWith on AdminBookingDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminBookingDto.copyWith(...)` or `instanceOfAdminBookingDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminBookingDtoCWProxy get copyWith => _$AdminBookingDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminBookingDto _$AdminBookingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminBookingDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'status',
          'arrivalAt',
          'partySize',
          'restaurantName',
          'restaurantId',
          'paymentMode',
        ],
      );
      final val = AdminBookingDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        restaurantName: $checkedConvert('restaurantName', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        guestName: $checkedConvert('guestName', (v) => v as String?),
        guestPhone: $checkedConvert('guestPhone', (v) => v as String?),
        total: $checkedConvert('total', (v) => v as num?),
        paymentMode: $checkedConvert('paymentMode', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AdminBookingDtoToJson(AdminBookingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': instance.status,
      'arrivalAt': instance.arrivalAt,
      'partySize': instance.partySize,
      'restaurantName': instance.restaurantName,
      'restaurantId': instance.restaurantId,
      'guestName': ?instance.guestName,
      'guestPhone': ?instance.guestPhone,
      'total': ?instance.total,
      'paymentMode': instance.paymentMode,
    };
