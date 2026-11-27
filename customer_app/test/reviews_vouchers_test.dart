import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/booking/booking_screen.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/cart/cart.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
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

  Future<void> pump(
    WidgetTester tester,
    Widget screen, {
    FakeReviews? reviews,
    FakeBookings? bookings,
    FakeDiscovery? discovery,
    FakeVouchers? vouchers,
  }) async {
    tester.view.physicalSize = const Size(420, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r')),
        locationServiceProvider.overrideWithValue(FakeLocation()),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        reviewsRepositoryProvider.overrideWithValue(reviews ?? FakeReviews()),
        vouchersRepositoryProvider.overrideWithValue(vouchers ?? FakeVouchers()),
        notificationsRepositoryProvider.overrideWithValue(FakeNotifications()),
        bookingsRepositoryProvider.overrideWithValue(bookings ?? FakeBookings()),
        discoveryRepositoryProvider.overrideWithValue(discovery ?? FakeDiscovery()),
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

  ReviewDto review(int rating, {String? reply}) => ReviewDto(
    id: 'r$rating',
    bookingId: 'b$rating',
    restaurantId: 'r1',
    authorName: 'Lan',
    rating: rating,
    text: 'Món ngon',
    verifiedVisit: true,
    visitedAt: '2026-12-02T05:00:00Z',
    partySize: 2,
    reply: reply,
    status: ReviewDtoStatusEnum.PUBLISHED,
    createdAt: '2026-12-02T08:00:00Z',
  );

  testWidgets('restaurant page reviews: average, verified badge, reply', (tester) async {
    final reviews = FakeReviews()
      ..page = ReviewPageDto(
        ratingAvg: 4.5,
        ratingCount: 2,
        histogram: const [0, 0, 0, 1, 1],
        items: [
          review(5, reply: 'Cảm ơn!'),
          review(4),
        ],
      );
    await pump(
      tester,
      const SingleChildScrollView(child: ReviewsSection(restaurantId: 'r1')),
      reviews: reviews,
    );
    expect(find.text('4,5'), findsOneWidget);
    expect(find.textContaining('2 lượt'), findsOneWidget);
    expect(find.text('Đã đến quán'), findsNWidgets(2));
    expect(find.text('Quán trả lời: Cảm ơn!'), findsOneWidget);
  });

  testWidgets('write a review: overall stars required, then sent', (tester) async {
    final reviews = FakeReviews();
    await pump(
      tester,
      const WriteReviewScreen(bookingId: 'b1', restaurantName: 'Quán Ốc'),
      reviews: reviews,
    );
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Gửi đánh giá')).onPressed, isNull);
    await tester.tap(find.byTooltip('Tổng thể 4 sao'));
    await tester.enterText(find.byType(TextField), 'Lẩu ngon');
    await tester.pump();
    await tester.tap(find.text('Gửi đánh giá'));
    await tester.pumpAndSettle();
    expect(reviews.created, [('b1', 4, 'Lẩu ngon')]);
  });

  testWidgets('voucher at checkout: wrong code explained, right code lowers the total and is sent', (tester) async {
    final bookings = FakeBookings();
    final discovery = FakeDiscovery(
      slots: [SlotDto(time: '2026-12-02T12:00:00.000Z', local: '19:00', available: true, diningMinutes: 90)],
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
    ), CartLine(item: dish('a', 'Lẩu', price: 100000), quantity: 1));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Mã giảm giá'), 'SAI');
    await tester.tap(find.text('Áp dụng'));
    await tester.pumpAndSettle();
    expect(find.text('Không có mã này'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5)); // let the message go away (it covers the bottom bar)
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Mã giảm giá'), 'trua20');
    await tester.tap(find.text('Áp dụng'));
    await tester.pumpAndSettle();
    expect(find.text('Mã TRUA20: giảm ${formatVnd(20000)}'), findsOneWidget);
    expect(find.text(formatVnd(80000)), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, '19:00'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Đặt bàn 19:00'));
    await tester.pumpAndSettle();
    expect(bookings.created!.voucherCode, 'TRUA20');
  });
}
