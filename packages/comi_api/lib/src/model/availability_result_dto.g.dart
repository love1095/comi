// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AvailabilityResultDtoCWProxy {
  AvailabilityResultDto id(String id);

  AvailabilityResultDto isAvailable(bool isAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AvailabilityResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AvailabilityResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AvailabilityResultDto call({String id, bool isAvailable});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAvailabilityResultDto.copyWith(...)` or call `instanceOfAvailabilityResultDto.copyWith.fieldName(value)` for a single field.
class _$AvailabilityResultDtoCWProxyImpl
    implements _$AvailabilityResultDtoCWProxy {
  const _$AvailabilityResultDtoCWProxyImpl(this._value);

  final AvailabilityResultDto _value;

  @override
  AvailabilityResultDto id(String id) => call(id: id);

  @override
  AvailabilityResultDto isAvailable(bool isAvailable) =>
      call(isAvailable: isAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AvailabilityResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AvailabilityResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AvailabilityResultDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
  }) {
    return AvailabilityResultDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isAvailable:
          isAvailable == const $CopyWithPlaceholder() || isAvailable == null
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool,
    );
  }
}

extension $AvailabilityResultDtoCopyWith on AvailabilityResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAvailabilityResultDto.copyWith(...)` or `instanceOfAvailabilityResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AvailabilityResultDtoCWProxy get copyWith =>
      _$AvailabilityResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailabilityResultDto _$AvailabilityResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AvailabilityResultDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'isAvailable']);
  final val = AvailabilityResultDto(
    id: $checkedConvert('id', (v) => v as String),
    isAvailable: $checkedConvert('isAvailable', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$AvailabilityResultDtoToJson(
  AvailabilityResultDto instance,
) => <String, dynamic>{'id': instance.id, 'isAvailable': instance.isAvailable};
