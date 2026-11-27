// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_group_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OptionGroupResponseDtoCWProxy {
  OptionGroupResponseDto id(String id);

  OptionGroupResponseDto name(String name);

  OptionGroupResponseDto minSelect(num minSelect);

  OptionGroupResponseDto maxSelect(num maxSelect);

  OptionGroupResponseDto sortOrder(num sortOrder);

  OptionGroupResponseDto options(List<MenuOptionResponseDto> options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionGroupResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionGroupResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OptionGroupResponseDto call({
    String id,
    String name,
    num minSelect,
    num maxSelect,
    num sortOrder,
    List<MenuOptionResponseDto> options,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOptionGroupResponseDto.copyWith(...)` or call `instanceOfOptionGroupResponseDto.copyWith.fieldName(value)` for a single field.
class _$OptionGroupResponseDtoCWProxyImpl
    implements _$OptionGroupResponseDtoCWProxy {
  const _$OptionGroupResponseDtoCWProxyImpl(this._value);

  final OptionGroupResponseDto _value;

  @override
  OptionGroupResponseDto id(String id) => call(id: id);

  @override
  OptionGroupResponseDto name(String name) => call(name: name);

  @override
  OptionGroupResponseDto minSelect(num minSelect) => call(minSelect: minSelect);

  @override
  OptionGroupResponseDto maxSelect(num maxSelect) => call(maxSelect: maxSelect);

  @override
  OptionGroupResponseDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  @override
  OptionGroupResponseDto options(List<MenuOptionResponseDto> options) =>
      call(options: options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionGroupResponseDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionGroupResponseDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OptionGroupResponseDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? minSelect = const $CopyWithPlaceholder(),
    Object? maxSelect = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
  }) {
    return OptionGroupResponseDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      minSelect: minSelect == const $CopyWithPlaceholder() || minSelect == null
          ? _value.minSelect
          // ignore: cast_nullable_to_non_nullable
          : minSelect as num,
      maxSelect: maxSelect == const $CopyWithPlaceholder() || maxSelect == null
          ? _value.maxSelect
          // ignore: cast_nullable_to_non_nullable
          : maxSelect as num,
      sortOrder: sortOrder == const $CopyWithPlaceholder() || sortOrder == null
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num,
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<MenuOptionResponseDto>,
    );
  }
}

extension $OptionGroupResponseDtoCopyWith on OptionGroupResponseDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOptionGroupResponseDto.copyWith(...)` or `instanceOfOptionGroupResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OptionGroupResponseDtoCWProxy get copyWith =>
      _$OptionGroupResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionGroupResponseDto _$OptionGroupResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OptionGroupResponseDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'minSelect',
      'maxSelect',
      'sortOrder',
      'options',
    ],
  );
  final val = OptionGroupResponseDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    minSelect: $checkedConvert('minSelect', (v) => v as num),
    maxSelect: $checkedConvert('maxSelect', (v) => v as num),
    sortOrder: $checkedConvert('sortOrder', (v) => v as num),
    options: $checkedConvert(
      'options',
      (v) => (v as List<dynamic>)
          .map((e) => MenuOptionResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$OptionGroupResponseDtoToJson(
  OptionGroupResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minSelect': instance.minSelect,
  'maxSelect': instance.maxSelect,
  'sortOrder': instance.sortOrder,
  'options': instance.options.map((e) => e.toJson()).toList(),
};
