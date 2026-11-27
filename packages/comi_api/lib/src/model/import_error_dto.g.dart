// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_error_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ImportErrorDtoCWProxy {
  ImportErrorDto row(num row);

  ImportErrorDto column(String? column);

  ImportErrorDto message(String message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportErrorDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportErrorDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ImportErrorDto call({num row, String? column, String message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfImportErrorDto.copyWith(...)` or call `instanceOfImportErrorDto.copyWith.fieldName(value)` for a single field.
class _$ImportErrorDtoCWProxyImpl implements _$ImportErrorDtoCWProxy {
  const _$ImportErrorDtoCWProxyImpl(this._value);

  final ImportErrorDto _value;

  @override
  ImportErrorDto row(num row) => call(row: row);

  @override
  ImportErrorDto column(String? column) => call(column: column);

  @override
  ImportErrorDto message(String message) => call(message: message);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportErrorDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportErrorDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ImportErrorDto call({
    Object? row = const $CopyWithPlaceholder(),
    Object? column = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return ImportErrorDto(
      row: row == const $CopyWithPlaceholder() || row == null
          ? _value.row
          // ignore: cast_nullable_to_non_nullable
          : row as num,
      column: column == const $CopyWithPlaceholder()
          ? _value.column
          // ignore: cast_nullable_to_non_nullable
          : column as String?,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $ImportErrorDtoCopyWith on ImportErrorDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfImportErrorDto.copyWith(...)` or `instanceOfImportErrorDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImportErrorDtoCWProxy get copyWith => _$ImportErrorDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportErrorDto _$ImportErrorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportErrorDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['row', 'message']);
      final val = ImportErrorDto(
        row: $checkedConvert('row', (v) => v as num),
        column: $checkedConvert('column', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ImportErrorDtoToJson(ImportErrorDto instance) =>
    <String, dynamic>{
      'row': instance.row,
      'column': ?instance.column,
      'message': instance.message,
    };
