// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_profile_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InvoiceProfileDtoCWProxy {
  InvoiceProfileDto id(String id);

  InvoiceProfileDto companyName(String companyName);

  InvoiceProfileDto taxCode(String taxCode);

  InvoiceProfileDto address(String address);

  InvoiceProfileDto email(String email);

  InvoiceProfileDto isDefault(bool isDefault);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceProfileDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceProfileDto(...).copyWith(id: 12, name: "My name")
  /// ```
  InvoiceProfileDto call({
    String id,
    String companyName,
    String taxCode,
    String address,
    String email,
    bool isDefault,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInvoiceProfileDto.copyWith(...)` or call `instanceOfInvoiceProfileDto.copyWith.fieldName(value)` for a single field.
class _$InvoiceProfileDtoCWProxyImpl implements _$InvoiceProfileDtoCWProxy {
  const _$InvoiceProfileDtoCWProxyImpl(this._value);

  final InvoiceProfileDto _value;

  @override
  InvoiceProfileDto id(String id) => call(id: id);

  @override
  InvoiceProfileDto companyName(String companyName) =>
      call(companyName: companyName);

  @override
  InvoiceProfileDto taxCode(String taxCode) => call(taxCode: taxCode);

  @override
  InvoiceProfileDto address(String address) => call(address: address);

  @override
  InvoiceProfileDto email(String email) => call(email: email);

  @override
  InvoiceProfileDto isDefault(bool isDefault) => call(isDefault: isDefault);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceProfileDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceProfileDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  InvoiceProfileDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? companyName = const $CopyWithPlaceholder(),
    Object? taxCode = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? isDefault = const $CopyWithPlaceholder(),
  }) {
    return InvoiceProfileDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      companyName:
          companyName == const $CopyWithPlaceholder() || companyName == null
          ? _value.companyName
          // ignore: cast_nullable_to_non_nullable
          : companyName as String,
      taxCode: taxCode == const $CopyWithPlaceholder() || taxCode == null
          ? _value.taxCode
          // ignore: cast_nullable_to_non_nullable
          : taxCode as String,
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      isDefault: isDefault == const $CopyWithPlaceholder() || isDefault == null
          ? _value.isDefault
          // ignore: cast_nullable_to_non_nullable
          : isDefault as bool,
    );
  }
}

extension $InvoiceProfileDtoCopyWith on InvoiceProfileDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInvoiceProfileDto.copyWith(...)` or `instanceOfInvoiceProfileDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InvoiceProfileDtoCWProxy get copyWith =>
      _$InvoiceProfileDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceProfileDto _$InvoiceProfileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InvoiceProfileDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'companyName',
          'taxCode',
          'address',
          'email',
          'isDefault',
        ],
      );
      final val = InvoiceProfileDto(
        id: $checkedConvert('id', (v) => v as String),
        companyName: $checkedConvert('companyName', (v) => v as String),
        taxCode: $checkedConvert('taxCode', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        isDefault: $checkedConvert('isDefault', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$InvoiceProfileDtoToJson(InvoiceProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'taxCode': instance.taxCode,
      'address': instance.address,
      'email': instance.email,
      'isDefault': instance.isDefault,
    };
