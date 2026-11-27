// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_area_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapAreaDtoCWProxy {
  MapAreaDto id(String id);

  MapAreaDto name(String name);

  MapAreaDto floor(num floor);

  MapAreaDto gridCols(num gridCols);

  MapAreaDto gridRows(num gridRows);

  MapAreaDto backgroundUrl(String? backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapAreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapAreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MapAreaDto call({
    String id,
    String name,
    num floor,
    num gridCols,
    num gridRows,
    String? backgroundUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMapAreaDto.copyWith(...)` or call `instanceOfMapAreaDto.copyWith.fieldName(value)` for a single field.
class _$MapAreaDtoCWProxyImpl implements _$MapAreaDtoCWProxy {
  const _$MapAreaDtoCWProxyImpl(this._value);

  final MapAreaDto _value;

  @override
  MapAreaDto id(String id) => call(id: id);

  @override
  MapAreaDto name(String name) => call(name: name);

  @override
  MapAreaDto floor(num floor) => call(floor: floor);

  @override
  MapAreaDto gridCols(num gridCols) => call(gridCols: gridCols);

  @override
  MapAreaDto gridRows(num gridRows) => call(gridRows: gridRows);

  @override
  MapAreaDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MapAreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MapAreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MapAreaDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
  }) {
    return MapAreaDto(
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
    );
  }
}

extension $MapAreaDtoCopyWith on MapAreaDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMapAreaDto.copyWith(...)` or `instanceOfMapAreaDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapAreaDtoCWProxy get copyWith => _$MapAreaDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapAreaDto _$MapAreaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MapAreaDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'name', 'floor', 'gridCols', 'gridRows'],
      );
      final val = MapAreaDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        floor: $checkedConvert('floor', (v) => v as num),
        gridCols: $checkedConvert('gridCols', (v) => v as num),
        gridRows: $checkedConvert('gridRows', (v) => v as num),
        backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MapAreaDtoToJson(MapAreaDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'floor': instance.floor,
      'gridCols': instance.gridCols,
      'gridRows': instance.gridRows,
      'backgroundUrl': ?instance.backgroundUrl,
    };
