import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/data/realtime.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/bookings/board_screen.dart';
import 'package:restaurant_app/features/bookings/booking_detail_screen.dart';
import 'package:restaurant_app/features/bookings/bookings_repository.dart';
import 'package:restaurant_app/features/kitchen/kitchen_repository.dart';
import 'package:restaurant_app/features/onboarding/onboarding_repository.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    FakeBookingsRepository repo,
    Widget screen, {
    Size size = const Size(1280, 800),
    FakeKitchenRepository? kitchen,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = const StoredSession(refreshToken: 'r', restaurantId: 'r1', restaurantName: 'Quán Demo');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStoreProvider.overrideWithValue(store),
          bookingsRepositoryProvider.overrideWithValue(repo),
          onboardingRepositoryProvider.overrideWithValue(FakeOnboardingRepository(profile: profileDto(status: RestaurantStatus.ACTIVE))),
          realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
          kitchenRepositoryProvider.overrideWithValue(kitchen ?? (FakeKitchenRepository()..detail = (id) => detailOf(boardDto(id)))),
        ],
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('BoardFilter / summary', () {
    test('filters by status; summary skips cancelled and counts approvals', () {
      final list = [
        boardDto('a', party: 2, total: 100000),
        boardDto('b', party: 12, status: BookingStatus.PENDING, needsApproval: true),
        boardDto('c', party: 4, status: BookingStatus.CANCELLED, total: 50000),
        boardDto('d', party: 3, status: BookingStatus.CHECKED_IN),
      ];
      expect(list.where(BoardFilter.pending.matches).map((b) => b.id), ['b']);
      expect(list.where(BoardFilter.seated.matches).map((b) => b.id), ['d']);
      expect(list.where(BoardFilter.done.matches).map((b) => b.id), ['c']);
      final s = BoardSummary(list);
      expect((s.bookings, s.guests, s.pending, s.preOrderTotal), (3, 17, 1, 100000));
    });

    test('dayLabel names today / tomorrow / weekday', () {
      final now = DateTime.utc(2026, 12, 2, 3); // 10:00 Wed 2/12 in Vietnam
      expect(dayLabel('2026-12-02', now: now), 'Hôm nay · 02/12');
      expect(dayLabel('2026-12-03', now: now), 'Ngày mai · 03/12');
      expect(dayLabel('2026-12-05', now: now), 'T7 · 05/12');
    });
  });

  group('BoardScreen', () {
    testWidgets('groups by hour, approves a large group', (tester) async {
      final repo = FakeBookingsRepository([
        boardDto('a', code: 'LUN001', arrival: '2026-12-02T05:15:00.000Z', total: 120000),
        boardDto(
          'b',
          code: 'GRP012',
          party: 12,
          arrival: '2026-12-02T12:00:00.000Z',
          status: BookingStatus.PENDING,
          needsApproval: true,
          tableCode: null,
        ),
      ]);
      await pump(tester, repo, const BoardScreen());

      expect(find.text('Quán Demo'), findsOneWidget);
      expect(find.text('Nhóm đông chờ duyệt (1)'), findsOneWidget);
      expect(find.text('12:00'), findsOneWidget); // hour header for the 12:15 booking
      expect(find.text('12:15'), findsOneWidget);
      expect(find.text('Chờ duyệt (1)'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Duyệt'));
      await tester.pumpAndSettle();
      expect(repo.calls, ['approve b']);
      expect(find.text('Đã duyệt đơn GRP012'), findsOneWidget);
      expect(find.text('Nhóm đông chờ duyệt (1)'), findsNothing);
      expect(find.text('19:00'), findsNWidgets(2)); // hour header + booking: now listed with the confirmed ones
    });

    testWidgets('reject needs a reason', (tester) async {
      final repo = FakeBookingsRepository([boardDto('b', code: 'GRP012', party: 12, status: BookingStatus.PENDING, needsApproval: true)]);
      await pump(tester, repo, const BoardScreen());

      await tester.tap(find.widgetWithText(OutlinedButton, 'Từ chối'));
      await tester.pumpAndSettle();
      final confirm = find.widgetWithText(FilledButton, 'Xác nhận huỷ');
      expect(tester.widget<FilledButton>(confirm).onPressed, isNull);

      await tester.tap(find.text('Hết bàn cho nhóm đông'));
      await tester.pumpAndSettle();
      await tester.tap(confirm);
      await tester.pumpAndSettle();
      expect(repo.calls, ['cancel b Hết bàn cho nhóm đông']);
    });

    testWidgets('empty day + date navigation', (tester) async {
      final repo = FakeBookingsRepository([]);
      await pump(tester, repo, const BoardScreen(), size: const Size(400, 800));
      expect(find.text('Không có đơn đặt bàn nào'), findsOneWidget);
      final today = repo.lastDate!;

      await tester.tap(find.byTooltip('Hôm sau'));
      await tester.pumpAndSettle();
      expect(repo.lastDate, isNot(today));
      expect(find.byTooltip('Về hôm nay'), findsOneWidget);
    });
  });

  group('BookingDetailScreen', () {
    testWidgets('shows dishes by course and total', (tester) async {
      final repo = FakeBookingsRepository(
        [boardDto('a', code: 'LUN001', party: 3, noShows: 1)],
        items: {
          'a': [
            itemDto(
              'Cơm tấm sườn',
              price: 55000,
              qty: 2,
              options: [OptionSnapshotDto(group: 'Size', option: 'Thêm trứng', priceDelta: 5000)],
            ),
            itemDto('Trà đá', price: 5000, qty: 3, course: Course.DRINK),
          ],
        },
      );
      await pump(tester, repo, const BookingDetailScreen(bookingId: 'a'));

      expect(find.text('Đơn LUN001'), findsOneWidget);
      expect(find.textContaining('Đã vắng 1 lần'), findsOneWidget);
      expect(find.text('Đồ uống'), findsOneWidget);
      expect(find.text('Món chính'), findsOneWidget);
      expect(find.text('Thêm trứng'), findsOneWidget);
      expect(find.text(formatVnd(125000)), findsOneWidget); // total
      expect(find.widgetWithText(FilledButton, 'Duyệt'), findsNothing); // already confirmed
    });

    testWidgets('move table: too-small tables are disabled, server result shown', (tester) async {
      final repo = FakeBookingsRepository(
        [boardDto('a', party: 4)],
        tables: [tableDto('t-A1', 'A1', max: 4), tableDto('t-B2', 'B2', max: 2), tableDto('t-C1', 'C1', max: 6)],
      );
      await pump(tester, repo, const BookingDetailScreen(bookingId: 'a'));

      await tester.tap(find.text('Đổi bàn'));
      await tester.pumpAndSettle();
      expect(find.text('Bàn A1'), findsNothing); // current table
      expect(tester.widget<ListTile>(find.widgetWithText(ListTile, 'Bàn B2')).enabled, isFalse);

      await tester.tap(find.text('Bàn C1'));
      await tester.pumpAndSettle();
      expect(repo.calls, ['move a t-C1']);
      expect(find.textContaining('Bàn C1'), findsOneWidget);
    });

    testWidgets('cancelled booking has no actions', (tester) async {
      final repo = FakeBookingsRepository([boardDto('a', status: BookingStatus.CANCELLED)]);
      await pump(tester, repo, const BookingDetailScreen(bookingId: 'a'));
      expect(find.text('Đổi bàn'), findsNothing);
      expect(find.text('Huỷ đơn'), findsNothing);
      expect(find.text('Khách chưa đặt món trước'), findsOneWidget);
    });
  });
}
