import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import 'inspector.dart';
import 'layout_draft.dart';
import 'map_editor_controller.dart';

enum _View { edit, preview, list }

/// Table map editor (§8.6): drag tables/elements on a grid, edit details, save.
/// Tablet: palette left, map centre, inspector right. Phone: palette in a sheet, inspector in a sheet.
class MapEditorScreen extends ConsumerStatefulWidget {
  const MapEditorScreen({super.key, required this.areaId});
  final String areaId;

  @override
  ConsumerState<MapEditorScreen> createState() => _MapEditorScreenState();
}

class _MapEditorScreenState extends ConsumerState<MapEditorScreen> {
  var _view = _View.edit;
  var _saving = false;

  MapEditorController get _ctrl => ref.read(mapEditorProvider(widget.areaId).notifier);

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg), backgroundColor: error ? Theme.of(context).colorScheme.error : null));
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final err = await _ctrl.save();
    if (!mounted) return;
    setState(() => _saving = false);
    err == null ? _snack('Đã lưu sơ đồ') : _snack(err, error: true);
  }

  Future<bool> _confirmDiscard() async =>
      await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Bỏ thay đổi?'),
          content: const Text('Sơ đồ chưa được lưu.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Ở lại')),
            FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Bỏ thay đổi')),
          ],
        ),
      ) ??
      false;

  Future<void> _editGridSize(LayoutDraft d) async {
    final result = await showDialog<(int, int)>(
      context: context,
      builder: (_) => _GridSizeDialog(cols: d.cols, rows: d.rows),
    );
    if (result != null) _ctrl.edit((d) => d.resizeGrid(result.$1, result.$2));
  }

  bool _isWide(BuildContext context) => MediaQuery.sizeOf(context).width >= 900;

  void _select(EditorSelection? s, LayoutDraft d) {
    _ctrl.edit((d) => d.select(s), undoable: false);
    if (s != null && !_isWide(context)) _openInspectorSheet();
  }

  void _openInspectorSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, _) => Consumer(
          builder: (context, ref, _) {
            final d = ref.watch(mapEditorProvider(widget.areaId)).value;
            final panel = d == null ? null : _inspector(d, closeOnDelete: true);
            return panel ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _openPaletteSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (c) => _Palette(
        onTable: (p) {
          Navigator.pop(c);
          _ctrl.edit((d) => d.addTable(p));
        },
        onElement: (k) {
          Navigator.pop(c);
          _ctrl.edit((d) => d.addElement(k));
        },
      ),
    );
  }

  Widget? _inspector(LayoutDraft d, {bool closeOnDelete = false}) {
    void closeIfSheet() {
      if (closeOnDelete) Navigator.of(context).pop();
    }

    final t = d.selectedTable;
    if (t != null) {
      return TableInspector(
        key: ValueKey('ti-${t.id}'),
        table: t,
        problems: d.problems.where((p) => p.codes.contains(t.code)).toList(),
        onChanged: (change) => _ctrl.edit((d) => d.updateTable(t.id, change)),
        onRotate: () => _ctrl.edit((d) => d.rotateTable(t.id)),
        onDuplicate: () => _ctrl.edit((d) => d.duplicateTable(t.id)),
        onDelete: () {
          closeIfSheet();
          _ctrl.edit((d) => d.removeTable(t.id));
        },
      );
    }
    final i = d.selectedElementIndex;
    if (i != null) {
      return ElementInspector(
        key: ValueKey('ei-$i'),
        index: i,
        element: d.elements[i],
        onChanged: (change) => _ctrl.edit((d) => d.updateElement(i, change)),
        onRotate: () => _ctrl.edit((d) => d.rotateElement(i)),
        onDelete: () {
          closeIfSheet();
          _ctrl.edit((d) => d.removeElement(i));
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mapEditorProvider(widget.areaId));
    final d = async.value;
    final wide = _isWide(context);

    return PopScope(
      canPop: !(d?.dirty ?? false),
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmDiscard() && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(d?.areaName ?? 'Sơ đồ bàn'),
          actions: d == null
              ? null
              : [
                  SegmentedButton<_View>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: _View.edit,
                        icon: const Icon(Icons.edit),
                        label: wide ? const Text('Sửa') : null,
                        tooltip: 'Sửa',
                      ),
                      ButtonSegment(
                        value: _View.preview,
                        icon: const Icon(Icons.visibility),
                        label: wide ? const Text('Khách thấy') : null,
                        tooltip: 'Xem như khách',
                      ),
                      ButtonSegment(
                        value: _View.list,
                        icon: const Icon(Icons.list),
                        label: wide ? const Text('Danh sách') : null,
                        tooltip: 'Danh sách',
                      ),
                    ],
                    selected: {_view},
                    onSelectionChanged: (s) => setState(() => _view = s.first),
                  ),
                  IconButton(tooltip: 'Hoàn tác', onPressed: _ctrl.canUndo ? _ctrl.undo : null, icon: const Icon(Icons.undo)),
                  IconButton(tooltip: 'Kích thước khu vực', onPressed: () => _editGridSize(d), icon: const Icon(Icons.aspect_ratio)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FilledButton.icon(
                      onPressed: d.dirty && !_saving && d.problems.isEmpty ? _save : null,
                      icon: _saving
                          ? const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: const Text('Lưu'),
                    ),
                  ),
                ],
        ),
        floatingActionButton: d != null && !wide && _view == _View.edit
            ? FloatingActionButton.extended(onPressed: _openPaletteSheet, icon: const Icon(Icons.add), label: const Text('Thêm'))
            : null,
        body: switch (async) {
          AsyncValue(:final error?) when d == null => _ErrorView(
            message: ApiError.from(error).userMessage,
            onRetry: () => ref.invalidate(mapEditorProvider(widget.areaId)),
          ),
          _ when d == null => const Center(child: CircularProgressIndicator()),
          _ => _body(d, wide),
        },
      ),
    );
  }

  Widget _body(LayoutDraft d, bool wide) {
    final problems = d.problems;
    final header = _StatusBar(draft: d, problems: problems);

    final Widget main = switch (_view) {
      _View.list => _TableList(
        draft: d,
        onTap: (t) {
          setState(() => _view = _View.edit);
          _select(TableSelection(t.id), d);
        },
      ),
      _View.preview => Padding(
        padding: const EdgeInsets.all(16),
        child: TableMap(
          cols: d.cols,
          rows: d.rows,
          elements: d.elements,
          tables: [
            for (final t in d.tables.where((t) => t.active))
              t.copyWith(state: t.selectable ? MapTableState.available : MapTableState.unavailable),
          ],
        ),
      ),
      _View.edit =>
        d.tables.isEmpty && d.elements.isEmpty
            ? _EmptyRoom(onTemplate: () => _ctrl.edit((d) => d.applySmallQuanTemplate()), onAdd: wide ? null : _openPaletteSheet)
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _ctrl.edit((d) => d.select(null), undoable: false),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TableMap(
                    cols: d.cols,
                    rows: d.rows,
                    editable: true,
                    tables: d.tables,
                    elements: d.elements,
                    selectedIds: {if (d.selectedTable != null) d.selectedTable!.id},
                    onTableTap: (t) => _select(TableSelection(t.id), d),
                    onTableMoved: (t, x, y) => _ctrl.edit((d) => d.moveTable(t.id, x, y).select(TableSelection(t.id))),
                    onElementTap: (i) => _select(ElementSelection(i), d),
                    onElementMoved: (i, x, y) => _ctrl.edit((d) => d.moveElement(i, x, y)),
                  ),
                ),
              ),
    };

    if (!wide) {
      return Column(
        children: [
          header,
          Expanded(child: main),
        ],
      );
    }

    final inspector = _view == _View.edit ? _inspector(d) : null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_view == _View.edit)
          SizedBox(
            width: 200,
            child: _Palette(onTable: (p) => _ctrl.edit((d) => d.addTable(p)), onElement: (k) => _ctrl.edit((d) => d.addElement(k))),
          ),
        if (_view == _View.edit) const VerticalDivider(width: 1),
        Expanded(
          child: Column(
            children: [
              header,
              Expanded(child: main),
            ],
          ),
        ),
        if (inspector != null) ...[const VerticalDivider(width: 1), SizedBox(width: 320, child: inspector)],
      ],
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.draft, required this.problems});
  final LayoutDraft draft;
  final List<LayoutProblem> problems;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final count = draft.tables.where((t) => t.active).length;
    return Material(
      color: problems.isEmpty ? scheme.surfaceContainerLow : scheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: problems.isEmpty
                  ? Text('$count bàn · ${draft.totalSeats} chỗ · ${draft.cols}×${draft.rows} ô${draft.dirty ? ' · chưa lưu' : ''}')
                  : Text(
                      problems.take(2).map(problemText).join(' · ') + (problems.length > 2 ? ' (+${problems.length - 2})' : ''),
                      style: TextStyle(color: scheme.onErrorContainer),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Palette extends StatelessWidget {
  const _Palette({required this.onTable, required this.onElement});
  final ValueChanged<TablePreset> onTable;
  final ValueChanged<MapElementKind> onElement;

  static const _elements = [
    MapElementKind.entrance,
    MapElementKind.window,
    MapElementKind.wall,
    MapElementKind.kitchen,
    MapElementKind.bar,
    MapElementKind.stage,
    MapElementKind.restroom,
    MapElementKind.stairs,
    MapElementKind.plant,
    MapElementKind.tv,
  ];

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.labelLarge;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text('Bàn', style: label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final p in TablePreset.all)
              ActionChip(avatar: const Icon(Icons.table_restaurant, size: 18), label: Text(p.label), onPressed: () => onTable(p)),
          ],
        ),
        const SizedBox(height: 16),
        Text('Vật dụng', style: label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [for (final k in _elements) ActionChip(label: Text(elementName(k)), onPressed: () => onElement(k))],
        ),
      ],
    );
  }
}

