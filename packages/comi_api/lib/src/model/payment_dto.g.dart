// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentDtoCWProxy {
  PaymentDto id(String id);

  PaymentDto bookingId(String bookingId);

  PaymentDto amount(num amount);

  PaymentDto status(PaymentDtoStatusEnum status);

  PaymentDto purpose(PaymentDtoPurposeEnum purpose);

  PaymentDto guestId(String? guestId);

  PaymentDto checkoutUrl(String? checkoutUrl);

  PaymentDto qrCode(String? qrCode);

  PaymentDto expiresAt(String expiresAt);

  PaymentDto paidAt(String? paidAt);

  PaymentDto refundedAmount(num refundedAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PaymentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentDto call({
    String id,
    String bookingId,
    num amount,
    PaymentDtoStatusEnum status,
    PaymentDtoPurposeEnum purpose,
    String? guestId,
    String? checkoutUrl,
    String? qrCode,
    String expiresAt,
    String? paidAt,
    num refundedAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentDto.copyWith(...)` or call `instanceOfPaymentDto.copyWith.fieldName(value)` for a single field.
class _$PaymentDtoCWProxyImpl implements _$PaymentDtoCWProxy {
  const _$PaymentDtoCWProxyImpl(this._value);

  final PaymentDto _value;

  @override
  PaymentDto id(String id) => call(id: id);

  @override
  PaymentDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  PaymentDto amount(num amount) => call(amount: amount);

  @override
  PaymentDto status(PaymentDtoStatusEnum status) => call(status: status);

  @override
  PaymentDto purpose(PaymentDtoPurposeEnum purpose) => call(purpose: purpose);

  @override
  PaymentDto guestId(String? guestId) => call(guestId: guestId);

  @override
  PaymentDto checkoutUrl(String? checkoutUrl) => call(checkoutUrl: checkoutUrl);

  @override
  PaymentDto qrCode(String? qrCode) => call(qrCode: qrCode);

  @override
  PaymentDto expiresAt(String expiresAt) => call(expiresAt: expiresAt);

  @override
  PaymentDto paidAt(String? paidAt) => call(paidAt: paidAt);

  @override
  PaymentDto refundedAmount(num refundedAmount) =>
      call(refundedAmount: refundedAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PaymentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PaymentDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? purpose = const $CopyWithPlaceholder(),
    Object? guestId = const $CopyWithPlaceholder(),
    Object? checkoutUrl = const $CopyWithPlaceholder(),
    Object? qrCode = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? paidAt = const $CopyWithPlaceholder(),
    Object? refundedAmount = const $CopyWithPlaceholder(),
  }) {
    return PaymentDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PaymentDtoStatusEnum,
      purpose: purpose == const $CopyWithPlaceholder() || purpose == null
          ? _value.purpose
          // ignore: cast_nullable_to_non_nullable
          : purpose as PaymentDtoPurposeEnum,
      guestId: guestId == const $CopyWithPlaceholder()
          ? _value.guestId
          // ignore: cast_nullable_to_non_nullable
          : guestId as String?,
      checkoutUrl: checkoutUrl == const $CopyWithPlaceholder()
          ? _value.checkoutUrl
          // ignore: cast_nullable_to_non_nullable
          : checkoutUrl as String?,
      qrCode: qrCode == const $CopyWithPlaceholder()
          ? _value.qrCode
          // ignore: cast_nullable_to_non_nullable
          : qrCode as String?,
      expiresAt: expiresAt == const $CopyWithPlaceholder() || expiresAt == null
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as String,
      paidAt: paidAt == const $CopyWithPlaceholder()
          ? _value.paidAt
          // ignore: cast_nullable_to_non_nullable
          : paidAt as String?,
      refundedAmount:
          refundedAmount == const $CopyWithPlaceholder() ||
              refundedAmount == null
          ? _value.refundedAmount
          // ignore: cast_nullable_to_non_nullable
          : refundedAmount as num,
    );
  }
}

extension $PaymentDtoCopyWith on PaymentDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentDto.copyWith(...)` or `instanceOfPaymentDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentDtoCWProxy get copyWith => _$PaymentDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaymentDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'bookingId',
          'amount',
          'status',
          'purpose',
          'expiresAt',
          'refundedAmount',
        ],
      );
      final val = PaymentDto(
        id: $checkedConvert('id', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        amount: $checkedConvert('amount', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$PaymentDtoStatusEnumEnumMap, v),
        ),
        purpose: $checkedConvert(
          'purpose',
          (v) => $enumDecode(_$PaymentDtoPurposeEnumEnumMap, v),
        ),
        guestId: $checkedConvert('guestId', (v) => v as String?),
        checkoutUrl: $checkedConvert('checkoutUrl', (v) => v as String?),
        qrCode: $checkedConvert('qrCode', (v) => v as String?),
        expiresAt: $checkedConvert('expiresAt', (v) => v as String),
        paidAt: $checkedConvert('paidAt', (v) => v as String?),
        refundedAmount: $checkedConvert('refundedAmount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'amount': instance.amount,
      'status': _$PaymentDtoStatusEnumEnumMap[instance.status]!,
      'purpose': _$PaymentDtoPurposeEnumEnumMap[instance.purpose]!,
      'guestId': ?instance.guestId,
      'checkoutUrl': ?instance.checkoutUrl,
      'qrCode': ?instance.qrCode,
      'expiresAt': instance.expiresAt,
      'paidAt': ?instance.paidAt,
      'refundedAmount': instance.refundedAmount,
    };

const _$PaymentDtoStatusEnumEnumMap = {
  PaymentDtoStatusEnum.CREATED: 'CREATED',
  PaymentDtoStatusEnum.PENDING: 'PENDING',
  PaymentDtoStatusEnum.PAID: 'PAID',
  PaymentDtoStatusEnum.FAILED: 'FAILED',
  PaymentDtoStatusEnum.EXPIRED: 'EXPIRED',
  PaymentDtoStatusEnum.REFUNDED: 'REFUNDED',
  PaymentDtoStatusEnum.PARTIALLY_REFUNDED: 'PARTIALLY_REFUNDED',
};

const _$PaymentDtoPurposeEnumEnumMap = {
  PaymentDtoPurposeEnum.BOOKING: 'BOOKING',
  PaymentDtoPurposeEnum.SHARE: 'SHARE',
};
