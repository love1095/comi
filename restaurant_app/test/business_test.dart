import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/business/business_repository.dart';
import 'package:restaurant_app/features/business/business_screens.dart';
import 'package:restaurant_app/features/business/payment_screens.dart';
import 'package:restaurant_app/features/business/marketing_screens.dart';
import 'package:shared_ui/shared_ui.dart';

class FakeBusiness implements BusinessRepository {
  final calls = <String>[];
  List<InvoiceRequestDto> invoices = [
    InvoiceRequestDto(
      id: 'inv1',
      bookingId: 'b1',
      bookingCode: 'CM-8K2P',
      companyName: 'Công ty ABC',
      taxCode: '0312345678',
      address: '1 Nguyễn Huệ',
      email: 'ketoan@abc.vn',
      status: InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT,
      amount: 300000,
      arrivalAt: '2026-12-02T05:00:00Z',
    ),
  ];

  @override
  Future<ReportDto> report(String from, String to) async {
    calls.add('report $from $to');
    return ReportDto(
      from: from,
      to: to,
      bookings: 12,
      completed: 10,
      cancelled: 1,
      noShows: 1,
      noShowRate: 9.1,
      guests: 31,
      revenue: 4200000,
      averageBill: 420000,
      preOrderValue: 1800000,
      platformFees: 42000,
      byDay: [ReportDayDto(date: '2026-12-02', bookings: 3, guests: 8, revenue: 1200000)],
      topDishes: [ReportDishDto(name: 'Lẩu thái', quantity: 7, revenue: 1750000)],
    );
  }

  final statementValue = StatementDetailDto(
    id: 's1',
    restaurantId: 'r1',
    periodMonth: '2026-12',
    bookingCount: 10,
    totalBase: 4200000,
    totalFee: 42000,
    platformVoucherCredit: 0,
    amountDue: 42000,
    status: StatementDetailDtoStatusEnum.ISSUED,
    dueAt: '2027-01-16T00:00:00Z',
    transferMemo: 'TS 0D4C7A527A',
    lines: [
      StatementLineDto(
        bookingId: 'b1',
        bookingCode: 'CM-8K2P',
        arrivalAt: '2026-12-02T05:00:00Z',
        partySize: 2,
        baseAmount: 300000,
        rateBps: 100,
        feeAmount: 3000,
      ),
    ],
  );

  @override
  Future<List<StatementDto>> statements() async => [
    StatementDto(
      id: 's1',
      restaurantId: 'r1',
      periodMonth: '2026-12',
      bookingCount: 10,
      totalBase: 4200000,
      totalFee: 42000,
      platformVoucherCredit: 0,
      amountDue: 42000,
      status: StatementDtoStatusEnum.ISSUED,
      transferMemo: 'TS 0D4C7A527A',
    ),
  ];

  @override
  Future<StatementDetailDto> statement(String id) async => statementValue;

  @override
  Future<List<InvoiceRequestDto>> invoiceRequests({bool all = false}) async =>
      all ? invoices : invoices.where((i) => i.status == InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT).toList();

  @override
  Future<InvoiceRequestDto> markIssued(String id, {String? invoiceNo}) async {
    calls.add('issued $id $invoiceNo');
    invoices = [
      for (final i in invoices)
        InvoiceRequestDto(
          id: i.id,
          bookingId: i.bookingId,
          bookingCode: i.bookingCode,
          companyName: i.companyName,
          taxCode: i.taxCode,
          address: i.address,
          email: i.email,
          status: InvoiceRequestDtoStatusEnum.EMAILED,
          invoiceNo: invoiceNo,
          amount: i.amount,
          arrivalAt: i.arrivalAt,
        ),
    ];
    return invoices.first;
  }

  @override
  Future<InvoiceRequestDto> reject(String id) async {
    calls.add('reject $id');
    return invoices.first;
  }

  var account = PaymentAccountStatusDto(provider: PaymentAccountStatusDtoProviderEnum.PAYOS, connected: false, serverReady: true);
  List<RefundDto> refundRows = [
    RefundDto(
      id: 'rf1',
      bookingId: 'b1',
      bookingCode: 'CM-8K2P',
      guestName: 'Lan',
      guestPhone: '+84901112233',
      amount: 100000,
      reason: RefundDtoReasonEnum.RESTAURANT_CANCELLED,
      status: RefundDtoStatusEnum.PENDING,
      toBankBin: '970436',
      toAccountNo: '0011223344',
      toAccountName: 'NGUYEN THI LAN',
      createdAt: '2026-12-02T06:00:00Z',
    ),
  ];

