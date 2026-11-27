// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_table_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MoveTableDtoCWProxy {
  MoveTableDto tableId(String tableId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MoveTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MoveTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MoveTableDto call({String tableId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMoveTableDto.copyWith(...)` or call `instanceOfMoveTableDto.copyWith.fieldName(value)` for a single field.
class _$MoveTableDtoCWProxyImpl implements _$MoveTableDtoCWProxy {
  const _$MoveTableDtoCWProxyImpl(this._value);

  final MoveTableDto _value;

  @override
  MoveTableDto tableId(String tableId) => call(tableId: tableId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MoveTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MoveTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MoveTableDto call({Object? tableId = const $CopyWithPlaceholder()}) {
    return MoveTableDto(
      tableId: tableId == const $CopyWithPlaceholder() || tableId == null
          ? _value.tableId
          // ignore: cast_nullable_to_non_nullable
          : tableId as String,
    );
  }
}

extension $MoveTableDtoCopyWith on MoveTableDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMoveTableDto.copyWith(...)` or `instanceOfMoveTableDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MoveTableDtoCWProxy get copyWith => _$MoveTableDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoveTableDto _$MoveTableDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MoveTableDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['tableId']);
      final val = MoveTableDto(
        tableId: $checkedConvert('tableId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$MoveTableDtoToJson(MoveTableDto instance) =>
    <String, dynamic>{'tableId': instance.tableId};
