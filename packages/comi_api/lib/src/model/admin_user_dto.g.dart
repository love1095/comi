// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminUserDtoCWProxy {
  AdminUserDto id(String id);

  AdminUserDto name(String? name);

  AdminUserDto phone(String? phone);

  AdminUserDto email(String? email);

  AdminUserDto status(AdminUserDtoStatusEnum status);

  AdminUserDto noShowCount(num noShowCount);

  AdminUserDto mustPrepay(bool mustPrepay);

  AdminUserDto bookings(num bookings);

  AdminUserDto createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminUserDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminUserDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminUserDto call({
    String id,
    String? name,
    String? phone,
    String? email,
    AdminUserDtoStatusEnum status,
    num noShowCount,
    bool mustPrepay,
    num bookings,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminUserDto.copyWith(...)` or call `instanceOfAdminUserDto.copyWith.fieldName(value)` for a single field.
class _$AdminUserDtoCWProxyImpl implements _$AdminUserDtoCWProxy {
  const _$AdminUserDtoCWProxyImpl(this._value);

  final AdminUserDto _value;

  @override
  AdminUserDto id(String id) => call(id: id);

  @override
  AdminUserDto name(String? name) => call(name: name);

  @override
  AdminUserDto phone(String? phone) => call(phone: phone);

  @override
  AdminUserDto email(String? email) => call(email: email);

  @override
  AdminUserDto status(AdminUserDtoStatusEnum status) => call(status: status);

  @override
  AdminUserDto noShowCount(num noShowCount) => call(noShowCount: noShowCount);

  @override
  AdminUserDto mustPrepay(bool mustPrepay) => call(mustPrepay: mustPrepay);

  @override
  AdminUserDto bookings(num bookings) => call(bookings: bookings);

  @override
  AdminUserDto createdAt(String createdAt) => call(createdAt: createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminUserDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminUserDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminUserDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? noShowCount = const $CopyWithPlaceholder(),
    Object? mustPrepay = const $CopyWithPlaceholder(),
    Object? bookings = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return AdminUserDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AdminUserDtoStatusEnum,
      noShowCount:
          noShowCount == const $CopyWithPlaceholder() || noShowCount == null
          ? _value.noShowCount
          // ignore: cast_nullable_to_non_nullable
          : noShowCount as num,
      mustPrepay:
          mustPrepay == const $CopyWithPlaceholder() || mustPrepay == null
          ? _value.mustPrepay
          // ignore: cast_nullable_to_non_nullable
          : mustPrepay as bool,
      bookings: bookings == const $CopyWithPlaceholder() || bookings == null
          ? _value.bookings
          // ignore: cast_nullable_to_non_nullable
          : bookings as num,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $AdminUserDtoCopyWith on AdminUserDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminUserDto.copyWith(...)` or `instanceOfAdminUserDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminUserDtoCWProxy get copyWith => _$AdminUserDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserDto _$AdminUserDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminUserDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'status',
          'noShowCount',
          'mustPrepay',
          'bookings',
          'createdAt',
        ],
      );
      final val = AdminUserDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$AdminUserDtoStatusEnumEnumMap, v),
        ),
        noShowCount: $checkedConvert('noShowCount', (v) => v as num),
        mustPrepay: $checkedConvert('mustPrepay', (v) => v as bool),
        bookings: $checkedConvert('bookings', (v) => v as num),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AdminUserDtoToJson(AdminUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': ?instance.name,
      'phone': ?instance.phone,
      'email': ?instance.email,
      'status': _$AdminUserDtoStatusEnumEnumMap[instance.status]!,
      'noShowCount': instance.noShowCount,
      'mustPrepay': instance.mustPrepay,
      'bookings': instance.bookings,
      'createdAt': instance.createdAt,
    };

const _$AdminUserDtoStatusEnumEnumMap = {
  AdminUserDtoStatusEnum.ACTIVE: 'ACTIVE',
  AdminUserDtoStatusEnum.BLOCKED: 'BLOCKED',
  AdminUserDtoStatusEnum.DELETED: 'DELETED',
};
