// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depart_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepartDtoCWProxy {
  DepartDto lat(num lat);

  DepartDto lng(num lng);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DepartDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DepartDto(...).copyWith(id: 12, name: "My name")
  /// ```
  DepartDto call({num lat, num lng});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDepartDto.copyWith(...)` or call `instanceOfDepartDto.copyWith.fieldName(value)` for a single field.
class _$DepartDtoCWProxyImpl implements _$DepartDtoCWProxy {
  const _$DepartDtoCWProxyImpl(this._value);

  final DepartDto _value;

  @override
  DepartDto lat(num lat) => call(lat: lat);

  @override
  DepartDto lng(num lng) => call(lng: lng);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DepartDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DepartDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DepartDto call({
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return DepartDto(
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
    );
  }
}

extension $DepartDtoCopyWith on DepartDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDepartDto.copyWith(...)` or `instanceOfDepartDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepartDtoCWProxy get copyWith => _$DepartDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartDto _$DepartDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepartDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['lat', 'lng']);
      final val = DepartDto(
        lat: $checkedConvert('lat', (v) => v as num),
        lng: $checkedConvert('lng', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DepartDtoToJson(DepartDto instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};
