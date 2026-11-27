// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartLineDtoCWProxy {
  CartLineDto menuItemId(String menuItemId);

  CartLineDto quantity(num quantity);

  CartLineDto optionIds(List<String>? optionIds);

  CartLineDto note(String? note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CartLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CartLineDto call({
    String menuItemId,
    num quantity,
    List<String>? optionIds,
    String? note,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCartLineDto.copyWith(...)` or call `instanceOfCartLineDto.copyWith.fieldName(value)` for a single field.
class _$CartLineDtoCWProxyImpl implements _$CartLineDtoCWProxy {
  const _$CartLineDtoCWProxyImpl(this._value);

  final CartLineDto _value;

  @override
  CartLineDto menuItemId(String menuItemId) => call(menuItemId: menuItemId);

  @override
  CartLineDto quantity(num quantity) => call(quantity: quantity);

  @override
  CartLineDto optionIds(List<String>? optionIds) => call(optionIds: optionIds);

  @override
  CartLineDto note(String? note) => call(note: note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CartLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CartLineDto call({
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? optionIds = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return CartLineDto(
      menuItemId:
          menuItemId == const $CopyWithPlaceholder() || menuItemId == null
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      optionIds: optionIds == const $CopyWithPlaceholder()
          ? _value.optionIds
          // ignore: cast_nullable_to_non_nullable
          : optionIds as List<String>?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $CartLineDtoCopyWith on CartLineDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCartLineDto.copyWith(...)` or `instanceOfCartLineDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartLineDtoCWProxy get copyWith => _$CartLineDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartLineDto _$CartLineDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CartLineDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['menuItemId', 'quantity']);
      final val = CartLineDto(
        menuItemId: $checkedConvert('menuItemId', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => v as num),
        optionIds: $checkedConvert(
          'optionIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CartLineDtoToJson(CartLineDto instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'optionIds': ?instance.optionIds,
      'note': ?instance.note,
    };
