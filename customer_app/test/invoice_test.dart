import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/features/invoice/invoice_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

class FakeInvoices implements InvoiceRepository {
  InvoiceRequestDto? existing;
  InvoiceRequestCreateDto? sent;
  List<InvoiceProfileDto> saved = [
    InvoiceProfileDto(
      id: 'p1',
      companyName: 'Công ty ABC',
      taxCode: '0312345678',
      address: '1 Nguyễn Huệ, Q1',
      email: 'ketoan@abc.vn',
      isDefault: true,
    ),
  ];

  @override
  Future<InvoiceRequestDto?> forBooking(String bookingId) async => existing;

  @override
  Future<List<InvoiceProfileDto>> profiles() async => saved;

  @override
  Future<InvoiceRequestDto> request(String bookingId, InvoiceRequestCreateDto dto) async {
    sent = dto;
    return existing = InvoiceRequestDto(
      id: 'i1',
      bookingId: bookingId,
      bookingCode: 'CM-1',
      companyName: dto.companyName,
      taxCode: dto.taxCode,
      address: dto.address,
      email: dto.email,
      status: InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT,
      amount: 300000,
      arrivalAt: '2026-12-02T05:00:00Z',
    );
  }
}

void main() {
  Future<void> pump(WidgetTester tester, FakeInvoices repo) async {
    tester.view.physicalSize = const Size(420, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [tokenStoreProvider.overrideWithValue(MemoryTokenStore()), invoiceRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: ComiTheme.light(),
          home: const InvoiceScreen(bookingId: 'b1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('tax code format', () {
    expect(taxCodeRe.hasMatch('0312345678'), isTrue);
    expect(taxCodeRe.hasMatch('0312345678-001'), isTrue);
    expect(taxCodeRe.hasMatch('031234567'), isFalse);
    expect(taxCodeRe.hasMatch('0312345678-1'), isFalse);
  });

  testWidgets('saved company is prefilled; a bad MST is caught before sending', (tester) async {
    final repo = FakeInvoices();
    await pump(tester, repo);
    expect(find.text('Công ty ABC'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Mã số thuế'), '123');
    await tester.tap(find.text('Gửi yêu cầu'));
    await tester.pumpAndSettle();
    expect(find.text('MST gồm 10 số (chi nhánh: 10 số-3 số)'), findsOneWidget);
    expect(repo.sent, isNull);

    await tester.enterText(find.widgetWithText(TextFormField, 'Mã số thuế'), '0312345678-001');
    await tester.tap(find.text('Gửi yêu cầu'));
    await tester.pumpAndSettle();
    expect(repo.sent!.taxCode, '0312345678-001');
    expect(repo.sent!.saveProfile, isTrue);
    expect(find.text('Đã gửi quán, chờ xuất hoá đơn'), findsOneWidget);
    expect(find.textContaining(formatVnd(300000)), findsOneWidget);
  });
}
