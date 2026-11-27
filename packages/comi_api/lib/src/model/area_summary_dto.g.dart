// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_summary_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AreaSummaryDtoCWProxy {
  AreaSummaryDto id(String id);

  AreaSummaryDto name(String name);

  AreaSummaryDto sortOrder(num sortOrder);

  AreaSummaryDto gridCols(num gridCols);

  AreaSummaryDto gridRows(num gridRows);

  AreaSummaryDto floor(num floor);

  AreaSummaryDto backgroundUrl(String? backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaSummaryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaSummaryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AreaSummaryDto call({
    String id,
    String name,
    num sortOrder,
    num gridCols,
    num gridRows,
    num floor,
    String? backgroundUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAreaSummaryDto.copyWith(...)` or call `instanceOfAreaSummaryDto.copyWith.fieldName(value)` for a single field.
class _$AreaSummaryDtoCWProxyImpl implements _$AreaSummaryDtoCWProxy {
  const _$AreaSummaryDtoCWProxyImpl(this._value);

  final AreaSummaryDto _value;

  @override
  AreaSummaryDto id(String id) => call(id: id);

  @override
  AreaSummaryDto name(String name) => call(name: name);

  @override
  AreaSummaryDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  @override
  AreaSummaryDto gridCols(num gridCols) => call(gridCols: gridCols);

  @override
  AreaSummaryDto gridRows(num gridRows) => call(gridRows: gridRows);

  @override
  AreaSummaryDto floor(num floor) => call(floor: floor);

  @override
  AreaSummaryDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaSummaryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaSummaryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AreaSummaryDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
  }) {
    return AreaSummaryDto(
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
    );
  }
}

extension $AreaSummaryDtoCopyWith on AreaSummaryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAreaSummaryDto.copyWith(...)` or `instanceOfAreaSummaryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AreaSummaryDtoCWProxy get copyWith => _$AreaSummaryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaSummaryDto _$AreaSummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AreaSummaryDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'name',
          'sortOrder',
          'gridCols',
          'gridRows',
          'floor',
        ],
      );
      final val = AreaSummaryDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num),
        gridCols: $checkedConvert('gridCols', (v) => v as num),
        gridRows: $checkedConvert('gridRows', (v) => v as num),
        floor: $checkedConvert('floor', (v) => v as num),
        backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AreaSummaryDtoToJson(AreaSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sortOrder': instance.sortOrder,
      'gridCols': instance.gridCols,
      'gridRows': instance.gridRows,
      'floor': instance.floor,
      'backgroundUrl': ?instance.backgroundUrl,
    };
