// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_layout_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AreaLayoutDtoCWProxy {
  AreaLayoutDto id(String id);

  AreaLayoutDto name(String name);

  AreaLayoutDto sortOrder(num sortOrder);

  AreaLayoutDto gridCols(num gridCols);

  AreaLayoutDto gridRows(num gridRows);

  AreaLayoutDto floor(num floor);

  AreaLayoutDto backgroundUrl(String? backgroundUrl);

  AreaLayoutDto tables(List<TableDto> tables);

  AreaLayoutDto elements(List<MapElementResponseDto> elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaLayoutDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaLayoutDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AreaLayoutDto call({
    String id,
    String name,
    num sortOrder,
    num gridCols,
    num gridRows,
    num floor,
    String? backgroundUrl,
    List<TableDto> tables,
    List<MapElementResponseDto> elements,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAreaLayoutDto.copyWith(...)` or call `instanceOfAreaLayoutDto.copyWith.fieldName(value)` for a single field.
class _$AreaLayoutDtoCWProxyImpl implements _$AreaLayoutDtoCWProxy {
  const _$AreaLayoutDtoCWProxyImpl(this._value);

  final AreaLayoutDto _value;

  @override
  AreaLayoutDto id(String id) => call(id: id);

  @override
  AreaLayoutDto name(String name) => call(name: name);

  @override
  AreaLayoutDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  @override
  AreaLayoutDto gridCols(num gridCols) => call(gridCols: gridCols);

  @override
  AreaLayoutDto gridRows(num gridRows) => call(gridRows: gridRows);

  @override
  AreaLayoutDto floor(num floor) => call(floor: floor);

  @override
  AreaLayoutDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  @override
  AreaLayoutDto tables(List<TableDto> tables) => call(tables: tables);

  @override
  AreaLayoutDto elements(List<MapElementResponseDto> elements) =>
      call(elements: elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaLayoutDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaLayoutDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AreaLayoutDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
    Object? tables = const $CopyWithPlaceholder(),
    Object? elements = const $CopyWithPlaceholder(),
  }) {
    return AreaLayoutDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sortOrder: sortOrder == const $CopyWithPlaceholder() || sortOrder == null
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num,
      gridCols: gridCols == const $CopyWithPlaceholder() || gridCols == null
          ? _value.gridCols
          // ignore: cast_nullable_to_non_nullable
          : gridCols as num,
      gridRows: gridRows == const $CopyWithPlaceholder() || gridRows == null
          ? _value.gridRows
          // ignore: cast_nullable_to_non_nullable
          : gridRows as num,
      floor: floor == const $CopyWithPlaceholder() || floor == null
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as num,
      backgroundUrl: backgroundUrl == const $CopyWithPlaceholder()
          ? _value.backgroundUrl
          // ignore: cast_nullable_to_non_nullable
          : backgroundUrl as String?,
      tables: tables == const $CopyWithPlaceholder() || tables == null
          ? _value.tables
          // ignore: cast_nullable_to_non_nullable
          : tables as List<TableDto>,
      elements: elements == const $CopyWithPlaceholder() || elements == null
          ? _value.elements
          // ignore: cast_nullable_to_non_nullable
          : elements as List<MapElementResponseDto>,
    );
  }
}

extension $AreaLayoutDtoCopyWith on AreaLayoutDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAreaLayoutDto.copyWith(...)` or `instanceOfAreaLayoutDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AreaLayoutDtoCWProxy get copyWith => _$AreaLayoutDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaLayoutDto _$AreaLayoutDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AreaLayoutDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'name',
          'sortOrder',
          'gridCols',
          'gridRows',
          'floor',
          'tables',
          'elements',
        ],
      );
      final val = AreaLayoutDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num),
        gridCols: $checkedConvert('gridCols', (v) => v as num),
        gridRows: $checkedConvert('gridRows', (v) => v as num),
        floor: $checkedConvert('floor', (v) => v as num),
        backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
        tables: $checkedConvert(
          'tables',
          (v) => (v as List<dynamic>)
              .map((e) => TableDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        elements: $checkedConvert(
          'elements',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    MapElementResponseDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AreaLayoutDtoToJson(AreaLayoutDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sortOrder': instance.sortOrder,
      'gridCols': instance.gridCols,
      'gridRows': instance.gridRows,
      'floor': instance.floor,
      'backgroundUrl': ?instance.backgroundUrl,
      'tables': instance.tables.map((e) => e.toJson()).toList(),
      'elements': instance.elements.map((e) => e.toJson()).toList(),
    };
