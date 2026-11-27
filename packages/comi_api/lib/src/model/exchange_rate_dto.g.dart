// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExchangeRateDtoCWProxy {
  ExchangeRateDto currency(ExchangeRateDtoCurrencyEnum currency);

  ExchangeRateDto vndPerUnit(num vndPerUnit);

  ExchangeRateDto updatedAt(String updatedAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ExchangeRateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExchangeRateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ExchangeRateDto call({
    ExchangeRateDtoCurrencyEnum currency,
    num vndPerUnit,
    String updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExchangeRateDto.copyWith(...)` or call `instanceOfExchangeRateDto.copyWith.fieldName(value)` for a single field.
class _$ExchangeRateDtoCWProxyImpl implements _$ExchangeRateDtoCWProxy {
  const _$ExchangeRateDtoCWProxyImpl(this._value);

  final ExchangeRateDto _value;

  @override
  ExchangeRateDto currency(ExchangeRateDtoCurrencyEnum currency) =>
      call(currency: currency);

  @override
  ExchangeRateDto vndPerUnit(num vndPerUnit) => call(vndPerUnit: vndPerUnit);

  @override
  ExchangeRateDto updatedAt(String updatedAt) => call(updatedAt: updatedAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ExchangeRateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExchangeRateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ExchangeRateDto call({
    Object? currency = const $CopyWithPlaceholder(),
    Object? vndPerUnit = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ExchangeRateDto(
      currency: currency == const $CopyWithPlaceholder() || currency == null
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as ExchangeRateDtoCurrencyEnum,
      vndPerUnit:
          vndPerUnit == const $CopyWithPlaceholder() || vndPerUnit == null
          ? _value.vndPerUnit
          // ignore: cast_nullable_to_non_nullable
          : vndPerUnit as num,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String,
    );
  }
}

extension $ExchangeRateDtoCopyWith on ExchangeRateDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExchangeRateDto.copyWith(...)` or `instanceOfExchangeRateDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExchangeRateDtoCWProxy get copyWith => _$ExchangeRateDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateDto _$ExchangeRateDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExchangeRateDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['currency', 'vndPerUnit', 'updatedAt'],
      );
      final val = ExchangeRateDto(
        currency: $checkedConvert(
          'currency',
          (v) => $enumDecode(_$ExchangeRateDtoCurrencyEnumEnumMap, v),
        ),
        vndPerUnit: $checkedConvert('vndPerUnit', (v) => v as num),
        updatedAt: $checkedConvert('updatedAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ExchangeRateDtoToJson(ExchangeRateDto instance) =>
    <String, dynamic>{
      'currency': _$ExchangeRateDtoCurrencyEnumEnumMap[instance.currency]!,
      'vndPerUnit': instance.vndPerUnit,
      'updatedAt': instance.updatedAt,
    };

const _$ExchangeRateDtoCurrencyEnumEnumMap = {
  ExchangeRateDtoCurrencyEnum.USD: 'USD',
  ExchangeRateDtoCurrencyEnum.KRW: 'KRW',
  ExchangeRateDtoCurrencyEnum.CNY: 'CNY',
  ExchangeRateDtoCurrencyEnum.JPY: 'JPY',
};
