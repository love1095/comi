// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_group_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StartGroupDtoCWProxy {
  StartGroupDto cutoffMinutes(num? cutoffMinutes);

  StartGroupDto maxGuests(num? maxGuests);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StartGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StartGroupDto call({num? cutoffMinutes, num? maxGuests});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStartGroupDto.copyWith(...)` or call `instanceOfStartGroupDto.copyWith.fieldName(value)` for a single field.
class _$StartGroupDtoCWProxyImpl implements _$StartGroupDtoCWProxy {
  const _$StartGroupDtoCWProxyImpl(this._value);

  final StartGroupDto _value;

  @override
  StartGroupDto cutoffMinutes(num? cutoffMinutes) =>
      call(cutoffMinutes: cutoffMinutes);

  @override
  StartGroupDto maxGuests(num? maxGuests) => call(maxGuests: maxGuests);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StartGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StartGroupDto call({
    Object? cutoffMinutes = const $CopyWithPlaceholder(),
    Object? maxGuests = const $CopyWithPlaceholder(),
  }) {
    return StartGroupDto(
      cutoffMinutes: cutoffMinutes == const $CopyWithPlaceholder()
          ? _value.cutoffMinutes
          // ignore: cast_nullable_to_non_nullable
          : cutoffMinutes as num?,
      maxGuests: maxGuests == const $CopyWithPlaceholder()
          ? _value.maxGuests
          // ignore: cast_nullable_to_non_nullable
          : maxGuests as num?,
    );
  }
}

extension $StartGroupDtoCopyWith on StartGroupDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStartGroupDto.copyWith(...)` or `instanceOfStartGroupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StartGroupDtoCWProxy get copyWith => _$StartGroupDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartGroupDto _$StartGroupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StartGroupDto', json, ($checkedConvert) {
      final val = StartGroupDto(
        cutoffMinutes: $checkedConvert('cutoffMinutes', (v) => v as num?),
        maxGuests: $checkedConvert('maxGuests', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$StartGroupDtoToJson(StartGroupDto instance) =>
    <String, dynamic>{
      'cutoffMinutes': ?instance.cutoffMinutes,
      'maxGuests': ?instance.maxGuests,
    };
