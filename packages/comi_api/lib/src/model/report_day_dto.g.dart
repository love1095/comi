// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_day_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportDayDtoCWProxy {
  ReportDayDto date(String date);

  ReportDayDto bookings(num bookings);

  ReportDayDto guests(num guests);

  ReportDayDto revenue(num revenue);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDayDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDayDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportDayDto call({String date, num bookings, num guests, num revenue});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportDayDto.copyWith(...)` or call `instanceOfReportDayDto.copyWith.fieldName(value)` for a single field.
class _$ReportDayDtoCWProxyImpl implements _$ReportDayDtoCWProxy {
  const _$ReportDayDtoCWProxyImpl(this._value);

  final ReportDayDto _value;

  @override
  ReportDayDto date(String date) => call(date: date);

  @override
  ReportDayDto bookings(num bookings) => call(bookings: bookings);

  @override
  ReportDayDto guests(num guests) => call(guests: guests);

  @override
  ReportDayDto revenue(num revenue) => call(revenue: revenue);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDayDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDayDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReportDayDto call({
    Object? date = const $CopyWithPlaceholder(),
    Object? bookings = const $CopyWithPlaceholder(),
    Object? guests = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return ReportDayDto(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      bookings: bookings == const $CopyWithPlaceholder() || bookings == null
          ? _value.bookings
          // ignore: cast_nullable_to_non_nullable
          : bookings as num,
      guests: guests == const $CopyWithPlaceholder() || guests == null
          ? _value.guests
          // ignore: cast_nullable_to_non_nullable
          : guests as num,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
    );
  }
}

extension $ReportDayDtoCopyWith on ReportDayDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportDayDto.copyWith(...)` or `instanceOfReportDayDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportDayDtoCWProxy get copyWith => _$ReportDayDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDayDto _$ReportDayDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportDayDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['date', 'bookings', 'guests', 'revenue'],
      );
      final val = ReportDayDto(
        date: $checkedConvert('date', (v) => v as String),
        bookings: $checkedConvert('bookings', (v) => v as num),
        guests: $checkedConvert('guests', (v) => v as num),
        revenue: $checkedConvert('revenue', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ReportDayDtoToJson(ReportDayDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'bookings': instance.bookings,
      'guests': instance.guests,
      'revenue': instance.revenue,
    };
