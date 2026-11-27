import 'package:shared_ui/shared_ui.dart';

/// Tables added in the editor get a local id with this prefix; it is dropped on save.
const newTablePrefix = 'new-';

/// What the selection points at.
sealed class EditorSelection {
  const EditorSelection();
}

class TableSelection extends EditorSelection {
  const TableSelection(this.id);
  final String id;
  @override
  bool operator ==(Object other) => other is TableSelection && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

class ElementSelection extends EditorSelection {
  const ElementSelection(this.index);
  final int index;
  @override
  bool operator ==(Object other) => other is ElementSelection && other.index == index;
  @override
  int get hashCode => index.hashCode;
}

/// Palette entry for a new table (§8.6: rectangle 2/4/6/8, round, booth, bar seat).
class TablePreset {
  const TablePreset(this.label, this.shape, this.maxSeats, this.w, this.h, {this.minSeats = 1});
  final String label;
  final TableShape shape;
  final int minSeats;
  final int maxSeats;
  final int w;
  final int h;

  static const all = [
    TablePreset('Bàn 2', TableShape.square, 2, 2, 2),
    TablePreset('Bàn 4', TableShape.rect, 4, 3, 2, minSeats: 2),
    TablePreset('Bàn 6', TableShape.rect, 6, 4, 2, minSeats: 3),
    TablePreset('Bàn 8', TableShape.rect, 8, 5, 2, minSeats: 5),
    TablePreset('Bàn tròn', TableShape.round, 4, 2, 2, minSeats: 2),
    TablePreset('Ghế sofa', TableShape.booth, 4, 3, 2, minSeats: 2),
    TablePreset('Ghế quầy', TableShape.barSeat, 1, 1, 1),
  ];
}

/// Default size of each map element when dropped from the palette.
({int w, int h}) defaultElementSize(MapElementKind k) => switch (k) {
  MapElementKind.entrance => (w: 2, h: 1),
  MapElementKind.window || MapElementKind.wall => (w: 4, h: 1),
  MapElementKind.kitchen || MapElementKind.stage => (w: 4, h: 3),
  MapElementKind.bar => (w: 4, h: 2),
  MapElementKind.restroom || MapElementKind.stairs || MapElementKind.smokingArea => (w: 2, h: 2),
  MapElementKind.plant || MapElementKind.tv || MapElementKind.aircon => (w: 1, h: 1),
};

String elementName(MapElementKind k) => switch (k) {
  MapElementKind.entrance => 'Cửa ra vào',
  MapElementKind.window => 'Cửa sổ',
  MapElementKind.wall => 'Tường',
  MapElementKind.kitchen => 'Bếp',
  MapElementKind.bar => 'Quầy bar',
  MapElementKind.stage => 'Sân khấu',
  MapElementKind.restroom => 'WC',
  MapElementKind.stairs => 'Cầu thang',
  MapElementKind.plant => 'Cây',
  MapElementKind.tv => 'TV',
  MapElementKind.aircon => 'Máy lạnh',
  MapElementKind.smokingArea => 'Khu hút thuốc',
};

const tableFeatures = {'window': 'Gần cửa sổ', 'view': 'Có view', 'private': 'Riêng tư', 'outdoor': 'Ngoài trời'};

/// Immutable editor state for one area. Every change returns a new draft.
class LayoutDraft {
  const LayoutDraft({
    required this.areaId,
    required this.areaName,
    required this.cols,
    required this.rows,
    required this.tables,
    required this.elements,
    this.selection,
    this.dirty = false,
    this.nextLocalId = 1,
  });

  final String areaId;
  final String areaName;
  final int cols;
  final int rows;
  final List<MapTable> tables;
  final List<MapElement> elements;
  final EditorSelection? selection;
  final bool dirty;
  final int nextLocalId;

  static const minGrid = 4, maxGrid = 100, maxTableSize = 20;

  MapTable? get selectedTable => switch (selection) {
    TableSelection(:final id) => tables.where((t) => t.id == id).firstOrNull,
    _ => null,
  };

  int? get selectedElementIndex => switch (selection) {
    ElementSelection(:final index) when index < elements.length => index,
    _ => null,
  };

  int get totalSeats => tables.where((t) => t.active).fold(0, (s, t) => s + t.maxSeats);

  /// Same checks as the server (tables + elements inside the grid).
  List<LayoutProblem> get problems {
    final p = validateLayout(cols, rows, tables);
    for (final e in elements) {
      final f = e.footprint;
      if (e.x < 0 || e.y < 0 || e.x + f.w > cols || e.y + f.h > rows) {
        p.add(LayoutProblem(LayoutProblemType.outOfBounds, [e.label ?? elementName(e.kind)]));
      }
    }
    return p;
  }

  LayoutDraft _copy({
    int? cols,
    int? rows,
    List<MapTable>? tables,
    List<MapElement>? elements,
    EditorSelection? selection,
    bool clearSelection = false,
    bool? dirty,
    int? nextLocalId,
  }) => LayoutDraft(
    areaId: areaId,
    areaName: areaName,
    cols: cols ?? this.cols,
    rows: rows ?? this.rows,
    tables: tables ?? this.tables,
    elements: elements ?? this.elements,
    selection: clearSelection ? null : (selection ?? this.selection),
    dirty: dirty ?? true,
    nextLocalId: nextLocalId ?? this.nextLocalId,
  );

  LayoutDraft select(EditorSelection? s) => _copy(selection: s, clearSelection: s == null, dirty: dirty);

