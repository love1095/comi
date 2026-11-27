// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReorderDtoCWProxy {
  ReorderDto ids(List<String> ids);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReorderDto call({List<String> ids});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReorderDto.copyWith(...)` or call `instanceOfReorderDto.copyWith.fieldName(value)` for a single field.
class _$ReorderDtoCWProxyImpl implements _$ReorderDtoCWProxy {
  const _$ReorderDtoCWProxyImpl(this._value);

  final ReorderDto _value;

  @override
  ReorderDto ids(List<String> ids) => call(ids: ids);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReorderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReorderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReorderDto call({Object? ids = const $CopyWithPlaceholder()}) {
    return ReorderDto(
      ids: ids == const $CopyWithPlaceholder() || ids == null
          ? _value.ids
          // ignore: cast_nullable_to_non_nullable
          : ids as List<String>,
    );
  }
}

extension $ReorderDtoCopyWith on ReorderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReorderDto.copyWith(...)` or `instanceOfReorderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReorderDtoCWProxy get copyWith => _$ReorderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReorderDto _$ReorderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReorderDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['ids']);
      final val = ReorderDto(
        ids: $checkedConvert(
          'ids',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReorderDtoToJson(ReorderDto instance) =>
    <String, dynamic>{'ids': instance.ids};
