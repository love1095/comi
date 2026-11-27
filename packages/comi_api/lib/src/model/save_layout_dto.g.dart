// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_layout_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SaveLayoutDtoCWProxy {
  SaveLayoutDto gridCols(num? gridCols);

  SaveLayoutDto gridRows(num? gridRows);

  SaveLayoutDto tables(List<LayoutTableDto> tables);

  SaveLayoutDto elements(List<MapElementDto> elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SaveLayoutDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SaveLayoutDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SaveLayoutDto call({
    num? gridCols,
    num? gridRows,
    List<LayoutTableDto> tables,
    List<MapElementDto> elements,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSaveLayoutDto.copyWith(...)` or call `instanceOfSaveLayoutDto.copyWith.fieldName(value)` for a single field.
class _$SaveLayoutDtoCWProxyImpl implements _$SaveLayoutDtoCWProxy {
  const _$SaveLayoutDtoCWProxyImpl(this._value);

  final SaveLayoutDto _value;

  @override
  SaveLayoutDto gridCols(num? gridCols) => call(gridCols: gridCols);

  @override
  SaveLayoutDto gridRows(num? gridRows) => call(gridRows: gridRows);

  @override
  SaveLayoutDto tables(List<LayoutTableDto> tables) => call(tables: tables);

  @override
  SaveLayoutDto elements(List<MapElementDto> elements) =>
      call(elements: elements);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SaveLayoutDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SaveLayoutDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SaveLayoutDto call({
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? tables = const $CopyWithPlaceholder(),
    Object? elements = const $CopyWithPlaceholder(),
  }) {
    return SaveLayoutDto(
      gridCols: gridCols == const $CopyWithPlaceholder()
          ? _value.gridCols
          // ignore: cast_nullable_to_non_nullable
          : gridCols as num?,
      gridRows: gridRows == const $CopyWithPlaceholder()
          ? _value.gridRows
          // ignore: cast_nullable_to_non_nullable
          : gridRows as num?,
      tables: tables == const $CopyWithPlaceholder() || tables == null
          ? _value.tables
          // ignore: cast_nullable_to_non_nullable
          : tables as List<LayoutTableDto>,
      elements: elements == const $CopyWithPlaceholder() || elements == null
          ? _value.elements
          // ignore: cast_nullable_to_non_nullable
          : elements as List<MapElementDto>,
    );
  }
}

extension $SaveLayoutDtoCopyWith on SaveLayoutDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSaveLayoutDto.copyWith(...)` or `instanceOfSaveLayoutDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SaveLayoutDtoCWProxy get copyWith => _$SaveLayoutDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveLayoutDto _$SaveLayoutDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SaveLayoutDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['tables', 'elements']);
      final val = SaveLayoutDto(
        gridCols: $checkedConvert('gridCols', (v) => v as num?),
        gridRows: $checkedConvert('gridRows', (v) => v as num?),
        tables: $checkedConvert(
          'tables',
          (v) => (v as List<dynamic>)
              .map((e) => LayoutTableDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        elements: $checkedConvert(
          'elements',
          (v) => (v as List<dynamic>)
              .map((e) => MapElementDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SaveLayoutDtoToJson(SaveLayoutDto instance) =>
    <String, dynamic>{
      'gridCols': ?instance.gridCols,
      'gridRows': ?instance.gridRows,
      'tables': instance.tables.map((e) => e.toJson()).toList(),
      'elements': instance.elements.map((e) => e.toJson()).toList(),
    };
