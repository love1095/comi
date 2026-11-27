// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RoundResultDtoCWProxy {
  RoundResultDto round(num round);

  RoundResultDto needsApproval(bool needsApproval);

  RoundResultDto total(num total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RoundResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RoundResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RoundResultDto call({num round, bool needsApproval, num total});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRoundResultDto.copyWith(...)` or call `instanceOfRoundResultDto.copyWith.fieldName(value)` for a single field.
class _$RoundResultDtoCWProxyImpl implements _$RoundResultDtoCWProxy {
  const _$RoundResultDtoCWProxyImpl(this._value);

  final RoundResultDto _value;

  @override
  RoundResultDto round(num round) => call(round: round);

  @override
  RoundResultDto needsApproval(bool needsApproval) =>
      call(needsApproval: needsApproval);

  @override
  RoundResultDto total(num total) => call(total: total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RoundResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RoundResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RoundResultDto call({
    Object? round = const $CopyWithPlaceholder(),
    Object? needsApproval = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return RoundResultDto(
      round: round == const $CopyWithPlaceholder() || round == null
          ? _value.round
          // ignore: cast_nullable_to_non_nullable
          : round as num,
      needsApproval:
          needsApproval == const $CopyWithPlaceholder() || needsApproval == null
          ? _value.needsApproval
          // ignore: cast_nullable_to_non_nullable
          : needsApproval as bool,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
    );
  }
}

extension $RoundResultDtoCopyWith on RoundResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRoundResultDto.copyWith(...)` or `instanceOfRoundResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoundResultDtoCWProxy get copyWith => _$RoundResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundResultDto _$RoundResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RoundResultDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['round', 'needsApproval', 'total']);
      final val = RoundResultDto(
        round: $checkedConvert('round', (v) => v as num),
        needsApproval: $checkedConvert('needsApproval', (v) => v as bool),
        total: $checkedConvert('total', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$RoundResultDtoToJson(RoundResultDto instance) =>
    <String, dynamic>{
      'round': instance.round,
      'needsApproval': instance.needsApproval,
      'total': instance.total,
    };
