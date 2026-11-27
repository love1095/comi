// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_area_with_elements_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapAreaWithElementsDtoCWProxy {
  MapAreaWithElementsDto id(String id);

  MapAreaWithElementsDto name(String name);

  MapAreaWithElementsDto floor(num floor);

  MapAreaWithElementsDto gridCols(num gridCols);

  MapAreaWithElementsDto gridRows(num gridRows);

  MapAreaWithElementsDto backgroundUrl(String? backgroundUrl);

  MapAreaWithElementsDto elements(List<MapElementResponseDto> elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapAreaWithElementsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapAreaWithElementsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MapAreaWithElementsDto call({
    String id,
    String name,
    num floor,
    num gridCols,
    num gridRows,
    String? backgroundUrl,
    List<MapElementResponseDto> elements,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMapAreaWithElementsDto.copyWith(...)` or call `instanceOfMapAreaWithElementsDto.copyWith.fieldName(value)` for a single field.
class _$MapAreaWithElementsDtoCWProxyImpl
    implements _$MapAreaWithElementsDtoCWProxy {
  const _$MapAreaWithElementsDtoCWProxyImpl(this._value);

  final MapAreaWithElementsDto _value;

  @override
  MapAreaWithElementsDto id(String id) => call(id: id);

  @override
  MapAreaWithElementsDto name(String name) => call(name: name);

  @override
  MapAreaWithElementsDto floor(num floor) => call(floor: floor);

  @override
  MapAreaWithElementsDto gridCols(num gridCols) => call(gridCols: gridCols);

  @override
  MapAreaWithElementsDto gridRows(num gridRows) => call(gridRows: gridRows);

  @override
  MapAreaWithElementsDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  @override
  MapAreaWithElementsDto elements(List<MapElementResponseDto> elements) =>
      call(elements: elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapAreaWithElementsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapAreaWithElementsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MapAreaWithElementsDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
    Object? elements = const $CopyWithPlaceholder(),
  }) {
    return MapAreaWithElementsDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      floor: floor == const $CopyWithPlaceholder() || floor == null
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as num,
      gridCols: gridCols == const $CopyWithPlaceholder() || gridCols == null
          ? _value.gridCols
          // ignore: cast_nullable_to_non_nullable
          : gridCols as num,
      gridRows: gridRows == const $CopyWithPlaceholder() || gridRows == null
          ? _value.gridRows
          // ignore: cast_nullable_to_non_nullable
          : gridRows as num,
      backgroundUrl: backgroundUrl == const $CopyWithPlaceholder()
          ? _value.backgroundUrl
          // ignore: cast_nullable_to_non_nullable
          : backgroundUrl as String?,
      elements: elements == const $CopyWithPlaceholder() || elements == null
          ? _value.elements
          // ignore: cast_nullable_to_non_nullable
          : elements as List<MapElementResponseDto>,
    );
  }
}

extension $MapAreaWithElementsDtoCopyWith on MapAreaWithElementsDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMapAreaWithElementsDto.copyWith(...)` or `instanceOfMapAreaWithElementsDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapAreaWithElementsDtoCWProxy get copyWith =>
      _$MapAreaWithElementsDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapAreaWithElementsDto _$MapAreaWithElementsDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MapAreaWithElementsDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'floor',
      'gridCols',
      'gridRows',
      'elements',
    ],
  );
  final val = MapAreaWithElementsDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    floor: $checkedConvert('floor', (v) => v as num),
    gridCols: $checkedConvert('gridCols', (v) => v as num),
    gridRows: $checkedConvert('gridRows', (v) => v as num),
    backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
    elements: $checkedConvert(
      'elements',
      (v) => (v as List<dynamic>)
          .map((e) => MapElementResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$MapAreaWithElementsDtoToJson(
  MapAreaWithElementsDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'floor': instance.floor,
  'gridCols': instance.gridCols,
  'gridRows': instance.gridRows,
  'backgroundUrl': ?instance.backgroundUrl,
  'elements': instance.elements.map((e) => e.toJson()).toList(),
};
