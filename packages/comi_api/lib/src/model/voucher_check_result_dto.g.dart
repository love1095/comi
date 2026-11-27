// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_check_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherCheckResultDtoCWProxy {
  VoucherCheckResultDto valid(bool valid);

  VoucherCheckResultDto discount(num discount);

  VoucherCheckResultDto problem(String? problem);

  VoucherCheckResultDto message(String? message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherCheckResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherCheckResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  VoucherCheckResultDto call({
    bool valid,
    num discount,
    String? problem,
    String? message,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVoucherCheckResultDto.copyWith(...)` or call `instanceOfVoucherCheckResultDto.copyWith.fieldName(value)` for a single field.
class _$VoucherCheckResultDtoCWProxyImpl
    implements _$VoucherCheckResultDtoCWProxy {
  const _$VoucherCheckResultDtoCWProxyImpl(this._value);

  final VoucherCheckResultDto _value;

  @override
  VoucherCheckResultDto valid(bool valid) => call(valid: valid);

  @override
  VoucherCheckResultDto discount(num discount) => call(discount: discount);

  @override
  VoucherCheckResultDto problem(String? problem) => call(problem: problem);

  @override
  VoucherCheckResultDto message(String? message) => call(message: message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherCheckResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherCheckResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  VoucherCheckResultDto call({
    Object? valid = const $CopyWithPlaceholder(),
    Object? discount = const $CopyWithPlaceholder(),
    Object? problem = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return VoucherCheckResultDto(
      valid: valid == const $CopyWithPlaceholder() || valid == null
          ? _value.valid
          // ignore: cast_nullable_to_non_nullable
          : valid as bool,
      discount: discount == const $CopyWithPlaceholder() || discount == null
          ? _value.discount
          // ignore: cast_nullable_to_non_nullable
          : discount as num,
      problem: problem == const $CopyWithPlaceholder()
          ? _value.problem
          // ignore: cast_nullable_to_non_nullable
          : problem as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $VoucherCheckResultDtoCopyWith on VoucherCheckResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVoucherCheckResultDto.copyWith(...)` or `instanceOfVoucherCheckResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherCheckResultDtoCWProxy get copyWith =>
      _$VoucherCheckResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCheckResultDto _$VoucherCheckResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('VoucherCheckResultDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['valid', 'discount']);
  final val = VoucherCheckResultDto(
    valid: $checkedConvert('valid', (v) => v as bool),
    discount: $checkedConvert('discount', (v) => v as num),
    problem: $checkedConvert('problem', (v) => v as String?),
    message: $checkedConvert('message', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$VoucherCheckResultDtoToJson(
  VoucherCheckResultDto instance,
) => <String, dynamic>{
  'valid': instance.valid,
  'discount': instance.discount,
  'problem': ?instance.problem,
  'message': ?instance.message,
};
