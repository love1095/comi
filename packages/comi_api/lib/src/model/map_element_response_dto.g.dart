// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_element_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapElementResponseDtoCWProxy {
  MapElementResponseDto id(String id);

  MapElementResponseDto type(MapElementType type);

  MapElementResponseDto label(String? label);

  MapElementResponseDto x(num x);

  MapElementResponseDto y(num y);

  MapElementResponseDto width(num width);

  MapElementResponseDto height(num height);

  MapElementResponseDto rotation(num rotation);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapElementResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapElementResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MapElementResponseDto call({
    String id,
    MapElementType type,
    String? label,
    num x,
    num y,
    num width,
    num height,
    num rotation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMapElementResponseDto.copyWith(...)` or call `instanceOfMapElementResponseDto.copyWith.fieldName(value)` for a single field.
class _$MapElementResponseDtoCWProxyImpl
    implements _$MapElementResponseDtoCWProxy {
  const _$MapElementResponseDtoCWProxyImpl(this._value);

  final MapElementResponseDto _value;

  @override
  MapElementResponseDto id(String id) => call(id: id);

  @override
  MapElementResponseDto type(MapElementType type) => call(type: type);

  @override
  MapElementResponseDto label(String? label) => call(label: label);

  @override
  MapElementResponseDto x(num x) => call(x: x);

  @override
  MapElementResponseDto y(num y) => call(y: y);

  @override
  MapElementResponseDto width(num width) => call(width: width);

  @override
  MapElementResponseDto height(num height) => call(height: height);

  @override
  MapElementResponseDto rotation(num rotation) => call(rotation: rotation);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapElementResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapElementResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MapElementResponseDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? rotation = const $CopyWithPlaceholder(),
  }) {
    return MapElementResponseDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as MapElementType,
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
      width: width == const $CopyWithPlaceholder() || width == null
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num,
      height: height == const $CopyWithPlaceholder() || height == null
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num,
      rotation: rotation == const $CopyWithPlaceholder() || rotation == null
          ? _value.rotation
          // ignore: cast_nullable_to_non_nullable
          : rotation as num,
    );
  }
}

extension $MapElementResponseDtoCopyWith on MapElementResponseDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMapElementResponseDto.copyWith(...)` or `instanceOfMapElementResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapElementResponseDtoCWProxy get copyWith =>
      _$MapElementResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapElementResponseDto _$MapElementResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MapElementResponseDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'type', 'x', 'y', 'width', 'height', 'rotation'],
  );
  final val = MapElementResponseDto(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$MapElementTypeEnumMap, v),
    ),
    label: $checkedConvert('label', (v) => v as String?),
    x: $checkedConvert('x', (v) => v as num),
    y: $checkedConvert('y', (v) => v as num),
    width: $checkedConvert('width', (v) => v as num),
    height: $checkedConvert('height', (v) => v as num),
    rotation: $checkedConvert('rotation', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MapElementResponseDtoToJson(
  MapElementResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$MapElementTypeEnumMap[instance.type]!,
  'label': ?instance.label,
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'rotation': instance.rotation,
};

const _$MapElementTypeEnumMap = {
  MapElementType.ENTRANCE: 'ENTRANCE',
  MapElementType.WINDOW: 'WINDOW',
  MapElementType.WALL: 'WALL',
  MapElementType.KITCHEN: 'KITCHEN',
  MapElementType.BAR: 'BAR',
  MapElementType.STAGE: 'STAGE',
  MapElementType.RESTROOM: 'RESTROOM',
  MapElementType.STAIRS: 'STAIRS',
  MapElementType.PLANT: 'PLANT',
  MapElementType.TV: 'TV',
  MapElementType.AIRCON: 'AIRCON',
  MapElementType.SMOKING_AREA: 'SMOKING_AREA',
};
