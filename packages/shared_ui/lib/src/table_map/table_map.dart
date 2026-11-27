import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'geometry.dart';

/// Floor plan of one area (§8.6). Same widget in both apps:
/// - customer app: read-only, tap to pick a table (colours by [MapTableState])
/// - restaurant app editor: [editable] = drag tables, they snap to the grid on release
///
/// Pinch/scroll to zoom. While editing, panning the canvas is off so drags move tables.
class TableMap extends StatelessWidget {
  const TableMap({
    super.key,
    required this.cols,
    required this.rows,
    required this.tables,
    this.elements = const [],
    this.editable = false,
    this.selectedIds = const {},
    this.onTableTap,
    this.onTableMoved,
    this.onElementTap,
    this.onElementMoved,
    this.minCell = 18,
  });

  final int cols;
  final int rows;
  final List<MapTable> tables;
  final List<MapElement> elements;
  final bool editable;
  final Set<String> selectedIds;
  final ValueChanged<MapTable>? onTableTap;
  final void Function(MapTable table, int x, int y)? onTableMoved;
  final ValueChanged<int>? onElementTap;
  final void Function(int index, int x, int y)? onElementMoved;
  final double minCell;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fit = [
          constraints.maxWidth.isFinite ? constraints.maxWidth / cols : 40.0,
          constraints.maxHeight.isFinite ? constraints.maxHeight / rows : 40.0,
        ].reduce((a, b) => a < b ? a : b);
        final cell = fit < minCell ? minCell : fit.floorToDouble();
        final size = Size(cols * cell, rows * cell);
        final scheme = Theme.of(context).colorScheme;

        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 3,
          panEnabled: !editable,
          constrained: false,
          boundaryMargin: const EdgeInsets.all(48),
          child: SizedBox.fromSize(
            size: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GridPainter(cols: cols, rows: rows, cell: cell, color: scheme.outlineVariant, editable: editable),
                  ),
                ),
                for (var i = 0; i < elements.length; i++)
                  _Draggable(
                    key: ValueKey('el-$i-${elements[i].kind.name}'),
                    x: elements[i].x,
                    y: elements[i].y,
                    footprint: elements[i].footprint,
                    cell: cell,
                    cols: cols,
                    rows: rows,
                    enabled: editable && onElementMoved != null,
                    onTap: onElementTap == null ? null : () => onElementTap!(i),
                    onMoved: (x, y) => onElementMoved?.call(i, x, y),
                    child: _ElementTile(element: elements[i]),
                  ),
                for (final t in tables)
                  _Draggable(
                    key: ValueKey('t-${t.id.isEmpty ? t.code : t.id}'),
                    x: t.x,
                    y: t.y,
                    footprint: t.footprint,
                    cell: cell,
                    cols: cols,
                    rows: rows,
                    enabled: editable && onTableMoved != null,
                    onTap: onTableTap == null ? null : () => onTableTap!(t),
                    onMoved: (x, y) => onTableMoved?.call(t, x, y),
                    child: TableTile(table: t, selected: selectedIds.contains(t.id), cell: cell, editable: editable),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Positions a child on the grid; when enabled it can be dragged and snaps on release.
class _Draggable extends StatefulWidget {
  const _Draggable({
    super.key,
    required this.x,
    required this.y,
    required this.footprint,
    required this.cell,
    required this.cols,
    required this.rows,
    required this.enabled,
    required this.child,
    this.onTap,
    this.onMoved,
  });

  final int x;
  final int y;
  final ({int w, int h}) footprint;
  final double cell;
  final int cols;
  final int rows;
  final bool enabled;
  final Widget child;
  final VoidCallback? onTap;
  final void Function(int x, int y)? onMoved;

  @override
  State<_Draggable> createState() => _DraggableState();
}

class _DraggableState extends State<_Draggable> {
  Offset _drag = Offset.zero;
  Offset _downLocal = Offset.zero;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final left = widget.x * widget.cell + _drag.dx;
    final top = widget.y * widget.cell + _drag.dy;
    return AnimatedPositioned(
      duration: _dragging ? Duration.zero : const Duration(milliseconds: 120),
      left: left,
      top: top,
      width: widget.footprint.w * widget.cell,
      height: widget.footprint.h * widget.cell,
      child: GestureDetector(
        onTap: widget.onTap,
        onPanDown: widget.enabled ? (d) => _downLocal = d.localPosition : null,
        // The recogniser only reports movement after the touch slop; add it back so the
        // tile stays under the finger. Local positions are already in canvas units (zoom-safe).
        onPanStart: widget.enabled
            ? (d) => setState(() {
                _dragging = true;
                _drag = d.localPosition - _downLocal;
              })
            : null,
        onPanUpdate: widget.enabled ? (d) => setState(() => _drag += d.delta) : null,
        onPanEnd: widget.enabled
            ? (_) {
                final snapped = snapToGrid(
                  widget.x + _drag.dx / widget.cell,
                  widget.y + _drag.dy / widget.cell,
                  widget.footprint,
                  widget.cols,
                  widget.rows,
                );
                setState(() {
                  _drag = Offset.zero;
                  _dragging = false;
                });
                if (snapped.x != widget.x || snapped.y != widget.y) widget.onMoved?.call(snapped.x, snapped.y);
              }
            : null,
        child: MouseRegion(
          cursor: widget.enabled ? SystemMouseCursors.grab : (widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer),
          child: AnimatedScale(scale: _dragging ? 1.06 : 1, duration: const Duration(milliseconds: 100), child: widget.child),
        ),
      ),
    );
  }
}

