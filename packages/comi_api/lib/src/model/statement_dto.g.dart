// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatementDtoCWProxy {
  StatementDto id(String id);

  StatementDto restaurantId(String restaurantId);

  StatementDto periodMonth(String periodMonth);

  StatementDto bookingCount(num bookingCount);

  StatementDto totalBase(num totalBase);

  StatementDto totalFee(num totalFee);

  StatementDto platformVoucherCredit(num platformVoucherCredit);

  StatementDto amountDue(num amountDue);

  StatementDto status(StatementDtoStatusEnum status);

  StatementDto issuedAt(String? issuedAt);

  StatementDto paidAt(String? paidAt);

  StatementDto dueAt(String? dueAt);

  StatementDto transferMemo(String transferMemo);

  StatementDto vietQrUrl(String? vietQrUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StatementDto call({
    String id,
    String restaurantId,
    String periodMonth,
    num bookingCount,
    num totalBase,
    num totalFee,
    num platformVoucherCredit,
    num amountDue,
    StatementDtoStatusEnum status,
    String? issuedAt,
    String? paidAt,
    String? dueAt,
    String transferMemo,
    String? vietQrUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStatementDto.copyWith(...)` or call `instanceOfStatementDto.copyWith.fieldName(value)` for a single field.
class _$StatementDtoCWProxyImpl implements _$StatementDtoCWProxy {
  const _$StatementDtoCWProxyImpl(this._value);

  final StatementDto _value;

  @override
  StatementDto id(String id) => call(id: id);

  @override
  StatementDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  StatementDto periodMonth(String periodMonth) =>
      call(periodMonth: periodMonth);

  @override
  StatementDto bookingCount(num bookingCount) =>
      call(bookingCount: bookingCount);

  @override
  StatementDto totalBase(num totalBase) => call(totalBase: totalBase);

  @override
  StatementDto totalFee(num totalFee) => call(totalFee: totalFee);

  @override
  StatementDto platformVoucherCredit(num platformVoucherCredit) =>
      call(platformVoucherCredit: platformVoucherCredit);

  @override
  StatementDto amountDue(num amountDue) => call(amountDue: amountDue);

  @override
  StatementDto status(StatementDtoStatusEnum status) => call(status: status);

  @override
  StatementDto issuedAt(String? issuedAt) => call(issuedAt: issuedAt);

  @override
  StatementDto paidAt(String? paidAt) => call(paidAt: paidAt);

  @override
  StatementDto dueAt(String? dueAt) => call(dueAt: dueAt);

  @override
  StatementDto transferMemo(String transferMemo) =>
      call(transferMemo: transferMemo);

  @override
  StatementDto vietQrUrl(String? vietQrUrl) => call(vietQrUrl: vietQrUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StatementDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? periodMonth = const $CopyWithPlaceholder(),
    Object? bookingCount = const $CopyWithPlaceholder(),
    Object? totalBase = const $CopyWithPlaceholder(),
    Object? totalFee = const $CopyWithPlaceholder(),
    Object? platformVoucherCredit = const $CopyWithPlaceholder(),
    Object? amountDue = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? issuedAt = const $CopyWithPlaceholder(),
    Object? paidAt = const $CopyWithPlaceholder(),
    Object? dueAt = const $CopyWithPlaceholder(),
    Object? transferMemo = const $CopyWithPlaceholder(),
    Object? vietQrUrl = const $CopyWithPlaceholder(),
  }) {
    return StatementDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      periodMonth:
          periodMonth == const $CopyWithPlaceholder() || periodMonth == null
          ? _value.periodMonth
          // ignore: cast_nullable_to_non_nullable
          : periodMonth as String,
      bookingCount:
          bookingCount == const $CopyWithPlaceholder() || bookingCount == null
          ? _value.bookingCount
          // ignore: cast_nullable_to_non_nullable
          : bookingCount as num,
      totalBase: totalBase == const $CopyWithPlaceholder() || totalBase == null
          ? _value.totalBase
          // ignore: cast_nullable_to_non_nullable
          : totalBase as num,
      totalFee: totalFee == const $CopyWithPlaceholder() || totalFee == null
          ? _value.totalFee
          // ignore: cast_nullable_to_non_nullable
          : totalFee as num,
      platformVoucherCredit:
          platformVoucherCredit == const $CopyWithPlaceholder() ||
              platformVoucherCredit == null
          ? _value.platformVoucherCredit
          // ignore: cast_nullable_to_non_nullable
          : platformVoucherCredit as num,
      amountDue: amountDue == const $CopyWithPlaceholder() || amountDue == null
          ? _value.amountDue
          // ignore: cast_nullable_to_non_nullable
          : amountDue as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as StatementDtoStatusEnum,
      issuedAt: issuedAt == const $CopyWithPlaceholder()
          ? _value.issuedAt
          // ignore: cast_nullable_to_non_nullable
          : issuedAt as String?,
      paidAt: paidAt == const $CopyWithPlaceholder()
          ? _value.paidAt
          // ignore: cast_nullable_to_non_nullable
          : paidAt as String?,
      dueAt: dueAt == const $CopyWithPlaceholder()
          ? _value.dueAt
          // ignore: cast_nullable_to_non_nullable
          : dueAt as String?,
      transferMemo:
          transferMemo == const $CopyWithPlaceholder() || transferMemo == null
          ? _value.transferMemo
          // ignore: cast_nullable_to_non_nullable
          : transferMemo as String,
      vietQrUrl: vietQrUrl == const $CopyWithPlaceholder()
          ? _value.vietQrUrl
          // ignore: cast_nullable_to_non_nullable
          : vietQrUrl as String?,
    );
  }
}

extension $StatementDtoCopyWith on StatementDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStatementDto.copyWith(...)` or `instanceOfStatementDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatementDtoCWProxy get copyWith => _$StatementDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementDto _$StatementDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StatementDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'restaurantId',
          'periodMonth',
          'bookingCount',
          'totalBase',
          'totalFee',
          'platformVoucherCredit',
          'amountDue',
          'status',
          'transferMemo',
        ],
      );
      final val = StatementDto(
        id: $checkedConvert('id', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        periodMonth: $checkedConvert('periodMonth', (v) => v as String),
        bookingCount: $checkedConvert('bookingCount', (v) => v as num),
        totalBase: $checkedConvert('totalBase', (v) => v as num),
        totalFee: $checkedConvert('totalFee', (v) => v as num),
        platformVoucherCredit: $checkedConvert(
          'platformVoucherCredit',
          (v) => v as num,
        ),
        amountDue: $checkedConvert('amountDue', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$StatementDtoStatusEnumEnumMap, v),
        ),
        issuedAt: $checkedConvert('issuedAt', (v) => v as String?),
        paidAt: $checkedConvert('paidAt', (v) => v as String?),
        dueAt: $checkedConvert('dueAt', (v) => v as String?),
        transferMemo: $checkedConvert('transferMemo', (v) => v as String),
        vietQrUrl: $checkedConvert('vietQrUrl', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$StatementDtoToJson(StatementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'periodMonth': instance.periodMonth,
      'bookingCount': instance.bookingCount,
      'totalBase': instance.totalBase,
      'totalFee': instance.totalFee,
      'platformVoucherCredit': instance.platformVoucherCredit,
      'amountDue': instance.amountDue,
      'status': _$StatementDtoStatusEnumEnumMap[instance.status]!,
      'issuedAt': ?instance.issuedAt,
      'paidAt': ?instance.paidAt,
      'dueAt': ?instance.dueAt,
      'transferMemo': instance.transferMemo,
      'vietQrUrl': ?instance.vietQrUrl,
    };

const _$StatementDtoStatusEnumEnumMap = {
  StatementDtoStatusEnum.DRAFT: 'DRAFT',
  StatementDtoStatusEnum.ISSUED: 'ISSUED',
  StatementDtoStatusEnum.PAID: 'PAID',
  StatementDtoStatusEnum.OVERDUE: 'OVERDUE',
};
