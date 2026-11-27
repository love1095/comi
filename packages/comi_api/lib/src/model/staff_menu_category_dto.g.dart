// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_menu_category_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StaffMenuCategoryDtoCWProxy {
  StaffMenuCategoryDto id(String id);

  StaffMenuCategoryDto name(String name);

  StaffMenuCategoryDto sortOrder(num sortOrder);

  StaffMenuCategoryDto items(List<StaffMenuItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffMenuCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffMenuCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StaffMenuCategoryDto call({
    String id,
    String name,
    num sortOrder,
    List<StaffMenuItemDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStaffMenuCategoryDto.copyWith(...)` or call `instanceOfStaffMenuCategoryDto.copyWith.fieldName(value)` for a single field.
class _$StaffMenuCategoryDtoCWProxyImpl
    implements _$StaffMenuCategoryDtoCWProxy {
  const _$StaffMenuCategoryDtoCWProxyImpl(this._value);

  final StaffMenuCategoryDto _value;

  @override
  StaffMenuCategoryDto id(String id) => call(id: id);

  @override
  StaffMenuCategoryDto name(String name) => call(name: name);

  @override
  StaffMenuCategoryDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  @override
  StaffMenuCategoryDto items(List<StaffMenuItemDto> items) =>
      call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffMenuCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffMenuCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StaffMenuCategoryDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return StaffMenuCategoryDto(
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
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<StaffMenuItemDto>,
    );
  }
}

extension $StaffMenuCategoryDtoCopyWith on StaffMenuCategoryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStaffMenuCategoryDto.copyWith(...)` or `instanceOfStaffMenuCategoryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StaffMenuCategoryDtoCWProxy get copyWith =>
      _$StaffMenuCategoryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffMenuCategoryDto _$StaffMenuCategoryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('StaffMenuCategoryDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'sortOrder', 'items']);
  final val = StaffMenuCategoryDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    sortOrder: $checkedConvert('sortOrder', (v) => v as num),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => StaffMenuItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$StaffMenuCategoryDtoToJson(
  StaffMenuCategoryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sortOrder': instance.sortOrder,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
