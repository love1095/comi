// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_pin_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapPinDtoCWProxy {
  MapPinDto id(String id);

  MapPinDto slug(String slug);

  MapPinDto name(String name);

  MapPinDto lat(num lat);

  MapPinDto lng(num lng);

  MapPinDto priceLevel(num priceLevel);

  MapPinDto ratingAvg(num ratingAvg);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapPinDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapPinDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MapPinDto call({
    String id,
    String slug,
    String name,
    num lat,
    num lng,
    num priceLevel,
    num ratingAvg,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMapPinDto.copyWith(...)` or call `instanceOfMapPinDto.copyWith.fieldName(value)` for a single field.
class _$MapPinDtoCWProxyImpl implements _$MapPinDtoCWProxy {
  const _$MapPinDtoCWProxyImpl(this._value);

  final MapPinDto _value;

  @override
  MapPinDto id(String id) => call(id: id);

  @override
  MapPinDto slug(String slug) => call(slug: slug);

  @override
  MapPinDto name(String name) => call(name: name);

  @override
  MapPinDto lat(num lat) => call(lat: lat);

  @override
  MapPinDto lng(num lng) => call(lng: lng);

  @override
  MapPinDto priceLevel(num priceLevel) => call(priceLevel: priceLevel);

  @override
  MapPinDto ratingAvg(num ratingAvg) => call(ratingAvg: ratingAvg);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapPinDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapPinDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MapPinDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? priceLevel = const $CopyWithPlaceholder(),
    Object? ratingAvg = const $CopyWithPlaceholder(),
  }) {
    return MapPinDto(
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
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
      priceLevel:
          priceLevel == const $CopyWithPlaceholder() || priceLevel == null
          ? _value.priceLevel
          // ignore: cast_nullable_to_non_nullable
          : priceLevel as num,
      ratingAvg: ratingAvg == const $CopyWithPlaceholder() || ratingAvg == null
          ? _value.ratingAvg
          // ignore: cast_nullable_to_non_nullable
          : ratingAvg as num,
    );
  }
}

extension $MapPinDtoCopyWith on MapPinDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMapPinDto.copyWith(...)` or `instanceOfMapPinDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapPinDtoCWProxy get copyWith => _$MapPinDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapPinDto _$MapPinDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MapPinDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'slug',
          'name',
          'lat',
          'lng',
          'priceLevel',
          'ratingAvg',
        ],
      );
      final val = MapPinDto(
        id: $checkedConvert('id', (v) => v as String),
        slug: $checkedConvert('slug', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        lat: $checkedConvert('lat', (v) => v as num),
        lng: $checkedConvert('lng', (v) => v as num),
        priceLevel: $checkedConvert('priceLevel', (v) => v as num),
        ratingAvg: $checkedConvert('ratingAvg', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$MapPinDtoToJson(MapPinDto instance) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'lat': instance.lat,
  'lng': instance.lng,
  'priceLevel': instance.priceLevel,
  'ratingAvg': instance.ratingAvg,
};
