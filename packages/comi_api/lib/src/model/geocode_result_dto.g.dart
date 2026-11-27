// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocode_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GeocodeResultDtoCWProxy {
  GeocodeResultDto address(String address);

  GeocodeResultDto lat(num lat);

  GeocodeResultDto lng(num lng);

  GeocodeResultDto placeId(String? placeId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GeocodeResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GeocodeResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GeocodeResultDto call({String address, num lat, num lng, String? placeId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGeocodeResultDto.copyWith(...)` or call `instanceOfGeocodeResultDto.copyWith.fieldName(value)` for a single field.
class _$GeocodeResultDtoCWProxyImpl implements _$GeocodeResultDtoCWProxy {
  const _$GeocodeResultDtoCWProxyImpl(this._value);

  final GeocodeResultDto _value;

  @override
  GeocodeResultDto address(String address) => call(address: address);

  @override
  GeocodeResultDto lat(num lat) => call(lat: lat);

  @override
  GeocodeResultDto lng(num lng) => call(lng: lng);

  @override
  GeocodeResultDto placeId(String? placeId) => call(placeId: placeId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GeocodeResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GeocodeResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GeocodeResultDto call({
    Object? address = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? placeId = const $CopyWithPlaceholder(),
  }) {
    return GeocodeResultDto(
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
      placeId: placeId == const $CopyWithPlaceholder()
          ? _value.placeId
          // ignore: cast_nullable_to_non_nullable
          : placeId as String?,
    );
  }
}

extension $GeocodeResultDtoCopyWith on GeocodeResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGeocodeResultDto.copyWith(...)` or `instanceOfGeocodeResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GeocodeResultDtoCWProxy get copyWith => _$GeocodeResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodeResultDto _$GeocodeResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GeocodeResultDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['address', 'lat', 'lng']);
      final val = GeocodeResultDto(
        address: $checkedConvert('address', (v) => v as String),
        lat: $checkedConvert('lat', (v) => v as num),
        lng: $checkedConvert('lng', (v) => v as num),
        placeId: $checkedConvert('placeId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$GeocodeResultDtoToJson(GeocodeResultDto instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'placeId': ?instance.placeId,
    };
