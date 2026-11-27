import 'dart:async';

import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/realtime.dart';
import '../../data/session.dart';

/// Kitchen queue, at-the-table actions and service requests (§7, §8.5, §9).
abstract class KitchenRepository {
  Future<KitchenQueueDto> queue();
  Future<KitchenItemDto> setStatus(String itemId, KitchenStatusDtoStatusEnum to);
  Future<int> fire(String bookingId, {Course? course});
  Future<List<ServiceRequestDto>> openRequests();
  Future<void> finishRequest(String id);
  Future<BookingDetailDto> checkIn(String bookingId);
  Future<BookingDetailDto> extendGrace(String bookingId);
  Future<BillDto> bill(String bookingId);
  Future<BookingDetailDto> closeBill(String bookingId, {int? amount});
  Future<RoundResultDto> addRound(String bookingId, List<CartLineDto> items);
  Future<int> approveRound(String bookingId, int round);
  Future<List<CapacityRuleDto>> capacityRules();
  Future<List<CapacityRuleDto>> saveCapacityRules(List<CapacityRuleInput> rules);
}

class ApiKitchenRepository implements KitchenRepository {
  ApiKitchenRepository(this._kitchen, this._table, this._rid);
  final RestaurantKitchenApi _kitchen;
  final RestaurantAtTheTableApi _table;
  final String _rid;

  @override
  Future<KitchenQueueDto> queue() async => (await _kitchen.kitchenQueue(xRestaurantId: _rid)).data!;

  @override
  Future<KitchenItemDto> setStatus(String itemId, KitchenStatusDtoStatusEnum to) async => (await _kitchen.kitchenSetStatus(
    id: itemId,
    xRestaurantId: _rid,
    kitchenStatusDto: KitchenStatusDto(status: to),
  )).data!;

  @override
  Future<int> fire(String bookingId, {Course? course}) async => (await _kitchen.kitchenFire(
    id: bookingId,
    xRestaurantId: _rid,
    fireDto: FireDto(course: course),
  )).data!.queued.toInt();

  @override
  Future<List<ServiceRequestDto>> openRequests() async => (await _table.restaurantTableRequests(xRestaurantId: _rid)).data ?? const [];

  @override
  Future<void> finishRequest(String id) => _table.restaurantTableDone(id: id, xRestaurantId: _rid);

  @override
  Future<BookingDetailDto> checkIn(String bookingId) async =>
      (await _table.restaurantTableCheckIn(id: bookingId, xRestaurantId: _rid)).data!;

  @override
  Future<BookingDetailDto> extendGrace(String bookingId) async =>
      (await _table.restaurantTableExtendGrace(id: bookingId, xRestaurantId: _rid)).data!;

  @override
  Future<BillDto> bill(String bookingId) async => (await _table.restaurantTableBill(id: bookingId, xRestaurantId: _rid)).data!;

  @override
  Future<BookingDetailDto> closeBill(String bookingId, {int? amount}) async => (await _table.restaurantTableClose(
    id: bookingId,
    xRestaurantId: _rid,
    closeBillDto: CloseBillDto(finalBillAmount: amount),
  )).data!;

  @override
  Future<RoundResultDto> addRound(String bookingId, List<CartLineDto> items) async => (await _table.restaurantTableOrder(
    id: bookingId,
    xRestaurantId: _rid,
    tableOrderDto: TableOrderDto(items: items),
  )).data!;

  @override
  Future<int> approveRound(String bookingId, int round) async =>
      (await _table.restaurantTableApproveRound(id: bookingId, round: round, xRestaurantId: _rid)).data!.queued.toInt();

  @override
  Future<List<CapacityRuleDto>> capacityRules() async => (await _kitchen.kitchenRules(xRestaurantId: _rid)).data ?? const [];

  @override
  Future<List<CapacityRuleDto>> saveCapacityRules(List<CapacityRuleInput> rules) async =>
      (await _kitchen.kitchenReplaceRules(
        xRestaurantId: _rid,
        capacityRulesDto: CapacityRulesDto(rules: rules),
      )).data ??
      const [];
}

final kitchenRepositoryProvider = Provider<KitchenRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiKitchenRepository(api.getRestaurantKitchenApi(), api.getRestaurantAtTheTableApi(), ref.watch(restaurantIdProvider));
});

/// Reloads every 20 s and on any kitchen hint from the socket.
final kitchenQueueProvider = FutureProvider.autoDispose<KitchenQueueDto>((ref) async {
  final timer = Timer(const Duration(seconds: 20), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  ref.listen(realtimeEventsProvider, (_, next) {
    if (next.value?.isKitchen ?? false) ref.invalidateSelf();
  });
  return ref.watch(kitchenRepositoryProvider).queue();
});

final serviceRequestsProvider = FutureProvider.autoDispose<List<ServiceRequestDto>>((ref) async {
  final timer = Timer(const Duration(seconds: 30), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  ref.listen(realtimeEventsProvider, (_, next) {
    if (next.value?.isService ?? false) ref.invalidateSelf();
  });
  return ref.watch(kitchenRepositoryProvider).openRequests();
});

final billProvider = FutureProvider.autoDispose.family<BillDto, String>((ref, bookingId) {
  ref.listen(realtimeEventsProvider, (_, next) {
    final e = next.value;
    if (e != null && (e.isKitchen || e.isBooking) && (e.data['bookingId'] == null || e.data['bookingId'] == bookingId)) {
      ref.invalidateSelf();
    }
  });
  return ref.watch(kitchenRepositoryProvider).bill(bookingId);
});

String serviceLabel(ServiceType t) => switch (t) {
  ServiceType.CALL_WAITER => 'Gọi nhân viên',
  ServiceType.MORE_ICE => 'Thêm đá',
  ServiceType.MORE_BOWLS => 'Thêm chén bát',
  ServiceType.BILL_PLEASE => 'Tính tiền',
  ServiceType.OTHER => 'Yêu cầu khác',
};

String kitchenStatusLabel(KitchenStatus s) => switch (s) {
  KitchenStatus.HOLD => 'Chờ khách',
  KitchenStatus.SCHEDULED => 'Đã hẹn giờ',
  KitchenStatus.QUEUED => 'Chờ nấu',
  KitchenStatus.COOKING => 'Đang nấu',
  KitchenStatus.READY => 'Xong',
  KitchenStatus.SERVED => 'Đã bưng',
  KitchenStatus.CANCELLED => 'Huỷ',
};
