import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/data/realtime.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/bookings/table_actions.dart';
import 'package:restaurant_app/features/kitchen/kitchen_repository.dart';
import 'package:restaurant_app/features/kitchen/kitchen_screen.dart';
import 'package:restaurant_app/features/kitchen/service_requests.dart';
import 'package:restaurant_app/features/menu/menu_repository.dart';
import 'package:restaurant_app/features/onboarding/onboarding_repository.dart';
import 'package:restaurant_app/features/settings/settings_screen.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    Widget screen, {
    required FakeKitchenRepository kitchen,
    RealtimeClient? realtime,
    List<Override> extra = const [],
    Size size = const Size(1280, 900),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()
      ..value = const StoredSession(accessToken: 'a', refreshToken: 'r', restaurantId: 'r1', restaurantName: 'Quán');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStoreProvider.overrideWithValue(store),
          restaurantIdProvider.overrideWithValue('r1'),
          kitchenRepositoryProvider.overrideWithValue(kitchen),
          realtimeClientProvider.overrideWithValue(realtime ?? NoRealtimeClient()),
          ...extra,
        ],
        child: MaterialApp(
          theme: ComiTheme.light(),
          home: Scaffold(body: screen),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('KitchenScreen', () {
    late List<bool> wake;
    late int sounds;
    List<Override> devices() => [
      wakelockProvider.overrideWithValue((on) => wake.add(on)),
      newItemSoundProvider.overrideWithValue(() => sounds++),
    ];

    setUp(() {
      wake = [];
      sounds = 0;
    });

    testWidgets('three columns; late dishes flagged; start → cooking', (tester) async {
      final kitchen = FakeKitchenRepository(
        items: [
          kitchenItem('i1', 'Phở bò', quantity: 2, scheduled: '2026-12-02T05:00:00.000Z'),
          kitchenItem('i2', 'Trà đá', status: KitchenStatus.READY, course: Course.DRINK),
          kitchenItem('i3', 'Chè', status: KitchenStatus.HOLD, course: Course.DESSERT),
        ],
      );
      await pump(tester, const KitchenScreen(), kitchen: kitchen, extra: devices());

      expect(find.text('Cần nấu (1)'), findsOneWidget);
      expect(find.text('Xong — chờ bưng (1)'), findsOneWidget);
      expect(find.text('Sắp tới (1)'), findsOneWidget);
      expect(find.text('2× Phở bò'), findsOneWidget);
      expect(find.text('Trễ 10 phút'), findsOneWidget);
      expect(find.textContaining('Chờ khách đến'), findsOneWidget);
      expect(wake, [true]);

      await tester.tap(find.text('Bắt đầu'));
      await tester.pumpAndSettle();
      expect(kitchen.calls, ['status i1 COOKING']);
      expect(find.text('Xong'), findsOneWidget); // next step offered
    });

    testWidgets('socket hint reloads the queue and rings', (tester) async {
      final realtime = FakeRealtime();
      final kitchen = FakeKitchenRepository();
      await pump(tester, const KitchenScreen(), kitchen: kitchen, realtime: realtime, extra: devices());
      expect(find.text('Chưa có món cần nấu'), findsOneWidget);

      kitchen.items = [kitchenItem('n1', 'Lẩu thái')];
      realtime.send('kitchen.item_queued', {'bookingId': 'b1', 'count': 1});
      await tester.pumpAndSettle();
      expect(sounds, 1);
      expect(find.text('1× Lẩu thái'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      expect(wake, [true, false]); // screen may sleep again after leaving
    });
  });

  testWidgets('service requests: badge count and done', (tester) async {
    final kitchen = FakeKitchenRepository(
      requests: [
        ServiceRequestDto(
          id: 's1',
          bookingId: 'b1',
          bookingCode: 'CM-1',
          tableCode: 'A3',
          type: ServiceType.MORE_ICE,
          status: ServiceRequestDtoStatusEnum.OPEN,
          createdAt: '2026-12-02T05:00:00.000Z',
        ),
      ],
    );
    await pump(tester, const Center(child: ServiceRequestsButton()), kitchen: kitchen);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byTooltip('Yêu cầu của khách'));
    await tester.pumpAndSettle();
    expect(find.text('Bàn A3 · Thêm đá'), findsOneWidget);
    await tester.tap(find.text('Xong'));
    await tester.pumpAndSettle();
    expect(kitchen.calls, ['done s1']);
    expect(find.text('Không có yêu cầu nào'), findsOneWidget);
  });

  group('TableActions', () {
    testWidgets('confirmed: guest arrived; late: keep table', (tester) async {
      final kitchen = FakeKitchenRepository()..detail = (id) => detailOf(boardDto(id, status: BookingStatus.CHECKED_IN));
      final b = detailOf(boardDto('b1'));
      await pump(
        tester,
        TableActions(booking: b, now: DateTime.parse('2026-12-02T05:20:00Z')),
        kitchen: kitchen,
      );

      await tester.tap(find.text('Khách đến trễ, giữ bàn +15′'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Khách đã đến'));
      await tester.pumpAndSettle();
      expect(kitchen.calls, ['extend b1', 'checkIn b1']);
    });

    testWidgets('seated: add dishes, fire, close the bill with the live total', (tester) async {
      final kitchen = FakeKitchenRepository(
        billValue: BillDto(bookingId: 'b1', code: 'CM', status: BookingStatus.CHECKED_IN, rounds: const [], total: 135000),
      )..detail = (id) => detailOf(boardDto(id, status: BookingStatus.COMPLETED));
      final b = detailOf(boardDto('b1', status: BookingStatus.CHECKED_IN));
      final menu = [
        StaffMenuCategoryDto(
          id: 'c1',
          name: 'Đồ uống',
          sortOrder: 0,
          items: [
            StaffMenuItemDto(
              id: 'tea',
              categoryId: 'c1',
              name: 'Trà đá',
              price: 5000,
              course: Course.DRINK,
              kind: ItemKind.DRINK,
              prepMinutes: 1,
              isAvailable: true,
              isPreorderable: true,
              isAlcohol: false,
              leadHours: 0,
              tags: const [],
              sortOrder: 0,
              photos: const [],
              optionGroups: const [],
              translations: const [],
            ),
          ],
        ),
      ];
      await pump(
        tester,
        TableActions(booking: b),
        kitchen: kitchen,
        extra: [menuProvider.overrideWith((ref) async => menu)],
      );

      await tester.tap(find.text('Gọi thêm món'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Thêm Trà đá'));
      await tester.tap(find.byTooltip('Thêm Trà đá'));
      await tester.pump();
      await tester.tap(find.text('Gửi 2 món vào bếp'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ra món tiếp'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tính tiền'));
      await tester.pumpAndSettle();
      expect(find.text('Hoá đơn trong app: ${formatVnd(135000)}'), findsOneWidget);
      await tester.enterText(find.byType(TextField), '150000');
      await tester.tap(find.text('Xác nhận'));
      await tester.pumpAndSettle();

      expect(kitchen.calls, ['round b1 teax2', 'fire b1 ALL', 'close b1 150000']);
    });

    testWidgets('live bill: confirm a round waiting for staff', (tester) async {
      final item = BoardOrderItemDto(
        id: 'x',
        nameSnapshot: 'Bia',
        unitPrice: 20000,
        quantity: 2,
        optionsSnapshot: const [],
        course: Course.DRINK,
        kitchenStatus: KitchenStatus.HOLD,
        round: 1,
      );
      final kitchen = FakeKitchenRepository(
        billValue: BillDto(
          bookingId: 'b1',
          code: 'CM',
          status: BookingStatus.CHECKED_IN,
          rounds: [
            BillRoundDto(round: 1, waitingForStaff: true, subtotal: 40000, items: [item]),
          ],
          total: 40000,
        ),
      );
      await pump(
        tester,
        const SingleChildScrollView(child: LiveBill(bookingId: 'b1')),
        kitchen: kitchen,
      );
      expect(find.text('Gọi thêm lần 1'), findsOneWidget);
      await tester.tap(find.text('Xác nhận gửi bếp'));
      await tester.pumpAndSettle();
      expect(kitchen.calls, ['approve b1 1']);
    });
  });

  testWidgets('settings: table ordering approval and kitchen limit are saved', (tester) async {
    final kitchen = FakeKitchenRepository();
    final onboarding = FakeOnboardingRepository(profile: profileDto(status: RestaurantStatus.ACTIVE));
    await pump(
      tester,
      const SettingsScreen(),
      kitchen: kitchen,
      extra: [onboardingRepositoryProvider.overrideWithValue(onboarding)],
      size: const Size(1280, 1600),
    );

    await tester.tap(find.text('Nhân viên xác nhận trước khi gửi bếp'));
    await tester.tap(find.text('Giới hạn món đặt trước'));
    await tester.pumpAndSettle();
    expect(find.text('20 món'), findsOneWidget);
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();

    expect(onboarding.settings!.tableOrderingNeedsApproval, isTrue);
    expect(kitchen.savedRules!.single.maxItems, 20);
    expect(find.text('Đã lưu cài đặt'), findsOneWidget);
  });
}
