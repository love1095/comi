// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_pay_os_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConnectPayOsDtoCWProxy {
  ConnectPayOsDto clientId(String clientId);

  ConnectPayOsDto apiKey(String apiKey);

  ConnectPayOsDto checksumKey(String checksumKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ConnectPayOsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConnectPayOsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ConnectPayOsDto call({String clientId, String apiKey, String checksumKey});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConnectPayOsDto.copyWith(...)` or call `instanceOfConnectPayOsDto.copyWith.fieldName(value)` for a single field.
class _$ConnectPayOsDtoCWProxyImpl implements _$ConnectPayOsDtoCWProxy {
  const _$ConnectPayOsDtoCWProxyImpl(this._value);

  final ConnectPayOsDto _value;

  @override
  ConnectPayOsDto clientId(String clientId) => call(clientId: clientId);

  @override
  ConnectPayOsDto apiKey(String apiKey) => call(apiKey: apiKey);

  @override
  ConnectPayOsDto checksumKey(String checksumKey) =>
      call(checksumKey: checksumKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ConnectPayOsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConnectPayOsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ConnectPayOsDto call({
    Object? clientId = const $CopyWithPlaceholder(),
    Object? apiKey = const $CopyWithPlaceholder(),
    Object? checksumKey = const $CopyWithPlaceholder(),
  }) {
    return ConnectPayOsDto(
      clientId: clientId == const $CopyWithPlaceholder() || clientId == null
          ? _value.clientId
          // ignore: cast_nullable_to_non_nullable
          : clientId as String,
      apiKey: apiKey == const $CopyWithPlaceholder() || apiKey == null
          ? _value.apiKey
          // ignore: cast_nullable_to_non_nullable
          : apiKey as String,
      checksumKey:
          checksumKey == const $CopyWithPlaceholder() || checksumKey == null
          ? _value.checksumKey
          // ignore: cast_nullable_to_non_nullable
          : checksumKey as String,
    );
  }
}

extension $ConnectPayOsDtoCopyWith on ConnectPayOsDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConnectPayOsDto.copyWith(...)` or `instanceOfConnectPayOsDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConnectPayOsDtoCWProxy get copyWith => _$ConnectPayOsDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectPayOsDto _$ConnectPayOsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConnectPayOsDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['clientId', 'apiKey', 'checksumKey'],
      );
      final val = ConnectPayOsDto(
        clientId: $checkedConvert('clientId', (v) => v as String),
        apiKey: $checkedConvert('apiKey', (v) => v as String),
        checksumKey: $checkedConvert('checksumKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ConnectPayOsDtoToJson(ConnectPayOsDto instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'apiKey': instance.apiKey,
      'checksumKey': instance.checksumKey,
    };
