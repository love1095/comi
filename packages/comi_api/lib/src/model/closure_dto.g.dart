// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closure_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClosureDtoCWProxy {
  ClosureDto startsAt(String startsAt);

  ClosureDto endsAt(String endsAt);

  ClosureDto reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ClosureDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ClosureDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ClosureDto call({String startsAt, String endsAt, String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfClosureDto.copyWith(...)` or call `instanceOfClosureDto.copyWith.fieldName(value)` for a single field.
class _$ClosureDtoCWProxyImpl implements _$ClosureDtoCWProxy {
  const _$ClosureDtoCWProxyImpl(this._value);

  final ClosureDto _value;

  @override
  ClosureDto startsAt(String startsAt) => call(startsAt: startsAt);

  @override
  ClosureDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  ClosureDto reason(String? reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ClosureDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ClosureDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ClosureDto call({
    Object? startsAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return ClosureDto(
      startsAt: startsAt == const $CopyWithPlaceholder() || startsAt == null
          ? _value.startsAt
          // ignore: cast_nullable_to_non_nullable
          : startsAt as String,
      endsAt: endsAt == const $CopyWithPlaceholder() || endsAt == null
          ? _value.endsAt
          // ignore: cast_nullable_to_non_nullable
          : endsAt as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $ClosureDtoCopyWith on ClosureDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfClosureDto.copyWith(...)` or `instanceOfClosureDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClosureDtoCWProxy get copyWith => _$ClosureDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosureDto _$ClosureDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ClosureDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['startsAt', 'endsAt']);
      final val = ClosureDto(
        startsAt: $checkedConvert('startsAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ClosureDtoToJson(ClosureDto instance) =>
    <String, dynamic>{
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'reason': ?instance.reason,
    };
