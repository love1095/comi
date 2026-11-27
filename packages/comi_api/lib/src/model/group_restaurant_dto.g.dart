// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_restaurant_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupRestaurantDtoCWProxy {
  GroupRestaurantDto id(String id);

  GroupRestaurantDto slug(String slug);

  GroupRestaurantDto name(String name);

  GroupRestaurantDto address(String address);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupRestaurantDto call({
    String id,
    String slug,
    String name,
    String address,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupRestaurantDto.copyWith(...)` or call `instanceOfGroupRestaurantDto.copyWith.fieldName(value)` for a single field.
class _$GroupRestaurantDtoCWProxyImpl implements _$GroupRestaurantDtoCWProxy {
  const _$GroupRestaurantDtoCWProxyImpl(this._value);

  final GroupRestaurantDto _value;

  @override
  GroupRestaurantDto id(String id) => call(id: id);

  @override
  GroupRestaurantDto slug(String slug) => call(slug: slug);

  @override
  GroupRestaurantDto name(String name) => call(name: name);

  @override
  GroupRestaurantDto address(String address) => call(address: address);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupRestaurantDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupRestaurantDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupRestaurantDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
  }) {
    return GroupRestaurantDto(
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
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
    );
  }
}

extension $GroupRestaurantDtoCopyWith on GroupRestaurantDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupRestaurantDto.copyWith(...)` or `instanceOfGroupRestaurantDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupRestaurantDtoCWProxy get copyWith =>
      _$GroupRestaurantDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupRestaurantDto _$GroupRestaurantDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupRestaurantDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'slug', 'name', 'address']);
      final val = GroupRestaurantDto(
        id: $checkedConvert('id', (v) => v as String),
        slug: $checkedConvert('slug', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GroupRestaurantDtoToJson(GroupRestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'address': instance.address,
    };
