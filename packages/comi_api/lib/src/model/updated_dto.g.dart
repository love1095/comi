// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdatedDtoCWProxy {
  UpdatedDto updated(num updated);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdatedDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdatedDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdatedDto call({num updated});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdatedDto.copyWith(...)` or call `instanceOfUpdatedDto.copyWith.fieldName(value)` for a single field.
class _$UpdatedDtoCWProxyImpl implements _$UpdatedDtoCWProxy {
  const _$UpdatedDtoCWProxyImpl(this._value);

  final UpdatedDto _value;

  @override
  UpdatedDto updated(num updated) => call(updated: updated);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdatedDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdatedDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UpdatedDto call({Object? updated = const $CopyWithPlaceholder()}) {
    return UpdatedDto(
      updated: updated == const $CopyWithPlaceholder() || updated == null
          ? _value.updated
          // ignore: cast_nullable_to_non_nullable
          : updated as num,
    );
  }
}

extension $UpdatedDtoCopyWith on UpdatedDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdatedDto.copyWith(...)` or `instanceOfUpdatedDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdatedDtoCWProxy get copyWith => _$UpdatedDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedDto _$UpdatedDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdatedDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['updated']);
      final val = UpdatedDto(
        updated: $checkedConvert('updated', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$UpdatedDtoToJson(UpdatedDto instance) =>
    <String, dynamic>{'updated': instance.updated};
