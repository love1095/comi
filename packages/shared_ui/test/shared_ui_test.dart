import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

MapTable t(
  String code,
  int x,
  int y, {
  int w = 2,
  int h = 2,
  int rot = 0,
  int min = 1,
  int max = 4,
  MapTableState state = MapTableState.available,
}) => MapTable(id: code, code: code, minSeats: min, maxSeats: max, x: x, y: y, width: w, height: h, rotation: rot, state: state);

void main() {
  group('format', () {
    test('VND in Vietnamese and English', () {
      expect(formatVnd(150000), '150.000 ₫');
      expect(formatVnd(150000, locale: 'en'), '150,000 VND');
    });
    test('minutes and Vietnam time', () {
      expect(formatMinute(600), '10:00');
      expect(formatMinute(1500), '01:00');
      expect(formatLocalTime(DateTime.utc(2026, 12, 2, 5, 15)), '12:15');
      expect(vietnamDate(now: DateTime.utc(2026, 12, 1, 18)), '2026-12-02');
      expect(vietnamDate(days: 1, now: DateTime.utc(2026, 12, 1, 3)), '2026-12-02');
    });
  });

  group('geometry (same rules as backend layout.ts)', () {
    test('rotation swaps footprint; touching is not overlap', () {
      expect(t('A', 0, 0, w: 4, h: 2, rot: 90).footprint, (w: 2, h: 4));
      expect(tablesOverlap(t('A', 0, 0), t('B', 2, 0)), isFalse);
      expect(tablesOverlap(t('A', 0, 0), t('B', 1, 1)), isTrue);
    });

    test('validateLayout reports out of bounds, overlap, duplicates, seats', () {
      final problems = validateLayout(10, 8, [t('A1', 9, 0), t('A2', 0, 0), t('a2', 1, 1), t('B1', 5, 5, min: 6, max: 4)]);
      expect(
        problems,
        containsAll([
          const LayoutProblem(LayoutProblemType.outOfBounds, ['A1']),
          const LayoutProblem(LayoutProblemType.duplicateCode, ['a2']),
          const LayoutProblem(LayoutProblemType.badSeats, ['B1']),
          const LayoutProblem(LayoutProblemType.overlap, ['A2', 'a2']),
        ]),
      );
      expect(validateLayout(10, 8, [t('A1', 0, 0), t('A2', 3, 0)]), isEmpty);
    });

    test('snap keeps the table inside the grid', () {
      expect(snapToGrid(3.4, 2.6, (w: 2, h: 2), 10, 8), (x: 3, y: 3));
      expect(snapToGrid(-2, 99, (w: 2, h: 2), 10, 8), (x: 0, y: 6));
    });

    test('next code and free spot', () {
      expect(nextTableCode(['A1', 'a2', 'B1']), 'A3');
      expect(nextTableCode([], prefix: 'VIP'), 'VIP1');
      expect(findFreeSpot(6, 2, [t('A1', 0, 0)], (w: 2, h: 2)), (x: 2, y: 0));
      expect(findFreeSpot(2, 2, [t('A1', 0, 0)], (w: 2, h: 2)), isNull);
    });
  });

  group('TableMap widget', () {
    Future<void> pump(WidgetTester tester, Widget child) => tester.pumpWidget(
      MaterialApp(
        theme: ComiTheme.light(),
        home: Scaffold(body: SizedBox(width: 400, height: 300, child: child)),
      ),
    );

    testWidgets('shows seats and code; tap reports the table', (tester) async {
      MapTable? tapped;
      await pump(
        tester,
        TableMap(
          cols: 10,
          rows: 8,
          tables: [
            t('A1', 0, 0, min: 2, max: 4),
            t('VIP', 4, 4, w: 4, h: 3, max: 10, state: MapTableState.booked),
          ],
          onTableTap: (x) => tapped = x,
        ),
      );
      expect(find.text('2–4'), findsOneWidget);
      expect(find.text('A1'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      await tester.tap(find.text('A1'));
      expect(tapped?.code, 'A1');
    });

    testWidgets('editable: dragging a table snaps and reports the new cell', (tester) async {
      (MapTable, int, int)? moved;
      await pump(
        tester,
        TableMap(cols: 10, rows: 8, editable: true, tables: [t('A1', 0, 0)], onTableMoved: (tb, x, y) => moved = (tb, x, y)),
      );
      // cell = min(400/10, 300/8) = 37 px → drag ~3 cells right, ~2 down
      await tester.drag(find.text('A1'), const Offset(37 * 3 + 5, 37 * 2 - 4));
      await tester.pumpAndSettle();
      expect(moved?.$2, 3);
      expect(moved?.$3, 2);
    });
  });
}
