// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_line_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReorderLineDtoCWProxy {
  ReorderLineDto menuItemId(String menuItemId);

  ReorderLineDto name(String name);

  ReorderLineDto price(num price);

  ReorderLineDto quantity(num quantity);

  ReorderLineDto note(String? note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReorderLineDto call({
    String menuItemId,
    String name,
    num price,
    num quantity,
    String? note,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReorderLineDto.copyWith(...)` or call `instanceOfReorderLineDto.copyWith.fieldName(value)` for a single field.
class _$ReorderLineDtoCWProxyImpl implements _$ReorderLineDtoCWProxy {
  const _$ReorderLineDtoCWProxyImpl(this._value);

  final ReorderLineDto _value;

  @override
  ReorderLineDto menuItemId(String menuItemId) => call(menuItemId: menuItemId);

  @override
  ReorderLineDto name(String name) => call(name: name);

  @override
  ReorderLineDto price(num price) => call(price: price);

  @override
  ReorderLineDto quantity(num quantity) => call(quantity: quantity);

  @override
  ReorderLineDto note(String? note) => call(note: note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReorderLineDto call({
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return ReorderLineDto(
      menuItemId:
          menuItemId == const $CopyWithPlaceholder() || menuItemId == null
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      price: price == const $CopyWithPlaceholder() || price == null
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $ReorderLineDtoCopyWith on ReorderLineDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReorderLineDto.copyWith(...)` or `instanceOfReorderLineDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReorderLineDtoCWProxy get copyWith => _$ReorderLineDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReorderLineDto _$ReorderLineDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReorderLineDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['menuItemId', 'name', 'price', 'quantity'],
      );
      final val = ReorderLineDto(
        menuItemId: $checkedConvert('menuItemId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        price: $checkedConvert('price', (v) => v as num),
        quantity: $checkedConvert('quantity', (v) => v as num),
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReorderLineDtoToJson(ReorderLineDto instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'note': ?instance.note,
    };
