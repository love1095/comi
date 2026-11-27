// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_hold_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MyHoldDtoCWProxy {
  MyHoldDto holdId(String holdId);

  MyHoldDto expiresAt(String expiresAt);

  MyHoldDto tableIds(List<String> tableIds);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MyHoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyHoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MyHoldDto call({String holdId, String expiresAt, List<String> tableIds});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMyHoldDto.copyWith(...)` or call `instanceOfMyHoldDto.copyWith.fieldName(value)` for a single field.
class _$MyHoldDtoCWProxyImpl implements _$MyHoldDtoCWProxy {
  const _$MyHoldDtoCWProxyImpl(this._value);

  final MyHoldDto _value;

  @override
  MyHoldDto holdId(String holdId) => call(holdId: holdId);

  @override
  MyHoldDto expiresAt(String expiresAt) => call(expiresAt: expiresAt);

  @override
  MyHoldDto tableIds(List<String> tableIds) => call(tableIds: tableIds);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MyHoldDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyHoldDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MyHoldDto call({
    Object? holdId = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? tableIds = const $CopyWithPlaceholder(),
  }) {
    return MyHoldDto(
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
    );
  }
}

extension $MyHoldDtoCopyWith on MyHoldDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMyHoldDto.copyWith(...)` or `instanceOfMyHoldDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MyHoldDtoCWProxy get copyWith => _$MyHoldDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyHoldDto _$MyHoldDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MyHoldDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['holdId', 'expiresAt', 'tableIds']);
      final val = MyHoldDto(
        holdId: $checkedConvert('holdId', (v) => v as String),
        expiresAt: $checkedConvert('expiresAt', (v) => v as String),
        tableIds: $checkedConvert(
          'tableIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MyHoldDtoToJson(MyHoldDto instance) => <String, dynamic>{
  'holdId': instance.holdId,
  'expiresAt': instance.expiresAt,
  'tableIds': instance.tableIds,
};
