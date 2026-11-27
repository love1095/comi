// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuCategoryResponseDtoCWProxy {
  MenuCategoryResponseDto id(String id);

  MenuCategoryResponseDto name(String name);

  MenuCategoryResponseDto sortOrder(num sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuCategoryResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuCategoryResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuCategoryResponseDto call({String id, String name, num sortOrder});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuCategoryResponseDto.copyWith(...)` or call `instanceOfMenuCategoryResponseDto.copyWith.fieldName(value)` for a single field.
class _$MenuCategoryResponseDtoCWProxyImpl
    implements _$MenuCategoryResponseDtoCWProxy {
  const _$MenuCategoryResponseDtoCWProxyImpl(this._value);

  final MenuCategoryResponseDto _value;

  @override
  MenuCategoryResponseDto id(String id) => call(id: id);

  @override
  MenuCategoryResponseDto name(String name) => call(name: name);

  @override
  MenuCategoryResponseDto sortOrder(num sortOrder) =>
      call(sortOrder: sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuCategoryResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuCategoryResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MenuCategoryResponseDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return MenuCategoryResponseDto(
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
    );
  }
}

extension $MenuCategoryResponseDtoCopyWith on MenuCategoryResponseDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuCategoryResponseDto.copyWith(...)` or `instanceOfMenuCategoryResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuCategoryResponseDtoCWProxy get copyWith =>
      _$MenuCategoryResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategoryResponseDto _$MenuCategoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MenuCategoryResponseDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'sortOrder']);
  final val = MenuCategoryResponseDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    sortOrder: $checkedConvert('sortOrder', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MenuCategoryResponseDtoToJson(
  MenuCategoryResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sortOrder': instance.sortOrder,
};
