// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_account_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundAccountDtoCWProxy {
  RefundAccountDto bankBin(String bankBin);

  RefundAccountDto accountNo(String accountNo);

  RefundAccountDto accountName(String accountName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundAccountDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundAccountDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundAccountDto call({String bankBin, String accountNo, String accountName});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefundAccountDto.copyWith(...)` or call `instanceOfRefundAccountDto.copyWith.fieldName(value)` for a single field.
class _$RefundAccountDtoCWProxyImpl implements _$RefundAccountDtoCWProxy {
  const _$RefundAccountDtoCWProxyImpl(this._value);

  final RefundAccountDto _value;

  @override
  RefundAccountDto bankBin(String bankBin) => call(bankBin: bankBin);

  @override
  RefundAccountDto accountNo(String accountNo) => call(accountNo: accountNo);

  @override
  RefundAccountDto accountName(String accountName) =>
      call(accountName: accountName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundAccountDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundAccountDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RefundAccountDto call({
    Object? bankBin = const $CopyWithPlaceholder(),
    Object? accountNo = const $CopyWithPlaceholder(),
    Object? accountName = const $CopyWithPlaceholder(),
  }) {
    return RefundAccountDto(
      bankBin: bankBin == const $CopyWithPlaceholder() || bankBin == null
          ? _value.bankBin
          // ignore: cast_nullable_to_non_nullable
          : bankBin as String,
      accountNo: accountNo == const $CopyWithPlaceholder() || accountNo == null
          ? _value.accountNo
          // ignore: cast_nullable_to_non_nullable
          : accountNo as String,
      accountName:
          accountName == const $CopyWithPlaceholder() || accountName == null
          ? _value.accountName
          // ignore: cast_nullable_to_non_nullable
          : accountName as String,
    );
  }
}

extension $RefundAccountDtoCopyWith on RefundAccountDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefundAccountDto.copyWith(...)` or `instanceOfRefundAccountDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundAccountDtoCWProxy get copyWith => _$RefundAccountDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundAccountDto _$RefundAccountDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundAccountDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['bankBin', 'accountNo', 'accountName'],
      );
      final val = RefundAccountDto(
        bankBin: $checkedConvert('bankBin', (v) => v as String),
        accountNo: $checkedConvert('accountNo', (v) => v as String),
        accountName: $checkedConvert('accountName', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RefundAccountDtoToJson(RefundAccountDto instance) =>
    <String, dynamic>{
      'bankBin': instance.bankBin,
      'accountNo': instance.accountNo,
      'accountName': instance.accountName,
    };
