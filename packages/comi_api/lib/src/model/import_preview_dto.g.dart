// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_preview_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ImportPreviewDtoCWProxy {
  ImportPreviewDto items(List<ImportedItemDto> items);

  ImportPreviewDto errors(List<ImportErrorDto> errors);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportPreviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportPreviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ImportPreviewDto call({
    List<ImportedItemDto> items,
    List<ImportErrorDto> errors,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfImportPreviewDto.copyWith(...)` or call `instanceOfImportPreviewDto.copyWith.fieldName(value)` for a single field.
class _$ImportPreviewDtoCWProxyImpl implements _$ImportPreviewDtoCWProxy {
  const _$ImportPreviewDtoCWProxyImpl(this._value);

  final ImportPreviewDto _value;

  @override
  ImportPreviewDto items(List<ImportedItemDto> items) => call(items: items);

  @override
  ImportPreviewDto errors(List<ImportErrorDto> errors) => call(errors: errors);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportPreviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportPreviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ImportPreviewDto call({
    Object? items = const $CopyWithPlaceholder(),
    Object? errors = const $CopyWithPlaceholder(),
  }) {
    return ImportPreviewDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ImportedItemDto>,
      errors: errors == const $CopyWithPlaceholder() || errors == null
          ? _value.errors
          // ignore: cast_nullable_to_non_nullable
          : errors as List<ImportErrorDto>,
    );
  }
}

extension $ImportPreviewDtoCopyWith on ImportPreviewDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfImportPreviewDto.copyWith(...)` or `instanceOfImportPreviewDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImportPreviewDtoCWProxy get copyWith => _$ImportPreviewDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportPreviewDto _$ImportPreviewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportPreviewDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'errors']);
      final val = ImportPreviewDto(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => ImportedItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        errors: $checkedConvert(
          'errors',
          (v) => (v as List<dynamic>)
              .map((e) => ImportErrorDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ImportPreviewDtoToJson(ImportPreviewDto instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'errors': instance.errors.map((e) => e.toJson()).toList(),
    };
