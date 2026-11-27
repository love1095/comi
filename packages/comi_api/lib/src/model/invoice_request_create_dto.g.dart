// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_request_create_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InvoiceRequestCreateDtoCWProxy {
  InvoiceRequestCreateDto companyName(String companyName);

  InvoiceRequestCreateDto taxCode(String taxCode);

  InvoiceRequestCreateDto address(String address);

  InvoiceRequestCreateDto email(String email);

  InvoiceRequestCreateDto saveProfile(bool? saveProfile);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceRequestCreateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceRequestCreateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  InvoiceRequestCreateDto call({
    String companyName,
    String taxCode,
    String address,
    String email,
    bool? saveProfile,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInvoiceRequestCreateDto.copyWith(...)` or call `instanceOfInvoiceRequestCreateDto.copyWith.fieldName(value)` for a single field.
class _$InvoiceRequestCreateDtoCWProxyImpl
    implements _$InvoiceRequestCreateDtoCWProxy {
  const _$InvoiceRequestCreateDtoCWProxyImpl(this._value);

  final InvoiceRequestCreateDto _value;

  @override
  InvoiceRequestCreateDto companyName(String companyName) =>
      call(companyName: companyName);

  @override
  InvoiceRequestCreateDto taxCode(String taxCode) => call(taxCode: taxCode);

  @override
  InvoiceRequestCreateDto address(String address) => call(address: address);

  @override
  InvoiceRequestCreateDto email(String email) => call(email: email);

  @override
  InvoiceRequestCreateDto saveProfile(bool? saveProfile) =>
      call(saveProfile: saveProfile);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceRequestCreateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceRequestCreateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  InvoiceRequestCreateDto call({
    Object? companyName = const $CopyWithPlaceholder(),
    Object? taxCode = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? saveProfile = const $CopyWithPlaceholder(),
  }) {
    return InvoiceRequestCreateDto(
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
      saveProfile: saveProfile == const $CopyWithPlaceholder()
          ? _value.saveProfile
          // ignore: cast_nullable_to_non_nullable
          : saveProfile as bool?,
    );
  }
}

extension $InvoiceRequestCreateDtoCopyWith on InvoiceRequestCreateDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInvoiceRequestCreateDto.copyWith(...)` or `instanceOfInvoiceRequestCreateDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InvoiceRequestCreateDtoCWProxy get copyWith =>
      _$InvoiceRequestCreateDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceRequestCreateDto _$InvoiceRequestCreateDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InvoiceRequestCreateDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['companyName', 'taxCode', 'address', 'email'],
  );
  final val = InvoiceRequestCreateDto(
    companyName: $checkedConvert('companyName', (v) => v as String),
    taxCode: $checkedConvert('taxCode', (v) => v as String),
    address: $checkedConvert('address', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    saveProfile: $checkedConvert('saveProfile', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$InvoiceRequestCreateDtoToJson(
  InvoiceRequestCreateDto instance,
) => <String, dynamic>{
  'companyName': instance.companyName,
  'taxCode': instance.taxCode,
  'address': instance.address,
  'email': instance.email,
  'saveProfile': ?instance.saveProfile,
};
