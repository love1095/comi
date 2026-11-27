// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundDtoCWProxy {
  RefundDto id(String id);

  RefundDto bookingId(String bookingId);

  RefundDto bookingCode(String bookingCode);

  RefundDto guestName(String? guestName);

  RefundDto guestPhone(String? guestPhone);

  RefundDto amount(num amount);

  RefundDto reason(RefundDtoReasonEnum reason);

  RefundDto status(RefundDtoStatusEnum status);

  RefundDto toBankBin(String? toBankBin);

  RefundDto toAccountNo(String? toAccountNo);

  RefundDto toAccountName(String? toAccountName);

  RefundDto note(String? note);

  RefundDto createdAt(String createdAt);

  RefundDto doneAt(String? doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundDto call({
    String id,
    String bookingId,
    String bookingCode,
    String? guestName,
    String? guestPhone,
    num amount,
    RefundDtoReasonEnum reason,
    RefundDtoStatusEnum status,
    String? toBankBin,
    String? toAccountNo,
    String? toAccountName,
    String? note,
    String createdAt,
    String? doneAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefundDto.copyWith(...)` or call `instanceOfRefundDto.copyWith.fieldName(value)` for a single field.
class _$RefundDtoCWProxyImpl implements _$RefundDtoCWProxy {
  const _$RefundDtoCWProxyImpl(this._value);

  final RefundDto _value;

  @override
  RefundDto id(String id) => call(id: id);

  @override
  RefundDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  RefundDto bookingCode(String bookingCode) => call(bookingCode: bookingCode);

  @override
  RefundDto guestName(String? guestName) => call(guestName: guestName);

  @override
  RefundDto guestPhone(String? guestPhone) => call(guestPhone: guestPhone);

  @override
  RefundDto amount(num amount) => call(amount: amount);

  @override
  RefundDto reason(RefundDtoReasonEnum reason) => call(reason: reason);

  @override
  RefundDto status(RefundDtoStatusEnum status) => call(status: status);

  @override
  RefundDto toBankBin(String? toBankBin) => call(toBankBin: toBankBin);

  @override
  RefundDto toAccountNo(String? toAccountNo) => call(toAccountNo: toAccountNo);

  @override
  RefundDto toAccountName(String? toAccountName) =>
      call(toAccountName: toAccountName);

  @override
  RefundDto note(String? note) => call(note: note);

  @override
  RefundDto createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  RefundDto doneAt(String? doneAt) => call(doneAt: doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RefundDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? bookingCode = const $CopyWithPlaceholder(),
    Object? guestName = const $CopyWithPlaceholder(),
    Object? guestPhone = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? toBankBin = const $CopyWithPlaceholder(),
    Object? toAccountNo = const $CopyWithPlaceholder(),
    Object? toAccountName = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? doneAt = const $CopyWithPlaceholder(),
  }) {
    return RefundDto(
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
      guestName: guestName == const $CopyWithPlaceholder()
          ? _value.guestName
          // ignore: cast_nullable_to_non_nullable
          : guestName as String?,
      guestPhone: guestPhone == const $CopyWithPlaceholder()
          ? _value.guestPhone
          // ignore: cast_nullable_to_non_nullable
          : guestPhone as String?,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as RefundDtoReasonEnum,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RefundDtoStatusEnum,
      toBankBin: toBankBin == const $CopyWithPlaceholder()
          ? _value.toBankBin
          // ignore: cast_nullable_to_non_nullable
          : toBankBin as String?,
      toAccountNo: toAccountNo == const $CopyWithPlaceholder()
          ? _value.toAccountNo
          // ignore: cast_nullable_to_non_nullable
          : toAccountNo as String?,
      toAccountName: toAccountName == const $CopyWithPlaceholder()
          ? _value.toAccountName
          // ignore: cast_nullable_to_non_nullable
          : toAccountName as String?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
      doneAt: doneAt == const $CopyWithPlaceholder()
          ? _value.doneAt
          // ignore: cast_nullable_to_non_nullable
          : doneAt as String?,
    );
  }
}

extension $RefundDtoCopyWith on RefundDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefundDto.copyWith(...)` or `instanceOfRefundDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundDtoCWProxy get copyWith => _$RefundDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundDto _$RefundDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'bookingId',
          'bookingCode',
          'amount',
          'reason',
          'status',
          'createdAt',
        ],
      );
      final val = RefundDto(
        id: $checkedConvert('id', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        bookingCode: $checkedConvert('bookingCode', (v) => v as String),
        guestName: $checkedConvert('guestName', (v) => v as String?),
        guestPhone: $checkedConvert('guestPhone', (v) => v as String?),
        amount: $checkedConvert('amount', (v) => v as num),
        reason: $checkedConvert(
          'reason',
          (v) => $enumDecode(_$RefundDtoReasonEnumEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$RefundDtoStatusEnumEnumMap, v),
        ),
        toBankBin: $checkedConvert('toBankBin', (v) => v as String?),
        toAccountNo: $checkedConvert('toAccountNo', (v) => v as String?),
        toAccountName: $checkedConvert('toAccountName', (v) => v as String?),
        note: $checkedConvert('note', (v) => v as String?),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        doneAt: $checkedConvert('doneAt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$RefundDtoToJson(RefundDto instance) => <String, dynamic>{
  'id': instance.id,
  'bookingId': instance.bookingId,
  'bookingCode': instance.bookingCode,
  'guestName': ?instance.guestName,
  'guestPhone': ?instance.guestPhone,
  'amount': instance.amount,
  'reason': _$RefundDtoReasonEnumEnumMap[instance.reason]!,
  'status': _$RefundDtoStatusEnumEnumMap[instance.status]!,
  'toBankBin': ?instance.toBankBin,
  'toAccountNo': ?instance.toAccountNo,
  'toAccountName': ?instance.toAccountName,
  'note': ?instance.note,
  'createdAt': instance.createdAt,
  'doneAt': ?instance.doneAt,
};

const _$RefundDtoReasonEnumEnumMap = {
  RefundDtoReasonEnum.RESTAURANT_CANCELLED: 'RESTAURANT_CANCELLED',
  RefundDtoReasonEnum.CUSTOMER_CANCELLED: 'CUSTOMER_CANCELLED',
  RefundDtoReasonEnum.LATE_PAYMENT_NO_TABLE: 'LATE_PAYMENT_NO_TABLE',
  RefundDtoReasonEnum.AMOUNT_MISMATCH: 'AMOUNT_MISMATCH',
  RefundDtoReasonEnum.NO_SHOW_POLICY: 'NO_SHOW_POLICY',
};

const _$RefundDtoStatusEnumEnumMap = {
  RefundDtoStatusEnum.PENDING: 'PENDING',
  RefundDtoStatusEnum.DONE: 'DONE',
};
