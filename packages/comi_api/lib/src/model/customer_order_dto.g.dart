// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerOrderDtoCWProxy {
  CustomerOrderDto id(String id);

  CustomerOrderDto subtotal(num subtotal);

  CustomerOrderDto restaurantDiscount(num restaurantDiscount);

  CustomerOrderDto platformDiscount(num platformDiscount);

  CustomerOrderDto total(num total);

  CustomerOrderDto status(OrderStatus status);

  CustomerOrderDto items(List<BoardOrderItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CustomerOrderDto call({
    String id,
    num subtotal,
    num restaurantDiscount,
    num platformDiscount,
    num total,
    OrderStatus status,
    List<BoardOrderItemDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCustomerOrderDto.copyWith(...)` or call `instanceOfCustomerOrderDto.copyWith.fieldName(value)` for a single field.
class _$CustomerOrderDtoCWProxyImpl implements _$CustomerOrderDtoCWProxy {
  const _$CustomerOrderDtoCWProxyImpl(this._value);

  final CustomerOrderDto _value;

  @override
  CustomerOrderDto id(String id) => call(id: id);

  @override
  CustomerOrderDto subtotal(num subtotal) => call(subtotal: subtotal);

  @override
  CustomerOrderDto restaurantDiscount(num restaurantDiscount) =>
      call(restaurantDiscount: restaurantDiscount);

  @override
  CustomerOrderDto platformDiscount(num platformDiscount) =>
      call(platformDiscount: platformDiscount);

  @override
  CustomerOrderDto total(num total) => call(total: total);

  @override
  CustomerOrderDto status(OrderStatus status) => call(status: status);

  @override
  CustomerOrderDto items(List<BoardOrderItemDto> items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CustomerOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CustomerOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CustomerOrderDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? restaurantDiscount = const $CopyWithPlaceholder(),
    Object? platformDiscount = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return CustomerOrderDto(
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
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderStatus,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<BoardOrderItemDto>,
    );
  }
}

extension $CustomerOrderDtoCopyWith on CustomerOrderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCustomerOrderDto.copyWith(...)` or `instanceOfCustomerOrderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerOrderDtoCWProxy get copyWith => _$CustomerOrderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrderDto _$CustomerOrderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CustomerOrderDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'subtotal',
          'restaurantDiscount',
          'platformDiscount',
          'total',
          'status',
          'items',
        ],
      );
      final val = CustomerOrderDto(
        id: $checkedConvert('id', (v) => v as String),
        subtotal: $checkedConvert('subtotal', (v) => v as num),
        restaurantDiscount: $checkedConvert(
          'restaurantDiscount',
          (v) => v as num,
        ),
        platformDiscount: $checkedConvert('platformDiscount', (v) => v as num),
        total: $checkedConvert('total', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$OrderStatusEnumMap, v),
        ),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => BoardOrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CustomerOrderDtoToJson(CustomerOrderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subtotal': instance.subtotal,
      'restaurantDiscount': instance.restaurantDiscount,
      'platformDiscount': instance.platformDiscount,
      'total': instance.total,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.DRAFT: 'DRAFT',
  OrderStatus.PLACED: 'PLACED',
  OrderStatus.IN_KITCHEN: 'IN_KITCHEN',
  OrderStatus.SERVED: 'SERVED',
  OrderStatus.CANCELLED: 'CANCELLED',
};
