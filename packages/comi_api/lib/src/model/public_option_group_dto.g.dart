// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_option_group_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicOptionGroupDtoCWProxy {
  PublicOptionGroupDto id(String id);

  PublicOptionGroupDto name(String name);

  PublicOptionGroupDto minSelect(num minSelect);

  PublicOptionGroupDto maxSelect(num maxSelect);

  PublicOptionGroupDto options(List<PublicOptionDto> options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicOptionGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicOptionGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PublicOptionGroupDto call({
    String id,
    String name,
    num minSelect,
    num maxSelect,
    List<PublicOptionDto> options,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPublicOptionGroupDto.copyWith(...)` or call `instanceOfPublicOptionGroupDto.copyWith.fieldName(value)` for a single field.
class _$PublicOptionGroupDtoCWProxyImpl
    implements _$PublicOptionGroupDtoCWProxy {
  const _$PublicOptionGroupDtoCWProxyImpl(this._value);

  final PublicOptionGroupDto _value;

  @override
  PublicOptionGroupDto id(String id) => call(id: id);

  @override
  PublicOptionGroupDto name(String name) => call(name: name);

  @override
  PublicOptionGroupDto minSelect(num minSelect) => call(minSelect: minSelect);

  @override
  PublicOptionGroupDto maxSelect(num maxSelect) => call(maxSelect: maxSelect);

  @override
  PublicOptionGroupDto options(List<PublicOptionDto> options) =>
      call(options: options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicOptionGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicOptionGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PublicOptionGroupDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? minSelect = const $CopyWithPlaceholder(),
    Object? maxSelect = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
  }) {
    return PublicOptionGroupDto(
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
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<PublicOptionDto>,
    );
  }
}

extension $PublicOptionGroupDtoCopyWith on PublicOptionGroupDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPublicOptionGroupDto.copyWith(...)` or `instanceOfPublicOptionGroupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicOptionGroupDtoCWProxy get copyWith =>
      _$PublicOptionGroupDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicOptionGroupDto _$PublicOptionGroupDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PublicOptionGroupDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'minSelect', 'maxSelect', 'options'],
  );
  final val = PublicOptionGroupDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    minSelect: $checkedConvert('minSelect', (v) => v as num),
    maxSelect: $checkedConvert('maxSelect', (v) => v as num),
    options: $checkedConvert(
      'options',
      (v) => (v as List<dynamic>)
          .map((e) => PublicOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicOptionGroupDtoToJson(
  PublicOptionGroupDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minSelect': instance.minSelect,
  'maxSelect': instance.maxSelect,
  'options': instance.options.map((e) => e.toJson()).toList(),
};
