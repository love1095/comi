// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BlockDtoCWProxy {
  BlockDto blocked(bool blocked);

  BlockDto reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BlockDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BlockDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BlockDto call({bool blocked, String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBlockDto.copyWith(...)` or call `instanceOfBlockDto.copyWith.fieldName(value)` for a single field.
class _$BlockDtoCWProxyImpl implements _$BlockDtoCWProxy {
  const _$BlockDtoCWProxyImpl(this._value);

  final BlockDto _value;

  @override
  BlockDto blocked(bool blocked) => call(blocked: blocked);

  @override
  BlockDto reason(String? reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BlockDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BlockDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BlockDto call({
    Object? blocked = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return BlockDto(
      blocked: blocked == const $CopyWithPlaceholder() || blocked == null
          ? _value.blocked
          // ignore: cast_nullable_to_non_nullable
          : blocked as bool,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $BlockDtoCopyWith on BlockDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBlockDto.copyWith(...)` or `instanceOfBlockDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BlockDtoCWProxy get copyWith => _$BlockDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockDto _$BlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BlockDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['blocked']);
      final val = BlockDto(
        blocked: $checkedConvert('blocked', (v) => v as bool),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BlockDtoToJson(BlockDto instance) => <String, dynamic>{
  'blocked': instance.blocked,
  'reason': ?instance.reason,
};
