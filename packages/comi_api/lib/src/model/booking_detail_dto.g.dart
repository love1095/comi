// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingDetailDtoCWProxy {
  BookingDetailDto id(String id);

  BookingDetailDto code(String code);

  BookingDetailDto partySize(num partySize);

  BookingDetailDto arrivalAt(String arrivalAt);

  BookingDetailDto endsAt(String endsAt);

  BookingDetailDto status(BookingStatus status);

  BookingDetailDto paymentMode(PaymentMode paymentMode);

  BookingDetailDto needsApproval(bool needsApproval);

  BookingDetailDto note(String? note);

  BookingDetailDto tableId(String? tableId);

  BookingDetailDto extraTableIds(List<String> extraTableIds);

  BookingDetailDto table(BoardTableDto? table);

  BookingDetailDto user(BoardUserDto user);

  BookingDetailDto order(BookingDetailOrderDto? order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingDetailDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingDetailDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingDetailDto call({
    String id,
    String code,
    num partySize,
    String arrivalAt,
    String endsAt,
    BookingStatus status,
    PaymentMode paymentMode,
    bool needsApproval,
    String? note,
    String? tableId,
    List<String> extraTableIds,
    BoardTableDto? table,
    BoardUserDto user,
    BookingDetailOrderDto? order,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingDetailDto.copyWith(...)` or call `instanceOfBookingDetailDto.copyWith.fieldName(value)` for a single field.
class _$BookingDetailDtoCWProxyImpl implements _$BookingDetailDtoCWProxy {
  const _$BookingDetailDtoCWProxyImpl(this._value);

  final BookingDetailDto _value;

  @override
  BookingDetailDto id(String id) => call(id: id);

  @override
  BookingDetailDto code(String code) => call(code: code);

  @override
  BookingDetailDto partySize(num partySize) => call(partySize: partySize);

  @override
  BookingDetailDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  BookingDetailDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  BookingDetailDto status(BookingStatus status) => call(status: status);

  @override
  BookingDetailDto paymentMode(PaymentMode paymentMode) =>
      call(paymentMode: paymentMode);

  @override
  BookingDetailDto needsApproval(bool needsApproval) =>
      call(needsApproval: needsApproval);

  @override
  BookingDetailDto note(String? note) => call(note: note);

  @override
  BookingDetailDto tableId(String? tableId) => call(tableId: tableId);

  @override
  BookingDetailDto extraTableIds(List<String> extraTableIds) =>
      call(extraTableIds: extraTableIds);

  @override
  BookingDetailDto table(BoardTableDto? table) => call(table: table);

  @override
  BookingDetailDto user(BoardUserDto user) => call(user: user);

  @override
  BookingDetailDto order(BookingDetailOrderDto? order) => call(order: order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingDetailDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingDetailDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingDetailDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? paymentMode = const $CopyWithPlaceholder(),
    Object? needsApproval = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? tableId = const $CopyWithPlaceholder(),
    Object? extraTableIds = const $CopyWithPlaceholder(),
    Object? table = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return BookingDetailDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      endsAt: endsAt == const $CopyWithPlaceholder() || endsAt == null
          ? _value.endsAt
          // ignore: cast_nullable_to_non_nullable
          : endsAt as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingStatus,
      paymentMode:
          paymentMode == const $CopyWithPlaceholder() || paymentMode == null
          ? _value.paymentMode
          // ignore: cast_nullable_to_non_nullable
          : paymentMode as PaymentMode,
      needsApproval:
          needsApproval == const $CopyWithPlaceholder() || needsApproval == null
          ? _value.needsApproval
          // ignore: cast_nullable_to_non_nullable
          : needsApproval as bool,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      tableId: tableId == const $CopyWithPlaceholder()
          ? _value.tableId
          // ignore: cast_nullable_to_non_nullable
          : tableId as String?,
      extraTableIds:
          extraTableIds == const $CopyWithPlaceholder() || extraTableIds == null
          ? _value.extraTableIds
          // ignore: cast_nullable_to_non_nullable
          : extraTableIds as List<String>,
      table: table == const $CopyWithPlaceholder()
          ? _value.table
          // ignore: cast_nullable_to_non_nullable
          : table as BoardTableDto?,
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as BoardUserDto,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as BookingDetailOrderDto?,
    );
  }
}

extension $BookingDetailDtoCopyWith on BookingDetailDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingDetailDto.copyWith(...)` or `instanceOfBookingDetailDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingDetailDtoCWProxy get copyWith => _$BookingDetailDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailDto _$BookingDetailDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BookingDetailDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'partySize',
          'arrivalAt',
          'endsAt',
          'status',
          'paymentMode',
          'needsApproval',
          'extraTableIds',
          'user',
        ],
      );
      final val = BookingDetailDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingStatusEnumMap, v),
        ),
        paymentMode: $checkedConvert(
          'paymentMode',
          (v) => $enumDecode(_$PaymentModeEnumMap, v),
        ),
        needsApproval: $checkedConvert('needsApproval', (v) => v as bool),
        note: $checkedConvert('note', (v) => v as String?),
        tableId: $checkedConvert('tableId', (v) => v as String?),
        extraTableIds: $checkedConvert(
          'extraTableIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        table: $checkedConvert(
          'table',
          (v) => v == null
              ? null
              : BoardTableDto.fromJson(v as Map<String, dynamic>),
        ),
        user: $checkedConvert(
          'user',
          (v) => BoardUserDto.fromJson(v as Map<String, dynamic>),
        ),
        order: $checkedConvert(
          'order',
          (v) => v == null
              ? null
              : BookingDetailOrderDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BookingDetailDtoToJson(BookingDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'partySize': instance.partySize,
      'arrivalAt': instance.arrivalAt,
      'endsAt': instance.endsAt,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'paymentMode': _$PaymentModeEnumMap[instance.paymentMode]!,
      'needsApproval': instance.needsApproval,
      'note': ?instance.note,
      'tableId': ?instance.tableId,
      'extraTableIds': instance.extraTableIds,
      'table': ?instance.table?.toJson(),
      'user': instance.user.toJson(),
      'order': ?instance.order?.toJson(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.PENDING: 'PENDING',
  BookingStatus.CONFIRMED: 'CONFIRMED',
  BookingStatus.CHECKED_IN: 'CHECKED_IN',
  BookingStatus.COMPLETED: 'COMPLETED',
  BookingStatus.CANCELLED: 'CANCELLED',
  BookingStatus.NO_SHOW: 'NO_SHOW',
  BookingStatus.EXPIRED: 'EXPIRED',
};

const _$PaymentModeEnumMap = {
  PaymentMode.PREPAID: 'PREPAID',
  PaymentMode.COD: 'COD',
};
