import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

/// Reports, comi fee statements, VAT invoice requests (§11, §13).
abstract class BusinessRepository {
  Future<ReportDto> report(String from, String to);
  Future<List<StatementDto>> statements();
  Future<StatementDetailDto> statement(String id);
  Future<List<InvoiceRequestDto>> invoiceRequests({bool all = false});
  Future<InvoiceRequestDto> markIssued(String id, {String? invoiceNo});
  Future<InvoiceRequestDto> reject(String id);
  Future<PaymentAccountStatusDto> paymentAccount();
  Future<PaymentAccountStatusDto> connectPayOs({required String clientId, required String apiKey, required String checksumKey});
  Future<PaymentAccountStatusDto> disconnectPayOs();
  Future<List<RefundDto>> refunds({bool pendingOnly = true});
  Future<RefundDto> refundDone(String id, {String? note});
}

class ApiBusinessRepository implements BusinessRepository {
  ApiBusinessRepository(this._fees, this._vat, this._rid, this._pay);
  final RestaurantPaymentsApi _pay;
  final RestaurantFeesReportsApi _fees;
  final RestaurantVATInvoiceApi _vat;
  final String _rid;

  @override
  Future<ReportDto> report(String from, String to) async =>
      (await _fees.restaurantFeesReport(from: from, to: to, xRestaurantId: _rid)).data!;

  @override
  Future<List<StatementDto>> statements() async => (await _fees.restaurantFeesStatements(xRestaurantId: _rid)).data ?? const [];

  @override
  Future<StatementDetailDto> statement(String id) async => (await _fees.restaurantFeesStatement(id: id, xRestaurantId: _rid)).data!;

  @override
  Future<List<InvoiceRequestDto>> invoiceRequests({bool all = false}) async =>
      (await _vat.restaurantInvoiceList(xRestaurantId: _rid, all: all ? 'true' : null)).data ?? const [];

  @override
  Future<InvoiceRequestDto> markIssued(String id, {String? invoiceNo}) async => (await _vat.restaurantInvoiceIssued(
    id: id,
    xRestaurantId: _rid,
    markIssuedDto: MarkIssuedDto(invoiceNo: invoiceNo),
  )).data!;

  @override
  Future<InvoiceRequestDto> reject(String id) async => (await _vat.restaurantInvoiceReject(id: id, xRestaurantId: _rid)).data!;

  @override
  Future<PaymentAccountStatusDto> paymentAccount() async => (await _pay.restaurantPaymentsAccount(xRestaurantId: _rid)).data!;

  @override
  Future<PaymentAccountStatusDto> connectPayOs({required String clientId, required String apiKey, required String checksumKey}) async =>
      (await _pay.restaurantPaymentsConnect(
        xRestaurantId: _rid,
        connectPayOsDto: ConnectPayOsDto(clientId: clientId, apiKey: apiKey, checksumKey: checksumKey),
      )).data!;

  @override
  Future<PaymentAccountStatusDto> disconnectPayOs() async => (await _pay.restaurantPaymentsDisconnect(xRestaurantId: _rid)).data!;

  @override
  Future<List<RefundDto>> refunds({bool pendingOnly = true}) async =>
      (await _pay.restaurantPaymentsRefunds(xRestaurantId: _rid, status: pendingOnly ? 'PENDING' : null)).data ?? const [];

  @override
  Future<RefundDto> refundDone(String id, {String? note}) async => (await _pay.restaurantPaymentsDone(
    id: id,
    xRestaurantId: _rid,
    refundDoneDto: RefundDoneDto(note: note),
  )).data!;
}

final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiBusinessRepository(
    api.getRestaurantFeesReportsApi(),
    api.getRestaurantVATInvoiceApi(),
    ref.watch(restaurantIdProvider),
    api.getRestaurantPaymentsApi(),
  );
});

final statementsProvider = FutureProvider.autoDispose<List<StatementDto>>((ref) => ref.watch(businessRepositoryProvider).statements());

final statementProvider = FutureProvider.autoDispose.family<StatementDetailDto, String>(
  (ref, id) => ref.watch(businessRepositoryProvider).statement(id),
);

final invoiceRequestsProvider = FutureProvider.autoDispose.family<List<InvoiceRequestDto>, bool>(
  (ref, all) => ref.watch(businessRepositoryProvider).invoiceRequests(all: all),
);

String statementStatusLabel(StatementDtoStatusEnum s) => switch (s) {
  StatementDtoStatusEnum.DRAFT => 'Nháp',
  StatementDtoStatusEnum.ISSUED => 'Chờ thanh toán',
  StatementDtoStatusEnum.PAID => 'Đã thanh toán',
  StatementDtoStatusEnum.OVERDUE => 'Quá hạn',
};

String invoiceStatusLabel(InvoiceRequestDtoStatusEnum s) => switch (s) {
  InvoiceRequestDtoStatusEnum.REQUESTED || InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT => 'Chờ xuất',
  InvoiceRequestDtoStatusEnum.ISSUED => 'Đã xuất',
  InvoiceRequestDtoStatusEnum.EMAILED => 'Đã xuất · đã báo khách',
  InvoiceRequestDtoStatusEnum.REJECTED => 'Từ chối',
};

final paymentAccountProvider = FutureProvider.autoDispose<PaymentAccountStatusDto>(
  (ref) => ref.watch(businessRepositoryProvider).paymentAccount(),
);

final refundsProvider = FutureProvider.autoDispose.family<List<RefundDto>, bool>(
  (ref, pendingOnly) => ref.watch(businessRepositoryProvider).refunds(pendingOnly: pendingOnly),
);

String refundReasonLabel(String r) => switch (r) {
  'RESTAURANT_CANCELLED' => 'Quán huỷ đơn',
  'CUSTOMER_CANCELLED' => 'Khách huỷ đúng hạn',
  'LATE_PAYMENT_NO_TABLE' => 'Trả tiền trễ, hết bàn',
  'AMOUNT_MISMATCH' => 'Chuyển thiếu tiền',
  _ => r,
};