class _EmptyRoom extends StatelessWidget {
  const _EmptyRoom({required this.onTemplate, this.onAdd});
  final VoidCallback onTemplate;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.table_restaurant, size: 56, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 12),
          Text('Khu vực chưa có bàn', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          const Text('Thêm bàn từ bảng bên trái, hoặc bắt đầu nhanh bằng mẫu.', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(onPressed: onTemplate, icon: const Icon(Icons.auto_awesome), label: const Text('Mẫu quán nhỏ (10 bàn)')),
          if (onAdd != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Thêm bàn')),
          ],
        ],
      ),
    ),
  );
}

/// Accessible alternative to the map (§8.6 "Show as list").
class _TableList extends StatelessWidget {
  const _TableList({required this.draft, required this.onTap});
  final LayoutDraft draft;
  final ValueChanged<MapTable> onTap;

  @override
  Widget build(BuildContext context) {
    final tables = [...draft.tables]..sort((a, b) => a.code.compareTo(b.code));
    if (tables.isEmpty) return const Center(child: Text('Chưa có bàn'));
    return ListView.separated(
      itemCount: tables.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final t = tables[i];
        final seats = t.minSeats == t.maxSeats ? '${t.maxSeats}' : '${t.minSeats}–${t.maxSeats}';
        return ListTile(
          leading: CircleAvatar(child: Text(t.code, style: const TextStyle(fontSize: 12))),
          title: Text('$seats khách · ${shapeName(t.shape)}'),
          subtitle: Text(
            [
              ...t.features.map((f) => tableFeatures[f] ?? f),
              if (t.joinGroup != null) 'nhóm ${t.joinGroup}',
              if (!t.selectable) 'khách không tự chọn',
              if (!t.active) 'đang tắt',
            ].join(' · '),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onTap(t),
        );
      },
    );
  }
}

