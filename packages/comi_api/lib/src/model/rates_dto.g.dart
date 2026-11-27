// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RatesDtoCWProxy {
  RatesDto rates(Map<String, num> rates);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RatesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RatesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RatesDto call({Map<String, num> rates});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRatesDto.copyWith(...)` or call `instanceOfRatesDto.copyWith.fieldName(value)` for a single field.
class _$RatesDtoCWProxyImpl implements _$RatesDtoCWProxy {
  const _$RatesDtoCWProxyImpl(this._value);

  final RatesDto _value;

  @override
  RatesDto rates(Map<String, num> rates) => call(rates: rates);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RatesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RatesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RatesDto call({Object? rates = const $CopyWithPlaceholder()}) {
    return RatesDto(
      rates: rates == const $CopyWithPlaceholder() || rates == null
          ? _value.rates
          // ignore: cast_nullable_to_non_nullable
          : rates as Map<String, num>,
    );
  }
}

extension $RatesDtoCopyWith on RatesDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRatesDto.copyWith(...)` or `instanceOfRatesDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RatesDtoCWProxy get copyWith => _$RatesDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatesDto _$RatesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RatesDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['rates']);
      final val = RatesDto(
        rates: $checkedConvert('rates', (v) => Map<String, num>.from(v as Map)),
      );
      return val;
    });

Map<String, dynamic> _$RatesDtoToJson(RatesDto instance) => <String, dynamic>{
  'rates': instance.rates,
};
