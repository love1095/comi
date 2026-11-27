import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

abstract class BookingsRepository {
  Future<CustomerBookingDto> create(CreateBookingDto dto, {required String idempotencyKey});
  Future<MyBookingsPageDto> mine({required bool upcoming, String? cursor});
  Future<CustomerBookingDto> get(String id);
  Future<CustomerBookingDto> cancel(String id, {String? reason});
  Future<ReorderDraftDto> reorder(String id);
  Future<MeDto> me();
}

class ApiBookingsRepository implements BookingsRepository {
  ApiBookingsRepository(this._api, this._me);
  final CustomerBookingsApi _api;
  final MeApi _me;

  @override
  Future<CustomerBookingDto> create(CreateBookingDto dto, {required String idempotencyKey}) async =>
      (await _api.bookingsCreate(idempotencyKey: idempotencyKey, createBookingDto: dto)).data!;

  @override
  Future<MyBookingsPageDto> mine({required bool upcoming, String? cursor}) async =>
      (await _api.bookingsList(status: upcoming ? 'upcoming' : 'past', cursor: cursor, limit: 20)).data!;

  @override
  Future<CustomerBookingDto> get(String id) async => (await _api.bookingsGet(id: id)).data!;

  @override
  Future<CustomerBookingDto> cancel(String id, {String? reason}) async => (await _api.bookingsCancel(
    id: id,
    cancelDto: CancelDto(reason: reason),
  )).data!;

  @override
  Future<ReorderDraftDto> reorder(String id) async => (await _api.bookingsReorder(id: id)).data!;

  @override
  Future<MeDto> me() async => (await _me.usersMe()).data!;
}

final bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiBookingsRepository(api.getCustomerBookingsApi(), api.getMeApi());
});

final myBookingsProvider = FutureProvider.autoDispose.family<MyBookingsPageDto, bool>((ref, upcoming) {
  ref.watch(sessionProvider.select((s) => s.value?.refreshToken)); // reload after login / logout
  return ref.watch(bookingsRepositoryProvider).mine(upcoming: upcoming);
});

final bookingProvider = FutureProvider.autoDispose.family<CustomerBookingDto, String>(
  (ref, id) => ref.watch(bookingsRepositoryProvider).get(id),
);

String bookingStatusLabel(BookingStatus s, {bool needsApproval = false}) => switch (s) {
  BookingStatus.PENDING => needsApproval ? 'Chờ quán duyệt' : 'Đang xử lý',
  BookingStatus.CONFIRMED => 'Đã xác nhận',
  BookingStatus.CHECKED_IN => 'Đã đến quán',
  BookingStatus.COMPLETED => 'Hoàn tất',
  BookingStatus.CANCELLED => 'Đã huỷ',
  BookingStatus.NO_SHOW => 'Không đến',
  BookingStatus.EXPIRED => 'Hết hạn',
};

/// `Hôm nay 12:15` / `Thứ 5, 04/12 19:00` in Vietnam time.
String arrivalLabel(String iso, {DateTime? now}) {
  final t = toVietnamTimeLocal(DateTime.parse(iso));
  final today = toVietnamTimeLocal(now ?? DateTime.now());
  final hm = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  final d0 = DateTime(today.year, today.month, today.day);
  final d1 = DateTime(t.year, t.month, t.day);
  final diff = d1.difference(d0).inDays;
  if (diff == 0) return 'Hôm nay $hm';
  if (diff == 1) return 'Ngày mai $hm';
  const names = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];
  return '${names[t.weekday - 1]}, ${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')} $hm';
}

DateTime toVietnamTimeLocal(DateTime utc) => utc.toUtc().add(const Duration(hours: 7));
