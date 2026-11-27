// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeviceTokenDtoCWProxy {
  DeviceTokenDto token(String token);

  DeviceTokenDto platform(DeviceTokenDtoPlatformEnum platform);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DeviceTokenDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DeviceTokenDto(...).copyWith(id: 12, name: "My name")
  /// ```
  DeviceTokenDto call({String token, DeviceTokenDtoPlatformEnum platform});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDeviceTokenDto.copyWith(...)` or call `instanceOfDeviceTokenDto.copyWith.fieldName(value)` for a single field.
class _$DeviceTokenDtoCWProxyImpl implements _$DeviceTokenDtoCWProxy {
  const _$DeviceTokenDtoCWProxyImpl(this._value);

  final DeviceTokenDto _value;

  @override
  DeviceTokenDto token(String token) => call(token: token);

  @override
  DeviceTokenDto platform(DeviceTokenDtoPlatformEnum platform) =>
      call(platform: platform);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DeviceTokenDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DeviceTokenDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DeviceTokenDto call({
    Object? token = const $CopyWithPlaceholder(),
    Object? platform = const $CopyWithPlaceholder(),
  }) {
    return DeviceTokenDto(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      platform: platform == const $CopyWithPlaceholder() || platform == null
          ? _value.platform
          // ignore: cast_nullable_to_non_nullable
          : platform as DeviceTokenDtoPlatformEnum,
    );
  }
}

extension $DeviceTokenDtoCopyWith on DeviceTokenDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDeviceTokenDto.copyWith(...)` or `instanceOfDeviceTokenDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeviceTokenDtoCWProxy get copyWith => _$DeviceTokenDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTokenDto _$DeviceTokenDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DeviceTokenDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token', 'platform']);
      final val = DeviceTokenDto(
        token: $checkedConvert('token', (v) => v as String),
        platform: $checkedConvert(
          'platform',
          (v) => $enumDecode(_$DeviceTokenDtoPlatformEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DeviceTokenDtoToJson(DeviceTokenDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'platform': _$DeviceTokenDtoPlatformEnumEnumMap[instance.platform]!,
    };

const _$DeviceTokenDtoPlatformEnumEnumMap = {
  DeviceTokenDtoPlatformEnum.ios: 'ios',
  DeviceTokenDtoPlatformEnum.android: 'android',
};