/// One table: big seat count, code underneath, colour by state.
class TableTile extends StatelessWidget {
  const TableTile({super.key, required this.table, required this.selected, required this.cell, this.editable = false});

  final MapTable table;
  final bool selected;
  final double cell;
  final bool editable;

  static Color colorFor(MapTableState s, ColorScheme scheme, {bool editable = false}) {
    if (editable) return scheme.secondaryContainer;
    return switch (s) {
      MapTableState.available => ComiColors.available,
      MapTableState.booked => ComiColors.booked,
      MapTableState.held => ComiColors.held,
      MapTableState.mine => ComiColors.selected,
      MapTableState.unfit => ComiColors.unfit,
      MapTableState.unavailable => ComiColors.unfit,
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = selected ? ComiColors.selected : colorFor(table.state, scheme, editable: editable);
    final fg = editable && !selected ? scheme.onSecondaryContainer : Colors.white;
    final seats = table.minSeats == table.maxSeats || table.minSeats <= 1 ? '${table.maxSeats}' : '${table.minSeats}–${table.maxSeats}';
    final round = table.shape == TableShape.round || table.shape == TableShape.barSeat;
    final pad = cell * 0.12;

    return Semantics(
      button: true,
      selected: selected,
      label: 'Table ${table.code}, $seats seats, ${table.state.name}',
      child: Opacity(
        opacity: table.active ? 1 : 0.4,
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bg,
              shape: round && table.footprint.w == table.footprint.h ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: round && table.footprint.w == table.footprint.h
                  ? null
                  : BorderRadius.circular(table.shape == TableShape.booth ? cell * 0.45 : cell * 0.2),
              border: Border.all(
                color: selected ? scheme.onSurface : (table.shape == TableShape.booth ? fg.withValues(alpha: 0.6) : Colors.transparent),
                width: selected ? 3 : 2,
              ),
              boxShadow: const [BoxShadow(blurRadius: 3, offset: Offset(0, 1), color: Color(0x33000000))],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected) Icon(Icons.check_circle, color: fg, size: 16),
                        if (editable && !table.selectable) Icon(Icons.visibility_off, color: fg, size: 14),
                        Text(
                          seats,
                          style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      table.code,
                      style: TextStyle(color: fg.withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    if (table.features.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [for (final f in table.features.take(2)) Icon(_featureIcon(f), size: 11, color: fg)],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static IconData _featureIcon(String f) => switch (f) {
    'window' => Icons.window,
    'view' => Icons.landscape,
    'private' => Icons.lock,
    'outdoor' => Icons.park,
    _ => Icons.star,
  };
}

class _ElementTile extends StatelessWidget {
  const _ElementTile({required this.element});
  final MapElement element;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (icon, text) = switch (element.kind) {
      MapElementKind.entrance => (Icons.door_front_door, 'Cửa'),
      MapElementKind.window => (Icons.window, ''),
      MapElementKind.wall => (Icons.square, ''),
      MapElementKind.kitchen => (Icons.soup_kitchen, 'Bếp'),
      MapElementKind.bar => (Icons.local_bar, 'Quầy'),
      MapElementKind.stage => (Icons.mic, 'Sân khấu'),
      MapElementKind.restroom => (Icons.wc, 'WC'),
      MapElementKind.stairs => (Icons.stairs, 'Cầu thang'),
      MapElementKind.plant => (Icons.local_florist, ''),
      MapElementKind.tv => (Icons.tv, 'TV'),
      MapElementKind.aircon => (Icons.ac_unit, ''),
      MapElementKind.smokingArea => (Icons.smoking_rooms, ''),
    };
    final isWall = element.kind == MapElementKind.wall || element.kind == MapElementKind.window;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: element.kind == MapElementKind.window
            ? Colors.lightBlue.withValues(alpha: 0.35)
            : isWall
            ? scheme.outline
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: isWall
          ? const SizedBox.expand()
          : FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 14, color: scheme.onSurfaceVariant),
                    if ((element.label ?? text).isNotEmpty) ...[
                      const SizedBox(width: 2),
                      Text(element.label ?? text, style: TextStyle(fontSize: 10, color: scheme.onSurfaceVariant)),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.cols, required this.rows, required this.cell, required this.color, required this.editable});
  final int cols;
  final int rows;
  final double cell;
  final Color color;
  final bool editable;

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)), border);
    if (!editable) return;
    final dot = Paint()..color = color.withValues(alpha: 0.7);
    for (var x = 1; x < cols; x++) {
      for (var y = 1; y < rows; y++) {
        canvas.drawCircle(Offset(x * cell, y * cell), 1.2, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.cols != cols || old.rows != rows || old.cell != cell || old.color != color || old.editable != editable;
}
