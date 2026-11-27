// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_login_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminLoginResultDtoCWProxy {
  AdminLoginResultDto accessToken(String accessToken);

  AdminLoginResultDto refreshToken(String refreshToken);

  AdminLoginResultDto expiresIn(num expiresIn);

  AdminLoginResultDto mfa(bool mfa);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminLoginResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminLoginResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminLoginResultDto call({
    String accessToken,
    String refreshToken,
    num expiresIn,
    bool mfa,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminLoginResultDto.copyWith(...)` or call `instanceOfAdminLoginResultDto.copyWith.fieldName(value)` for a single field.
class _$AdminLoginResultDtoCWProxyImpl implements _$AdminLoginResultDtoCWProxy {
  const _$AdminLoginResultDtoCWProxyImpl(this._value);

  final AdminLoginResultDto _value;

  @override
  AdminLoginResultDto accessToken(String accessToken) =>
      call(accessToken: accessToken);

  @override
  AdminLoginResultDto refreshToken(String refreshToken) =>
      call(refreshToken: refreshToken);

  @override
  AdminLoginResultDto expiresIn(num expiresIn) => call(expiresIn: expiresIn);

  @override
  AdminLoginResultDto mfa(bool mfa) => call(mfa: mfa);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminLoginResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminLoginResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminLoginResultDto call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? mfa = const $CopyWithPlaceholder(),
  }) {
    return AdminLoginResultDto(
      accessToken:
          accessToken == const $CopyWithPlaceholder() || accessToken == null
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String,
      refreshToken:
          refreshToken == const $CopyWithPlaceholder() || refreshToken == null
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
      expiresIn: expiresIn == const $CopyWithPlaceholder() || expiresIn == null
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as num,
      mfa: mfa == const $CopyWithPlaceholder() || mfa == null
          ? _value.mfa
          // ignore: cast_nullable_to_non_nullable
          : mfa as bool,
    );
  }
}

extension $AdminLoginResultDtoCopyWith on AdminLoginResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminLoginResultDto.copyWith(...)` or `instanceOfAdminLoginResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminLoginResultDtoCWProxy get copyWith =>
      _$AdminLoginResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminLoginResultDto _$AdminLoginResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminLoginResultDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['accessToken', 'refreshToken', 'expiresIn', 'mfa'],
      );
      final val = AdminLoginResultDto(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
        expiresIn: $checkedConvert('expiresIn', (v) => v as num),
        mfa: $checkedConvert('mfa', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$AdminLoginResultDtoToJson(
  AdminLoginResultDto instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
  'mfa': instance.mfa,
};
