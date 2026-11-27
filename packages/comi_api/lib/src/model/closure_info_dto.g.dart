// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closure_info_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClosureInfoDtoCWProxy {
  ClosureInfoDto startsAt(String startsAt);

  ClosureInfoDto endsAt(String endsAt);

  ClosureInfoDto reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ClosureInfoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ClosureInfoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ClosureInfoDto call({String startsAt, String endsAt, String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfClosureInfoDto.copyWith(...)` or call `instanceOfClosureInfoDto.copyWith.fieldName(value)` for a single field.
class _$ClosureInfoDtoCWProxyImpl implements _$ClosureInfoDtoCWProxy {
  const _$ClosureInfoDtoCWProxyImpl(this._value);

  final ClosureInfoDto _value;

  @override
  ClosureInfoDto startsAt(String startsAt) => call(startsAt: startsAt);

  @override
  ClosureInfoDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  ClosureInfoDto reason(String? reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ClosureInfoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ClosureInfoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ClosureInfoDto call({
    Object? startsAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return ClosureInfoDto(
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

extension $ClosureInfoDtoCopyWith on ClosureInfoDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfClosureInfoDto.copyWith(...)` or `instanceOfClosureInfoDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClosureInfoDtoCWProxy get copyWith => _$ClosureInfoDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosureInfoDto _$ClosureInfoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ClosureInfoDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['startsAt', 'endsAt']);
      final val = ClosureInfoDto(
        startsAt: $checkedConvert('startsAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ClosureInfoDtoToJson(ClosureInfoDto instance) =>
    <String, dynamic>{
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'reason': ?instance.reason,
    };
