// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_menu_category_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicMenuCategoryDtoCWProxy {
  PublicMenuCategoryDto id(String id);

  PublicMenuCategoryDto name(String name);

  PublicMenuCategoryDto items(List<PublicMenuItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicMenuCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicMenuCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PublicMenuCategoryDto call({
    String id,
    String name,
    List<PublicMenuItemDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPublicMenuCategoryDto.copyWith(...)` or call `instanceOfPublicMenuCategoryDto.copyWith.fieldName(value)` for a single field.
class _$PublicMenuCategoryDtoCWProxyImpl
    implements _$PublicMenuCategoryDtoCWProxy {
  const _$PublicMenuCategoryDtoCWProxyImpl(this._value);

  final PublicMenuCategoryDto _value;

  @override
  PublicMenuCategoryDto id(String id) => call(id: id);

  @override
  PublicMenuCategoryDto name(String name) => call(name: name);

  @override
  PublicMenuCategoryDto items(List<PublicMenuItemDto> items) =>
      call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicMenuCategoryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicMenuCategoryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PublicMenuCategoryDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return PublicMenuCategoryDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PublicMenuItemDto>,
    );
  }
}

extension $PublicMenuCategoryDtoCopyWith on PublicMenuCategoryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPublicMenuCategoryDto.copyWith(...)` or `instanceOfPublicMenuCategoryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicMenuCategoryDtoCWProxy get copyWith =>
      _$PublicMenuCategoryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMenuCategoryDto _$PublicMenuCategoryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PublicMenuCategoryDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'items']);
  final val = PublicMenuCategoryDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => PublicMenuItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicMenuCategoryDtoToJson(
  PublicMenuCategoryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
