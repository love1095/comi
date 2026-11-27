// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InvoiceRequestDtoCWProxy {
  InvoiceRequestDto id(String id);

  InvoiceRequestDto bookingId(String bookingId);

  InvoiceRequestDto bookingCode(String bookingCode);

  InvoiceRequestDto companyName(String companyName);

  InvoiceRequestDto taxCode(String taxCode);

  InvoiceRequestDto address(String address);

  InvoiceRequestDto email(String email);

  InvoiceRequestDto status(InvoiceRequestDtoStatusEnum status);

  InvoiceRequestDto invoiceNo(String? invoiceNo);

  InvoiceRequestDto issuedAt(String? issuedAt);

  InvoiceRequestDto amount(num amount);

  InvoiceRequestDto arrivalAt(String arrivalAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceRequestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceRequestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  InvoiceRequestDto call({
    String id,
    String bookingId,
    String bookingCode,
    String companyName,
    String taxCode,
    String address,
    String email,
    InvoiceRequestDtoStatusEnum status,
    String? invoiceNo,
    String? issuedAt,
    num amount,
    String arrivalAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInvoiceRequestDto.copyWith(...)` or call `instanceOfInvoiceRequestDto.copyWith.fieldName(value)` for a single field.
class _$InvoiceRequestDtoCWProxyImpl implements _$InvoiceRequestDtoCWProxy {
  const _$InvoiceRequestDtoCWProxyImpl(this._value);

  final InvoiceRequestDto _value;

  @override
  InvoiceRequestDto id(String id) => call(id: id);

  @override
  InvoiceRequestDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  InvoiceRequestDto bookingCode(String bookingCode) =>
      call(bookingCode: bookingCode);

  @override
  InvoiceRequestDto companyName(String companyName) =>
      call(companyName: companyName);

  @override
  InvoiceRequestDto taxCode(String taxCode) => call(taxCode: taxCode);

  @override
  InvoiceRequestDto address(String address) => call(address: address);

  @override
  InvoiceRequestDto email(String email) => call(email: email);

  @override
  InvoiceRequestDto status(InvoiceRequestDtoStatusEnum status) =>
      call(status: status);

  @override
  InvoiceRequestDto invoiceNo(String? invoiceNo) => call(invoiceNo: invoiceNo);

  @override
  InvoiceRequestDto issuedAt(String? issuedAt) => call(issuedAt: issuedAt);

  @override
  InvoiceRequestDto amount(num amount) => call(amount: amount);

  @override
  InvoiceRequestDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `InvoiceRequestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvoiceRequestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  InvoiceRequestDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? bookingCode = const $CopyWithPlaceholder(),
    Object? companyName = const $CopyWithPlaceholder(),
    Object? taxCode = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? invoiceNo = const $CopyWithPlaceholder(),
    Object? issuedAt = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
  }) {
    return InvoiceRequestDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      bookingCode:
          bookingCode == const $CopyWithPlaceholder() || bookingCode == null
          ? _value.bookingCode
          // ignore: cast_nullable_to_non_nullable
          : bookingCode as String,
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
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as InvoiceRequestDtoStatusEnum,
      invoiceNo: invoiceNo == const $CopyWithPlaceholder()
          ? _value.invoiceNo
          // ignore: cast_nullable_to_non_nullable
          : invoiceNo as String?,
      issuedAt: issuedAt == const $CopyWithPlaceholder()
          ? _value.issuedAt
          // ignore: cast_nullable_to_non_nullable
          : issuedAt as String?,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
    );
  }
}

extension $InvoiceRequestDtoCopyWith on InvoiceRequestDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInvoiceRequestDto.copyWith(...)` or `instanceOfInvoiceRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InvoiceRequestDtoCWProxy get copyWith =>
      _$InvoiceRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceRequestDto _$InvoiceRequestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InvoiceRequestDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'bookingId',
          'bookingCode',
          'companyName',
          'taxCode',
          'address',
          'email',
          'status',
          'amount',
          'arrivalAt',
        ],
      );
      final val = InvoiceRequestDto(
        id: $checkedConvert('id', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        bookingCode: $checkedConvert('bookingCode', (v) => v as String),
        companyName: $checkedConvert('companyName', (v) => v as String),
        taxCode: $checkedConvert('taxCode', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$InvoiceRequestDtoStatusEnumEnumMap, v),
        ),
        invoiceNo: $checkedConvert('invoiceNo', (v) => v as String?),
        issuedAt: $checkedConvert('issuedAt', (v) => v as String?),
        amount: $checkedConvert('amount', (v) => v as num),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$InvoiceRequestDtoToJson(InvoiceRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'bookingCode': instance.bookingCode,
      'companyName': instance.companyName,
      'taxCode': instance.taxCode,
      'address': instance.address,
      'email': instance.email,
      'status': _$InvoiceRequestDtoStatusEnumEnumMap[instance.status]!,
      'invoiceNo': ?instance.invoiceNo,
      'issuedAt': ?instance.issuedAt,
      'amount': instance.amount,
      'arrivalAt': instance.arrivalAt,
    };

const _$InvoiceRequestDtoStatusEnumEnumMap = {
  InvoiceRequestDtoStatusEnum.REQUESTED: 'REQUESTED',
  InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT: 'SENT_TO_RESTAURANT',
  InvoiceRequestDtoStatusEnum.ISSUED: 'ISSUED',
  InvoiceRequestDtoStatusEnum.EMAILED: 'EMAILED',
  InvoiceRequestDtoStatusEnum.REJECTED: 'REJECTED',
};
