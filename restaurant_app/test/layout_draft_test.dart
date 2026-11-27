import 'package:comi_api/comi_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/features/tables/layout_draft.dart';
import 'package:restaurant_app/features/tables/layout_mapper.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

LayoutDraft empty({int cols = 12, int rows = 8}) =>
    LayoutDraft(areaId: 'a', areaName: 'Tầng 1', cols: cols, rows: rows, tables: const [], elements: const []);

void main() {
  group('LayoutDraft', () {
    test('addTable picks the next code and a free spot, selects it, marks dirty', () {
      final d = empty().addTable(TablePreset.all[1]).addTable(TablePreset.all[1]);
      expect(d.tables.map((t) => t.code), ['A1', 'A2']);
      expect(d.tables[1].x, 3); // A1 is 3 wide at x=0
      expect(d.tables[1].id, startsWith(newTablePrefix));
      expect(d.selection, TableSelection(d.tables[1].id));
      expect(d.dirty, isTrue);
      expect(d.problems, isEmpty);
    });

    test('new tables avoid map elements', () {
      final d = empty().addElement(MapElementKind.kitchen).addTable(TablePreset.all[1]);
      expect(d.elements.single.x, 0);
      expect(d.tables.single.x, 4); // kitchen is 4 wide
    });

    test('bar seats and booths get their own prefixes', () {
      final d = empty().addTable(TablePreset.all.last).addTable(TablePreset.all[5]);
      expect(d.tables.map((t) => t.code), ['Q1', 'S1']);
    });

    test('rotate keeps the table inside the grid', () {
      var d = empty(cols: 10, rows: 4).addTable(TablePreset.all[3]); // 5×2
      final id = d.tables.single.id;
      d = d.moveTable(id, 0, 2).rotateTable(id); // footprint 2×5 does not fit in 4 rows
      expect(d.tables.single.rotation, 90);
      expect(d.tables.single.y, 0);
      expect(d.problems.single.type, LayoutProblemType.outOfBounds); // still too tall: shown, not hidden
    });

    test('overlap and duplicate code are reported', () {
      var d = empty().addTable(TablePreset.all[0]).addTable(TablePreset.all[0]);
      final b = d.tables[1].id;
      d = d.moveTable(b, 1, 1).updateTable(b, (t) => t.copyWith(code: 'a1'));
      expect(d.problems.map((p) => p.type), containsAll([LayoutProblemType.overlap, LayoutProblemType.duplicateCode]));
    });

    test('elements outside the grid are a problem (server checks them too)', () {
      final d = empty(cols: 6, rows: 6).addElement(MapElementKind.window).resizeGrid(4, 4).updateElement(0, (e) => e.moveTo(2, 0));
      expect(d.problems.single.type, LayoutProblemType.outOfBounds);
    });

    test('duplicate, remove, select are consistent', () {
      var d = empty().addTable(TablePreset.all[1]);
      d = d.duplicateTable(d.tables.single.id);
      expect(d.tables.map((t) => t.code), ['A1', 'A2']);
      expect(tablesOverlap(d.tables[0], d.tables[1]), isFalse);
      d = d.removeTable(d.tables[0].id);
      expect(d.tables.single.code, 'A2');
      expect(d.selection, isNull);
    });

    test('small quán template: 10 tables, valid layout', () {
      final d = empty().applySmallQuanTemplate();
      expect(d.tables, hasLength(10));
      expect(d.elements, hasLength(2));
      expect(d.problems, isEmpty);
      expect(d.totalSeats, 6 * 4 + 4 * 2);
    });
  });

  group('mapper', () {
    test('unplaced tables get a free spot and the draft needs saving', () {
      final d = draftFromDto(layoutDto(tables: [tableDto('t1', 'A1', x: 0, y: 0), tableDto('t2', 'A2')]));
      expect(d.tables.firstWhere((t) => t.id == 't2').x, 2);
      expect(d.dirty, isTrue);
      expect(d.problems, isEmpty);
    });

    test('round trip keeps ids, inactive and non-selectable tables; new tables have no id', () {
      var d = draftFromDto(
        layoutDto(
          tables: [tableDto('t1', 'A1', x: 0, y: 0, active: false), tableDto('t2', 'A2', x: 4, y: 0, selectable: false)],
          elements: [
            api.MapElementResponseDto(id: 'e1', type: api.MapElementType.SMOKING_AREA, x: 0, y: 6, width: 2, height: 2, rotation: 0),
          ],
        ),
      );
      expect(d.dirty, isFalse);
      d = d.addTable(TablePreset.all[0]);
      final dto = draftToDto(d);
      expect(dto.tables.map((t) => t.id), ['t1', 't2', null]);
      expect(dto.tables[0].isActive, isFalse);
      expect(dto.tables[1].isSelectable, isFalse);
      expect(dto.tables[2].shape, api.LayoutTableDtoShapeEnum.SQUARE);
      expect(dto.elements.single.type, api.MapElementDtoTypeEnum.SMOKING_AREA);
    });

    test('codes are upper-cased and blank join groups dropped', () {
      var d = empty().addTable(TablePreset.all[0]);
      d = d.updateTable(d.tables.single.id, (t) => t.copyWith(code: ' vip1 ', joinGroup: '  '));
      final t = draftToDto(d).tables.single;
      expect(t.code, 'VIP1');
      expect(t.joinGroup, isNull);
    });

    test('every element kind maps to an API enum value', () {
      for (final k in MapElementKind.values) {
        expect(api.MapElementType.values.map((v) => v.value), contains(elementToApi(k).value));
      }
    });
  });
}