  @override
  Future<PaymentAccountStatusDto> paymentAccount() async => account;

  @override
  Future<PaymentAccountStatusDto> connectPayOs({required String clientId, required String apiKey, required String checksumKey}) async {
    calls.add('connect $clientId');
    return account = PaymentAccountStatusDto(
      provider: PaymentAccountStatusDtoProviderEnum.PAYOS,
      connected: true,
      clientIdHint: '…${clientId.substring(clientId.length - 4)}',
      serverReady: true,
    );
  }

  @override
  Future<PaymentAccountStatusDto> disconnectPayOs() async {
    calls.add('disconnect');
    return account = PaymentAccountStatusDto(provider: PaymentAccountStatusDtoProviderEnum.PAYOS, connected: false, serverReady: true);
  }

  @override
  Future<List<RefundDto>> refunds({bool pendingOnly = true}) async =>
      pendingOnly ? refundRows.where((r) => r.status == RefundDtoStatusEnum.PENDING).toList() : refundRows;

  @override
  Future<RefundDto> refundDone(String id, {String? note}) async {
    calls.add('refund $id $note');
    refundRows = [];
    return RefundDto(
      id: id,
      bookingId: 'b1',
      bookingCode: 'CM-8K2P',
      amount: 100000,
      reason: RefundDtoReasonEnum.RESTAURANT_CANCELLED,
      status: RefundDtoStatusEnum.DONE,
      createdAt: '2026-12-02T06:00:00Z',
    );
  }

  ReviewDto review = ReviewDto(
    id: 'rv1',
    bookingId: 'b1',
    restaurantId: 'r1',
    authorName: 'Lan',
    rating: 2,
    text: 'Chờ lâu',
    verifiedVisit: true,
    visitedAt: '2026-12-02T05:00:00Z',
    partySize: 2,
    status: ReviewDtoStatusEnum.PUBLISHED,
    createdAt: '2026-12-02T08:00:00Z',
  );

  @override
  Future<ReviewPageDto> reviews() async => ReviewPageDto(ratingAvg: 2, ratingCount: 1, histogram: const [0, 1, 0, 0, 0], items: [review]);

  @override
  Future<ReviewDto> replyReview(String id, String reply) async {
    calls.add('reply $id $reply');
    return review;
  }

  @override
  Future<ReviewDto> reportReview(String id, String reason) async {
    calls.add('report $id');
    return review;
  }

  List<VoucherDto> voucherRows = [];
  VoucherInputDto? createdVoucher;

  @override
  Future<List<VoucherDto>> vouchers() async => voucherRows;

  @override
  Future<VoucherDto> createVoucher(VoucherInputDto dto) async {
    createdVoucher = dto;
    final v = VoucherDto(
      id: 'v1',
      code: dto.code,
      fundedBy: VoucherFunder.RESTAURANT,
      type: dto.type,
      value: dto.value,
      maxDiscount: dto.maxDiscount,
      minOrder: dto.minOrder ?? 0,
      startsAt: dto.startsAt,
      endsAt: dto.endsAt,
      perUserLimit: 1,
      firstOrderOnly: dto.firstOrderOnly ?? false,
      usedCount: 0,
      isActive: true,
    );
    voucherRows = [v];
    return v;
  }

  @override
  Future<VoucherDto> setVoucherActive(String id, bool active) async {
    calls.add('voucher $id $active');
    return voucherRows.first;
  }
}

