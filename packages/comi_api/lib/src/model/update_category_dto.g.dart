// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_category_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCategoryDtoCWProxy {
  UpdateCategoryDto name(String? name);

  UpdateCategoryDto sortOrder(num? sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCategoryDto call({String? name, num? sortOrder});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateCategoryDto.copyWith(...)` or call `instanceOfUpdateCategoryDto.copyWith.fieldName(value)` for a single field.
class _$UpdateCategoryDtoCWProxyImpl implements _$UpdateCategoryDtoCWProxy {
  const _$UpdateCategoryDtoCWProxyImpl(this._value);

  final UpdateCategoryDto _value;

  @override
  UpdateCategoryDto name(String? name) => call(name: name);

  @override
  UpdateCategoryDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UpdateCategoryDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return UpdateCategoryDto(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num?,
    );
  }
}

extension $UpdateCategoryDtoCopyWith on UpdateCategoryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateCategoryDto.copyWith(...)` or `instanceOfUpdateCategoryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCategoryDtoCWProxy get copyWith =>
      _$UpdateCategoryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCategoryDto _$UpdateCategoryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateCategoryDto', json, ($checkedConvert) {
      final val = UpdateCategoryDto(
        name: $checkedConvert('name', (v) => v as String?),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateCategoryDtoToJson(UpdateCategoryDto instance) =>
    <String, dynamic>{'name': ?instance.name, 'sortOrder': ?instance.sortOrder};
