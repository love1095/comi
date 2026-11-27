import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/account/login_screen.dart';
import 'package:customer_app/features/booking/booking_detail_screen.dart';
import 'package:customer_app/features/booking/booking_screen.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/cart/cart.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
import 'package:customer_app/features/home/home_screen.dart';
import 'package:customer_app/features/restaurant/item_sheet.dart';
import 'package:customer_app/features/restaurant/restaurant_screen.dart';
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
    FakeDiscovery? discovery,
    FakeBookings? bookings,
    bool loggedIn = true,
    Size size = const Size(420, 1600),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = loggedIn ? const StoredSession(accessToken: 'a', refreshToken: 'r') : const StoredSession();
    container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(store),
        locationServiceProvider.overrideWithValue(FakeLocation()),
        discoveryRepositoryProvider.overrideWithValue(discovery ?? FakeDiscovery()),
        bookingsRepositoryProvider.overrideWithValue(bookings ?? FakeBookings()),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        reviewsRepositoryProvider.overrideWithValue(FakeReviews()),
        vouchersRepositoryProvider.overrideWithValue(FakeVouchers()),
        notificationsRepositoryProvider.overrideWithValue(FakeNotifications()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(sessionProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('pure helpers', () {
    test('cart merges identical lines, totals by course, flags alcohol', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      const r = (id: 'r1', slug: 's', name: 'Quán');
      final cart = c.read(cartProvider.notifier);
      final size = PublicOptionDto(id: 'big', name: 'Lớn', priceDelta: 10000);
      cart.add(r, CartLine(item: dish('a', 'Lẩu'), quantity: 1, options: [size]));
      cart.add(r, CartLine(item: dish('a', 'Lẩu'), quantity: 2, options: [size]));
      cart.add(r, CartLine(item: dish('b', 'Bia', price: 20000, course: Course.DRINK, alcohol: true), quantity: 3));

      final s = c.read(cartProvider);
      expect(s.lines.length, 2);
      expect(s.count, 6);
      expect(s.total, 3 * 60000 + 3 * 20000);
      expect(s.byCourse.keys.first, Course.DRINK);
      expect(s.hasAlcohol, isTrue);

      cart.removeOne('b');
      expect(c.read(cartProvider).quantityOf('b'), 2);
      expect(cart.belongsToOther('r2'), isTrue);
      cart.add((id: 'r2', slug: 's2', name: 'Khác'), CartLine(item: dish('x', 'Phở'), quantity: 1));
      expect(c.read(cartProvider).restaurantId, 'r2'); // switching restaurant starts a new cart
      expect(c.read(cartProvider).count, 1);
    });

    test('hours summary merges days with the same hours', () {
      expect(hoursSummary(restaurantDetail().openingHours), 'T2–T6 10:00–22:00 · T7, CN 16:00–02:00');
      expect(hoursSummary(const []), 'Chưa có giờ mở cửa');
    });

    test('phone check, distances, list filters from links', () {
      expect(isVnPhone('0901234567'), isTrue);
      expect(isVnPhone('+84 90 123 4567'), isTrue);
      expect(isVnPhone('012345'), isFalse);
      expect(formatDistance(350), '350 m');
      expect(formatDistance(1250), '1,3 km');
      expect(filtersFromQuery({'under60k': '1', 'mode': 'lunch'}), const SearchFilters(under60k: true, mode: 'lunch'));
      expect(filtersFromQuery({'section': 'tonight_groups'}), const SearchFilters(mode: 'nhau', groups10: true));
    });

    test('dev phone login token format', () async {
      expect(await DevPhoneAuth().idTokenFor('090 123 4567'), 'dev:u0901234567:+84901234567');
    });
  });

  testWidgets('restaurant page: add dishes, cart bar shows count and total', (tester) async {
    final discovery = FakeDiscovery(
      menuCats: [
        PublicMenuCategoryDto(
          id: 'c1',
          name: 'Mồi nhậu',
          items: [dish('a', 'Ốc hương', price: 120000), dish('b', 'Sò điệp', available: false)],
        ),
      ],
    );
    await pump(tester, const RestaurantScreen(slug: 'quan-oc'), discovery: discovery);

    expect(find.text('Quán Ốc Bờ Kè'), findsWidgets);
    expect(find.text('Hết món hôm nay'), findsOneWidget);
    expect(find.byTooltip('Thêm Sò điệp'), findsNothing); // sold out → no add button

    await tester.tap(find.byTooltip('Thêm Ốc hương'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Thêm Ốc hương'));
    await tester.pumpAndSettle();
    expect(find.text('Đặt bàn với món đã chọn'), findsOneWidget);
    expect(find.text(formatVnd(240000)), findsOneWidget);
  });

  testWidgets('item sheet: required option must be chosen; price includes options', (tester) async {
    final item = dish(
      'a',
      'Lẩu thái',
      price: 200000,
      groups: [
        PublicOptionGroupDto(
          id: 'g1',
          name: 'Size',
          minSelect: 1,
          maxSelect: 1,
          options: [
            PublicOptionDto(id: 'o1', name: 'Nhỏ', priceDelta: 0),
            PublicOptionDto(id: 'o2', name: 'Lớn', priceDelta: 50000),
          ],
        ),
        PublicOptionGroupDto(
          id: 'g2',
          name: 'Topping',
          minSelect: 0,
          maxSelect: 2,
          options: [PublicOptionDto(id: 't1', name: 'Mực', priceDelta: 30000)],
        ),
      ],
    );
    CartLine? result;
    await pump(
      tester,
      Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () async => result = await showModalBottomSheet<CartLine>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ItemSheet(item: item),
                ),
                child: const Text('open'),
              ),
            ),
          );
        },
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Thêm · ${formatVnd(200000)}'), findsOneWidget); // first size pre-selected

    await tester.tap(find.text('Lớn'));
    await tester.tap(find.text('Mực'));
    await tester.tap(find.byTooltip('Thêm'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thêm · ${formatVnd(2 * 280000)}'));
    await tester.pumpAndSettle();
    expect(result!.quantity, 2);
    expect(result!.options.map((o) => o.id), ['o2', 't1']);
  });

  group('BookingScreen', () {
    final slots = [
      SlotDto(time: '2026-12-02T05:00:00.000Z', local: '12:00', available: true, diningMinutes: 45),
      SlotDto(time: '2026-12-02T05:15:00.000Z', local: '12:15', available: false, diningMinutes: 45),
    ];

    testWidgets('pick a time and confirm sends the cart; same key on retry', (tester) async {
      final discovery = FakeDiscovery(slots: slots);
      final bookings = FakeBookings()..createError = Exception('network');
      await pump(
        tester,
        const BookingScreen(slug: 'quan-oc'),
        discovery: discovery,
        bookings: bookings,
      );
      container.read(cartProvider.notifier).add((
        id: 'r1',
        slug: 'quan-oc',
        name: 'Quán Ốc',
      ), CartLine(item: dish('a', 'Ốc hương', price: 120000), quantity: 2));
      await tester.pumpAndSettle();

      expect(find.text('Chọn giờ đến'), findsOneWidget);
      final busy = tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, '12:15'));
      expect(busy.onSelected, isNull);

      await tester.tap(find.widgetWithText(ChoiceChip, '12:00'));
      await tester.pumpAndSettle();
      final confirm = find.textContaining('Đặt bàn 12:00 · 2 người');
      expect(confirm, findsOneWidget);

      await tester.tap(confirm); // first try fails (network)
      await tester.pumpAndSettle();
      expect(bookings.created, isNull);
      await tester.tap(confirm);
      await tester.pumpAndSettle();

      final dto = bookings.created!;
      expect((dto.restaurantId, dto.arrivalAt, dto.partySize), ('r1', '2026-12-02T05:00:00.000Z', 2));
      expect(dto.items!.single.quantity, 2);
      expect(dto.paymentMode, CreateBookingDtoPaymentModeEnum.COD);
      expect(bookings.keys.toSet().length, 1); // retry reused the idempotency key
      expect(container.read(cartProvider).isEmpty, isTrue);
    });

    testWidgets('alcohol needs the 18+ box; big groups see the approval note', (tester) async {
      final discovery = FakeDiscovery(slots: slots);
      await pump(tester, const BookingScreen(slug: 'quan-oc'), discovery: discovery);
      container.read(cartProvider.notifier).add((
        id: 'r1',
        slug: 'quan-oc',
        name: 'Quán Ốc',
      ), CartLine(item: dish('beer', 'Bia', alcohol: true), quantity: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ChoiceChip, '12:00'));
      await tester.pumpAndSettle();
      FilledButton button() =>
          tester.widget<FilledButton>(find.ancestor(of: find.textContaining('Đặt bàn 12:00'), matching: find.byType(FilledButton)));
      expect(button().onPressed, isNull);
      await tester.tap(find.text('Tôi đủ 18 tuổi'));
      await tester.pumpAndSettle();
      expect(button().onPressed, isNotNull);

      for (var i = 0; i < 9; i++) {
        await tester.tap(find.byTooltip('Thêm người'));
      }
      await tester.pumpAndSettle();
      expect(find.text('Nhóm trên 10 người'), findsOneWidget);
      expect(discovery.slotQueries.last.$2, 11); // slots reloaded for the new party size
    });
  });

  testWidgets('booking detail: cancel an upcoming booking', (tester) async {
    final bookings = FakeBookings(
      upcoming: [
        bookingDto(
          items: [
            BoardOrderItemDto(
              id: 'i1',
              nameSnapshot: 'Ốc hương',
              unitPrice: 120000,
              quantity: 1,
              optionsSnapshot: const [],
              course: Course.MAIN,
              kitchenStatus: KitchenStatus.HOLD,
              round: 0,
            ),
          ],
        ),
      ],
    );
    await pump(tester, const BookingDetailScreen(bookingId: 'b1', justBooked: true), bookings: bookings);

    expect(find.text('Đặt bàn thành công!'), findsOneWidget);
    expect(find.text('Mã đặt bàn: CM-8K2P'), findsOneWidget);
    expect(find.text('Ốc hương'), findsOneWidget);

    await tester.tap(find.text('Huỷ bàn'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Huỷ bàn'));
    await tester.pumpAndSettle();
    expect(bookings.calls, ['cancel b1']);
    expect(find.text('Đã huỷ'), findsOneWidget);
  });

  testWidgets('home shows sections for the time of day', (tester) async {
    final discovery = FakeDiscovery(
      homeDto: HomeDto(
        mode: HomeDtoModeEnum.lunch,
        sections: [
          HomeSectionDto(key: 'lunch_near_you', items: [card('a', 'Cơm Tấm Ba Ghiền')]),
        ],
      ),
    );
    await pump(tester, const HomeScreen(), discovery: discovery);
    expect(find.text('Trưa nay ăn gì?'), findsOneWidget);
    expect(find.text('Cơm trưa gần bạn'), findsOneWidget);
    expect(find.text('Cơm Tấm Ba Ghiền'), findsOneWidget);
  });
}
