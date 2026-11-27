// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_order_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SavedOrderDtoCWProxy {
  SavedOrderDto restaurantId(String restaurantId);

  SavedOrderDto name(String? name);

  SavedOrderDto items(List<CartLineDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SavedOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SavedOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SavedOrderDto call({
    String restaurantId,
    String? name,
    List<CartLineDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSavedOrderDto.copyWith(...)` or call `instanceOfSavedOrderDto.copyWith.fieldName(value)` for a single field.
class _$SavedOrderDtoCWProxyImpl implements _$SavedOrderDtoCWProxy {
  const _$SavedOrderDtoCWProxyImpl(this._value);

  final SavedOrderDto _value;

  @override
  SavedOrderDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  SavedOrderDto name(String? name) => call(name: name);

  @override
  SavedOrderDto items(List<CartLineDto> items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SavedOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SavedOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SavedOrderDto call({
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return SavedOrderDto(
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineDto>,
    );
  }
}

extension $SavedOrderDtoCopyWith on SavedOrderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSavedOrderDto.copyWith(...)` or `instanceOfSavedOrderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SavedOrderDtoCWProxy get copyWith => _$SavedOrderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedOrderDto _$SavedOrderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SavedOrderDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['restaurantId', 'items']);
      final val = SavedOrderDto(
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String? ?? 'My usual'),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CartLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SavedOrderDtoToJson(SavedOrderDto instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'name': ?instance.name,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
