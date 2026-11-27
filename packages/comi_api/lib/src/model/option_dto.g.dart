// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OptionDtoCWProxy {
  OptionDto name(String name);

  OptionDto priceDelta(num? priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OptionDto call({String name, num? priceDelta});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOptionDto.copyWith(...)` or call `instanceOfOptionDto.copyWith.fieldName(value)` for a single field.
class _$OptionDtoCWProxyImpl implements _$OptionDtoCWProxy {
  const _$OptionDtoCWProxyImpl(this._value);

  final OptionDto _value;

  @override
  OptionDto name(String name) => call(name: name);

  @override
  OptionDto priceDelta(num? priceDelta) => call(priceDelta: priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OptionDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? priceDelta = const $CopyWithPlaceholder(),
  }) {
    return OptionDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      priceDelta: priceDelta == const $CopyWithPlaceholder()
          ? _value.priceDelta
          // ignore: cast_nullable_to_non_nullable
          : priceDelta as num?,
    );
  }
}

extension $OptionDtoCopyWith on OptionDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOptionDto.copyWith(...)` or `instanceOfOptionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OptionDtoCWProxy get copyWith => _$OptionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionDto _$OptionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OptionDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = OptionDto(
        name: $checkedConvert('name', (v) => v as String),
        priceDelta: $checkedConvert('priceDelta', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$OptionDtoToJson(OptionDto instance) => <String, dynamic>{
  'name': instance.name,
  'priceDelta': ?instance.priceDelta,
};
