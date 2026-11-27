// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_translation_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuTranslationDtoCWProxy {
  MenuTranslationDto locale(String locale);

  MenuTranslationDto name(String name);

  MenuTranslationDto description(String? description);

  MenuTranslationDto isMachine(bool isMachine);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuTranslationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuTranslationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuTranslationDto call({
    String locale,
    String name,
    String? description,
    bool isMachine,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuTranslationDto.copyWith(...)` or call `instanceOfMenuTranslationDto.copyWith.fieldName(value)` for a single field.
class _$MenuTranslationDtoCWProxyImpl implements _$MenuTranslationDtoCWProxy {
  const _$MenuTranslationDtoCWProxyImpl(this._value);

  final MenuTranslationDto _value;

  @override
  MenuTranslationDto locale(String locale) => call(locale: locale);

  @override
  MenuTranslationDto name(String name) => call(name: name);

  @override
  MenuTranslationDto description(String? description) =>
      call(description: description);

  @override
  MenuTranslationDto isMachine(bool isMachine) => call(isMachine: isMachine);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuTranslationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuTranslationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MenuTranslationDto call({
    Object? locale = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isMachine = const $CopyWithPlaceholder(),
  }) {
    return MenuTranslationDto(
      locale: locale == const $CopyWithPlaceholder() || locale == null
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isMachine: isMachine == const $CopyWithPlaceholder() || isMachine == null
          ? _value.isMachine
          // ignore: cast_nullable_to_non_nullable
          : isMachine as bool,
    );
  }
}

extension $MenuTranslationDtoCopyWith on MenuTranslationDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuTranslationDto.copyWith(...)` or `instanceOfMenuTranslationDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuTranslationDtoCWProxy get copyWith =>
      _$MenuTranslationDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuTranslationDto _$MenuTranslationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MenuTranslationDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['locale', 'name', 'isMachine']);
      final val = MenuTranslationDto(
        locale: $checkedConvert('locale', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        isMachine: $checkedConvert('isMachine', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$MenuTranslationDtoToJson(MenuTranslationDto instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'name': instance.name,
      'description': ?instance.description,
      'isMachine': instance.isMachine,
    };
