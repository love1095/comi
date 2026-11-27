// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryDtoCWProxy {
  CategoryDto name(String name);

  CategoryDto sortOrder(num? sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CategoryDto call({String name, num? sortOrder});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCategoryDto.copyWith(...)` or call `instanceOfCategoryDto.copyWith.fieldName(value)` for a single field.
class _$CategoryDtoCWProxyImpl implements _$CategoryDtoCWProxy {
  const _$CategoryDtoCWProxyImpl(this._value);

  final CategoryDto _value;

  @override
  CategoryDto name(String name) => call(name: name);

  @override
  CategoryDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CategoryDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return CategoryDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num?,
    );
  }
}

extension $CategoryDtoCopyWith on CategoryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCategoryDto.copyWith(...)` or `instanceOfCategoryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryDtoCWProxy get copyWith => _$CategoryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CategoryDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = CategoryDto(
        name: $checkedConvert('name', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{'name': instance.name, 'sortOrder': ?instance.sortOrder};
