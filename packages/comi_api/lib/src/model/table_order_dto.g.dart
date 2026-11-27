// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_order_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableOrderDtoCWProxy {
  TableOrderDto items(List<CartLineDto> items);

  TableOrderDto ageConfirmed(bool? ageConfirmed);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TableOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  TableOrderDto call({List<CartLineDto> items, bool? ageConfirmed});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTableOrderDto.copyWith(...)` or call `instanceOfTableOrderDto.copyWith.fieldName(value)` for a single field.
class _$TableOrderDtoCWProxyImpl implements _$TableOrderDtoCWProxy {
  const _$TableOrderDtoCWProxyImpl(this._value);

  final TableOrderDto _value;

  @override
  TableOrderDto items(List<CartLineDto> items) => call(items: items);

  @override
  TableOrderDto ageConfirmed(bool? ageConfirmed) =>
      call(ageConfirmed: ageConfirmed);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TableOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  TableOrderDto call({
    Object? items = const $CopyWithPlaceholder(),
    Object? ageConfirmed = const $CopyWithPlaceholder(),
  }) {
    return TableOrderDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineDto>,
      ageConfirmed: ageConfirmed == const $CopyWithPlaceholder()
          ? _value.ageConfirmed
          // ignore: cast_nullable_to_non_nullable
          : ageConfirmed as bool?,
    );
  }
}

extension $TableOrderDtoCopyWith on TableOrderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTableOrderDto.copyWith(...)` or `instanceOfTableOrderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableOrderDtoCWProxy get copyWith => _$TableOrderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableOrderDto _$TableOrderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TableOrderDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = TableOrderDto(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CartLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        ageConfirmed: $checkedConvert('ageConfirmed', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$TableOrderDtoToJson(TableOrderDto instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'ageConfirmed': ?instance.ageConfirmed,
    };
