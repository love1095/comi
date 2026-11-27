import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/booking/at_table.dart';
import 'package:customer_app/features/booking/booking_detail_screen.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/cart/cart.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
import 'package:customer_app/features/restaurant/restaurant_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  late ProviderContainer container;

  Future<void> pump(WidgetTester tester, Widget screen, {required FakeBookings bookings, FakeDiscovery? discovery, String? scanned}) async {
    tester.view.physicalSize = const Size(420, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r');
    container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(store),
        locationServiceProvider.overrideWithValue(FakeLocation()),
        discoveryRepositoryProvider.overrideWithValue(discovery ?? FakeDiscovery()),
        bookingsRepositoryProvider.overrideWithValue(bookings),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        scanQrProvider.overrideWithValue((_) async => scanned),
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

  // bookingDto arrives 2026-12-02 12:00Z.
  final soon = DateTime.parse('2026-12-02T11:30:00Z');

  testWidgets('near the time: leave now, then scan to check in', (tester) async {
    final bookings = FakeBookings(upcoming: [bookingDto()]);
    await pump(
      tester,
      AtTablePanel(booking: bookingDto(), now: soon),
      bookings: bookings,
      scanned: 'https://comi.vn/c/quan-oc/A1?s=sig',
    );

    await tester.tap(find.text('Tôi đi bây giờ'));
    await tester.pumpAndSettle();
    expect(bookings.calls, ['depart b1']);
    expect(find.textContaining('khoảng 7 phút'), findsOneWidget);

    await tester.tap(find.text('Tới quán rồi — quét mã check-in'));
    await tester.pumpAndSettle();
    expect(bookings.checkedInWith, 'https://comi.vn/c/quan-oc/A1?s=sig');
    expect(find.text('Đã check-in — bếp bắt đầu làm món'), findsOneWidget);
  });

  testWidgets('hours before the booking nothing is offered yet', (tester) async {
    await pump(
      tester,
      AtTablePanel(booking: bookingDto(), now: DateTime.parse('2026-12-02T09:00:00Z')),
      bookings: FakeBookings(),
    );
    expect(find.text('Tôi đi bây giờ'), findsNothing);
    expect(find.textContaining('quét mã'), findsNothing);
  });

  testWidgets('seated: dish statuses live, call staff', (tester) async {
    final bookings = FakeBookings(upcoming: [bookingDto(status: BookingStatus.CHECKED_IN)])
      ..billValue = BillDto(
        bookingId: 'b1',
        code: 'CM',
        status: BookingStatus.CHECKED_IN,
        rounds: [
          BillRoundDto(
            round: 0,
            waitingForStaff: false,
            subtotal: 110000,
            items: [
              BoardOrderItemDto(
                id: 'i1',
                nameSnapshot: 'Phở bò',
                unitPrice: 55000,
                quantity: 2,
                optionsSnapshot: const [],
                course: Course.MAIN,
                kitchenStatus: KitchenStatus.COOKING,
                round: 0,
              ),
            ],
          ),
        ],
        total: 110000,
      );
    await pump(tester, const BookingDetailScreen(bookingId: 'b1'), bookings: bookings);

    expect(find.text('Món của bàn'), findsOneWidget);
    expect(find.text('Đang nấu'), findsOneWidget);
    expect(find.text(formatVnd(110000)), findsWidgets);
    expect(find.text('Gọi thêm món'), findsOneWidget);

    await tester.tap(find.text('Thêm đá'));
    await tester.pumpAndSettle();
    expect(bookings.calls, ['service MORE_ICE']);
    expect(find.text('Đã báo nhân viên: Thêm đá'), findsOneWidget);
  });

  testWidgets('order more at the table: "table only" dishes allowed, cart goes to the kitchen', (tester) async {
    final bookings = FakeBookings(upcoming: [bookingDto(status: BookingStatus.CHECKED_IN)]);
    final tableOnly = PublicMenuItemDto(
      id: 'oc',
      name: 'Ốc len xào dừa',
      translated: PublicMenuItemDtoTranslatedEnum.none,
      originalName: 'Ốc len xào dừa',
      price: 90000,
      course: Course.STARTER,
      kind: ItemKind.DISH,
      prepMinutes: 10,
      isAvailable: true,
      isPreorderable: false,
      isAlcohol: false,
      leadHours: 0,
      tags: const [],
      photos: const [],
      optionGroups: const [],
    );
    final discovery = FakeDiscovery(
      menuCats: [
        PublicMenuCategoryDto(id: 'c', name: 'Mồi', items: [tableOnly]),
      ],
    );
    await pump(
      tester,
      const RestaurantScreen(slug: 'quan-oc', tableBookingId: 'b1'),
      bookings: bookings,
      discovery: discovery,
    );

    expect(find.text('Gọi thêm món cho bàn của bạn'), findsOneWidget);
    expect(find.text('Đặt bàn'), findsNothing);
    await tester.tap(find.byTooltip('Thêm Ốc len xào dừa'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gửi món vào bếp'));
    await tester.pumpAndSettle();

    expect(bookings.ordered!.single.menuItemId, 'oc');
    expect(container.read(cartProvider).isEmpty, isTrue);
  });
}
