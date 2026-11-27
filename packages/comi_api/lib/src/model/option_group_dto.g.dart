// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_group_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OptionGroupDtoCWProxy {
  OptionGroupDto name(String name);

  OptionGroupDto minSelect(num? minSelect);

  OptionGroupDto maxSelect(num? maxSelect);

  OptionGroupDto options(List<OptionDto> options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OptionGroupDto call({
    String name,
    num? minSelect,
    num? maxSelect,
    List<OptionDto> options,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOptionGroupDto.copyWith(...)` or call `instanceOfOptionGroupDto.copyWith.fieldName(value)` for a single field.
class _$OptionGroupDtoCWProxyImpl implements _$OptionGroupDtoCWProxy {
  const _$OptionGroupDtoCWProxyImpl(this._value);

  final OptionGroupDto _value;

  @override
  OptionGroupDto name(String name) => call(name: name);

  @override
  OptionGroupDto minSelect(num? minSelect) => call(minSelect: minSelect);

  @override
  OptionGroupDto maxSelect(num? maxSelect) => call(maxSelect: maxSelect);

  @override
  OptionGroupDto options(List<OptionDto> options) => call(options: options);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OptionGroupDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? minSelect = const $CopyWithPlaceholder(),
    Object? maxSelect = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
  }) {
    return OptionGroupDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      minSelect: minSelect == const $CopyWithPlaceholder()
          ? _value.minSelect
          // ignore: cast_nullable_to_non_nullable
          : minSelect as num?,
      maxSelect: maxSelect == const $CopyWithPlaceholder()
          ? _value.maxSelect
          // ignore: cast_nullable_to_non_nullable
          : maxSelect as num?,
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<OptionDto>,
    );
  }
}

extension $OptionGroupDtoCopyWith on OptionGroupDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOptionGroupDto.copyWith(...)` or `instanceOfOptionGroupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OptionGroupDtoCWProxy get copyWith => _$OptionGroupDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionGroupDto _$OptionGroupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OptionGroupDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name', 'options']);
      final val = OptionGroupDto(
        name: $checkedConvert('name', (v) => v as String),
        minSelect: $checkedConvert('minSelect', (v) => v as num?),
        maxSelect: $checkedConvert('maxSelect', (v) => v as num?),
        options: $checkedConvert(
          'options',
          (v) => (v as List<dynamic>)
              .map((e) => OptionDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OptionGroupDtoToJson(OptionGroupDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'minSelect': ?instance.minSelect,
      'maxSelect': ?instance.maxSelect,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };
