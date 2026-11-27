// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_page_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantPageDtoCWProxy {
  RestaurantPageDto items(List<RestaurantCardDto> items);

  RestaurantPageDto nextCursor(num? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RestaurantPageDto call({List<RestaurantCardDto> items, num? nextCursor});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRestaurantPageDto.copyWith(...)` or call `instanceOfRestaurantPageDto.copyWith.fieldName(value)` for a single field.
class _$RestaurantPageDtoCWProxyImpl implements _$RestaurantPageDtoCWProxy {
  const _$RestaurantPageDtoCWProxyImpl(this._value);

  final RestaurantPageDto _value;

  @override
  RestaurantPageDto items(List<RestaurantCardDto> items) => call(items: items);

  @override
  RestaurantPageDto nextCursor(num? nextCursor) => call(nextCursor: nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RestaurantPageDto call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return RestaurantPageDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RestaurantCardDto>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as num?,
    );
  }
}

extension $RestaurantPageDtoCopyWith on RestaurantPageDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRestaurantPageDto.copyWith(...)` or `instanceOfRestaurantPageDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantPageDtoCWProxy get copyWith =>
      _$RestaurantPageDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantPageDto _$RestaurantPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RestaurantPageDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = RestaurantPageDto(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => RestaurantCardDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$RestaurantPageDtoToJson(RestaurantPageDto instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': ?instance.nextCursor,
    };