void main() {
  Future<void> pump(WidgetTester tester, Widget screen, FakeBusiness repo) async {
    tester.view.physicalSize = const Size(900, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = const StoredSession(refreshToken: 'r', restaurantId: 'r1');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStoreProvider.overrideWithValue(store),
          restaurantIdProvider.overrideWithValue('r1'),
          businessRepositoryProvider.overrideWithValue(repo),
        ],
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('report periods are Vietnam dates', () {
    // Wed 2026-12-02 23:30 in Vietnam (16:30 UTC).
    final p = reportPeriods(DateTime.utc(2026, 12, 2, 16, 30));
    expect(p[0], ('Tuần này', '2026-11-30', '2026-12-02'));
    expect(p[1], ('Tháng này', '2026-12-01', '2026-12-02'));
    expect(p[2], ('Tháng trước', '2026-11-01', '2026-11-30'));
  });

  testWidgets('reports: totals, best dishes, switching period reloads', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, ReportsScreen(now: DateTime.utc(2026, 12, 2, 5)), repo);
    expect(find.text(formatVnd(4200000)), findsOneWidget);
    expect(find.text('10 / 12'), findsOneWidget);
    expect(find.text('Lẩu thái'), findsOneWidget);

    await tester.tap(find.text('Tháng trước'));
    await tester.pumpAndSettle();
    expect(repo.calls.last, 'report 2026-11-01 2026-11-30');
  });

  testWidgets('statements: list → detail with transfer memo and lines', (tester) async {
    await pump(tester, const StatementsScreen(), FakeBusiness());
    expect(find.text('Tháng 2026-12 · 10 đơn'), findsOneWidget);
    await tester.tap(find.text('Tháng 2026-12 · 10 đơn'));
    await tester.pumpAndSettle();
    expect(find.text('Nội dung: TS 0D4C7A527A'), findsOneWidget);
    expect(find.text('Cần thanh toán'), findsOneWidget);
    expect(find.textContaining('CM-8K2P'), findsOneWidget);
  });

  testWidgets('VAT requests: mark issued with the invoice number', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, const InvoiceRequestsScreen(), repo);
    expect(find.text('Công ty ABC'), findsOneWidget);

    await tester.tap(find.text('Đã xuất hoá đơn'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '0000123');
    await tester.tap(find.text('Xác nhận'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['issued inv1 0000123']);
    expect(find.text('Không có yêu cầu xuất hoá đơn'), findsOneWidget); // done → off the open list
  });

  testWidgets('PayOS: connect with the three keys, then it shows connected', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, const PaymentSettingsScreen(), repo);
    expect(find.text('Chưa nhận trả trước'), findsOneWidget);

    await tester.tap(find.text('Kết nối'));
    await tester.pumpAndSettle();
    expect(find.text('Dán đúng khoá từ trang PayOS'), findsNWidgets(3));

    await tester.enterText(find.widgetWithText(TextFormField, 'Client ID'), 'client-abcd-1234');
    await tester.enterText(find.widgetWithText(TextFormField, 'API Key'), 'api-key-123456');
    await tester.enterText(find.widgetWithText(TextFormField, 'Checksum Key'), 'checksum-123456');
    await tester.tap(find.text('Kết nối'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['connect client-abcd-1234']);
    expect(find.text('Đã kết nối PayOS (…1234)'), findsOneWidget);
  });

  testWidgets('refunds: account to send to, mark done with the transfer reference', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, const RefundsScreen(), repo);
    expect(find.textContaining('STK 0011223344'), findsOneWidget);
    await tester.tap(find.text('Đã hoàn tiền'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'FT9999');
    await tester.tap(find.text('Xác nhận'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['refund rf1 FT9999']);
    expect(find.text('Không có khoản cần hoàn'), findsOneWidget);
  });

  testWidgets('reviews: histogram, reply to a guest', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, const ReviewsManageScreen(), repo);
    expect(find.text('2.0 ★ · 1 đánh giá'), findsOneWidget);
    await tester.tap(find.text('Trả lời'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Xin lỗi anh chị, lần sau quán sẽ nhanh hơn');
    await tester.pump();
    await tester.tap(find.text('Gửi'));
    await tester.pumpAndSettle();
    expect(repo.calls.single, startsWith('reply rv1 Xin lỗi'));
  });

  testWidgets('vouchers: create a 20% code capped at 30k', (tester) async {
    final repo = FakeBusiness();
    await pump(tester, NewVoucherScreen(now: DateTime.utc(2026, 12, 1)), repo);
    await tester.enterText(find.widgetWithText(TextFormField, 'Mã (VD: TRUA20)'), 'trua20');
    await tester.enterText(find.widgetWithText(TextFormField, 'Phần trăm (1–100)'), '20');
    await tester.enterText(find.widgetWithText(TextFormField, 'Giảm tối đa (đ, không bắt buộc)'), '30000');
    await tester.tap(find.text('Tạo'));
    await tester.pumpAndSettle();
    final v = repo.createdVoucher!;
    expect((v.code, v.type, v.value, v.maxDiscount), ('TRUA20', VoucherType.PERCENT, 2000, 30000));
    expect(v.endsAt, '2026-12-31T00:00:00.000Z');
  });
}
