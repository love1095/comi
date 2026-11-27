// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HoldDtoCWProxy {
  HoldDto holdId(String holdId);

  HoldDto expiresAt(String expiresAt);

  HoldDto tableIds(List<String> tableIds);

  HoldDto arrivalAt(String arrivalAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  HoldDto call({
    String holdId,
    String expiresAt,
    List<String> tableIds,
    String arrivalAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHoldDto.copyWith(...)` or call `instanceOfHoldDto.copyWith.fieldName(value)` for a single field.
class _$HoldDtoCWProxyImpl implements _$HoldDtoCWProxy {
  const _$HoldDtoCWProxyImpl(this._value);

  final HoldDto _value;

  @override
  HoldDto holdId(String holdId) => call(holdId: holdId);

  @override
  HoldDto expiresAt(String expiresAt) => call(expiresAt: expiresAt);

  @override
  HoldDto tableIds(List<String> tableIds) => call(tableIds: tableIds);

  @override
  HoldDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  HoldDto call({
    Object? holdId = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? tableIds = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
  }) {
    return HoldDto(
      holdId: holdId == const $CopyWithPlaceholder() || holdId == null
          ? _value.holdId
          // ignore: cast_nullable_to_non_nullable
          : holdId as String,
      expiresAt: expiresAt == const $CopyWithPlaceholder() || expiresAt == null
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as String,
      tableIds: tableIds == const $CopyWithPlaceholder() || tableIds == null
          ? _value.tableIds
          // ignore: cast_nullable_to_non_nullable
          : tableIds as List<String>,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
    );
  }
}

extension $HoldDtoCopyWith on HoldDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHoldDto.copyWith(...)` or `instanceOfHoldDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HoldDtoCWProxy get copyWith => _$HoldDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoldDto _$HoldDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HoldDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['holdId', 'expiresAt', 'tableIds', 'arrivalAt'],
      );
      final val = HoldDto(
        holdId: $checkedConvert('holdId', (v) => v as String),
        expiresAt: $checkedConvert('expiresAt', (v) => v as String),
        tableIds: $checkedConvert(
          'tableIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$HoldDtoToJson(HoldDto instance) => <String, dynamic>{
  'holdId': instance.holdId,
  'expiresAt': instance.expiresAt,
  'tableIds': instance.tableIds,
  'arrivalAt': instance.arrivalAt,
};
