// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AreaDtoCWProxy {
  AreaDto name(String name);

  AreaDto sortOrder(num? sortOrder);

  AreaDto gridCols(num? gridCols);

  AreaDto gridRows(num? gridRows);

  AreaDto floor(num? floor);

  AreaDto backgroundUrl(String? backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AreaDto call({
    String name,
    num? sortOrder,
    num? gridCols,
    num? gridRows,
    num? floor,
    String? backgroundUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAreaDto.copyWith(...)` or call `instanceOfAreaDto.copyWith.fieldName(value)` for a single field.
class _$AreaDtoCWProxyImpl implements _$AreaDtoCWProxy {
  const _$AreaDtoCWProxyImpl(this._value);

  final AreaDto _value;

  @override
  AreaDto name(String name) => call(name: name);

  @override
  AreaDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  @override
  AreaDto gridCols(num? gridCols) => call(gridCols: gridCols);

  @override
  AreaDto gridRows(num? gridRows) => call(gridRows: gridRows);

  @override
  AreaDto floor(num? floor) => call(floor: floor);

  @override
  AreaDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AreaDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
  }) {
    return AreaDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num?,
      gridCols: gridCols == const $CopyWithPlaceholder()
          ? _value.gridCols
          // ignore: cast_nullable_to_non_nullable
          : gridCols as num?,
      gridRows: gridRows == const $CopyWithPlaceholder()
          ? _value.gridRows
          // ignore: cast_nullable_to_non_nullable
          : gridRows as num?,
      floor: floor == const $CopyWithPlaceholder()
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as num?,
      backgroundUrl: backgroundUrl == const $CopyWithPlaceholder()
          ? _value.backgroundUrl
          // ignore: cast_nullable_to_non_nullable
          : backgroundUrl as String?,
    );
  }
}

extension $AreaDtoCopyWith on AreaDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAreaDto.copyWith(...)` or `instanceOfAreaDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AreaDtoCWProxy get copyWith => _$AreaDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaDto _$AreaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AreaDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = AreaDto(
        name: $checkedConvert('name', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num?),
        gridCols: $checkedConvert('gridCols', (v) => v as num?),
        gridRows: $checkedConvert('gridRows', (v) => v as num?),
        floor: $checkedConvert('floor', (v) => v as num?),
        backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AreaDtoToJson(AreaDto instance) => <String, dynamic>{
  'name': instance.name,
  'sortOrder': ?instance.sortOrder,
  'gridCols': ?instance.gridCols,
  'gridRows': ?instance.gridRows,
  'floor': ?instance.floor,
  'backgroundUrl': ?instance.backgroundUrl,
};
