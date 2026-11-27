// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_draft_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReorderDraftDtoCWProxy {
  ReorderDraftDto restaurant(BookingRestaurantDto restaurant);

  ReorderDraftDto partySize(num partySize);

  ReorderDraftDto serveStyle(ServeStyle serveStyle);

  ReorderDraftDto items(List<ReorderLineDto> items);

  ReorderDraftDto unavailable(List<UnavailableLineDto> unavailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderDraftDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderDraftDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReorderDraftDto call({
    BookingRestaurantDto restaurant,
    num partySize,
    ServeStyle serveStyle,
    List<ReorderLineDto> items,
    List<UnavailableLineDto> unavailable,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReorderDraftDto.copyWith(...)` or call `instanceOfReorderDraftDto.copyWith.fieldName(value)` for a single field.
class _$ReorderDraftDtoCWProxyImpl implements _$ReorderDraftDtoCWProxy {
  const _$ReorderDraftDtoCWProxyImpl(this._value);

  final ReorderDraftDto _value;

  @override
  ReorderDraftDto restaurant(BookingRestaurantDto restaurant) =>
      call(restaurant: restaurant);

  @override
  ReorderDraftDto partySize(num partySize) => call(partySize: partySize);

  @override
  ReorderDraftDto serveStyle(ServeStyle serveStyle) =>
      call(serveStyle: serveStyle);

  @override
  ReorderDraftDto items(List<ReorderLineDto> items) => call(items: items);

  @override
  ReorderDraftDto unavailable(List<UnavailableLineDto> unavailable) =>
      call(unavailable: unavailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderDraftDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderDraftDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReorderDraftDto call({
    Object? restaurant = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? serveStyle = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? unavailable = const $CopyWithPlaceholder(),
  }) {
    return ReorderDraftDto(
      restaurant:
          restaurant == const $CopyWithPlaceholder() || restaurant == null
          ? _value.restaurant
          // ignore: cast_nullable_to_non_nullable
          : restaurant as BookingRestaurantDto,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      serveStyle:
          serveStyle == const $CopyWithPlaceholder() || serveStyle == null
          ? _value.serveStyle
          // ignore: cast_nullable_to_non_nullable
          : serveStyle as ServeStyle,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ReorderLineDto>,
      unavailable:
          unavailable == const $CopyWithPlaceholder() || unavailable == null
          ? _value.unavailable
          // ignore: cast_nullable_to_non_nullable
          : unavailable as List<UnavailableLineDto>,
    );
  }
}

extension $ReorderDraftDtoCopyWith on ReorderDraftDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReorderDraftDto.copyWith(...)` or `instanceOfReorderDraftDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReorderDraftDtoCWProxy get copyWith => _$ReorderDraftDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReorderDraftDto _$ReorderDraftDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReorderDraftDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'restaurant',
          'partySize',
          'serveStyle',
          'items',
          'unavailable',
        ],
      );
      final val = ReorderDraftDto(
        restaurant: $checkedConvert(
          'restaurant',
          (v) => BookingRestaurantDto.fromJson(v as Map<String, dynamic>),
        ),
        partySize: $checkedConvert('partySize', (v) => v as num),
        serveStyle: $checkedConvert(
          'serveStyle',
          (v) => $enumDecode(_$ServeStyleEnumMap, v),
        ),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => ReorderLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        unavailable: $checkedConvert(
          'unavailable',
          (v) => (v as List<dynamic>)
              .map(
                (e) => UnavailableLineDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReorderDraftDtoToJson(ReorderDraftDto instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant.toJson(),
      'partySize': instance.partySize,
      'serveStyle': _$ServeStyleEnumMap[instance.serveStyle]!,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'unavailable': instance.unavailable.map((e) => e.toJson()).toList(),
    };

const _$ServeStyleEnumMap = {
  ServeStyle.BY_COURSE: 'BY_COURSE',
  ServeStyle.ALL_TOGETHER: 'ALL_TOGETHER',
};
