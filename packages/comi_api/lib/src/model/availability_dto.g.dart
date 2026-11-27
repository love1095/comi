// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AvailabilityDtoCWProxy {
  AvailabilityDto isAvailable(bool isAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AvailabilityDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AvailabilityDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AvailabilityDto call({bool isAvailable});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAvailabilityDto.copyWith(...)` or call `instanceOfAvailabilityDto.copyWith.fieldName(value)` for a single field.
class _$AvailabilityDtoCWProxyImpl implements _$AvailabilityDtoCWProxy {
  const _$AvailabilityDtoCWProxyImpl(this._value);

  final AvailabilityDto _value;

  @override
  AvailabilityDto isAvailable(bool isAvailable) =>
      call(isAvailable: isAvailable);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AvailabilityDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AvailabilityDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AvailabilityDto call({Object? isAvailable = const $CopyWithPlaceholder()}) {
    return AvailabilityDto(
      isAvailable:
          isAvailable == const $CopyWithPlaceholder() || isAvailable == null
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool,
    );
  }
}

extension $AvailabilityDtoCopyWith on AvailabilityDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAvailabilityDto.copyWith(...)` or `instanceOfAvailabilityDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AvailabilityDtoCWProxy get copyWith => _$AvailabilityDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailabilityDto _$AvailabilityDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AvailabilityDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['isAvailable']);
      final val = AvailabilityDto(
        isAvailable: $checkedConvert('isAvailable', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$AvailabilityDtoToJson(AvailabilityDto instance) =>
    <String, dynamic>{'isAvailable': instance.isAvailable};
