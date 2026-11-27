// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportDtoCWProxy {
  ReportDto from(String from);

  ReportDto to(String to);

  ReportDto bookings(num bookings);

  ReportDto completed(num completed);

  ReportDto cancelled(num cancelled);

  ReportDto noShows(num noShows);

  ReportDto noShowRate(num noShowRate);

  ReportDto guests(num guests);

  ReportDto revenue(num revenue);

  ReportDto averageBill(num averageBill);

  ReportDto preOrderValue(num preOrderValue);

  ReportDto platformFees(num platformFees);

  ReportDto byDay(List<ReportDayDto> byDay);

  ReportDto topDishes(List<ReportDishDto> topDishes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportDto call({
    String from,
    String to,
    num bookings,
    num completed,
    num cancelled,
    num noShows,
    num noShowRate,
    num guests,
    num revenue,
    num averageBill,
    num preOrderValue,
    num platformFees,
    List<ReportDayDto> byDay,
    List<ReportDishDto> topDishes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportDto.copyWith(...)` or call `instanceOfReportDto.copyWith.fieldName(value)` for a single field.
class _$ReportDtoCWProxyImpl implements _$ReportDtoCWProxy {
  const _$ReportDtoCWProxyImpl(this._value);

  final ReportDto _value;

  @override
  ReportDto from(String from) => call(from: from);

  @override
  ReportDto to(String to) => call(to: to);

  @override
  ReportDto bookings(num bookings) => call(bookings: bookings);

  @override
  ReportDto completed(num completed) => call(completed: completed);

  @override
  ReportDto cancelled(num cancelled) => call(cancelled: cancelled);

  @override
  ReportDto noShows(num noShows) => call(noShows: noShows);

  @override
  ReportDto noShowRate(num noShowRate) => call(noShowRate: noShowRate);

  @override
  ReportDto guests(num guests) => call(guests: guests);

  @override
  ReportDto revenue(num revenue) => call(revenue: revenue);

  @override
  ReportDto averageBill(num averageBill) => call(averageBill: averageBill);

  @override
  ReportDto preOrderValue(num preOrderValue) =>
      call(preOrderValue: preOrderValue);

  @override
  ReportDto platformFees(num platformFees) => call(platformFees: platformFees);

  @override
  ReportDto byDay(List<ReportDayDto> byDay) => call(byDay: byDay);

  @override
  ReportDto topDishes(List<ReportDishDto> topDishes) =>
      call(topDishes: topDishes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReportDto call({
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? bookings = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? cancelled = const $CopyWithPlaceholder(),
    Object? noShows = const $CopyWithPlaceholder(),
    Object? noShowRate = const $CopyWithPlaceholder(),
    Object? guests = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? averageBill = const $CopyWithPlaceholder(),
    Object? preOrderValue = const $CopyWithPlaceholder(),
    Object? platformFees = const $CopyWithPlaceholder(),
    Object? byDay = const $CopyWithPlaceholder(),
    Object? topDishes = const $CopyWithPlaceholder(),
  }) {
    return ReportDto(
      from: from == const $CopyWithPlaceholder() || from == null
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as String,
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as String,
      bookings: bookings == const $CopyWithPlaceholder() || bookings == null
          ? _value.bookings
          // ignore: cast_nullable_to_non_nullable
          : bookings as num,
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as num,
      cancelled: cancelled == const $CopyWithPlaceholder() || cancelled == null
          ? _value.cancelled
          // ignore: cast_nullable_to_non_nullable
          : cancelled as num,
      noShows: noShows == const $CopyWithPlaceholder() || noShows == null
          ? _value.noShows
          // ignore: cast_nullable_to_non_nullable
          : noShows as num,
      noShowRate:
          noShowRate == const $CopyWithPlaceholder() || noShowRate == null
          ? _value.noShowRate
          // ignore: cast_nullable_to_non_nullable
          : noShowRate as num,
      guests: guests == const $CopyWithPlaceholder() || guests == null
          ? _value.guests
          // ignore: cast_nullable_to_non_nullable
          : guests as num,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
      averageBill:
          averageBill == const $CopyWithPlaceholder() || averageBill == null
          ? _value.averageBill
          // ignore: cast_nullable_to_non_nullable
          : averageBill as num,
      preOrderValue:
          preOrderValue == const $CopyWithPlaceholder() || preOrderValue == null
          ? _value.preOrderValue
          // ignore: cast_nullable_to_non_nullable
          : preOrderValue as num,
      platformFees:
          platformFees == const $CopyWithPlaceholder() || platformFees == null
          ? _value.platformFees
          // ignore: cast_nullable_to_non_nullable
          : platformFees as num,
      byDay: byDay == const $CopyWithPlaceholder() || byDay == null
          ? _value.byDay
          // ignore: cast_nullable_to_non_nullable
          : byDay as List<ReportDayDto>,
      topDishes: topDishes == const $CopyWithPlaceholder() || topDishes == null
          ? _value.topDishes
          // ignore: cast_nullable_to_non_nullable
          : topDishes as List<ReportDishDto>,
    );
  }
}

extension $ReportDtoCopyWith on ReportDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportDto.copyWith(...)` or `instanceOfReportDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportDtoCWProxy get copyWith => _$ReportDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDto _$ReportDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'from',
          'to',
          'bookings',
          'completed',
          'cancelled',
          'noShows',
          'noShowRate',
          'guests',
          'revenue',
          'averageBill',
          'preOrderValue',
          'platformFees',
          'byDay',
          'topDishes',
        ],
      );
      final val = ReportDto(
        from: $checkedConvert('from', (v) => v as String),
        to: $checkedConvert('to', (v) => v as String),
        bookings: $checkedConvert('bookings', (v) => v as num),
        completed: $checkedConvert('completed', (v) => v as num),
        cancelled: $checkedConvert('cancelled', (v) => v as num),
        noShows: $checkedConvert('noShows', (v) => v as num),
        noShowRate: $checkedConvert('noShowRate', (v) => v as num),
        guests: $checkedConvert('guests', (v) => v as num),
        revenue: $checkedConvert('revenue', (v) => v as num),
        averageBill: $checkedConvert('averageBill', (v) => v as num),
        preOrderValue: $checkedConvert('preOrderValue', (v) => v as num),
        platformFees: $checkedConvert('platformFees', (v) => v as num),
        byDay: $checkedConvert(
          'byDay',
          (v) => (v as List<dynamic>)
              .map((e) => ReportDayDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        topDishes: $checkedConvert(
          'topDishes',
          (v) => (v as List<dynamic>)
              .map((e) => ReportDishDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReportDtoToJson(ReportDto instance) => <String, dynamic>{
  'from': instance.from,
  'to': instance.to,
  'bookings': instance.bookings,
  'completed': instance.completed,
  'cancelled': instance.cancelled,
  'noShows': instance.noShows,
  'noShowRate': instance.noShowRate,
  'guests': instance.guests,
  'revenue': instance.revenue,
  'averageBill': instance.averageBill,
  'preOrderValue': instance.preOrderValue,
  'platformFees': instance.platformFees,
  'byDay': instance.byDay.map((e) => e.toJson()).toList(),
  'topDishes': instance.topDishes.map((e) => e.toJson()).toList(),
};
