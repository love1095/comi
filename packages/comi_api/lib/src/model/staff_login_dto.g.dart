// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_login_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StaffLoginDtoCWProxy {
  StaffLoginDto email(String email);

  StaffLoginDto password(String password);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffLoginDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffLoginDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StaffLoginDto call({String email, String password});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStaffLoginDto.copyWith(...)` or call `instanceOfStaffLoginDto.copyWith.fieldName(value)` for a single field.
class _$StaffLoginDtoCWProxyImpl implements _$StaffLoginDtoCWProxy {
  const _$StaffLoginDtoCWProxyImpl(this._value);

  final StaffLoginDto _value;

  @override
  StaffLoginDto email(String email) => call(email: email);

  @override
  StaffLoginDto password(String password) => call(password: password);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffLoginDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffLoginDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StaffLoginDto call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return StaffLoginDto(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $StaffLoginDtoCopyWith on StaffLoginDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStaffLoginDto.copyWith(...)` or `instanceOfStaffLoginDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StaffLoginDtoCWProxy get copyWith => _$StaffLoginDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffLoginDto _$StaffLoginDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StaffLoginDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'password']);
      final val = StaffLoginDto(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$StaffLoginDtoToJson(StaffLoginDto instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
