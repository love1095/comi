// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BillDtoCWProxy {
  BillDto bookingId(String bookingId);

  BillDto code(String code);

  BillDto status(BookingStatus status);

  BillDto rounds(List<BillRoundDto> rounds);

  BillDto total(num total);

  BillDto finalBillAmount(num? finalBillAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BillDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BillDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BillDto call({
    String bookingId,
    String code,
    BookingStatus status,
    List<BillRoundDto> rounds,
    num total,
    num? finalBillAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBillDto.copyWith(...)` or call `instanceOfBillDto.copyWith.fieldName(value)` for a single field.
class _$BillDtoCWProxyImpl implements _$BillDtoCWProxy {
  const _$BillDtoCWProxyImpl(this._value);

  final BillDto _value;

  @override
  BillDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  BillDto code(String code) => call(code: code);

  @override
  BillDto status(BookingStatus status) => call(status: status);

  @override
  BillDto rounds(List<BillRoundDto> rounds) => call(rounds: rounds);

  @override
  BillDto total(num total) => call(total: total);

  @override
  BillDto finalBillAmount(num? finalBillAmount) =>
      call(finalBillAmount: finalBillAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BillDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BillDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BillDto call({
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? rounds = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? finalBillAmount = const $CopyWithPlaceholder(),
  }) {
    return BillDto(
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingStatus,
      rounds: rounds == const $CopyWithPlaceholder() || rounds == null
          ? _value.rounds
          // ignore: cast_nullable_to_non_nullable
          : rounds as List<BillRoundDto>,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      finalBillAmount: finalBillAmount == const $CopyWithPlaceholder()
          ? _value.finalBillAmount
          // ignore: cast_nullable_to_non_nullable
          : finalBillAmount as num?,
    );
  }
}

extension $BillDtoCopyWith on BillDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBillDto.copyWith(...)` or `instanceOfBillDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BillDtoCWProxy get copyWith => _$BillDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillDto _$BillDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BillDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['bookingId', 'code', 'status', 'rounds', 'total'],
      );
      final val = BillDto(
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingStatusEnumMap, v),
        ),
        rounds: $checkedConvert(
          'rounds',
          (v) => (v as List<dynamic>)
              .map((e) => BillRoundDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        total: $checkedConvert('total', (v) => v as num),
        finalBillAmount: $checkedConvert('finalBillAmount', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$BillDtoToJson(BillDto instance) => <String, dynamic>{
  'bookingId': instance.bookingId,
  'code': instance.code,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'rounds': instance.rounds.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'finalBillAmount': ?instance.finalBillAmount,
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
