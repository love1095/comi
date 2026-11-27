// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_split_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SaveSplitDtoCWProxy {
  SaveSplitDto mode(SplitMode mode);

  SaveSplitDto people(num? people);

  SaveSplitDto amounts(Map<String, int>? amounts);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SaveSplitDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SaveSplitDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SaveSplitDto call({SplitMode mode, num? people, Map<String, int>? amounts});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSaveSplitDto.copyWith(...)` or call `instanceOfSaveSplitDto.copyWith.fieldName(value)` for a single field.
class _$SaveSplitDtoCWProxyImpl implements _$SaveSplitDtoCWProxy {
  const _$SaveSplitDtoCWProxyImpl(this._value);

  final SaveSplitDto _value;

  @override
  SaveSplitDto mode(SplitMode mode) => call(mode: mode);

  @override
  SaveSplitDto people(num? people) => call(people: people);

  @override
  SaveSplitDto amounts(Map<String, int>? amounts) => call(amounts: amounts);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SaveSplitDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SaveSplitDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SaveSplitDto call({
    Object? mode = const $CopyWithPlaceholder(),
    Object? people = const $CopyWithPlaceholder(),
    Object? amounts = const $CopyWithPlaceholder(),
  }) {
    return SaveSplitDto(
      mode: mode == const $CopyWithPlaceholder() || mode == null
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as SplitMode,
      people: people == const $CopyWithPlaceholder()
          ? _value.people
          // ignore: cast_nullable_to_non_nullable
          : people as num?,
      amounts: amounts == const $CopyWithPlaceholder()
          ? _value.amounts
          // ignore: cast_nullable_to_non_nullable
          : amounts as Map<String, int>?,
    );
  }
}

extension $SaveSplitDtoCopyWith on SaveSplitDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSaveSplitDto.copyWith(...)` or `instanceOfSaveSplitDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SaveSplitDtoCWProxy get copyWith => _$SaveSplitDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveSplitDto _$SaveSplitDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SaveSplitDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['mode']);
      final val = SaveSplitDto(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecode(_$SplitModeEnumMap, v),
        ),
        people: $checkedConvert('people', (v) => v as num?),
        amounts: $checkedConvert(
          'amounts',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SaveSplitDtoToJson(SaveSplitDto instance) =>
    <String, dynamic>{
      'mode': _$SplitModeEnumMap[instance.mode]!,
      'people': ?instance.people,
      'amounts': ?instance.amounts,
    };

const _$SplitModeEnumMap = {
  SplitMode.EQUAL: 'EQUAL',
  SplitMode.BY_ITEMS: 'BY_ITEMS',
  SplitMode.CUSTOM: 'CUSTOM',
};
