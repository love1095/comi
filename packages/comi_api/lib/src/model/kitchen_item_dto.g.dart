// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KitchenItemDtoCWProxy {
  KitchenItemDto id(String id);

  KitchenItemDto bookingId(String bookingId);

  KitchenItemDto bookingCode(String bookingCode);

  KitchenItemDto tableCode(String? tableCode);

  KitchenItemDto partySize(num partySize);

  KitchenItemDto arrivalAt(String arrivalAt);

  KitchenItemDto guestArrived(bool guestArrived);

  KitchenItemDto nameSnapshot(String nameSnapshot);

  KitchenItemDto quantity(num quantity);

  KitchenItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot);

  KitchenItemDto note(String? note);

  KitchenItemDto course(Course course);

  KitchenItemDto prepMinutes(num prepMinutes);

  KitchenItemDto kitchenStatus(KitchenStatus kitchenStatus);

  KitchenItemDto round(num round);

  KitchenItemDto scheduledStartAt(String? scheduledStartAt);

  KitchenItemDto releasedAt(String? releasedAt);

  KitchenItemDto startedAt(String? startedAt);

  KitchenItemDto readyAt(String? readyAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  KitchenItemDto call({
    String id,
    String bookingId,
    String bookingCode,
    String? tableCode,
    num partySize,
    String arrivalAt,
    bool guestArrived,
    String nameSnapshot,
    num quantity,
    List<OptionSnapshotDto> optionsSnapshot,
    String? note,
    Course course,
    num prepMinutes,
    KitchenStatus kitchenStatus,
    num round,
    String? scheduledStartAt,
    String? releasedAt,
    String? startedAt,
    String? readyAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfKitchenItemDto.copyWith(...)` or call `instanceOfKitchenItemDto.copyWith.fieldName(value)` for a single field.
class _$KitchenItemDtoCWProxyImpl implements _$KitchenItemDtoCWProxy {
  const _$KitchenItemDtoCWProxyImpl(this._value);

  final KitchenItemDto _value;

  @override
  KitchenItemDto id(String id) => call(id: id);

  @override
  KitchenItemDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  KitchenItemDto bookingCode(String bookingCode) =>
      call(bookingCode: bookingCode);

  @override
  KitchenItemDto tableCode(String? tableCode) => call(tableCode: tableCode);

  @override
  KitchenItemDto partySize(num partySize) => call(partySize: partySize);

  @override
  KitchenItemDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  KitchenItemDto guestArrived(bool guestArrived) =>
      call(guestArrived: guestArrived);

  @override
  KitchenItemDto nameSnapshot(String nameSnapshot) =>
      call(nameSnapshot: nameSnapshot);

  @override
  KitchenItemDto quantity(num quantity) => call(quantity: quantity);

  @override
  KitchenItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot) =>
      call(optionsSnapshot: optionsSnapshot);

  @override
  KitchenItemDto note(String? note) => call(note: note);

  @override
  KitchenItemDto course(Course course) => call(course: course);

  @override
  KitchenItemDto prepMinutes(num prepMinutes) => call(prepMinutes: prepMinutes);

  @override
  KitchenItemDto kitchenStatus(KitchenStatus kitchenStatus) =>
      call(kitchenStatus: kitchenStatus);

  @override
  KitchenItemDto round(num round) => call(round: round);

  @override
  KitchenItemDto scheduledStartAt(String? scheduledStartAt) =>
      call(scheduledStartAt: scheduledStartAt);

  @override
  KitchenItemDto releasedAt(String? releasedAt) => call(releasedAt: releasedAt);

  @override
  KitchenItemDto startedAt(String? startedAt) => call(startedAt: startedAt);

  @override
  KitchenItemDto readyAt(String? readyAt) => call(readyAt: readyAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  KitchenItemDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? bookingCode = const $CopyWithPlaceholder(),
    Object? tableCode = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? guestArrived = const $CopyWithPlaceholder(),
    Object? nameSnapshot = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? optionsSnapshot = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? prepMinutes = const $CopyWithPlaceholder(),
    Object? kitchenStatus = const $CopyWithPlaceholder(),
    Object? round = const $CopyWithPlaceholder(),
    Object? scheduledStartAt = const $CopyWithPlaceholder(),
    Object? releasedAt = const $CopyWithPlaceholder(),
    Object? startedAt = const $CopyWithPlaceholder(),
    Object? readyAt = const $CopyWithPlaceholder(),
  }) {
    return KitchenItemDto(
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
      tableCode: tableCode == const $CopyWithPlaceholder()
          ? _value.tableCode
          // ignore: cast_nullable_to_non_nullable
          : tableCode as String?,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      guestArrived:
          guestArrived == const $CopyWithPlaceholder() || guestArrived == null
          ? _value.guestArrived
          // ignore: cast_nullable_to_non_nullable
          : guestArrived as bool,
      nameSnapshot:
          nameSnapshot == const $CopyWithPlaceholder() || nameSnapshot == null
          ? _value.nameSnapshot
          // ignore: cast_nullable_to_non_nullable
          : nameSnapshot as String,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      optionsSnapshot:
          optionsSnapshot == const $CopyWithPlaceholder() ||
              optionsSnapshot == null
          ? _value.optionsSnapshot
          // ignore: cast_nullable_to_non_nullable
          : optionsSnapshot as List<OptionSnapshotDto>,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      course: course == const $CopyWithPlaceholder() || course == null
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as Course,
      prepMinutes:
          prepMinutes == const $CopyWithPlaceholder() || prepMinutes == null
          ? _value.prepMinutes
          // ignore: cast_nullable_to_non_nullable
          : prepMinutes as num,
      kitchenStatus:
          kitchenStatus == const $CopyWithPlaceholder() || kitchenStatus == null
          ? _value.kitchenStatus
          // ignore: cast_nullable_to_non_nullable
          : kitchenStatus as KitchenStatus,
      round: round == const $CopyWithPlaceholder() || round == null
          ? _value.round
          // ignore: cast_nullable_to_non_nullable
          : round as num,
      scheduledStartAt: scheduledStartAt == const $CopyWithPlaceholder()
          ? _value.scheduledStartAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledStartAt as String?,
      releasedAt: releasedAt == const $CopyWithPlaceholder()
          ? _value.releasedAt
          // ignore: cast_nullable_to_non_nullable
          : releasedAt as String?,
      startedAt: startedAt == const $CopyWithPlaceholder()
          ? _value.startedAt
          // ignore: cast_nullable_to_non_nullable
          : startedAt as String?,
      readyAt: readyAt == const $CopyWithPlaceholder()
          ? _value.readyAt
          // ignore: cast_nullable_to_non_nullable
          : readyAt as String?,
    );
  }
}

extension $KitchenItemDtoCopyWith on KitchenItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfKitchenItemDto.copyWith(...)` or `instanceOfKitchenItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KitchenItemDtoCWProxy get copyWith => _$KitchenItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenItemDto _$KitchenItemDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('KitchenItemDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'bookingId',
      'bookingCode',
      'partySize',
      'arrivalAt',
      'guestArrived',
      'nameSnapshot',
      'quantity',
      'optionsSnapshot',
      'course',
      'prepMinutes',
      'kitchenStatus',
      'round',
    ],
  );
  final val = KitchenItemDto(
    id: $checkedConvert('id', (v) => v as String),
    bookingId: $checkedConvert('bookingId', (v) => v as String),
    bookingCode: $checkedConvert('bookingCode', (v) => v as String),
    tableCode: $checkedConvert('tableCode', (v) => v as String?),
    partySize: $checkedConvert('partySize', (v) => v as num),
    arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
    guestArrived: $checkedConvert('guestArrived', (v) => v as bool),
    nameSnapshot: $checkedConvert('nameSnapshot', (v) => v as String),
    quantity: $checkedConvert('quantity', (v) => v as num),
    optionsSnapshot: $checkedConvert(
      'optionsSnapshot',
      (v) => (v as List<dynamic>)
          .map((e) => OptionSnapshotDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    note: $checkedConvert('note', (v) => v as String?),
    course: $checkedConvert('course', (v) => $enumDecode(_$CourseEnumMap, v)),
    prepMinutes: $checkedConvert('prepMinutes', (v) => v as num),
    kitchenStatus: $checkedConvert(
      'kitchenStatus',
      (v) => $enumDecode(_$KitchenStatusEnumMap, v),
    ),
    round: $checkedConvert('round', (v) => v as num),
    scheduledStartAt: $checkedConvert('scheduledStartAt', (v) => v as String?),
    releasedAt: $checkedConvert('releasedAt', (v) => v as String?),
    startedAt: $checkedConvert('startedAt', (v) => v as String?),
    readyAt: $checkedConvert('readyAt', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$KitchenItemDtoToJson(
  KitchenItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'bookingId': instance.bookingId,
  'bookingCode': instance.bookingCode,
  'tableCode': ?instance.tableCode,
  'partySize': instance.partySize,
  'arrivalAt': instance.arrivalAt,
  'guestArrived': instance.guestArrived,
  'nameSnapshot': instance.nameSnapshot,
  'quantity': instance.quantity,
  'optionsSnapshot': instance.optionsSnapshot.map((e) => e.toJson()).toList(),
  'note': ?instance.note,
  'course': _$CourseEnumMap[instance.course]!,
  'prepMinutes': instance.prepMinutes,
  'kitchenStatus': _$KitchenStatusEnumMap[instance.kitchenStatus]!,
  'round': instance.round,
  'scheduledStartAt': ?instance.scheduledStartAt,
  'releasedAt': ?instance.releasedAt,
  'startedAt': ?instance.startedAt,
  'readyAt': ?instance.readyAt,
};

const _$CourseEnumMap = {
  Course.DRINK: 'DRINK',
  Course.STARTER: 'STARTER',
  Course.MAIN: 'MAIN',
  Course.DESSERT: 'DESSERT',
};

const _$KitchenStatusEnumMap = {
  KitchenStatus.HOLD: 'HOLD',
  KitchenStatus.SCHEDULED: 'SCHEDULED',
  KitchenStatus.QUEUED: 'QUEUED',
  KitchenStatus.COOKING: 'COOKING',
  KitchenStatus.READY: 'READY',
  KitchenStatus.SERVED: 'SERVED',
  KitchenStatus.CANCELLED: 'CANCELLED',
};
