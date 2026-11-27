// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_code_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MfaCodeDtoCWProxy {
  MfaCodeDto code(String code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MfaCodeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MfaCodeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MfaCodeDto call({String code});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMfaCodeDto.copyWith(...)` or call `instanceOfMfaCodeDto.copyWith.fieldName(value)` for a single field.
class _$MfaCodeDtoCWProxyImpl implements _$MfaCodeDtoCWProxy {
  const _$MfaCodeDtoCWProxyImpl(this._value);

  final MfaCodeDto _value;

  @override
  MfaCodeDto code(String code) => call(code: code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MfaCodeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MfaCodeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MfaCodeDto call({Object? code = const $CopyWithPlaceholder()}) {
    return MfaCodeDto(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
    );
  }
}

extension $MfaCodeDtoCopyWith on MfaCodeDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMfaCodeDto.copyWith(...)` or `instanceOfMfaCodeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MfaCodeDtoCWProxy get copyWith => _$MfaCodeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MfaCodeDto _$MfaCodeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MfaCodeDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code']);
      final val = MfaCodeDto(code: $checkedConvert('code', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$MfaCodeDtoToJson(MfaCodeDto instance) =>
    <String, dynamic>{'code': instance.code};
