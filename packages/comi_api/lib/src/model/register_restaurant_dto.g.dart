// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_restaurant_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterRestaurantDtoCWProxy {
  RegisterRestaurantDto name(String name);

  RegisterRestaurantDto phone(String phone);

  RegisterRestaurantDto address(String address);

  RegisterRestaurantDto provinceCode(String provinceCode);

  RegisterRestaurantDto wardCode(String? wardCode);

  RegisterRestaurantDto priceLevel(num priceLevel);

  RegisterRestaurantDto cuisineTags(List<String>? cuisineTags);

  RegisterRestaurantDto lat(num? lat);

  RegisterRestaurantDto lng(num? lng);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RegisterRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RegisterRestaurantDto call({
    String name,
    String phone,
    String address,
    String provinceCode,
    String? wardCode,
    num priceLevel,
    List<String>? cuisineTags,
    num? lat,
    num? lng,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRegisterRestaurantDto.copyWith(...)` or call `instanceOfRegisterRestaurantDto.copyWith.fieldName(value)` for a single field.
class _$RegisterRestaurantDtoCWProxyImpl
    implements _$RegisterRestaurantDtoCWProxy {
  const _$RegisterRestaurantDtoCWProxyImpl(this._value);

  final RegisterRestaurantDto _value;

  @override
  RegisterRestaurantDto name(String name) => call(name: name);

  @override
  RegisterRestaurantDto phone(String phone) => call(phone: phone);

  @override
  RegisterRestaurantDto address(String address) => call(address: address);

  @override
  RegisterRestaurantDto provinceCode(String provinceCode) =>
      call(provinceCode: provinceCode);

  @override
  RegisterRestaurantDto wardCode(String? wardCode) => call(wardCode: wardCode);

  @override
  RegisterRestaurantDto priceLevel(num priceLevel) =>
      call(priceLevel: priceLevel);

  @override
  RegisterRestaurantDto cuisineTags(List<String>? cuisineTags) =>
      call(cuisineTags: cuisineTags);

  @override
  RegisterRestaurantDto lat(num? lat) => call(lat: lat);

  @override
  RegisterRestaurantDto lng(num? lng) => call(lng: lng);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RegisterRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RegisterRestaurantDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? provinceCode = const $CopyWithPlaceholder(),
    Object? wardCode = const $CopyWithPlaceholder(),
    Object? priceLevel = const $CopyWithPlaceholder(),
    Object? cuisineTags = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return RegisterRestaurantDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      provinceCode:
          provinceCode == const $CopyWithPlaceholder() || provinceCode == null
          ? _value.provinceCode
          // ignore: cast_nullable_to_non_nullable
          : provinceCode as String,
      wardCode: wardCode == const $CopyWithPlaceholder()
          ? _value.wardCode
          // ignore: cast_nullable_to_non_nullable
          : wardCode as String?,
      priceLevel:
          priceLevel == const $CopyWithPlaceholder() || priceLevel == null
          ? _value.priceLevel
          // ignore: cast_nullable_to_non_nullable
          : priceLevel as num,
      cuisineTags: cuisineTags == const $CopyWithPlaceholder()
          ? _value.cuisineTags
          // ignore: cast_nullable_to_non_nullable
          : cuisineTags as List<String>?,
      lat: lat == const $CopyWithPlaceholder()
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num?,
      lng: lng == const $CopyWithPlaceholder()
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num?,
    );
  }
}

extension $RegisterRestaurantDtoCopyWith on RegisterRestaurantDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRegisterRestaurantDto.copyWith(...)` or `instanceOfRegisterRestaurantDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterRestaurantDtoCWProxy get copyWith =>
      _$RegisterRestaurantDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRestaurantDto _$RegisterRestaurantDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RegisterRestaurantDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'phone',
      'address',
      'provinceCode',
      'priceLevel',
    ],
  );
  final val = RegisterRestaurantDto(
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    address: $checkedConvert('address', (v) => v as String),
    provinceCode: $checkedConvert('provinceCode', (v) => v as String),
    wardCode: $checkedConvert('wardCode', (v) => v as String?),
    priceLevel: $checkedConvert('priceLevel', (v) => v as num),
    cuisineTags: $checkedConvert(
      'cuisineTags',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
    lat: $checkedConvert('lat', (v) => v as num?),
    lng: $checkedConvert('lng', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$RegisterRestaurantDtoToJson(
  RegisterRestaurantDto instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'address': instance.address,
  'provinceCode': instance.provinceCode,
  'wardCode': ?instance.wardCode,
  'priceLevel': instance.priceLevel,
  'cuisineTags': ?instance.cuisineTags,
  'lat': ?instance.lat,
  'lng': ?instance.lng,
};
