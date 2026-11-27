// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_dish_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuggestDishDtoCWProxy {
  SuggestDishDto id(String id);

  SuggestDishDto name(String name);

  SuggestDishDto price(num price);

  SuggestDishDto restaurantId(String restaurantId);

  SuggestDishDto restaurantSlug(String restaurantSlug);

  SuggestDishDto restaurantName(String restaurantName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestDishDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestDishDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SuggestDishDto call({
    String id,
    String name,
    num price,
    String restaurantId,
    String restaurantSlug,
    String restaurantName,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSuggestDishDto.copyWith(...)` or call `instanceOfSuggestDishDto.copyWith.fieldName(value)` for a single field.
class _$SuggestDishDtoCWProxyImpl implements _$SuggestDishDtoCWProxy {
  const _$SuggestDishDtoCWProxyImpl(this._value);

  final SuggestDishDto _value;

  @override
  SuggestDishDto id(String id) => call(id: id);

  @override
  SuggestDishDto name(String name) => call(name: name);

  @override
  SuggestDishDto price(num price) => call(price: price);

  @override
  SuggestDishDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  SuggestDishDto restaurantSlug(String restaurantSlug) =>
      call(restaurantSlug: restaurantSlug);

  @override
  SuggestDishDto restaurantName(String restaurantName) =>
      call(restaurantName: restaurantName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SuggestDishDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SuggestDishDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SuggestDishDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? restaurantSlug = const $CopyWithPlaceholder(),
    Object? restaurantName = const $CopyWithPlaceholder(),
  }) {
    return SuggestDishDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      price: price == const $CopyWithPlaceholder() || price == null
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      restaurantSlug:
          restaurantSlug == const $CopyWithPlaceholder() ||
              restaurantSlug == null
          ? _value.restaurantSlug
          // ignore: cast_nullable_to_non_nullable
          : restaurantSlug as String,
      restaurantName:
          restaurantName == const $CopyWithPlaceholder() ||
              restaurantName == null
          ? _value.restaurantName
          // ignore: cast_nullable_to_non_nullable
          : restaurantName as String,
    );
  }
}

extension $SuggestDishDtoCopyWith on SuggestDishDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSuggestDishDto.copyWith(...)` or `instanceOfSuggestDishDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuggestDishDtoCWProxy get copyWith => _$SuggestDishDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestDishDto _$SuggestDishDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SuggestDishDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'name',
          'price',
          'restaurantId',
          'restaurantSlug',
          'restaurantName',
        ],
      );
      final val = SuggestDishDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        price: $checkedConvert('price', (v) => v as num),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        restaurantSlug: $checkedConvert('restaurantSlug', (v) => v as String),
        restaurantName: $checkedConvert('restaurantName', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SuggestDishDtoToJson(SuggestDishDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'restaurantId': instance.restaurantId,
      'restaurantSlug': instance.restaurantSlug,
      'restaurantName': instance.restaurantName,
    };
