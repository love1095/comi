// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuggestDtoCWProxy {
  SuggestDto restaurants(List<SuggestRestaurantDto> restaurants);

  SuggestDto dishes(List<SuggestDishDto> dishes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SuggestDto call({
    List<SuggestRestaurantDto> restaurants,
    List<SuggestDishDto> dishes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSuggestDto.copyWith(...)` or call `instanceOfSuggestDto.copyWith.fieldName(value)` for a single field.
class _$SuggestDtoCWProxyImpl implements _$SuggestDtoCWProxy {
  const _$SuggestDtoCWProxyImpl(this._value);

  final SuggestDto _value;

  @override
  SuggestDto restaurants(List<SuggestRestaurantDto> restaurants) =>
      call(restaurants: restaurants);

  @override
  SuggestDto dishes(List<SuggestDishDto> dishes) => call(dishes: dishes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SuggestDto call({
    Object? restaurants = const $CopyWithPlaceholder(),
    Object? dishes = const $CopyWithPlaceholder(),
  }) {
    return SuggestDto(
      restaurants:
          restaurants == const $CopyWithPlaceholder() || restaurants == null
          ? _value.restaurants
          // ignore: cast_nullable_to_non_nullable
          : restaurants as List<SuggestRestaurantDto>,
      dishes: dishes == const $CopyWithPlaceholder() || dishes == null
          ? _value.dishes
          // ignore: cast_nullable_to_non_nullable
          : dishes as List<SuggestDishDto>,
    );
  }
}

extension $SuggestDtoCopyWith on SuggestDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSuggestDto.copyWith(...)` or `instanceOfSuggestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuggestDtoCWProxy get copyWith => _$SuggestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestDto _$SuggestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SuggestDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['restaurants', 'dishes']);
      final val = SuggestDto(
        restaurants: $checkedConvert(
          'restaurants',
          (v) => (v as List<dynamic>)
              .map(
                (e) => SuggestRestaurantDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        dishes: $checkedConvert(
          'dishes',
          (v) => (v as List<dynamic>)
              .map((e) => SuggestDishDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SuggestDtoToJson(SuggestDto instance) =>
    <String, dynamic>{
      'restaurants': instance.restaurants.map((e) => e.toJson()).toList(),
      'dishes': instance.dishes.map((e) => e.toJson()).toList(),
    };
