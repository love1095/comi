/// Table-map geometry (§8.6), same rules as the backend's `layout.ts`, so the editor
/// can show problems before saving. Units are grid cells.
library;

enum TableShape { rect, round, square, booth, barSeat }

enum MapTableState { available, booked, held, mine, unfit, unavailable }

class MapTable {
  const MapTable({
    required this.id,
    required this.code,
    required this.minSeats,
    required this.maxSeats,
    required this.x,
    required this.y,
    this.width = 2,
    this.height = 2,
    this.rotation = 0,
    this.shape = TableShape.rect,
    this.features = const [],
    this.joinGroup,
    this.selectable = true,
    this.active = true,
    this.state = MapTableState.available,
  });

  /// Empty for a table not saved yet.
  final String id;
  final String code;
  final int minSeats;
  final int maxSeats;
  final int x;
  final int y;
  final int width;
  final int height;
  final int rotation;
  final TableShape shape;
  final List<String> features;
  final String? joinGroup;

  /// Customers may pick it on the map (§8.6 `isSelectable`).
  final bool selectable;

  /// Inactive tables (removed but still referenced by bookings) stay on the server.
  final bool active;
  final MapTableState state;

  /// Width/height after rotation: 90 and 270 swap them.
  ({int w, int h}) get footprint => rotation == 90 || rotation == 270 ? (w: height, h: width) : (w: width, h: height);

  MapTable copyWith({
    String? code,
    int? minSeats,
    int? maxSeats,
    int? x,
    int? y,
    int? width,
    int? height,
    int? rotation,
    TableShape? shape,
    List<String>? features,
    String? joinGroup,
    bool clearJoinGroup = false,
    bool? selectable,
    bool? active,
    MapTableState? state,
  }) => MapTable(
    id: id,
    code: code ?? this.code,
    minSeats: minSeats ?? this.minSeats,
    maxSeats: maxSeats ?? this.maxSeats,
    x: x ?? this.x,
    y: y ?? this.y,
    width: width ?? this.width,
    height: height ?? this.height,
    rotation: rotation ?? this.rotation,
    shape: shape ?? this.shape,
    features: features ?? this.features,
    joinGroup: clearJoinGroup ? null : (joinGroup ?? this.joinGroup),
    selectable: selectable ?? this.selectable,
    active: active ?? this.active,
    state: state ?? this.state,
  );
}

enum MapElementKind { entrance, window, wall, kitchen, bar, stage, restroom, stairs, plant, tv, aircon, smokingArea }

class MapElement {
  const MapElement({required this.kind, required this.x, required this.y, this.width = 1, this.height = 1, this.rotation = 0, this.label});

  final MapElementKind kind;
  final int x;
  final int y;
  final int width;
  final int height;
  final int rotation;
  final String? label;

  ({int w, int h}) get footprint => rotation == 90 || rotation == 270 ? (w: height, h: width) : (w: width, h: height);

  MapElement moveTo(int nx, int ny) => copyWith(x: nx, y: ny);

  MapElement copyWith({int? x, int? y, int? width, int? height, int? rotation, String? label, bool clearLabel = false}) => MapElement(
    kind: kind,
    x: x ?? this.x,
    y: y ?? this.y,
    width: width ?? this.width,
    height: height ?? this.height,
    rotation: rotation ?? this.rotation,
    label: clearLabel ? null : (label ?? this.label),
  );
}

bool tablesOverlap(MapTable a, MapTable b) {
  final fa = a.footprint, fb = b.footprint;
  return a.x < b.x + fb.w && b.x < a.x + fa.w && a.y < b.y + fb.h && b.y < a.y + fa.h;
}

enum LayoutProblemType { outOfBounds, overlap, duplicateCode, badSeats }

class LayoutProblem {
  const LayoutProblem(this.type, this.codes);
  final LayoutProblemType type;
  final List<String> codes;

  @override
  String toString() => '${type.name}: ${codes.join(', ')}';

  @override
  bool operator ==(Object other) => other is LayoutProblem && other.type == type && other.codes.join('|') == codes.join('|');

  @override
  int get hashCode => Object.hash(type, codes.join('|'));
}

/// Same checks as the server: inside the grid, no overlapping tables, unique codes, valid seats.
List<LayoutProblem> validateLayout(int cols, int rows, List<MapTable> tables) {
  final problems = <LayoutProblem>[];
  final seen = <String>{};
  for (final t in tables) {
    final code = t.code.toUpperCase();
    if (!seen.add(code)) problems.add(LayoutProblem(LayoutProblemType.duplicateCode, [t.code]));
    if (t.minSeats < 1 || t.maxSeats < t.minSeats) problems.add(LayoutProblem(LayoutProblemType.badSeats, [t.code]));
    final f = t.footprint;
    if (t.x < 0 || t.y < 0 || t.x + f.w > cols || t.y + f.h > rows) {
      problems.add(LayoutProblem(LayoutProblemType.outOfBounds, [t.code]));
    }
  }
  for (var i = 0; i < tables.length; i++) {
    for (var j = i + 1; j < tables.length; j++) {
      if (tablesOverlap(tables[i], tables[j])) {
        problems.add(LayoutProblem(LayoutProblemType.overlap, [tables[i].code, tables[j].code]));
      }
    }
  }
  return problems;
}

/// Snap a dragged position (in cells, fractional) to the grid, kept inside the area.
({int x, int y}) snapToGrid(double x, double y, ({int w, int h}) footprint, int cols, int rows) {
  final sx = x.round().clamp(0, (cols - footprint.w).clamp(0, cols));
  final sy = y.round().clamp(0, (rows - footprint.h).clamp(0, rows));
  return (x: sx, y: sy);
}

/// Next free code with the same letter prefix: A1, A2 → A3.
String nextTableCode(Iterable<String> existing, {String prefix = 'A'}) {
  final used = existing.map((c) => c.toUpperCase()).toSet();
  for (var n = 1; ; n++) {
    final code = '$prefix$n';
    if (!used.contains(code)) return code;
  }
}

/// First free spot (top-left first) where a table of this footprint fits.
({int x, int y})? findFreeSpot(int cols, int rows, List<MapTable> tables, ({int w, int h}) footprint) {
  for (var y = 0; y + footprint.h <= rows; y++) {
    for (var x = 0; x + footprint.w <= cols; x++) {
      final probe = MapTable(id: '', code: '_', minSeats: 1, maxSeats: 1, x: x, y: y, width: footprint.w, height: footprint.h);
      if (!tables.any((t) => tablesOverlap(t, probe))) return (x: x, y: y);
    }
  }
  return null;
}
