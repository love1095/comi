import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session.dart';

/// Everything the admin website calls. Faked in tests.
abstract class AdminRepository {
  Future<AdminDashboardDto> dashboard();

  Future<List<AdminRestaurantRowDto>> restaurants(String status);
  Future<RestaurantProfileDto> restaurant(String id);
  Future<RestaurantProfileDto> approve(String id);
  Future<RestaurantProfileDto> reject(String id, String reason);
  Future<RestaurantProfileDto> pause(String id);

  Future<List<ReviewDto>> reportedReviews();
  Future<ReviewDto> decideReview(String id, {required bool hide});

  Future<List<AdminUserDto>> users(String? q);
  Future<AdminUserDto> block(String id, {required bool blocked, String? reason});
  Future<AdminUserDto> resetNoShow(String id);
  Future<List<AdminBookingDto>> bookings({String? code, String? userId, String? restaurantId});

  Future<List<StatementDto>> statements(String? status);
  Future<void> markStatementPaid(String id);
  Future<void> generateStatements(String month);

  Future<List<VoucherDto>> vouchers();
  Future<VoucherDto> createVoucher(AdminVoucherInputDto dto);
  Future<VoucherDto> setVoucherActive(String id, bool active);

  Future<Map<String, double>> rates();
  Future<void> setRates(Map<String, double> rates);

  Future<List<AuditEntryDto>> audit({String? entity, String? entityId, String? before});
}

class ApiAdminRepository implements AdminRepository {
  ApiAdminRepository(this._api);
  final ComiApi _api;

  AdminApi get _admin => _api.getAdminApi();

  @override
  Future<AdminDashboardDto> dashboard() async => (await _admin.adminDashboard()).data!;

  @override
  Future<List<AdminRestaurantRowDto>> restaurants(String status) async =>
      (await _admin.adminRestaurantsList(status: status)).data ?? const [];

  @override
  Future<RestaurantProfileDto> restaurant(String id) async => (await _admin.adminRestaurantsGet(id: id)).data!;

  @override
  Future<RestaurantProfileDto> approve(String id) async => (await _admin.adminRestaurantsApprove(id: id)).data!;

  @override
  Future<RestaurantProfileDto> reject(String id, String reason) async => (await _admin.adminRestaurantsReject(
    id: id,
    rejectDto: RejectDto(reason: reason),
  )).data!;

  @override
  Future<RestaurantProfileDto> pause(String id) async => (await _admin.adminRestaurantsPause(id: id)).data!;

  @override
  Future<List<ReviewDto>> reportedReviews() async => (await _api.getAdminReviewsApi().adminReviewsReported()).data ?? const [];

  @override
  Future<ReviewDto> decideReview(String id, {required bool hide}) async => (await _api.getAdminReviewsApi().adminReviewsDecide(
    id: id,
    decisionDto: DecisionDto(hide_: hide),
  )).data!;

  @override
  Future<List<AdminUserDto>> users(String? q) async => (await _admin.adminUsers(q: q)).data ?? const [];

  @override
  Future<AdminUserDto> block(String id, {required bool blocked, String? reason}) async => (await _admin.adminBlock(
    id: id,
    blockDto: BlockDto(blocked: blocked, reason: reason),
  )).data!;

  @override
  Future<AdminUserDto> resetNoShow(String id) async => (await _admin.adminResetNoShow(id: id)).data!;

  @override
  Future<List<AdminBookingDto>> bookings({String? code, String? userId, String? restaurantId}) async =>
      (await _admin.adminBookings(code: code, userId: userId, restaurantId: restaurantId)).data ?? const [];

  @override
  Future<List<StatementDto>> statements(String? status) async =>
      (await _api.getAdminStatementsApi().adminStatementsList(status: status)).data ?? const [];

  @override
  Future<void> markStatementPaid(String id) => _api.getAdminStatementsApi().adminStatementsPaid(id: id);

  @override
  Future<void> generateStatements(String month) => _api.getAdminStatementsApi().adminStatementsGenerate(month: month);

  @override
  Future<List<VoucherDto>> vouchers() async => (await _api.getAdminVouchersApi().adminVouchersList()).data ?? const [];

  @override
  Future<VoucherDto> createVoucher(AdminVoucherInputDto dto) async =>
      (await _api.getAdminVouchersApi().adminVouchersCreate(adminVoucherInputDto: dto)).data!;

  @override
  Future<VoucherDto> setVoucherActive(String id, bool active) async => (await _api.getAdminVouchersApi().adminVouchersActive(
    id: id,
    voucherActiveDto: VoucherActiveDto(isActive: active),
  )).data!;

  @override
  Future<Map<String, double>> rates() async => {
    for (final r in (await _api.getPublicExchangeRatesApi().placesRates()).data ?? const <ExchangeRateDto>[])
      r.currency.value: r.vndPerUnit.toDouble(),
  };

  @override
  Future<void> setRates(Map<String, double> rates) => _api.getPublicExchangeRatesApi().placesSetRates(ratesDto: RatesDto(rates: rates));

  @override
  Future<List<AuditEntryDto>> audit({String? entity, String? entityId, String? before}) async =>
      (await _admin.adminAuditLog(entity: entity, entityId: entityId, before: before)).data ?? const [];
}

final adminRepositoryProvider = Provider<AdminRepository>((ref) => ApiAdminRepository(ref.watch(apiProvider)));
