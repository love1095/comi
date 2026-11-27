// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_login_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminLoginDtoCWProxy {
  AdminLoginDto email(String email);

  AdminLoginDto password(String password);

  AdminLoginDto code(String? code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminLoginDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminLoginDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminLoginDto call({String email, String password, String? code});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminLoginDto.copyWith(...)` or call `instanceOfAdminLoginDto.copyWith.fieldName(value)` for a single field.
class _$AdminLoginDtoCWProxyImpl implements _$AdminLoginDtoCWProxy {
  const _$AdminLoginDtoCWProxyImpl(this._value);

  final AdminLoginDto _value;

  @override
  AdminLoginDto email(String email) => call(email: email);

  @override
  AdminLoginDto password(String password) => call(password: password);

  @override
  AdminLoginDto code(String? code) => call(code: code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminLoginDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminLoginDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminLoginDto call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
  }) {
    return AdminLoginDto(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
    );
  }
}

extension $AdminLoginDtoCopyWith on AdminLoginDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminLoginDto.copyWith(...)` or `instanceOfAdminLoginDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminLoginDtoCWProxy get copyWith => _$AdminLoginDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminLoginDto _$AdminLoginDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminLoginDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'password']);
      final val = AdminLoginDto(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AdminLoginDtoToJson(AdminLoginDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'code': ?instance.code,
    };
