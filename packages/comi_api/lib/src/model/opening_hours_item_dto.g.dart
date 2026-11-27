// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OpeningHoursItemDtoCWProxy {
  OpeningHoursItemDto weekday(num weekday);

  OpeningHoursItemDto openMinute(num openMinute);

  OpeningHoursItemDto closeMinute(num closeMinute);

  OpeningHoursItemDto lastOrderMinute(num? lastOrderMinute);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OpeningHoursItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OpeningHoursItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OpeningHoursItemDto call({
    num weekday,
    num openMinute,
    num closeMinute,
    num? lastOrderMinute,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOpeningHoursItemDto.copyWith(...)` or call `instanceOfOpeningHoursItemDto.copyWith.fieldName(value)` for a single field.
class _$OpeningHoursItemDtoCWProxyImpl implements _$OpeningHoursItemDtoCWProxy {
  const _$OpeningHoursItemDtoCWProxyImpl(this._value);

  final OpeningHoursItemDto _value;

  @override
  OpeningHoursItemDto weekday(num weekday) => call(weekday: weekday);

  @override
  OpeningHoursItemDto openMinute(num openMinute) =>
      call(openMinute: openMinute);

  @override
  OpeningHoursItemDto closeMinute(num closeMinute) =>
      call(closeMinute: closeMinute);

  @override
  OpeningHoursItemDto lastOrderMinute(num? lastOrderMinute) =>
      call(lastOrderMinute: lastOrderMinute);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OpeningHoursItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OpeningHoursItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OpeningHoursItemDto call({
    Object? weekday = const $CopyWithPlaceholder(),
    Object? openMinute = const $CopyWithPlaceholder(),
    Object? closeMinute = const $CopyWithPlaceholder(),
    Object? lastOrderMinute = const $CopyWithPlaceholder(),
  }) {
    return OpeningHoursItemDto(
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

extension $OpeningHoursItemDtoCopyWith on OpeningHoursItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOpeningHoursItemDto.copyWith(...)` or `instanceOfOpeningHoursItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpeningHoursItemDtoCWProxy get copyWith =>
      _$OpeningHoursItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHoursItemDto _$OpeningHoursItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OpeningHoursItemDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['weekday', 'openMinute', 'closeMinute'],
      );
      final val = OpeningHoursItemDto(
        weekday: $checkedConvert('weekday', (v) => v as num),
        openMinute: $checkedConvert('openMinute', (v) => v as num),
        closeMinute: $checkedConvert('closeMinute', (v) => v as num),
        lastOrderMinute: $checkedConvert('lastOrderMinute', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$OpeningHoursItemDtoToJson(
  OpeningHoursItemDto instance,
) => <String, dynamic>{
  'weekday': instance.weekday,
  'openMinute': instance.openMinute,
  'closeMinute': instance.closeMinute,
  'lastOrderMinute': ?instance.lastOrderMinute,
};
