// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ServiceRequestDtoCWProxy {
  ServiceRequestDto id(String id);

  ServiceRequestDto bookingId(String bookingId);

  ServiceRequestDto bookingCode(String bookingCode);

  ServiceRequestDto tableCode(String? tableCode);

  ServiceRequestDto type(ServiceType type);

  ServiceRequestDto note(String? note);

  ServiceRequestDto status(ServiceRequestDtoStatusEnum status);

  ServiceRequestDto createdAt(String createdAt);

  ServiceRequestDto doneAt(String? doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ServiceRequestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ServiceRequestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ServiceRequestDto call({
    String id,
    String bookingId,
    String bookingCode,
    String? tableCode,
    ServiceType type,
    String? note,
    ServiceRequestDtoStatusEnum status,
    String createdAt,
    String? doneAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfServiceRequestDto.copyWith(...)` or call `instanceOfServiceRequestDto.copyWith.fieldName(value)` for a single field.
class _$ServiceRequestDtoCWProxyImpl implements _$ServiceRequestDtoCWProxy {
  const _$ServiceRequestDtoCWProxyImpl(this._value);

  final ServiceRequestDto _value;

  @override
  ServiceRequestDto id(String id) => call(id: id);

  @override
  ServiceRequestDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  ServiceRequestDto bookingCode(String bookingCode) =>
      call(bookingCode: bookingCode);

  @override
  ServiceRequestDto tableCode(String? tableCode) => call(tableCode: tableCode);

  @override
  ServiceRequestDto type(ServiceType type) => call(type: type);

  @override
  ServiceRequestDto note(String? note) => call(note: note);

  @override
  ServiceRequestDto status(ServiceRequestDtoStatusEnum status) =>
      call(status: status);

  @override
  ServiceRequestDto createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  ServiceRequestDto doneAt(String? doneAt) => call(doneAt: doneAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ServiceRequestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ServiceRequestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ServiceRequestDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? bookingCode = const $CopyWithPlaceholder(),
    Object? tableCode = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? doneAt = const $CopyWithPlaceholder(),
  }) {
    return ServiceRequestDto(
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ServiceType,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ServiceRequestDtoStatusEnum,
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

extension $ServiceRequestDtoCopyWith on ServiceRequestDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfServiceRequestDto.copyWith(...)` or `instanceOfServiceRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServiceRequestDtoCWProxy get copyWith =>
      _$ServiceRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestDto _$ServiceRequestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ServiceRequestDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'bookingId',
          'bookingCode',
          'type',
          'status',
          'createdAt',
        ],
      );
      final val = ServiceRequestDto(
        id: $checkedConvert('id', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        bookingCode: $checkedConvert('bookingCode', (v) => v as String),
        tableCode: $checkedConvert('tableCode', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ServiceTypeEnumMap, v),
        ),
        note: $checkedConvert('note', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ServiceRequestDtoStatusEnumEnumMap, v),
        ),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        doneAt: $checkedConvert('doneAt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ServiceRequestDtoToJson(ServiceRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'bookingCode': instance.bookingCode,
      'tableCode': ?instance.tableCode,
      'type': _$ServiceTypeEnumMap[instance.type]!,
      'note': ?instance.note,
      'status': _$ServiceRequestDtoStatusEnumEnumMap[instance.status]!,
      'createdAt': instance.createdAt,
      'doneAt': ?instance.doneAt,
    };

const _$ServiceTypeEnumMap = {
  ServiceType.CALL_WAITER: 'CALL_WAITER',
  ServiceType.MORE_ICE: 'MORE_ICE',
  ServiceType.MORE_BOWLS: 'MORE_BOWLS',
  ServiceType.BILL_PLEASE: 'BILL_PLEASE',
  ServiceType.OTHER: 'OTHER',
};

const _$ServiceRequestDtoStatusEnumEnumMap = {
  ServiceRequestDtoStatusEnum.OPEN: 'OPEN',
  ServiceRequestDtoStatusEnum.DONE: 'DONE',
};
