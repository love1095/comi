// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_restaurant_row_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminRestaurantRowDtoCWProxy {
  AdminRestaurantRowDto id(String id);

  AdminRestaurantRowDto slug(String slug);

  AdminRestaurantRowDto name(String name);

  AdminRestaurantRowDto address(String address);

  AdminRestaurantRowDto phone(String phone);

  AdminRestaurantRowDto status(RestaurantStatus status);

  AdminRestaurantRowDto submittedAt(String? submittedAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminRestaurantRowDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminRestaurantRowDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminRestaurantRowDto call({
    String id,
    String slug,
    String name,
    String address,
    String phone,
    RestaurantStatus status,
    String? submittedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminRestaurantRowDto.copyWith(...)` or call `instanceOfAdminRestaurantRowDto.copyWith.fieldName(value)` for a single field.
class _$AdminRestaurantRowDtoCWProxyImpl
    implements _$AdminRestaurantRowDtoCWProxy {
  const _$AdminRestaurantRowDtoCWProxyImpl(this._value);

  final AdminRestaurantRowDto _value;

  @override
  AdminRestaurantRowDto id(String id) => call(id: id);

  @override
  AdminRestaurantRowDto slug(String slug) => call(slug: slug);

  @override
  AdminRestaurantRowDto name(String name) => call(name: name);

  @override
  AdminRestaurantRowDto address(String address) => call(address: address);

  @override
  AdminRestaurantRowDto phone(String phone) => call(phone: phone);

  @override
  AdminRestaurantRowDto status(RestaurantStatus status) => call(status: status);

  @override
  AdminRestaurantRowDto submittedAt(String? submittedAt) =>
      call(submittedAt: submittedAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminRestaurantRowDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminRestaurantRowDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminRestaurantRowDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? submittedAt = const $CopyWithPlaceholder(),
  }) {
    return AdminRestaurantRowDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      slug: slug == const $CopyWithPlaceholder() || slug == null
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RestaurantStatus,
      submittedAt: submittedAt == const $CopyWithPlaceholder()
          ? _value.submittedAt
          // ignore: cast_nullable_to_non_nullable
          : submittedAt as String?,
    );
  }
}

extension $AdminRestaurantRowDtoCopyWith on AdminRestaurantRowDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminRestaurantRowDto.copyWith(...)` or `instanceOfAdminRestaurantRowDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminRestaurantRowDtoCWProxy get copyWith =>
      _$AdminRestaurantRowDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminRestaurantRowDto _$AdminRestaurantRowDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AdminRestaurantRowDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'slug', 'name', 'address', 'phone', 'status'],
  );
  final val = AdminRestaurantRowDto(
    id: $checkedConvert('id', (v) => v as String),
    slug: $checkedConvert('slug', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    address: $checkedConvert('address', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$RestaurantStatusEnumMap, v),
    ),
    submittedAt: $checkedConvert('submittedAt', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AdminRestaurantRowDtoToJson(
  AdminRestaurantRowDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'address': instance.address,
  'phone': instance.phone,
  'status': _$RestaurantStatusEnumMap[instance.status]!,
  'submittedAt': ?instance.submittedAt,
};

const _$RestaurantStatusEnumMap = {
  RestaurantStatus.DRAFT: 'DRAFT',
  RestaurantStatus.PENDING_REVIEW: 'PENDING_REVIEW',
  RestaurantStatus.ACTIVE: 'ACTIVE',
  RestaurantStatus.PAUSED: 'PAUSED',
  RestaurantStatus.REJECTED: 'REJECTED',
};
