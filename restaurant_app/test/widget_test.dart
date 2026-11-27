import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/app/router.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/tables/map_editor_screen.dart';
import 'package:restaurant_app/features/tables/tables_repository.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  group('sessionRedirect', () {
    test('loading → splash, logged out → login, no restaurant → picker, else areas', () {
      expect(sessionRedirect(const AsyncLoading(), '/areas'), '/splash');
      expect(sessionRedirect(const AsyncData(Session()), '/areas'), '/login');
      expect(sessionRedirect(const AsyncData(Session()), '/login'), isNull);
      expect(sessionRedirect(const AsyncData(Session(refreshToken: 'r')), '/login'), '/restaurants');
      const full = Session(refreshToken: 'r', restaurantId: 'x');
      expect(sessionRedirect(const AsyncData(full), '/restaurants'), '/board');
      expect(sessionRedirect(const AsyncData(full), '/board/abc'), isNull);
      expect(sessionRedirect(const AsyncData(full), '/areas/abc'), isNull);
    });
  });

  group('MapEditorScreen', () {
    Future<FakeTablesRepository> pumpEditor(WidgetTester tester, FakeTablesRepository repo, {Size size = const Size(1280, 800)}) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [tablesRepositoryProvider.overrideWithValue(repo)],
          child: MaterialApp(
            theme: ComiTheme.light(),
            home: const MapEditorScreen(areaId: 'area1'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return repo;
    }

    testWidgets('loads the map, edits seats in the inspector, saves', (tester) async {
      final repo = await pumpEditor(tester, FakeTablesRepository(layoutDto(tables: [tableDto('t1', 'A1', x: 0, y: 0, max: 4)])));

      expect(find.text('Tầng 1'), findsOneWidget);
      expect(find.textContaining('1 bàn · 4 chỗ'), findsOneWidget);
      final save = find.widgetWithText(FilledButton, 'Lưu');
      expect(tester.widget<FilledButton>(save).onPressed, isNull); // nothing changed yet

      await tester.tap(find.text('A1'));
      await tester.pumpAndSettle();
      expect(find.text('Bàn A1'), findsOneWidget); // inspector open (wide layout)

      // "Nhiều nhất" stepper is the second "Thêm" button.
      await tester.tap(find.byTooltip('Thêm').at(1));
      await tester.pumpAndSettle();
      expect(find.textContaining('5 chỗ'), findsOneWidget);

      await tester.tap(save);
      await tester.pumpAndSettle();
      expect(repo.lastSaved!.tables.single.maxSeats, 5);
      expect(repo.lastSaved!.tables.single.id, 't1');
      expect(find.text('Đã lưu sơ đồ'), findsOneWidget);
    });

    testWidgets('empty room offers the template; problems block saving', (tester) async {
      final repo = await pumpEditor(tester, FakeTablesRepository(layoutDto()));
      await tester.tap(find.text('Mẫu quán nhỏ (10 bàn)'));
      await tester.pumpAndSettle();
      expect(find.textContaining('10 bàn · 32 chỗ'), findsOneWidget);

      // Rename A2 to A1 → duplicate code → save disabled.
      await tester.tap(find.text('A2'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'A2'), 'A1');
      await tester.pumpAndSettle();
      expect(find.textContaining('Trùng mã bàn'), findsWidgets);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Lưu')).onPressed, isNull);

      await tester.tap(find.byTooltip('Hoàn tác'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Trùng mã bàn'), findsNothing);
      expect(repo.lastSaved, isNull);
    });

    testWidgets('list view shows every table', (tester) async {
      await pumpEditor(
        tester,
        FakeTablesRepository(layoutDto(tables: [tableDto('t1', 'B2', x: 0, y: 0), tableDto('t2', 'B1', x: 4, y: 0, selectable: false)])),
      );
      await tester.tap(find.text('Danh sách'));
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.textContaining('khách không tự chọn'), findsOneWidget);
    });
  });

  test('session restores from storage; restaurantId only after picking', () async {
    final store = MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(overrides: [tokenStoreProvider.overrideWithValue(store)]);
    addTearDown(c.dispose);
    final s = await c.read(sessionProvider.future);
    expect(s.loggedIn, isTrue);
    expect(() => c.read(restaurantIdProvider), throwsA(anything));

    await c.read(sessionProvider.notifier).selectRestaurant('r1', 'Quán Demo');
    expect(c.read(restaurantIdProvider), 'r1');
    expect(store.value.restaurantName, 'Quán Demo');
  });
}
