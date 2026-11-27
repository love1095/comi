// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CheckInDtoCWProxy {
  CheckInDto qrPayload(String qrPayload);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CheckInDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CheckInDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CheckInDto call({String qrPayload});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCheckInDto.copyWith(...)` or call `instanceOfCheckInDto.copyWith.fieldName(value)` for a single field.
class _$CheckInDtoCWProxyImpl implements _$CheckInDtoCWProxy {
  const _$CheckInDtoCWProxyImpl(this._value);

  final CheckInDto _value;

  @override
  CheckInDto qrPayload(String qrPayload) => call(qrPayload: qrPayload);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CheckInDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CheckInDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CheckInDto call({Object? qrPayload = const $CopyWithPlaceholder()}) {
    return CheckInDto(
      qrPayload: qrPayload == const $CopyWithPlaceholder() || qrPayload == null
          ? _value.qrPayload
          // ignore: cast_nullable_to_non_nullable
          : qrPayload as String,
    );
  }
}

extension $CheckInDtoCopyWith on CheckInDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCheckInDto.copyWith(...)` or `instanceOfCheckInDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CheckInDtoCWProxy get copyWith => _$CheckInDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInDto _$CheckInDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CheckInDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['qrPayload']);
      final val = CheckInDto(
        qrPayload: $checkedConvert('qrPayload', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CheckInDtoToJson(CheckInDto instance) =>
    <String, dynamic>{'qrPayload': instance.qrPayload};
