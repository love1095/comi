// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ImportResultDtoCWProxy {
  ImportResultDto created(num created);

  ImportResultDto categories(num categories);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ImportResultDto call({num created, num categories});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfImportResultDto.copyWith(...)` or call `instanceOfImportResultDto.copyWith.fieldName(value)` for a single field.
class _$ImportResultDtoCWProxyImpl implements _$ImportResultDtoCWProxy {
  const _$ImportResultDtoCWProxyImpl(this._value);

  final ImportResultDto _value;

  @override
  ImportResultDto created(num created) => call(created: created);

  @override
  ImportResultDto categories(num categories) => call(categories: categories);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ImportResultDto call({
    Object? created = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
  }) {
    return ImportResultDto(
      created: created == const $CopyWithPlaceholder() || created == null
          ? _value.created
          // ignore: cast_nullable_to_non_nullable
          : created as num,
      categories:
          categories == const $CopyWithPlaceholder() || categories == null
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as num,
    );
  }
}

extension $ImportResultDtoCopyWith on ImportResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfImportResultDto.copyWith(...)` or `instanceOfImportResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImportResultDtoCWProxy get copyWith => _$ImportResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportResultDto _$ImportResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportResultDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['created', 'categories']);
      final val = ImportResultDto(
        created: $checkedConvert('created', (v) => v as num),
        categories: $checkedConvert('categories', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ImportResultDtoToJson(ImportResultDto instance) =>
    <String, dynamic>{
      'created': instance.created,
      'categories': instance.categories,
    };
