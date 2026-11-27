// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_check_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherCheckDtoCWProxy {
  VoucherCheckDto code(String code);

  VoucherCheckDto restaurantId(String restaurantId);

  VoucherCheckDto items(List<CartLineDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherCheckDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherCheckDto(...).copyWith(id: 12, name: "My name")
  /// ```
  VoucherCheckDto call({
    String code,
    String restaurantId,
    List<CartLineDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVoucherCheckDto.copyWith(...)` or call `instanceOfVoucherCheckDto.copyWith.fieldName(value)` for a single field.
class _$VoucherCheckDtoCWProxyImpl implements _$VoucherCheckDtoCWProxy {
  const _$VoucherCheckDtoCWProxyImpl(this._value);

  final VoucherCheckDto _value;

  @override
  VoucherCheckDto code(String code) => call(code: code);

  @override
  VoucherCheckDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  VoucherCheckDto items(List<CartLineDto> items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherCheckDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherCheckDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  VoucherCheckDto call({
    Object? code = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return VoucherCheckDto(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineDto>,
    );
  }
}

extension $VoucherCheckDtoCopyWith on VoucherCheckDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVoucherCheckDto.copyWith(...)` or `instanceOfVoucherCheckDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherCheckDtoCWProxy get copyWith => _$VoucherCheckDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCheckDto _$VoucherCheckDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VoucherCheckDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'restaurantId', 'items']);
      final val = VoucherCheckDto(
        code: $checkedConvert('code', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CartLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$VoucherCheckDtoToJson(VoucherCheckDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'restaurantId': instance.restaurantId,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
