// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FireResultDtoCWProxy {
  FireResultDto queued(num queued);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FireResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FireResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  FireResultDto call({num queued});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFireResultDto.copyWith(...)` or call `instanceOfFireResultDto.copyWith.fieldName(value)` for a single field.
class _$FireResultDtoCWProxyImpl implements _$FireResultDtoCWProxy {
  const _$FireResultDtoCWProxyImpl(this._value);

  final FireResultDto _value;

  @override
  FireResultDto queued(num queued) => call(queued: queued);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FireResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FireResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FireResultDto call({Object? queued = const $CopyWithPlaceholder()}) {
    return FireResultDto(
      queued: queued == const $CopyWithPlaceholder() || queued == null
          ? _value.queued
          // ignore: cast_nullable_to_non_nullable
          : queued as num,
    );
  }
}

extension $FireResultDtoCopyWith on FireResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFireResultDto.copyWith(...)` or `instanceOfFireResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FireResultDtoCWProxy get copyWith => _$FireResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireResultDto _$FireResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FireResultDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['queued']);
      final val = FireResultDto(
        queued: $checkedConvert('queued', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$FireResultDtoToJson(FireResultDto instance) =>
    <String, dynamic>{'queued': instance.queued};
