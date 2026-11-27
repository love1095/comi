// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_booking_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardBookingDtoCWProxy {
  BoardBookingDto id(String id);

  BoardBookingDto code(String code);

  BoardBookingDto partySize(num partySize);

  BoardBookingDto arrivalAt(String arrivalAt);

  BoardBookingDto endsAt(String endsAt);

  BoardBookingDto status(BookingStatus status);

  BoardBookingDto paymentMode(PaymentMode paymentMode);

  BoardBookingDto needsApproval(bool needsApproval);

  BoardBookingDto note(String? note);

  BoardBookingDto tableId(String? tableId);

  BoardBookingDto extraTableIds(List<String> extraTableIds);

  BoardBookingDto table(BoardTableDto? table);

  BoardBookingDto user(BoardUserDto user);

  BoardBookingDto order(BoardOrderDto? order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BoardBookingDto call({
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
    BoardOrderDto? order,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBoardBookingDto.copyWith(...)` or call `instanceOfBoardBookingDto.copyWith.fieldName(value)` for a single field.
class _$BoardBookingDtoCWProxyImpl implements _$BoardBookingDtoCWProxy {
  const _$BoardBookingDtoCWProxyImpl(this._value);

  final BoardBookingDto _value;

  @override
  BoardBookingDto id(String id) => call(id: id);

  @override
  BoardBookingDto code(String code) => call(code: code);

  @override
  BoardBookingDto partySize(num partySize) => call(partySize: partySize);

  @override
  BoardBookingDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  BoardBookingDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  BoardBookingDto status(BookingStatus status) => call(status: status);

  @override
  BoardBookingDto paymentMode(PaymentMode paymentMode) =>
      call(paymentMode: paymentMode);

  @override
  BoardBookingDto needsApproval(bool needsApproval) =>
      call(needsApproval: needsApproval);

  @override
  BoardBookingDto note(String? note) => call(note: note);

  @override
  BoardBookingDto tableId(String? tableId) => call(tableId: tableId);

  @override
  BoardBookingDto extraTableIds(List<String> extraTableIds) =>
      call(extraTableIds: extraTableIds);

  @override
  BoardBookingDto table(BoardTableDto? table) => call(table: table);

  @override
  BoardBookingDto user(BoardUserDto user) => call(user: user);

  @override
  BoardBookingDto order(BoardOrderDto? order) => call(order: order);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BoardBookingDto call({
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
    return BoardBookingDto(
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
          : order as BoardOrderDto?,
    );
  }
}

extension $BoardBookingDtoCopyWith on BoardBookingDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBoardBookingDto.copyWith(...)` or `instanceOfBoardBookingDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardBookingDtoCWProxy get copyWith => _$BoardBookingDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardBookingDto _$BoardBookingDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BoardBookingDto', json, ($checkedConvert) {
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
  final val = BoardBookingDto(
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
      (v) =>
          v == null ? null : BoardTableDto.fromJson(v as Map<String, dynamic>),
    ),
    user: $checkedConvert(
      'user',
      (v) => BoardUserDto.fromJson(v as Map<String, dynamic>),
    ),
    order: $checkedConvert(
      'order',
      (v) =>
          v == null ? null : BoardOrderDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$BoardBookingDtoToJson(BoardBookingDto instance) =>
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
