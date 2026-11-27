import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/booking/table_picker_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

class FakeHolds implements TableHoldRepository {
  FakeHolds(this.tables);
  List<MapTableStateDto> tables;
  final held = <List<String>>[];

  @override
  Future<TableMapDto> tableMap(String restaurantId, {required String arrivalAt, required int partySize, String? areaId}) async =>
      TableMapDto(
        allowTableChoice: true,
        arrivalAt: arrivalAt,
        diningMinutes: 120,
        areas: [MapAreaDto(id: 'a1', name: 'Tầng 1', floor: 1, gridCols: 12, gridRows: 6)],
        area: MapAreaWithElementsDto(id: 'a1', name: 'Tầng 1', floor: 1, gridCols: 12, gridRows: 6, elements: const []),
        tables: tables,
      );

  @override
  Future<HoldDto> hold(String restaurantId, {required List<String> tableIds, required String arrivalAt, required int partySize}) async {
    held.add(tableIds);
    return HoldDto(
      holdId: 'h1',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)).toUtc().toIso8601String(),
      tableIds: tableIds,
      arrivalAt: arrivalAt,
    );
  }

  @override
  Future<void> release(String holdId) async {}
}

void main() {
  test('selection fits one table, or same-group tables with enough seats', () {
    final a = mapTable('a', 'A1', max: 4, group: 'g');
    final b = mapTable('b', 'A2', max: 4, group: 'g');
    final c = mapTable('c', 'B1', max: 4);
    expect(selectionFits([a], 4), isTrue);
    expect(selectionFits([a], 6), isFalse);
    expect(selectionFits([a, b], 7), isTrue);
    expect(selectionFits([a, c], 7), isFalse); // different groups
    expect(countdown(const Duration(minutes: 4, seconds: 9)), '4:09');
  });

  testWidgets('tap a free table, hold it, use it', (tester) async {
    tester.view.physicalSize = const Size(420, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final repo = FakeHolds([mapTable('t1', 'A1', x: 0), mapTable('t2', 'A2', x: 4, state: MapTableStateDtoStateEnum.booked)]);
    final store = MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r');
    HeldTables? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [tokenStoreProvider.overrideWithValue(store), tableHoldRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: ComiTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () async => result = await Navigator.of(context).push<HeldTables>(
                    MaterialPageRoute(
                      builder: (_) => const TablePickerScreen(restaurantId: 'r1', arrivalAt: '2026-12-02T12:00:00Z', partySize: 4),
                    ),
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('A2'));
    await tester.pump();
    expect(find.text('Bàn A2 đã có người đặt giờ này'), findsOneWidget);

    await tester.tap(find.text('A1'));
    await tester.pump();
    await tester.tap(find.text('Giữ bàn A1 trong 5 phút'));
    await tester.pump();
    await tester.pump();
    expect(repo.held, [
      ['t1'],
    ]);
    expect(find.textContaining('Đang giữ bàn — còn 4:'), findsOneWidget);

    await tester.tap(find.text('Dùng bàn này'));
    await tester.pumpAndSettle();
    expect(result!.holdId, 'h1');
    expect(result!.codes, ['A1']);
  });
}
