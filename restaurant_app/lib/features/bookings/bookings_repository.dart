import 'dart:async';

import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/session.dart';

/// Thin wrapper over the restaurant bookings API so screens can be tested with a fake.
abstract class BookingsRepository {
  Future<List<BoardBookingDto>> list(String date, {BookingStatus? status, String? q});
  Future<BookingDetailDto> get(String id);
  Future<BookingDetailDto> approve(String id);
  Future<BookingDetailDto> cancel(String id, String reason);
  Future<BookingDetailDto> moveTable(String id, String tableId);
  Future<List<TableDto>> listTables();
}

class ApiBookingsRepository implements BookingsRepository {
  ApiBookingsRepository(this._api, this._tables, this._rid);
  final RestaurantBookingsApi _api;
  final RestaurantTablesApi _tables;
  final String _rid;

  @override
  Future<List<BoardBookingDto>> list(String date, {BookingStatus? status, String? q}) async =>
      (await _api.restaurantBookingsList(date: date, xRestaurantId: _rid, status: status?.value, q: q)).data ?? const [];

  @override
  Future<BookingDetailDto> get(String id) async => (await _api.restaurantBookingsGet(id: id, xRestaurantId: _rid)).data!;

  @override
  Future<BookingDetailDto> approve(String id) async => (await _api.restaurantBookingsApprove(id: id, xRestaurantId: _rid)).data!;

  @override
  Future<BookingDetailDto> cancel(String id, String reason) async => (await _api.restaurantBookingsCancel(
    id: id,
    xRestaurantId: _rid,
    restaurantCancelDto: RestaurantCancelDto(reason: reason),
  )).data!;

  @override
  Future<BookingDetailDto> moveTable(String id, String tableId) async => (await _api.restaurantBookingsMoveTable(
    id: id,
    xRestaurantId: _rid,
    moveTableDto: MoveTableDto(tableId: tableId),
  )).data!;

  @override
  Future<List<TableDto>> listTables() async => (await _tables.tablesListTables(xRestaurantId: _rid)).data ?? const [];
}

final bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiBookingsRepository(api.getRestaurantBookingsApi(), api.getRestaurantTablesApi(), ref.watch(restaurantIdProvider));
});

/// Board filter tabs. `pending` = waiting for the restaurant to approve (large groups).
enum BoardFilter {
  all('Tất cả'),
  pending('Chờ duyệt'),
  upcoming('Sắp đến'),
  seated('Đang ngồi'),
  done('Xong / huỷ');

  const BoardFilter(this.label);
  final String label;

  bool matches(BoardBookingDto b) => switch (this) {
    BoardFilter.all => true,
    BoardFilter.pending => b.status == BookingStatus.PENDING,
    BoardFilter.upcoming => b.status == BookingStatus.CONFIRMED,
    BoardFilter.seated => b.status == BookingStatus.CHECKED_IN,
    BoardFilter.done => !isActive(b.status),
  };
}

bool isActive(BookingStatus s) => s == BookingStatus.PENDING || s == BookingStatus.CONFIRMED || s == BookingStatus.CHECKED_IN;

/// Mirrors the backend state machine (booking.state.ts): staff may cancel before check-in.
bool canCancel(BookingStatus s) => s == BookingStatus.PENDING || s == BookingStatus.CONFIRMED;

String statusLabel(BookingStatus s) => switch (s) {
  BookingStatus.PENDING => 'Chờ duyệt',
  BookingStatus.CONFIRMED => 'Đã xác nhận',
  BookingStatus.CHECKED_IN => 'Đã đến',
  BookingStatus.COMPLETED => 'Hoàn tất',
  BookingStatus.CANCELLED => 'Đã huỷ',
  BookingStatus.NO_SHOW => 'Không đến',
  BookingStatus.EXPIRED => 'Hết hạn',
};

class BoardDate extends Notifier<String> {
  @override
  String build() => vietnamDate();

  void set(String date) => state = date;

  void shift(int days) {
    final d = DateTime.parse(state).add(Duration(days: days));
    state = '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}

final boardDateProvider = NotifierProvider<BoardDate, String>(BoardDate.new);

class BoardSearch extends Notifier<String> {
  @override
  String build() => '';
  void set(String q) => state = q.trim();
}

final boardSearchProvider = NotifierProvider<BoardSearch, String>(BoardSearch.new);

/// Bookings of the selected day. Re-fetches every 30 s until live socket events land (§19).
final boardBookingsProvider = FutureProvider.autoDispose<List<BoardBookingDto>>((ref) async {
  final date = ref.watch(boardDateProvider);
  final q = ref.watch(boardSearchProvider);
  final timer = Timer(const Duration(seconds: 30), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  return ref.watch(bookingsRepositoryProvider).list(date, q: q.isEmpty ? null : q);
});

final bookingDetailProvider = FutureProvider.autoDispose.family<BookingDetailDto, String>(
  (ref, id) => ref.watch(bookingsRepositoryProvider).get(id),
);

/// Head counts for the summary row.
class BoardSummary {
  BoardSummary(List<BoardBookingDto> list)
    : bookings = list.where((b) => isActive(b.status) || b.status == BookingStatus.COMPLETED).length,
      guests = list.where((b) => isActive(b.status) || b.status == BookingStatus.COMPLETED).fold<num>(0, (s, b) => s + b.partySize).toInt(),
      pending = list.where((b) => b.status == BookingStatus.PENDING && b.needsApproval).length,
      preOrderTotal = list.where((b) => isActive(b.status)).fold<num>(0, (s, b) => s + (b.order?.total ?? 0));

  final int bookings;
  final int guests;
  final int pending;
  final num preOrderTotal;
}
