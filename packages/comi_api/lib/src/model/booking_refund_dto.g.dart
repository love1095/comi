// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_refund_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingRefundDtoCWProxy {
  BookingRefundDto id(String id);

  BookingRefundDto amount(num amount);

  BookingRefundDto status(BookingRefundDtoStatusEnum status);

  BookingRefundDto reason(String reason);

  BookingRefundDto createdAt(String createdAt);

  BookingRefundDto doneAt(String? doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingRefundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingRefundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingRefundDto call({
    String id,
    num amount,
    BookingRefundDtoStatusEnum status,
    String reason,
    String createdAt,
    String? doneAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingRefundDto.copyWith(...)` or call `instanceOfBookingRefundDto.copyWith.fieldName(value)` for a single field.
class _$BookingRefundDtoCWProxyImpl implements _$BookingRefundDtoCWProxy {
  const _$BookingRefundDtoCWProxyImpl(this._value);

  final BookingRefundDto _value;

  @override
  BookingRefundDto id(String id) => call(id: id);

  @override
  BookingRefundDto amount(num amount) => call(amount: amount);

  @override
  BookingRefundDto status(BookingRefundDtoStatusEnum status) =>
      call(status: status);

  @override
  BookingRefundDto reason(String reason) => call(reason: reason);

  @override
  BookingRefundDto createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  BookingRefundDto doneAt(String? doneAt) => call(doneAt: doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingRefundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingRefundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingRefundDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? doneAt = const $CopyWithPlaceholder(),
  }) {
    return BookingRefundDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingRefundDtoStatusEnum,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
      doneAt: doneAt == const $CopyWithPlaceholder()
          ? _value.doneAt
          // ignore: cast_nullable_to_non_nullable
          : doneAt as String?,
    );
  }
}

extension $BookingRefundDtoCopyWith on BookingRefundDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingRefundDto.copyWith(...)` or `instanceOfBookingRefundDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingRefundDtoCWProxy get copyWith => _$BookingRefundDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRefundDto _$BookingRefundDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BookingRefundDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'amount', 'status', 'reason', 'createdAt'],
      );
      final val = BookingRefundDto(
        id: $checkedConvert('id', (v) => v as String),
        amount: $checkedConvert('amount', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingRefundDtoStatusEnumEnumMap, v),
        ),
        reason: $checkedConvert('reason', (v) => v as String),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        doneAt: $checkedConvert('doneAt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BookingRefundDtoToJson(BookingRefundDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': _$BookingRefundDtoStatusEnumEnumMap[instance.status]!,
      'reason': instance.reason,
      'createdAt': instance.createdAt,
      'doneAt': ?instance.doneAt,
    };

const _$BookingRefundDtoStatusEnumEnumMap = {
  BookingRefundDtoStatusEnum.PENDING: 'PENDING',
  BookingRefundDtoStatusEnum.DONE: 'DONE',
};
