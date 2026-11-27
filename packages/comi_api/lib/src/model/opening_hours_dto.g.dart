// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OpeningHoursDtoCWProxy {
  OpeningHoursDto weekday(num weekday);

  OpeningHoursDto openMinute(num openMinute);

  OpeningHoursDto closeMinute(num closeMinute);

  OpeningHoursDto lastOrderMinute(num? lastOrderMinute);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OpeningHoursDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OpeningHoursDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OpeningHoursDto call({
    num weekday,
    num openMinute,
    num closeMinute,
    num? lastOrderMinute,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOpeningHoursDto.copyWith(...)` or call `instanceOfOpeningHoursDto.copyWith.fieldName(value)` for a single field.
class _$OpeningHoursDtoCWProxyImpl implements _$OpeningHoursDtoCWProxy {
  const _$OpeningHoursDtoCWProxyImpl(this._value);

  final OpeningHoursDto _value;

  @override
  OpeningHoursDto weekday(num weekday) => call(weekday: weekday);

  @override
  OpeningHoursDto openMinute(num openMinute) => call(openMinute: openMinute);

  @override
  OpeningHoursDto closeMinute(num closeMinute) =>
      call(closeMinute: closeMinute);

  @override
  OpeningHoursDto lastOrderMinute(num? lastOrderMinute) =>
      call(lastOrderMinute: lastOrderMinute);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OpeningHoursDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OpeningHoursDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OpeningHoursDto call({
    Object? weekday = const $CopyWithPlaceholder(),
    Object? openMinute = const $CopyWithPlaceholder(),
    Object? closeMinute = const $CopyWithPlaceholder(),
    Object? lastOrderMinute = const $CopyWithPlaceholder(),
  }) {
    return OpeningHoursDto(
      weekday: weekday == const $CopyWithPlaceholder() || weekday == null
          ? _value.weekday
          // ignore: cast_nullable_to_non_nullable
          : weekday as num,
      openMinute:
          openMinute == const $CopyWithPlaceholder() || openMinute == null
          ? _value.openMinute
          // ignore: cast_nullable_to_non_nullable
          : openMinute as num,
      closeMinute:
          closeMinute == const $CopyWithPlaceholder() || closeMinute == null
          ? _value.closeMinute
          // ignore: cast_nullable_to_non_nullable
          : closeMinute as num,
      lastOrderMinute: lastOrderMinute == const $CopyWithPlaceholder()
          ? _value.lastOrderMinute
          // ignore: cast_nullable_to_non_nullable
          : lastOrderMinute as num?,
    );
  }
}

extension $OpeningHoursDtoCopyWith on OpeningHoursDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOpeningHoursDto.copyWith(...)` or `instanceOfOpeningHoursDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpeningHoursDtoCWProxy get copyWith => _$OpeningHoursDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHoursDto _$OpeningHoursDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OpeningHoursDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['weekday', 'openMinute', 'closeMinute'],
      );
      final val = OpeningHoursDto(
        weekday: $checkedConvert('weekday', (v) => v as num),
        openMinute: $checkedConvert('openMinute', (v) => v as num),
        closeMinute: $checkedConvert('closeMinute', (v) => v as num),
        lastOrderMinute: $checkedConvert('lastOrderMinute', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$OpeningHoursDtoToJson(OpeningHoursDto instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'openMinute': instance.openMinute,
      'closeMinute': instance.closeMinute,
      'lastOrderMinute': ?instance.lastOrderMinute,
    };
