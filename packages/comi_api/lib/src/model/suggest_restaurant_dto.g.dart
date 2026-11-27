// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_restaurant_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuggestRestaurantDtoCWProxy {
  SuggestRestaurantDto id(String id);

  SuggestRestaurantDto slug(String slug);

  SuggestRestaurantDto name(String name);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SuggestRestaurantDto call({String id, String slug, String name});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSuggestRestaurantDto.copyWith(...)` or call `instanceOfSuggestRestaurantDto.copyWith.fieldName(value)` for a single field.
class _$SuggestRestaurantDtoCWProxyImpl
    implements _$SuggestRestaurantDtoCWProxy {
  const _$SuggestRestaurantDtoCWProxyImpl(this._value);

  final SuggestRestaurantDto _value;

  @override
  SuggestRestaurantDto id(String id) => call(id: id);

  @override
  SuggestRestaurantDto slug(String slug) => call(slug: slug);

  @override
  SuggestRestaurantDto name(String name) => call(name: name);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SuggestRestaurantDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return SuggestRestaurantDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      slug: slug == const $CopyWithPlaceholder() || slug == null
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $SuggestRestaurantDtoCopyWith on SuggestRestaurantDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSuggestRestaurantDto.copyWith(...)` or `instanceOfSuggestRestaurantDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuggestRestaurantDtoCWProxy get copyWith =>
      _$SuggestRestaurantDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestRestaurantDto _$SuggestRestaurantDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SuggestRestaurantDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'slug', 'name']);
  final val = SuggestRestaurantDto(
    id: $checkedConvert('id', (v) => v as String),
    slug: $checkedConvert('slug', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$SuggestRestaurantDtoToJson(
  SuggestRestaurantDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
};
