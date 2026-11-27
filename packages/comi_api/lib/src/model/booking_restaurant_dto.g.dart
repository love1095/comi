// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_restaurant_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingRestaurantDtoCWProxy {
  BookingRestaurantDto id(String id);

  BookingRestaurantDto slug(String slug);

  BookingRestaurantDto name(String name);

  BookingRestaurantDto address(String address);

  BookingRestaurantDto phone(String phone);

  BookingRestaurantDto coverPhotoUrl(String? coverPhotoUrl);

  BookingRestaurantDto timezone(String timezone);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingRestaurantDto call({
    String id,
    String slug,
    String name,
    String address,
    String phone,
    String? coverPhotoUrl,
    String timezone,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingRestaurantDto.copyWith(...)` or call `instanceOfBookingRestaurantDto.copyWith.fieldName(value)` for a single field.
class _$BookingRestaurantDtoCWProxyImpl
    implements _$BookingRestaurantDtoCWProxy {
  const _$BookingRestaurantDtoCWProxyImpl(this._value);

  final BookingRestaurantDto _value;

  @override
  BookingRestaurantDto id(String id) => call(id: id);

  @override
  BookingRestaurantDto slug(String slug) => call(slug: slug);

  @override
  BookingRestaurantDto name(String name) => call(name: name);

  @override
  BookingRestaurantDto address(String address) => call(address: address);

  @override
  BookingRestaurantDto phone(String phone) => call(phone: phone);

  @override
  BookingRestaurantDto coverPhotoUrl(String? coverPhotoUrl) =>
      call(coverPhotoUrl: coverPhotoUrl);

  @override
  BookingRestaurantDto timezone(String timezone) => call(timezone: timezone);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingRestaurantDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? coverPhotoUrl = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
  }) {
    return BookingRestaurantDto(
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
      coverPhotoUrl: coverPhotoUrl == const $CopyWithPlaceholder()
          ? _value.coverPhotoUrl
          // ignore: cast_nullable_to_non_nullable
          : coverPhotoUrl as String?,
      timezone: timezone == const $CopyWithPlaceholder() || timezone == null
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String,
    );
  }
}

extension $BookingRestaurantDtoCopyWith on BookingRestaurantDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingRestaurantDto.copyWith(...)` or `instanceOfBookingRestaurantDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingRestaurantDtoCWProxy get copyWith =>
      _$BookingRestaurantDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRestaurantDto _$BookingRestaurantDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BookingRestaurantDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'slug', 'name', 'address', 'phone', 'timezone'],
  );
  final val = BookingRestaurantDto(
    id: $checkedConvert('id', (v) => v as String),
    slug: $checkedConvert('slug', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    address: $checkedConvert('address', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    coverPhotoUrl: $checkedConvert('coverPhotoUrl', (v) => v as String?),
    timezone: $checkedConvert('timezone', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BookingRestaurantDtoToJson(
  BookingRestaurantDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'address': instance.address,
  'phone': instance.phone,
  'coverPhotoUrl': ?instance.coverPhotoUrl,
  'timezone': instance.timezone,
};
