// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_register_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StaffRegisterDtoCWProxy {
  StaffRegisterDto email(String email);

  StaffRegisterDto password(String password);

  StaffRegisterDto name(String name);

  StaffRegisterDto phone(String? phone);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffRegisterDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffRegisterDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StaffRegisterDto call({
    String email,
    String password,
    String name,
    String? phone,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStaffRegisterDto.copyWith(...)` or call `instanceOfStaffRegisterDto.copyWith.fieldName(value)` for a single field.
class _$StaffRegisterDtoCWProxyImpl implements _$StaffRegisterDtoCWProxy {
  const _$StaffRegisterDtoCWProxyImpl(this._value);

  final StaffRegisterDto _value;

  @override
  StaffRegisterDto email(String email) => call(email: email);

  @override
  StaffRegisterDto password(String password) => call(password: password);

  @override
  StaffRegisterDto name(String name) => call(name: name);

  @override
  StaffRegisterDto phone(String? phone) => call(phone: phone);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffRegisterDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffRegisterDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StaffRegisterDto call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return StaffRegisterDto(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
    );
  }
}

extension $StaffRegisterDtoCopyWith on StaffRegisterDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStaffRegisterDto.copyWith(...)` or `instanceOfStaffRegisterDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StaffRegisterDtoCWProxy get copyWith => _$StaffRegisterDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffRegisterDto _$StaffRegisterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StaffRegisterDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'password', 'name']);
      final val = StaffRegisterDto(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$StaffRegisterDtoToJson(StaffRegisterDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'phone': ?instance.phone,
    };