class _GridSizeDialog extends StatefulWidget {
  const _GridSizeDialog({required this.cols, required this.rows});
  final int cols;
  final int rows;

  @override
  State<_GridSizeDialog> createState() => _GridSizeDialogState();
}

class _GridSizeDialogState extends State<_GridSizeDialog> {
  late int _cols = widget.cols, _rows = widget.rows;

  Widget _row(String label, int v, ValueChanged<int> set) => Row(
    children: [
      Expanded(child: Text(label)),
      IconButton(onPressed: v > LayoutDraft.minGrid ? () => setState(() => set(v - 1)) : null, icon: const Icon(Icons.remove)),
      SizedBox(width: 36, child: Text('$v', textAlign: TextAlign.center)),
      IconButton(onPressed: v < LayoutDraft.maxGrid ? () => setState(() => set(v + 1)) : null, icon: const Icon(Icons.add)),
    ],
  );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Kích thước khu vực'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _row('Chiều ngang (ô)', _cols, (v) => _cols = v),
        _row('Chiều dọc (ô)', _rows, (v) => _rows = v),
        const SizedBox(height: 8),
        const Text('Bàn 4 người mặc định chiếm 3×2 ô.', style: TextStyle(fontSize: 12)),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: () => Navigator.pop(context, (_cols, _rows)), child: const Text('Đổi')),
    ],
  );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        const SizedBox(height: 12),
        OutlinedButton(onPressed: onRetry, child: const Text('Thử lại')),
      ],
    ),
  );
}
