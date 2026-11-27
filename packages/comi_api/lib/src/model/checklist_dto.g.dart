// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChecklistDtoCWProxy {
  ChecklistDto complete(bool complete);

  ChecklistDto missing(List<String> missing);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ChecklistDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChecklistDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ChecklistDto call({bool complete, List<String> missing});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChecklistDto.copyWith(...)` or call `instanceOfChecklistDto.copyWith.fieldName(value)` for a single field.
class _$ChecklistDtoCWProxyImpl implements _$ChecklistDtoCWProxy {
  const _$ChecklistDtoCWProxyImpl(this._value);

  final ChecklistDto _value;

  @override
  ChecklistDto complete(bool complete) => call(complete: complete);

  @override
  ChecklistDto missing(List<String> missing) => call(missing: missing);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ChecklistDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChecklistDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ChecklistDto call({
    Object? complete = const $CopyWithPlaceholder(),
    Object? missing = const $CopyWithPlaceholder(),
  }) {
    return ChecklistDto(
      complete: complete == const $CopyWithPlaceholder() || complete == null
          ? _value.complete
          // ignore: cast_nullable_to_non_nullable
          : complete as bool,
      missing: missing == const $CopyWithPlaceholder() || missing == null
          ? _value.missing
          // ignore: cast_nullable_to_non_nullable
          : missing as List<String>,
    );
  }
}

extension $ChecklistDtoCopyWith on ChecklistDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChecklistDto.copyWith(...)` or `instanceOfChecklistDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChecklistDtoCWProxy get copyWith => _$ChecklistDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChecklistDto _$ChecklistDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChecklistDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['complete', 'missing']);
      final val = ChecklistDto(
        complete: $checkedConvert('complete', (v) => v as bool),
        missing: $checkedConvert(
          'missing',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChecklistDtoToJson(ChecklistDto instance) =>
    <String, dynamic>{
      'complete': instance.complete,
      'missing': instance.missing,
    };
