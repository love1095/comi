// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CancelDtoCWProxy {
  CancelDto reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CancelDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CancelDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CancelDto call({String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCancelDto.copyWith(...)` or call `instanceOfCancelDto.copyWith.fieldName(value)` for a single field.
class _$CancelDtoCWProxyImpl implements _$CancelDtoCWProxy {
  const _$CancelDtoCWProxyImpl(this._value);

  final CancelDto _value;

  @override
  CancelDto reason(String? reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CancelDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CancelDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CancelDto call({Object? reason = const $CopyWithPlaceholder()}) {
    return CancelDto(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $CancelDtoCopyWith on CancelDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCancelDto.copyWith(...)` or `instanceOfCancelDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CancelDtoCWProxy get copyWith => _$CancelDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelDto _$CancelDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CancelDto', json, ($checkedConvert) {
      final val = CancelDto(
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CancelDtoToJson(CancelDto instance) => <String, dynamic>{
  'reason': ?instance.reason,
};
