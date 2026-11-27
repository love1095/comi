// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_active_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherActiveDtoCWProxy {
  VoucherActiveDto isActive(bool isActive);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherActiveDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherActiveDto(...).copyWith(id: 12, name: "My name")
  /// ```
  VoucherActiveDto call({bool isActive});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVoucherActiveDto.copyWith(...)` or call `instanceOfVoucherActiveDto.copyWith.fieldName(value)` for a single field.
class _$VoucherActiveDtoCWProxyImpl implements _$VoucherActiveDtoCWProxy {
  const _$VoucherActiveDtoCWProxyImpl(this._value);

  final VoucherActiveDto _value;

  @override
  VoucherActiveDto isActive(bool isActive) => call(isActive: isActive);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherActiveDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherActiveDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  VoucherActiveDto call({Object? isActive = const $CopyWithPlaceholder()}) {
    return VoucherActiveDto(
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $VoucherActiveDtoCopyWith on VoucherActiveDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVoucherActiveDto.copyWith(...)` or `instanceOfVoucherActiveDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherActiveDtoCWProxy get copyWith => _$VoucherActiveDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherActiveDto _$VoucherActiveDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VoucherActiveDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['isActive']);
      final val = VoucherActiveDto(
        isActive: $checkedConvert('isActive', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$VoucherActiveDtoToJson(VoucherActiveDto instance) =>
    <String, dynamic>{'isActive': instance.isActive};
