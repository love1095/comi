// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_hold_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateHoldDtoCWProxy {
  CreateHoldDto tableIds(List<String> tableIds);

  CreateHoldDto arrivalAt(String arrivalAt);

  CreateHoldDto partySize(num partySize);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateHoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateHoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CreateHoldDto call({List<String> tableIds, String arrivalAt, num partySize});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCreateHoldDto.copyWith(...)` or call `instanceOfCreateHoldDto.copyWith.fieldName(value)` for a single field.
class _$CreateHoldDtoCWProxyImpl implements _$CreateHoldDtoCWProxy {
  const _$CreateHoldDtoCWProxyImpl(this._value);

  final CreateHoldDto _value;

  @override
  CreateHoldDto tableIds(List<String> tableIds) => call(tableIds: tableIds);

  @override
  CreateHoldDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  CreateHoldDto partySize(num partySize) => call(partySize: partySize);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateHoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateHoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CreateHoldDto call({
    Object? tableIds = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
  }) {
    return CreateHoldDto(
      tableIds: tableIds == const $CopyWithPlaceholder() || tableIds == null
          ? _value.tableIds
          // ignore: cast_nullable_to_non_nullable
          : tableIds as List<String>,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
    );
  }
}

extension $CreateHoldDtoCopyWith on CreateHoldDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCreateHoldDto.copyWith(...)` or `instanceOfCreateHoldDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateHoldDtoCWProxy get copyWith => _$CreateHoldDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateHoldDto _$CreateHoldDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateHoldDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['tableIds', 'arrivalAt', 'partySize'],
      );
      final val = CreateHoldDto(
        tableIds: $checkedConvert(
          'tableIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CreateHoldDtoToJson(CreateHoldDto instance) =>
    <String, dynamic>{
      'tableIds': instance.tableIds,
      'arrivalAt': instance.arrivalAt,
      'partySize': instance.partySize,
    };
