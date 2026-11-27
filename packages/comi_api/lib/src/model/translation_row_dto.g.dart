// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_row_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TranslationRowDtoCWProxy {
  TranslationRowDto itemId(String itemId);

  TranslationRowDto sourceName(String sourceName);

  TranslationRowDto sourceDescription(String? sourceDescription);

  TranslationRowDto name(String? name);

  TranslationRowDto description(String? description);

  TranslationRowDto state(TranslationRowDtoStateEnum state);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TranslationRowDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TranslationRowDto(...).copyWith(id: 12, name: "My name")
  /// ```
  TranslationRowDto call({
    String itemId,
    String sourceName,
    String? sourceDescription,
    String? name,
    String? description,
    TranslationRowDtoStateEnum state,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTranslationRowDto.copyWith(...)` or call `instanceOfTranslationRowDto.copyWith.fieldName(value)` for a single field.
class _$TranslationRowDtoCWProxyImpl implements _$TranslationRowDtoCWProxy {
  const _$TranslationRowDtoCWProxyImpl(this._value);

  final TranslationRowDto _value;

  @override
  TranslationRowDto itemId(String itemId) => call(itemId: itemId);

  @override
  TranslationRowDto sourceName(String sourceName) =>
      call(sourceName: sourceName);

  @override
  TranslationRowDto sourceDescription(String? sourceDescription) =>
      call(sourceDescription: sourceDescription);

  @override
  TranslationRowDto name(String? name) => call(name: name);

  @override
  TranslationRowDto description(String? description) =>
      call(description: description);

  @override
  TranslationRowDto state(TranslationRowDtoStateEnum state) =>
      call(state: state);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TranslationRowDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TranslationRowDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  TranslationRowDto call({
    Object? itemId = const $CopyWithPlaceholder(),
    Object? sourceName = const $CopyWithPlaceholder(),
    Object? sourceDescription = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
  }) {
    return TranslationRowDto(
      itemId: itemId == const $CopyWithPlaceholder() || itemId == null
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      sourceName:
          sourceName == const $CopyWithPlaceholder() || sourceName == null
          ? _value.sourceName
          // ignore: cast_nullable_to_non_nullable
          : sourceName as String,
      sourceDescription: sourceDescription == const $CopyWithPlaceholder()
          ? _value.sourceDescription
          // ignore: cast_nullable_to_non_nullable
          : sourceDescription as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      state: state == const $CopyWithPlaceholder() || state == null
          ? _value.state
          // ignore: cast_nullable_to_non_nullable
          : state as TranslationRowDtoStateEnum,
    );
  }
}

extension $TranslationRowDtoCopyWith on TranslationRowDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTranslationRowDto.copyWith(...)` or `instanceOfTranslationRowDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TranslationRowDtoCWProxy get copyWith =>
      _$TranslationRowDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationRowDto _$TranslationRowDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TranslationRowDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['itemId', 'sourceName', 'state']);
      final val = TranslationRowDto(
        itemId: $checkedConvert('itemId', (v) => v as String),
        sourceName: $checkedConvert('sourceName', (v) => v as String),
        sourceDescription: $checkedConvert(
          'sourceDescription',
          (v) => v as String?,
        ),
        name: $checkedConvert('name', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        state: $checkedConvert(
          'state',
          (v) => $enumDecode(_$TranslationRowDtoStateEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TranslationRowDtoToJson(TranslationRowDto instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'sourceName': instance.sourceName,
      'sourceDescription': ?instance.sourceDescription,
      'name': ?instance.name,
      'description': ?instance.description,
      'state': _$TranslationRowDtoStateEnumEnumMap[instance.state]!,
    };

const _$TranslationRowDtoStateEnumEnumMap = {
  TranslationRowDtoStateEnum.none: 'none',
  TranslationRowDtoStateEnum.machine: 'machine',
  TranslationRowDtoStateEnum.human: 'human',
};