  /// Tables and elements as boxes, so new tables are not dropped onto the kitchen.
  List<MapTable> get _obstacles => [
    ...tables,
    for (final e in elements)
      MapTable(id: '', code: '_', minSeats: 1, maxSeats: 1, x: e.x, y: e.y, width: e.footprint.w, height: e.footprint.h),
  ];

  /// Adds a table at the first free spot (or top-left if the room is full — shown as overlap).
  LayoutDraft addTable(TablePreset p) {
    final spot = findFreeSpot(cols, rows, _obstacles, (w: p.w, h: p.h)) ?? (x: 0, y: 0);
    final prefix = switch (p.shape) {
      TableShape.barSeat => 'Q',
      TableShape.booth => 'S',
      _ => 'A',
    };
    final t = MapTable(
      id: '$newTablePrefix$nextLocalId',
      code: nextTableCode(tables.map((t) => t.code), prefix: prefix),
      minSeats: p.minSeats,
      maxSeats: p.maxSeats,
      x: spot.x,
      y: spot.y,
      width: p.w,
      height: p.h,
      shape: p.shape,
    );
    return _copy(tables: [...tables, t], selection: TableSelection(t.id), nextLocalId: nextLocalId + 1);
  }

  LayoutDraft updateTable(String id, MapTable Function(MapTable) change) =>
      _copy(tables: [for (final t in tables) t.id == id ? change(t) : t]);

  LayoutDraft moveTable(String id, int x, int y) => updateTable(id, (t) => t.copyWith(x: x, y: y));

  /// Rotates 90° and nudges the table back inside the grid if needed.
  LayoutDraft rotateTable(String id) => updateTable(id, (t) {
    final r = t.copyWith(rotation: (t.rotation + 90) % 360);
    final f = r.footprint;
    return r.copyWith(x: t.x.clamp(0, (cols - f.w).clamp(0, cols)), y: t.y.clamp(0, (rows - f.h).clamp(0, rows)));
  });

  LayoutDraft removeTable(String id) => _copy(tables: tables.where((t) => t.id != id).toList(), clearSelection: true);

  LayoutDraft duplicateTable(String id) {
    final src = tables.firstWhere((t) => t.id == id);
    final spot = findFreeSpot(cols, rows, _obstacles, src.footprint) ?? (x: src.x, y: src.y);
    final prefix = RegExp(r'^[A-Za-z]+').stringMatch(src.code) ?? 'A';
    final copy = MapTable(
      id: '$newTablePrefix$nextLocalId',
      code: nextTableCode(tables.map((t) => t.code), prefix: prefix.toUpperCase()),
      minSeats: src.minSeats,
      maxSeats: src.maxSeats,
      x: spot.x,
      y: spot.y,
      width: src.width,
      height: src.height,
      rotation: src.rotation,
      shape: src.shape,
      features: src.features,
      joinGroup: src.joinGroup,
      selectable: src.selectable,
    );
    return _copy(tables: [...tables, copy], selection: TableSelection(copy.id), nextLocalId: nextLocalId + 1);
  }

  LayoutDraft addElement(MapElementKind kind) {
    final size = defaultElementSize(kind);
    final spot = findFreeSpot(cols, rows, _obstacles, size) ?? (x: 0, y: 0);
    final e = MapElement(kind: kind, x: spot.x, y: spot.y, width: size.w, height: size.h);
    return _copy(elements: [...elements, e], selection: ElementSelection(elements.length));
  }

  LayoutDraft updateElement(int index, MapElement Function(MapElement) change) =>
      _copy(elements: [for (var i = 0; i < elements.length; i++) i == index ? change(elements[i]) : elements[i]]);

  LayoutDraft moveElement(int index, int x, int y) => updateElement(index, (e) => e.moveTo(x, y));

  LayoutDraft rotateElement(int index) => updateElement(index, (e) {
    final r = e.copyWith(rotation: (e.rotation + 90) % 360);
    final f = r.footprint;
    return r.copyWith(x: e.x.clamp(0, (cols - f.w).clamp(0, cols)), y: e.y.clamp(0, (rows - f.h).clamp(0, rows)));
  });

  LayoutDraft removeElement(int index) => _copy(
    elements: [
      for (var i = 0; i < elements.length; i++)
        if (i != index) elements[i],
    ],
    clearSelection: true,
  );

  LayoutDraft resizeGrid(int newCols, int newRows) => _copy(cols: newCols.clamp(minGrid, maxGrid), rows: newRows.clamp(minGrid, maxGrid));

  /// Quick start for an empty room (§8.6 templates): a small quán with 10 tables.
  LayoutDraft applySmallQuanTemplate() {
    var d = resizeGrid(cols < 16 ? 16 : cols, rows < 12 ? 12 : rows)._copy(tables: const [], elements: const []);
    d = d.addElement(MapElementKind.entrance).moveElement(0, 0, d.rows - 1);
    d = d.addElement(MapElementKind.kitchen).moveElement(1, d.cols - 4, 0);
    // Fixed spots with one-cell aisles: 6 tables for 4 on the left, 4 tables for 2 on the right.
    const spots = [
      (1, 1, 1), (1, 5, 1), (1, 1, 4), (1, 5, 4), (1, 1, 7), (1, 5, 7), //
      (0, 10, 4), (0, 13, 4), (0, 10, 7), (0, 13, 7),
    ];
    for (final (preset, x, y) in spots) {
      d = d.addTable(TablePreset.all[preset]);
      d = d.moveTable(d.tables.last.id, x, y);
    }
    return d._copy(clearSelection: true);
  }
}
