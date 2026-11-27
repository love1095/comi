// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RejectDtoCWProxy {
  RejectDto reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RejectDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RejectDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RejectDto call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRejectDto.copyWith(...)` or call `instanceOfRejectDto.copyWith.fieldName(value)` for a single field.
class _$RejectDtoCWProxyImpl implements _$RejectDtoCWProxy {
  const _$RejectDtoCWProxyImpl(this._value);

  final RejectDto _value;

  @override
  RejectDto reason(String reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RejectDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RejectDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RejectDto call({Object? reason = const $CopyWithPlaceholder()}) {
    return RejectDto(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $RejectDtoCopyWith on RejectDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRejectDto.copyWith(...)` or `instanceOfRejectDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RejectDtoCWProxy get copyWith => _$RejectDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectDto _$RejectDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RejectDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = RejectDto(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RejectDtoToJson(RejectDto instance) => <String, dynamic>{
  'reason': instance.reason,
};
