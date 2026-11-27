// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_table_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardTableDtoCWProxy {
  BoardTableDto id(String id);

  BoardTableDto code(String code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BoardTableDto call({String id, String code});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBoardTableDto.copyWith(...)` or call `instanceOfBoardTableDto.copyWith.fieldName(value)` for a single field.
class _$BoardTableDtoCWProxyImpl implements _$BoardTableDtoCWProxy {
  const _$BoardTableDtoCWProxyImpl(this._value);

  final BoardTableDto _value;

  @override
  BoardTableDto id(String id) => call(id: id);

  @override
  BoardTableDto code(String code) => call(code: code);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BoardTableDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
  }) {
    return BoardTableDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
    );
  }
}

extension $BoardTableDtoCopyWith on BoardTableDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBoardTableDto.copyWith(...)` or `instanceOfBoardTableDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardTableDtoCWProxy get copyWith => _$BoardTableDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardTableDto _$BoardTableDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BoardTableDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'code']);
      final val = BoardTableDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BoardTableDtoToJson(BoardTableDto instance) =>
    <String, dynamic>{'id': instance.id, 'code': instance.code};
