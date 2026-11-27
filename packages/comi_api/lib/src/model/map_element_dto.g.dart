// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_element_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapElementDtoCWProxy {
  MapElementDto type(MapElementDtoTypeEnum type);

  MapElementDto label(String? label);

  MapElementDto x(num x);

  MapElementDto y(num y);

  MapElementDto width(num? width);

  MapElementDto height(num? height);

  MapElementDto rotation(num? rotation);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapElementDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapElementDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MapElementDto call({
    MapElementDtoTypeEnum type,
    String? label,
    num x,
    num y,
    num? width,
    num? height,
    num? rotation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMapElementDto.copyWith(...)` or call `instanceOfMapElementDto.copyWith.fieldName(value)` for a single field.
class _$MapElementDtoCWProxyImpl implements _$MapElementDtoCWProxy {
  const _$MapElementDtoCWProxyImpl(this._value);

  final MapElementDto _value;

  @override
  MapElementDto type(MapElementDtoTypeEnum type) => call(type: type);

  @override
  MapElementDto label(String? label) => call(label: label);

  @override
  MapElementDto x(num x) => call(x: x);

  @override
  MapElementDto y(num y) => call(y: y);

  @override
  MapElementDto width(num? width) => call(width: width);

  @override
  MapElementDto height(num? height) => call(height: height);

  @override
  MapElementDto rotation(num? rotation) => call(rotation: rotation);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapElementDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapElementDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MapElementDto call({
    Object? type = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? rotation = const $CopyWithPlaceholder(),
  }) {
    return MapElementDto(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as MapElementDtoTypeEnum,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      x: x == const $CopyWithPlaceholder() || x == null
          ? _value.x
          // ignore: cast_nullable_to_non_nullable
          : x as num,
      y: y == const $CopyWithPlaceholder() || y == null
          ? _value.y
          // ignore: cast_nullable_to_non_nullable
          : y as num,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num?,
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num?,
      rotation: rotation == const $CopyWithPlaceholder()
          ? _value.rotation
          // ignore: cast_nullable_to_non_nullable
          : rotation as num?,
    );
  }
}

extension $MapElementDtoCopyWith on MapElementDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMapElementDto.copyWith(...)` or `instanceOfMapElementDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapElementDtoCWProxy get copyWith => _$MapElementDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapElementDto _$MapElementDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MapElementDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'x', 'y']);
      final val = MapElementDto(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$MapElementDtoTypeEnumEnumMap, v),
        ),
        label: $checkedConvert('label', (v) => v as String?),
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
        width: $checkedConvert('width', (v) => v as num?),
        height: $checkedConvert('height', (v) => v as num?),
        rotation: $checkedConvert('rotation', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$MapElementDtoToJson(MapElementDto instance) =>
    <String, dynamic>{
      'type': _$MapElementDtoTypeEnumEnumMap[instance.type]!,
      'label': ?instance.label,
      'x': instance.x,
      'y': instance.y,
      'width': ?instance.width,
      'height': ?instance.height,
      'rotation': ?instance.rotation,
    };

const _$MapElementDtoTypeEnumEnumMap = {
  MapElementDtoTypeEnum.ENTRANCE: 'ENTRANCE',
  MapElementDtoTypeEnum.WINDOW: 'WINDOW',
  MapElementDtoTypeEnum.WALL: 'WALL',
  MapElementDtoTypeEnum.KITCHEN: 'KITCHEN',
  MapElementDtoTypeEnum.BAR: 'BAR',
  MapElementDtoTypeEnum.STAGE: 'STAGE',
  MapElementDtoTypeEnum.RESTROOM: 'RESTROOM',
  MapElementDtoTypeEnum.STAIRS: 'STAIRS',
  MapElementDtoTypeEnum.PLANT: 'PLANT',
  MapElementDtoTypeEnum.TV: 'TV',
  MapElementDtoTypeEnum.AIRCON: 'AIRCON',
  MapElementDtoTypeEnum.SMOKING_AREA: 'SMOKING_AREA',
};
