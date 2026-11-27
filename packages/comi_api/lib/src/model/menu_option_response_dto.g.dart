// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_option_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuOptionResponseDtoCWProxy {
  MenuOptionResponseDto id(String id);

  MenuOptionResponseDto name(String name);

  MenuOptionResponseDto priceDelta(num priceDelta);

  MenuOptionResponseDto sortOrder(num sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuOptionResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuOptionResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuOptionResponseDto call({
    String id,
    String name,
    num priceDelta,
    num sortOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuOptionResponseDto.copyWith(...)` or call `instanceOfMenuOptionResponseDto.copyWith.fieldName(value)` for a single field.
class _$MenuOptionResponseDtoCWProxyImpl
    implements _$MenuOptionResponseDtoCWProxy {
  const _$MenuOptionResponseDtoCWProxyImpl(this._value);

  final MenuOptionResponseDto _value;

  @override
  MenuOptionResponseDto id(String id) => call(id: id);

  @override
  MenuOptionResponseDto name(String name) => call(name: name);

  @override
  MenuOptionResponseDto priceDelta(num priceDelta) =>
      call(priceDelta: priceDelta);

  @override
  MenuOptionResponseDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuOptionResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuOptionResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MenuOptionResponseDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? priceDelta = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return MenuOptionResponseDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      priceDelta:
          priceDelta == const $CopyWithPlaceholder() || priceDelta == null
          ? _value.priceDelta
          // ignore: cast_nullable_to_non_nullable
          : priceDelta as num,
      sortOrder: sortOrder == const $CopyWithPlaceholder() || sortOrder == null
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num,
    );
  }
}

extension $MenuOptionResponseDtoCopyWith on MenuOptionResponseDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuOptionResponseDto.copyWith(...)` or `instanceOfMenuOptionResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuOptionResponseDtoCWProxy get copyWith =>
      _$MenuOptionResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuOptionResponseDto _$MenuOptionResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MenuOptionResponseDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'priceDelta', 'sortOrder'],
  );
  final val = MenuOptionResponseDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    priceDelta: $checkedConvert('priceDelta', (v) => v as num),
    sortOrder: $checkedConvert('sortOrder', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MenuOptionResponseDtoToJson(
  MenuOptionResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'priceDelta': instance.priceDelta,
  'sortOrder': instance.sortOrder,
};
