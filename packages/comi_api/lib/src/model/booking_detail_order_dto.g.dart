// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_order_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingDetailOrderDtoCWProxy {
  BookingDetailOrderDto total(num total);

  BookingDetailOrderDto id(String id);

  BookingDetailOrderDto subtotal(num subtotal);

  BookingDetailOrderDto restaurantDiscount(num restaurantDiscount);

  BookingDetailOrderDto platformDiscount(num platformDiscount);

  BookingDetailOrderDto items(List<BoardOrderItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingDetailOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingDetailOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingDetailOrderDto call({
    num total,
    String id,
    num subtotal,
    num restaurantDiscount,
    num platformDiscount,
    List<BoardOrderItemDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingDetailOrderDto.copyWith(...)` or call `instanceOfBookingDetailOrderDto.copyWith.fieldName(value)` for a single field.
class _$BookingDetailOrderDtoCWProxyImpl
    implements _$BookingDetailOrderDtoCWProxy {
  const _$BookingDetailOrderDtoCWProxyImpl(this._value);

  final BookingDetailOrderDto _value;

  @override
  BookingDetailOrderDto total(num total) => call(total: total);

  @override
  BookingDetailOrderDto id(String id) => call(id: id);

  @override
  BookingDetailOrderDto subtotal(num subtotal) => call(subtotal: subtotal);

  @override
  BookingDetailOrderDto restaurantDiscount(num restaurantDiscount) =>
      call(restaurantDiscount: restaurantDiscount);

  @override
  BookingDetailOrderDto platformDiscount(num platformDiscount) =>
      call(platformDiscount: platformDiscount);

  @override
  BookingDetailOrderDto items(List<BoardOrderItemDto> items) =>
      call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingDetailOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingDetailOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingDetailOrderDto call({
    Object? total = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? restaurantDiscount = const $CopyWithPlaceholder(),
    Object? platformDiscount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return BookingDetailOrderDto(
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      subtotal: subtotal == const $CopyWithPlaceholder() || subtotal == null
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as num,
      restaurantDiscount:
          restaurantDiscount == const $CopyWithPlaceholder() ||
              restaurantDiscount == null
          ? _value.restaurantDiscount
          // ignore: cast_nullable_to_non_nullable
          : restaurantDiscount as num,
      platformDiscount:
          platformDiscount == const $CopyWithPlaceholder() ||
              platformDiscount == null
          ? _value.platformDiscount
          // ignore: cast_nullable_to_non_nullable
          : platformDiscount as num,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<BoardOrderItemDto>,
    );
  }
}

extension $BookingDetailOrderDtoCopyWith on BookingDetailOrderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingDetailOrderDto.copyWith(...)` or `instanceOfBookingDetailOrderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingDetailOrderDtoCWProxy get copyWith =>
      _$BookingDetailOrderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailOrderDto _$BookingDetailOrderDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BookingDetailOrderDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'total',
      'id',
      'subtotal',
      'restaurantDiscount',
      'platformDiscount',
      'items',
    ],
  );
  final val = BookingDetailOrderDto(
    total: $checkedConvert('total', (v) => v as num),
    id: $checkedConvert('id', (v) => v as String),
    subtotal: $checkedConvert('subtotal', (v) => v as num),
    restaurantDiscount: $checkedConvert('restaurantDiscount', (v) => v as num),
    platformDiscount: $checkedConvert('platformDiscount', (v) => v as num),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => BoardOrderItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$BookingDetailOrderDtoToJson(
  BookingDetailOrderDto instance,
) => <String, dynamic>{
  'total': instance.total,
  'id': instance.id,
  'subtotal': instance.subtotal,
  'restaurantDiscount': instance.restaurantDiscount,
  'platformDiscount': instance.platformDiscount,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
