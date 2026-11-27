// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_line_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatementLineDtoCWProxy {
  StatementLineDto bookingId(String bookingId);

  StatementLineDto bookingCode(String bookingCode);

  StatementLineDto arrivalAt(String arrivalAt);

  StatementLineDto partySize(num partySize);

  StatementLineDto baseAmount(num baseAmount);

  StatementLineDto rateBps(num rateBps);

  StatementLineDto feeAmount(num feeAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StatementLineDto call({
    String bookingId,
    String bookingCode,
    String arrivalAt,
    num partySize,
    num baseAmount,
    num rateBps,
    num feeAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStatementLineDto.copyWith(...)` or call `instanceOfStatementLineDto.copyWith.fieldName(value)` for a single field.
class _$StatementLineDtoCWProxyImpl implements _$StatementLineDtoCWProxy {
  const _$StatementLineDtoCWProxyImpl(this._value);

  final StatementLineDto _value;

  @override
  StatementLineDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  StatementLineDto bookingCode(String bookingCode) =>
      call(bookingCode: bookingCode);

  @override
  StatementLineDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  StatementLineDto partySize(num partySize) => call(partySize: partySize);

  @override
  StatementLineDto baseAmount(num baseAmount) => call(baseAmount: baseAmount);

  @override
  StatementLineDto rateBps(num rateBps) => call(rateBps: rateBps);

  @override
  StatementLineDto feeAmount(num feeAmount) => call(feeAmount: feeAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StatementLineDto call({
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? bookingCode = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? baseAmount = const $CopyWithPlaceholder(),
    Object? rateBps = const $CopyWithPlaceholder(),
    Object? feeAmount = const $CopyWithPlaceholder(),
  }) {
    return StatementLineDto(
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      bookingCode:
          bookingCode == const $CopyWithPlaceholder() || bookingCode == null
          ? _value.bookingCode
          // ignore: cast_nullable_to_non_nullable
          : bookingCode as String,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      baseAmount:
          baseAmount == const $CopyWithPlaceholder() || baseAmount == null
          ? _value.baseAmount
          // ignore: cast_nullable_to_non_nullable
          : baseAmount as num,
      rateBps: rateBps == const $CopyWithPlaceholder() || rateBps == null
          ? _value.rateBps
          // ignore: cast_nullable_to_non_nullable
          : rateBps as num,
      feeAmount: feeAmount == const $CopyWithPlaceholder() || feeAmount == null
          ? _value.feeAmount
          // ignore: cast_nullable_to_non_nullable
          : feeAmount as num,
    );
  }
}

extension $StatementLineDtoCopyWith on StatementLineDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStatementLineDto.copyWith(...)` or `instanceOfStatementLineDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatementLineDtoCWProxy get copyWith => _$StatementLineDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementLineDto _$StatementLineDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StatementLineDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'bookingId',
          'bookingCode',
          'arrivalAt',
          'partySize',
          'baseAmount',
          'rateBps',
          'feeAmount',
        ],
      );
      final val = StatementLineDto(
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        bookingCode: $checkedConvert('bookingCode', (v) => v as String),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        baseAmount: $checkedConvert('baseAmount', (v) => v as num),
        rateBps: $checkedConvert('rateBps', (v) => v as num),
        feeAmount: $checkedConvert('feeAmount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$StatementLineDtoToJson(StatementLineDto instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'bookingCode': instance.bookingCode,
      'arrivalAt': instance.arrivalAt,
      'partySize': instance.partySize,
      'baseAmount': instance.baseAmount,
      'rateBps': instance.rateBps,
      'feeAmount': instance.feeAmount,
    };
