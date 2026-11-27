// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_exchange_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerExchangeDtoCWProxy {
  CustomerExchangeDto idToken(String idToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerExchangeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerExchangeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CustomerExchangeDto call({String idToken});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCustomerExchangeDto.copyWith(...)` or call `instanceOfCustomerExchangeDto.copyWith.fieldName(value)` for a single field.
class _$CustomerExchangeDtoCWProxyImpl implements _$CustomerExchangeDtoCWProxy {
  const _$CustomerExchangeDtoCWProxyImpl(this._value);

  final CustomerExchangeDto _value;

  @override
  CustomerExchangeDto idToken(String idToken) => call(idToken: idToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerExchangeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerExchangeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CustomerExchangeDto call({Object? idToken = const $CopyWithPlaceholder()}) {
    return CustomerExchangeDto(
      idToken: idToken == const $CopyWithPlaceholder() || idToken == null
          ? _value.idToken
          // ignore: cast_nullable_to_non_nullable
          : idToken as String,
    );
  }
}

extension $CustomerExchangeDtoCopyWith on CustomerExchangeDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCustomerExchangeDto.copyWith(...)` or `instanceOfCustomerExchangeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerExchangeDtoCWProxy get copyWith =>
      _$CustomerExchangeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerExchangeDto _$CustomerExchangeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CustomerExchangeDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['idToken']);
      final val = CustomerExchangeDto(
        idToken: $checkedConvert('idToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CustomerExchangeDtoToJson(
  CustomerExchangeDto instance,
) => <String, dynamic>{'idToken': instance.idToken};
