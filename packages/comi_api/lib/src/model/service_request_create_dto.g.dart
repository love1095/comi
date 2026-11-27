// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_create_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ServiceRequestCreateDtoCWProxy {
  ServiceRequestCreateDto type(ServiceType type);

  ServiceRequestCreateDto note(String? note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ServiceRequestCreateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ServiceRequestCreateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ServiceRequestCreateDto call({ServiceType type, String? note});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfServiceRequestCreateDto.copyWith(...)` or call `instanceOfServiceRequestCreateDto.copyWith.fieldName(value)` for a single field.
class _$ServiceRequestCreateDtoCWProxyImpl
    implements _$ServiceRequestCreateDtoCWProxy {
  const _$ServiceRequestCreateDtoCWProxyImpl(this._value);

  final ServiceRequestCreateDto _value;

  @override
  ServiceRequestCreateDto type(ServiceType type) => call(type: type);

  @override
  ServiceRequestCreateDto note(String? note) => call(note: note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ServiceRequestCreateDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ServiceRequestCreateDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ServiceRequestCreateDto call({
    Object? type = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return ServiceRequestCreateDto(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ServiceType,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $ServiceRequestCreateDtoCopyWith on ServiceRequestCreateDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfServiceRequestCreateDto.copyWith(...)` or `instanceOfServiceRequestCreateDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ServiceRequestCreateDtoCWProxy get copyWith =>
      _$ServiceRequestCreateDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestCreateDto _$ServiceRequestCreateDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ServiceRequestCreateDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type']);
  final val = ServiceRequestCreateDto(
    type: $checkedConvert('type', (v) => $enumDecode(_$ServiceTypeEnumMap, v)),
    note: $checkedConvert('note', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ServiceRequestCreateDtoToJson(
  ServiceRequestCreateDto instance,
) => <String, dynamic>{
  'type': _$ServiceTypeEnumMap[instance.type]!,
  'note': ?instance.note,
};

const _$ServiceTypeEnumMap = {
  ServiceType.CALL_WAITER: 'CALL_WAITER',
  ServiceType.MORE_ICE: 'MORE_ICE',
  ServiceType.MORE_BOWLS: 'MORE_BOWLS',
  ServiceType.BILL_PLEASE: 'BILL_PLEASE',
  ServiceType.OTHER: 'OTHER',
};
