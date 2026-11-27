// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminDashboardDtoCWProxy {
  AdminDashboardDto restaurants(Map<String, num> restaurants);

  AdminDashboardDto bookingsToday(num bookingsToday);

  AdminDashboardDto bookingsMonth(num bookingsMonth);

  AdminDashboardDto gmvMonth(num gmvMonth);

  AdminDashboardDto noShowsMonth(num noShowsMonth);

  AdminDashboardDto newUsersMonth(num newUsersMonth);

  AdminDashboardDto reportedReviews(num reportedReviews);

  AdminDashboardDto overdueStatements(num overdueStatements);

  AdminDashboardDto pendingRefunds(num pendingRefunds);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminDashboardDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminDashboardDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminDashboardDto call({
    Map<String, num> restaurants,
    num bookingsToday,
    num bookingsMonth,
    num gmvMonth,
    num noShowsMonth,
    num newUsersMonth,
    num reportedReviews,
    num overdueStatements,
    num pendingRefunds,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminDashboardDto.copyWith(...)` or call `instanceOfAdminDashboardDto.copyWith.fieldName(value)` for a single field.
class _$AdminDashboardDtoCWProxyImpl implements _$AdminDashboardDtoCWProxy {
  const _$AdminDashboardDtoCWProxyImpl(this._value);

  final AdminDashboardDto _value;

  @override
  AdminDashboardDto restaurants(Map<String, num> restaurants) =>
      call(restaurants: restaurants);

  @override
  AdminDashboardDto bookingsToday(num bookingsToday) =>
      call(bookingsToday: bookingsToday);

  @override
  AdminDashboardDto bookingsMonth(num bookingsMonth) =>
      call(bookingsMonth: bookingsMonth);

  @override
  AdminDashboardDto gmvMonth(num gmvMonth) => call(gmvMonth: gmvMonth);

  @override
  AdminDashboardDto noShowsMonth(num noShowsMonth) =>
      call(noShowsMonth: noShowsMonth);

  @override
  AdminDashboardDto newUsersMonth(num newUsersMonth) =>
      call(newUsersMonth: newUsersMonth);

  @override
  AdminDashboardDto reportedReviews(num reportedReviews) =>
      call(reportedReviews: reportedReviews);

  @override
  AdminDashboardDto overdueStatements(num overdueStatements) =>
      call(overdueStatements: overdueStatements);

  @override
  AdminDashboardDto pendingRefunds(num pendingRefunds) =>
      call(pendingRefunds: pendingRefunds);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminDashboardDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminDashboardDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminDashboardDto call({
    Object? restaurants = const $CopyWithPlaceholder(),
    Object? bookingsToday = const $CopyWithPlaceholder(),
    Object? bookingsMonth = const $CopyWithPlaceholder(),
    Object? gmvMonth = const $CopyWithPlaceholder(),
    Object? noShowsMonth = const $CopyWithPlaceholder(),
    Object? newUsersMonth = const $CopyWithPlaceholder(),
    Object? reportedReviews = const $CopyWithPlaceholder(),
    Object? overdueStatements = const $CopyWithPlaceholder(),
    Object? pendingRefunds = const $CopyWithPlaceholder(),
  }) {
    return AdminDashboardDto(
      restaurants:
          restaurants == const $CopyWithPlaceholder() || restaurants == null
          ? _value.restaurants
          // ignore: cast_nullable_to_non_nullable
          : restaurants as Map<String, num>,
      bookingsToday:
          bookingsToday == const $CopyWithPlaceholder() || bookingsToday == null
          ? _value.bookingsToday
          // ignore: cast_nullable_to_non_nullable
          : bookingsToday as num,
      bookingsMonth:
          bookingsMonth == const $CopyWithPlaceholder() || bookingsMonth == null
          ? _value.bookingsMonth
          // ignore: cast_nullable_to_non_nullable
          : bookingsMonth as num,
      gmvMonth: gmvMonth == const $CopyWithPlaceholder() || gmvMonth == null
          ? _value.gmvMonth
          // ignore: cast_nullable_to_non_nullable
          : gmvMonth as num,
      noShowsMonth:
          noShowsMonth == const $CopyWithPlaceholder() || noShowsMonth == null
          ? _value.noShowsMonth
          // ignore: cast_nullable_to_non_nullable
          : noShowsMonth as num,
      newUsersMonth:
          newUsersMonth == const $CopyWithPlaceholder() || newUsersMonth == null
          ? _value.newUsersMonth
          // ignore: cast_nullable_to_non_nullable
          : newUsersMonth as num,
      reportedReviews:
          reportedReviews == const $CopyWithPlaceholder() ||
              reportedReviews == null
          ? _value.reportedReviews
          // ignore: cast_nullable_to_non_nullable
          : reportedReviews as num,
      overdueStatements:
          overdueStatements == const $CopyWithPlaceholder() ||
              overdueStatements == null
          ? _value.overdueStatements
          // ignore: cast_nullable_to_non_nullable
          : overdueStatements as num,
      pendingRefunds:
          pendingRefunds == const $CopyWithPlaceholder() ||
              pendingRefunds == null
          ? _value.pendingRefunds
          // ignore: cast_nullable_to_non_nullable
          : pendingRefunds as num,
    );
  }
}

extension $AdminDashboardDtoCopyWith on AdminDashboardDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminDashboardDto.copyWith(...)` or `instanceOfAdminDashboardDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminDashboardDtoCWProxy get copyWith =>
      _$AdminDashboardDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDashboardDto _$AdminDashboardDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminDashboardDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'restaurants',
          'bookingsToday',
          'bookingsMonth',
          'gmvMonth',
          'noShowsMonth',
          'newUsersMonth',
          'reportedReviews',
          'overdueStatements',
          'pendingRefunds',
        ],
      );
      final val = AdminDashboardDto(
        restaurants: $checkedConvert(
          'restaurants',
          (v) => Map<String, num>.from(v as Map),
        ),
        bookingsToday: $checkedConvert('bookingsToday', (v) => v as num),
        bookingsMonth: $checkedConvert('bookingsMonth', (v) => v as num),
        gmvMonth: $checkedConvert('gmvMonth', (v) => v as num),
        noShowsMonth: $checkedConvert('noShowsMonth', (v) => v as num),
        newUsersMonth: $checkedConvert('newUsersMonth', (v) => v as num),
        reportedReviews: $checkedConvert('reportedReviews', (v) => v as num),
        overdueStatements: $checkedConvert(
          'overdueStatements',
          (v) => v as num,
        ),
        pendingRefunds: $checkedConvert('pendingRefunds', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$AdminDashboardDtoToJson(AdminDashboardDto instance) =>
    <String, dynamic>{
      'restaurants': instance.restaurants,
      'bookingsToday': instance.bookingsToday,
      'bookingsMonth': instance.bookingsMonth,
      'gmvMonth': instance.gmvMonth,
      'noShowsMonth': instance.noShowsMonth,
      'newUsersMonth': instance.newUsersMonth,
      'reportedReviews': instance.reportedReviews,
      'overdueStatements': instance.overdueStatements,
      'pendingRefunds': instance.pendingRefunds,
    };
