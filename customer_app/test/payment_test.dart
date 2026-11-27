import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/booking/booking_screen.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/booking/payment_panel.dart';
import 'package:customer_app/features/cart/cart.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
import 'package:customer_app/features/group/split_screen.dart';
import 'package:customer_app/features/reviews/reviews.dart';
import 'package:customer_app/features/vouchers/vouchers.dart';
import 'package:customer_app/features/notifications/notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  late ProviderContainer container;
  late List<Uri> opened;

  Future<void> pump(WidgetTester tester, Widget screen, {FakeBookings? bookings, FakeDiscovery? discovery}) async {
    tester.view.physicalSize = const Size(420, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    opened = [];
    container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r')),
        locationServiceProvider.overrideWithValue(FakeLocation()),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        reviewsRepositoryProvider.overrideWithValue(FakeReviews()),
        vouchersRepositoryProvider.overrideWithValue(FakeVouchers()),
        notificationsRepositoryProvider.overrideWithValue(FakeNotifications()),
        bookingsRepositoryProvider.overrideWithValue(bookings ?? FakeBookings()),
        discoveryRepositoryProvider.overrideWithValue(discovery ?? FakeDiscovery()),
        openUrlProvider.overrideWithValue((u) async {
          opened.add(u);
          return true;
        }),
      ],
    );
    addTearDown(container.dispose);
    await container.read(sessionProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ComiTheme.light(),
          home: Scaffold(body: screen),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  BookingPaymentDto payment(String status, {String purpose = 'BOOKING'}) => BookingPaymentDto(
    id: 'p1',
    amount: 100000,
    status: BookingPaymentDtoStatusEnum.values.byName(status),
    purpose: BookingPaymentDtoPurposeEnum.values.byName(purpose),
    expiresAt: '2026-12-02T04:15:00Z',
    refundedAmount: 0,
  );

  testWidgets('waiting for payment: countdown and "pay" opens PayOS', (tester) async {
    final bookings = FakeBookings();
    final b = bookingDto(
      status: BookingStatus.PENDING,
      paymentMode: PaymentMode.PREPAID,
      payments: [payment('PENDING')],
      items: [
        BoardOrderItemDto(
          id: 'i',
          nameSnapshot: 'Cơm',
          unitPrice: 50000,
          quantity: 2,
          optionsSnapshot: const [],
          course: Course.MAIN,
          kitchenStatus: KitchenStatus.HOLD,
          round: 0,
        ),
      ],
    );
    await pump(
      tester,
      PaymentPanel(booking: b, now: DateTime.parse('2026-12-02T04:10:30Z')),
      bookings: bookings,
    );
    expect(find.text('Chờ thanh toán ${formatVnd(100000)}'), findsOneWidget);
    expect(find.text('Còn 4:30 để thanh toán.'), findsOneWidget);

    await tester.tap(find.text('Thanh toán bằng VietQR'));
    await tester.pumpAndSettle();
    expect(bookings.calls, ['pay b1']);
    expect(opened.single.toString(), 'https://pay.payos.vn/web/x');
  });

  testWidgets('cancelled after paying: refund shown, account can be given', (tester) async {
    final bookings = FakeBookings();
    final b = bookingDto(
      status: BookingStatus.CANCELLED,
      paymentMode: PaymentMode.PREPAID,
      payments: [payment('PAID')],
      refunds: [
        BookingRefundDto(
          id: 'r1',
          amount: 100000,
          status: BookingRefundDtoStatusEnum.PENDING,
          reason: 'RESTAURANT_CANCELLED',
          createdAt: '2026-12-02T06:00:00Z',
        ),
      ],
    );
    await pump(tester, PaymentPanel(booking: b), bookings: bookings);
    expect(find.text('Đang hoàn ${formatVnd(100000)}'), findsOneWidget);
    expect(find.textContaining('quán huỷ đơn'), findsOneWidget);

    await tester.tap(find.text('Nhập tài khoản nhận hoàn tiền'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Số tài khoản'), '0011223344');
    await tester.enterText(find.widgetWithText(TextField, 'Tên chủ tài khoản'), 'NGUYEN VAN A');
    await tester.tap(find.text('Gửi'));
    await tester.pumpAndSettle();
    expect(bookings.refundAccount, (bankBin: '970436', accountNo: '0011223344', accountName: 'NGUYEN VAN A'));
  });

  testWidgets('lunch at a restaurant with PayOS: prepay by default, pays right after booking', (tester) async {
    final bookings = FakeBookings();
    final discovery = FakeDiscovery(
      prepaid: true,
      slots: [SlotDto(time: '2026-12-02T05:00:00.000Z', local: '12:00', available: true, diningMinutes: 45)],
    );
    await pump(
      tester,
      const BookingScreen(slug: 'quan-oc'),
      bookings: bookings,
      discovery: discovery,
    );
    container.read(cartProvider.notifier).add((
      id: 'r1',
      slug: 'quan-oc',
      name: 'Quán',
    ), CartLine(item: dish('a', 'Cơm sườn'), quantity: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ChoiceChip, '12:00'));
    await tester.pumpAndSettle();
    expect(find.text('Trả trước bằng VietQR'), findsOneWidget);

    // Switching to "pay at the restaurant" at lunch shows the kitchen warning.
    await tester.tap(find.text('Trả tại quán'));
    await tester.pumpAndSettle();
    expect(find.textContaining('bếp chỉ bắt đầu nấu khi bạn tới'), findsOneWidget);
    await tester.tap(find.text('Trả trước bằng VietQR'));
    await tester.pumpAndSettle();

    bookings.createdStatus = BookingStatus.PENDING;
    bookings.createdMode = PaymentMode.PREPAID;
    await tester.tap(find.textContaining('Đặt bàn 12:00'));
    await tester.pumpAndSettle();
    expect(bookings.created!.paymentMode, CreateBookingDtoPaymentModeEnum.PREPAID);
    expect(bookings.calls, contains('pay new'));
    expect(opened, isNotEmpty);
  });
}
