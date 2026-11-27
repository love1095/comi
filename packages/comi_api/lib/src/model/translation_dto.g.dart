// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TranslationDtoCWProxy {
  TranslationDto name(String name);

  TranslationDto description(String? description);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TranslationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TranslationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  TranslationDto call({String name, String? description});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTranslationDto.copyWith(...)` or call `instanceOfTranslationDto.copyWith.fieldName(value)` for a single field.
class _$TranslationDtoCWProxyImpl implements _$TranslationDtoCWProxy {
  const _$TranslationDtoCWProxyImpl(this._value);

  final TranslationDto _value;

  @override
  TranslationDto name(String name) => call(name: name);

  @override
  TranslationDto description(String? description) =>
      call(description: description);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TranslationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TranslationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  TranslationDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return TranslationDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
    );
  }
}

extension $TranslationDtoCopyWith on TranslationDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTranslationDto.copyWith(...)` or `instanceOfTranslationDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TranslationDtoCWProxy get copyWith => _$TranslationDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationDto _$TranslationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TranslationDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = TranslationDto(
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TranslationDtoToJson(TranslationDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': ?instance.description,
    };
