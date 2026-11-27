// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_area_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateAreaDtoCWProxy {
  UpdateAreaDto name(String? name);

  UpdateAreaDto sortOrder(num? sortOrder);

  UpdateAreaDto gridCols(num? gridCols);

  UpdateAreaDto gridRows(num? gridRows);

  UpdateAreaDto floor(num? floor);

  UpdateAreaDto backgroundUrl(String? backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateAreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateAreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateAreaDto call({
    String? name,
    num? sortOrder,
    num? gridCols,
    num? gridRows,
    num? floor,
    String? backgroundUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateAreaDto.copyWith(...)` or call `instanceOfUpdateAreaDto.copyWith.fieldName(value)` for a single field.
class _$UpdateAreaDtoCWProxyImpl implements _$UpdateAreaDtoCWProxy {
  const _$UpdateAreaDtoCWProxyImpl(this._value);

  final UpdateAreaDto _value;

  @override
  UpdateAreaDto name(String? name) => call(name: name);

  @override
  UpdateAreaDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  @override
  UpdateAreaDto gridCols(num? gridCols) => call(gridCols: gridCols);

  @override
  UpdateAreaDto gridRows(num? gridRows) => call(gridRows: gridRows);

  @override
  UpdateAreaDto floor(num? floor) => call(floor: floor);

  @override
  UpdateAreaDto backgroundUrl(String? backgroundUrl) =>
      call(backgroundUrl: backgroundUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateAreaDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateAreaDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UpdateAreaDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? gridCols = const $CopyWithPlaceholder(),
    Object? gridRows = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? backgroundUrl = const $CopyWithPlaceholder(),
  }) {
    return UpdateAreaDto(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
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

extension $UpdateAreaDtoCopyWith on UpdateAreaDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateAreaDto.copyWith(...)` or `instanceOfUpdateAreaDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateAreaDtoCWProxy get copyWith => _$UpdateAreaDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAreaDto _$UpdateAreaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateAreaDto', json, ($checkedConvert) {
      final val = UpdateAreaDto(
        name: $checkedConvert('name', (v) => v as String?),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num?),
        gridCols: $checkedConvert('gridCols', (v) => v as num?),
        gridRows: $checkedConvert('gridRows', (v) => v as num?),
        floor: $checkedConvert('floor', (v) => v as num?),
        backgroundUrl: $checkedConvert('backgroundUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateAreaDtoToJson(UpdateAreaDto instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'sortOrder': ?instance.sortOrder,
      'gridCols': ?instance.gridCols,
      'gridRows': ?instance.gridRows,
      'floor': ?instance.floor,
      'backgroundUrl': ?instance.backgroundUrl,
    };
