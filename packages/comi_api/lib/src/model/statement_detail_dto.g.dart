// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_detail_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatementDetailDtoCWProxy {
  StatementDetailDto id(String id);

  StatementDetailDto restaurantId(String restaurantId);

  StatementDetailDto periodMonth(String periodMonth);

  StatementDetailDto bookingCount(num bookingCount);

  StatementDetailDto totalBase(num totalBase);

  StatementDetailDto totalFee(num totalFee);

  StatementDetailDto platformVoucherCredit(num platformVoucherCredit);

  StatementDetailDto amountDue(num amountDue);

  StatementDetailDto status(StatementDetailDtoStatusEnum status);

  StatementDetailDto issuedAt(String? issuedAt);

  StatementDetailDto paidAt(String? paidAt);

  StatementDetailDto dueAt(String? dueAt);

  StatementDetailDto transferMemo(String transferMemo);

  StatementDetailDto vietQrUrl(String? vietQrUrl);

  StatementDetailDto lines(List<StatementLineDto> lines);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementDetailDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementDetailDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StatementDetailDto call({
    String id,
    String restaurantId,
    String periodMonth,
    num bookingCount,
    num totalBase,
    num totalFee,
    num platformVoucherCredit,
    num amountDue,
    StatementDetailDtoStatusEnum status,
    String? issuedAt,
    String? paidAt,
    String? dueAt,
    String transferMemo,
    String? vietQrUrl,
    List<StatementLineDto> lines,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStatementDetailDto.copyWith(...)` or call `instanceOfStatementDetailDto.copyWith.fieldName(value)` for a single field.
class _$StatementDetailDtoCWProxyImpl implements _$StatementDetailDtoCWProxy {
  const _$StatementDetailDtoCWProxyImpl(this._value);

  final StatementDetailDto _value;

  @override
  StatementDetailDto id(String id) => call(id: id);

  @override
  StatementDetailDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  StatementDetailDto periodMonth(String periodMonth) =>
      call(periodMonth: periodMonth);

  @override
  StatementDetailDto bookingCount(num bookingCount) =>
      call(bookingCount: bookingCount);

  @override
  StatementDetailDto totalBase(num totalBase) => call(totalBase: totalBase);

  @override
  StatementDetailDto totalFee(num totalFee) => call(totalFee: totalFee);

  @override
  StatementDetailDto platformVoucherCredit(num platformVoucherCredit) =>
      call(platformVoucherCredit: platformVoucherCredit);

  @override
  StatementDetailDto amountDue(num amountDue) => call(amountDue: amountDue);

  @override
  StatementDetailDto status(StatementDetailDtoStatusEnum status) =>
      call(status: status);

  @override
  StatementDetailDto issuedAt(String? issuedAt) => call(issuedAt: issuedAt);

  @override
  StatementDetailDto paidAt(String? paidAt) => call(paidAt: paidAt);

  @override
  StatementDetailDto dueAt(String? dueAt) => call(dueAt: dueAt);

  @override
  StatementDetailDto transferMemo(String transferMemo) =>
      call(transferMemo: transferMemo);

  @override
  StatementDetailDto vietQrUrl(String? vietQrUrl) => call(vietQrUrl: vietQrUrl);

  @override
  StatementDetailDto lines(List<StatementLineDto> lines) => call(lines: lines);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StatementDetailDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StatementDetailDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StatementDetailDto call({
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
    Object? lines = const $CopyWithPlaceholder(),
  }) {
    return StatementDetailDto(
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
          : status as StatementDetailDtoStatusEnum,
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
      lines: lines == const $CopyWithPlaceholder() || lines == null
          ? _value.lines
          // ignore: cast_nullable_to_non_nullable
          : lines as List<StatementLineDto>,
    );
  }
}

extension $StatementDetailDtoCopyWith on StatementDetailDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStatementDetailDto.copyWith(...)` or `instanceOfStatementDetailDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatementDetailDtoCWProxy get copyWith =>
      _$StatementDetailDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementDetailDto _$StatementDetailDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StatementDetailDto', json, ($checkedConvert) {
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
          'lines',
        ],
      );
      final val = StatementDetailDto(
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
          (v) => $enumDecode(_$StatementDetailDtoStatusEnumEnumMap, v),
        ),
        issuedAt: $checkedConvert('issuedAt', (v) => v as String?),
        paidAt: $checkedConvert('paidAt', (v) => v as String?),
        dueAt: $checkedConvert('dueAt', (v) => v as String?),
        transferMemo: $checkedConvert('transferMemo', (v) => v as String),
        vietQrUrl: $checkedConvert('vietQrUrl', (v) => v as String?),
        lines: $checkedConvert(
          'lines',
          (v) => (v as List<dynamic>)
              .map((e) => StatementLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StatementDetailDtoToJson(StatementDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'periodMonth': instance.periodMonth,
      'bookingCount': instance.bookingCount,
      'totalBase': instance.totalBase,
      'totalFee': instance.totalFee,
      'platformVoucherCredit': instance.platformVoucherCredit,
      'amountDue': instance.amountDue,
      'status': _$StatementDetailDtoStatusEnumEnumMap[instance.status]!,
      'issuedAt': ?instance.issuedAt,
      'paidAt': ?instance.paidAt,
      'dueAt': ?instance.dueAt,
      'transferMemo': instance.transferMemo,
      'vietQrUrl': ?instance.vietQrUrl,
      'lines': instance.lines.map((e) => e.toJson()).toList(),
    };

const _$StatementDetailDtoStatusEnumEnumMap = {
  StatementDetailDtoStatusEnum.DRAFT: 'DRAFT',
  StatementDetailDtoStatusEnum.ISSUED: 'ISSUED',
  StatementDetailDtoStatusEnum.PAID: 'PAID',
  StatementDetailDtoStatusEnum.OVERDUE: 'OVERDUE',
};
