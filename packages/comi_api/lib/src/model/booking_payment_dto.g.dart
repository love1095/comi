// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingPaymentDtoCWProxy {
  BookingPaymentDto id(String id);

  BookingPaymentDto amount(num amount);

  BookingPaymentDto status(BookingPaymentDtoStatusEnum status);

  BookingPaymentDto purpose(BookingPaymentDtoPurposeEnum purpose);

  BookingPaymentDto guestId(String? guestId);

  BookingPaymentDto checkoutUrl(String? checkoutUrl);

  BookingPaymentDto qrCode(String? qrCode);

  BookingPaymentDto expiresAt(String expiresAt);

  BookingPaymentDto paidAt(String? paidAt);

  BookingPaymentDto refundedAmount(num refundedAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingPaymentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingPaymentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingPaymentDto call({
    String id,
    num amount,
    BookingPaymentDtoStatusEnum status,
    BookingPaymentDtoPurposeEnum purpose,
    String? guestId,
    String? checkoutUrl,
    String? qrCode,
    String expiresAt,
    String? paidAt,
    num refundedAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingPaymentDto.copyWith(...)` or call `instanceOfBookingPaymentDto.copyWith.fieldName(value)` for a single field.
class _$BookingPaymentDtoCWProxyImpl implements _$BookingPaymentDtoCWProxy {
  const _$BookingPaymentDtoCWProxyImpl(this._value);

  final BookingPaymentDto _value;

  @override
  BookingPaymentDto id(String id) => call(id: id);

  @override
  BookingPaymentDto amount(num amount) => call(amount: amount);

  @override
  BookingPaymentDto status(BookingPaymentDtoStatusEnum status) =>
      call(status: status);

  @override
  BookingPaymentDto purpose(BookingPaymentDtoPurposeEnum purpose) =>
      call(purpose: purpose);

  @override
  BookingPaymentDto guestId(String? guestId) => call(guestId: guestId);

  @override
  BookingPaymentDto checkoutUrl(String? checkoutUrl) =>
      call(checkoutUrl: checkoutUrl);

  @override
  BookingPaymentDto qrCode(String? qrCode) => call(qrCode: qrCode);

  @override
  BookingPaymentDto expiresAt(String expiresAt) => call(expiresAt: expiresAt);

  @override
  BookingPaymentDto paidAt(String? paidAt) => call(paidAt: paidAt);

  @override
  BookingPaymentDto refundedAmount(num refundedAmount) =>
      call(refundedAmount: refundedAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingPaymentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingPaymentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingPaymentDto call({
    Object? id = const $CopyWithPlaceholder(),
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
    return BookingPaymentDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingPaymentDtoStatusEnum,
      purpose: purpose == const $CopyWithPlaceholder() || purpose == null
          ? _value.purpose
          // ignore: cast_nullable_to_non_nullable
          : purpose as BookingPaymentDtoPurposeEnum,
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

extension $BookingPaymentDtoCopyWith on BookingPaymentDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingPaymentDto.copyWith(...)` or `instanceOfBookingPaymentDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingPaymentDtoCWProxy get copyWith =>
      _$BookingPaymentDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingPaymentDto _$BookingPaymentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BookingPaymentDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'amount',
          'status',
          'purpose',
          'expiresAt',
          'refundedAmount',
        ],
      );
      final val = BookingPaymentDto(
        id: $checkedConvert('id', (v) => v as String),
        amount: $checkedConvert('amount', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingPaymentDtoStatusEnumEnumMap, v),
        ),
        purpose: $checkedConvert(
          'purpose',
          (v) => $enumDecode(_$BookingPaymentDtoPurposeEnumEnumMap, v),
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

Map<String, dynamic> _$BookingPaymentDtoToJson(BookingPaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': _$BookingPaymentDtoStatusEnumEnumMap[instance.status]!,
      'purpose': _$BookingPaymentDtoPurposeEnumEnumMap[instance.purpose]!,
      'guestId': ?instance.guestId,
      'checkoutUrl': ?instance.checkoutUrl,
      'qrCode': ?instance.qrCode,
      'expiresAt': instance.expiresAt,
      'paidAt': ?instance.paidAt,
      'refundedAmount': instance.refundedAmount,
    };

const _$BookingPaymentDtoStatusEnumEnumMap = {
  BookingPaymentDtoStatusEnum.CREATED: 'CREATED',
  BookingPaymentDtoStatusEnum.PENDING: 'PENDING',
  BookingPaymentDtoStatusEnum.PAID: 'PAID',
  BookingPaymentDtoStatusEnum.FAILED: 'FAILED',
  BookingPaymentDtoStatusEnum.EXPIRED: 'EXPIRED',
  BookingPaymentDtoStatusEnum.REFUNDED: 'REFUNDED',
  BookingPaymentDtoStatusEnum.PARTIALLY_REFUNDED: 'PARTIALLY_REFUNDED',
};

const _$BookingPaymentDtoPurposeEnumEnumMap = {
  BookingPaymentDtoPurposeEnum.BOOKING: 'BOOKING',
  BookingPaymentDtoPurposeEnum.SHARE: 'SHARE',
};
