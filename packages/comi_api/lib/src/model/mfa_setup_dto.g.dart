// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_setup_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MfaSetupDtoCWProxy {
  MfaSetupDto secret(String secret);

  MfaSetupDto otpauthUrl(String otpauthUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MfaSetupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MfaSetupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MfaSetupDto call({String secret, String otpauthUrl});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMfaSetupDto.copyWith(...)` or call `instanceOfMfaSetupDto.copyWith.fieldName(value)` for a single field.
class _$MfaSetupDtoCWProxyImpl implements _$MfaSetupDtoCWProxy {
  const _$MfaSetupDtoCWProxyImpl(this._value);

  final MfaSetupDto _value;

  @override
  MfaSetupDto secret(String secret) => call(secret: secret);

  @override
  MfaSetupDto otpauthUrl(String otpauthUrl) => call(otpauthUrl: otpauthUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MfaSetupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MfaSetupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MfaSetupDto call({
    Object? secret = const $CopyWithPlaceholder(),
    Object? otpauthUrl = const $CopyWithPlaceholder(),
  }) {
    return MfaSetupDto(
      secret: secret == const $CopyWithPlaceholder() || secret == null
          ? _value.secret
          // ignore: cast_nullable_to_non_nullable
          : secret as String,
      otpauthUrl:
          otpauthUrl == const $CopyWithPlaceholder() || otpauthUrl == null
          ? _value.otpauthUrl
          // ignore: cast_nullable_to_non_nullable
          : otpauthUrl as String,
    );
  }
}

extension $MfaSetupDtoCopyWith on MfaSetupDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMfaSetupDto.copyWith(...)` or `instanceOfMfaSetupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MfaSetupDtoCWProxy get copyWith => _$MfaSetupDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MfaSetupDto _$MfaSetupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MfaSetupDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['secret', 'otpauthUrl']);
      final val = MfaSetupDto(
        secret: $checkedConvert('secret', (v) => v as String),
        otpauthUrl: $checkedConvert('otpauthUrl', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$MfaSetupDtoToJson(MfaSetupDto instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'otpauthUrl': instance.otpauthUrl,
    };
