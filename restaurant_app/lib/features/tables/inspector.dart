import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'layout_draft.dart';

/// Edits the selected table: code, seats, shape, size, rotation, features, selectable, join group.
class TableInspector extends StatelessWidget {
  const TableInspector({
    super.key,
    required this.table,
    required this.onChanged,
    required this.onRotate,
    required this.onDuplicate,
    required this.onDelete,
    this.problems = const [],
  });

  final MapTable table;
  final ValueChanged<MapTable Function(MapTable)> onChanged;
  final VoidCallback onRotate;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final List<LayoutProblem> problems;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Bàn ${table.code}', style: text.titleLarge),
        if (!table.active)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Bàn đang tắt (có đặt chỗ cũ)'),
                trailing: TextButton(onPressed: () => onChanged((t) => t.copyWith(active: true)), child: const Text('Bật lại')),
              ),
            ),
          ),
        for (final p in problems)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('⚠ ${problemText(p)}', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        const SizedBox(height: 16),
        _TextField(
          key: ValueKey('code-${table.id}'),
          label: 'Mã bàn',
          initial: table.code,
          maxLength: 20,
          onChanged: (v) => onChanged((t) => t.copyWith(code: v.toUpperCase())),
        ),
        const SizedBox(height: 8),
        _Stepper(
          label: 'Ít nhất (khách)',
          value: table.minSeats,
          min: 1,
          max: table.maxSeats,
          onChanged: (v) => onChanged((t) => t.copyWith(minSeats: v)),
        ),
        _Stepper(
          label: 'Nhiều nhất (khách)',
          value: table.maxSeats,
          min: table.minSeats,
          max: 100,
          onChanged: (v) => onChanged((t) => t.copyWith(maxSeats: v)),
        ),
        const SizedBox(height: 12),
        Text('Kiểu bàn', style: text.labelLarge),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final s in TableShape.values)
              ChoiceChip(
                label: Text(shapeName(s)),
                selected: table.shape == s,
                onSelected: (_) => onChanged((t) => t.copyWith(shape: s)),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _Stepper(
          label: 'Rộng (ô)',
          value: table.width,
          min: 1,
          max: LayoutDraft.maxTableSize,
          onChanged: (v) => onChanged((t) => t.copyWith(width: v)),
        ),
        _Stepper(
          label: 'Dài (ô)',
          value: table.height,
          min: 1,
          max: LayoutDraft.maxTableSize,
          onChanged: (v) => onChanged((t) => t.copyWith(height: v)),
        ),
        const SizedBox(height: 12),
        Text('Đặc điểm', style: text.labelLarge),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final f in tableFeatures.entries)
              FilterChip(
                label: Text(f.value),
                selected: table.features.contains(f.key),
                onSelected: (on) =>
                    onChanged((t) => t.copyWith(features: on ? [...t.features, f.key] : t.features.where((x) => x != f.key).toList())),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Khách được chọn bàn này'),
          subtitle: const Text('Tắt: chỉ quán xếp bàn'),
          value: table.selectable,
          onChanged: (v) => onChanged((t) => t.copyWith(selectable: v)),
        ),
        _TextField(
          key: ValueKey('join-${table.id}'),
          label: 'Nhóm ghép bàn',
          helper: 'Các bàn cùng nhóm có thể ghép cho đoàn đông',
          initial: table.joinGroup ?? '',
          maxLength: 20,
          onChanged: (v) => onChanged((t) => v.trim().isEmpty ? t.copyWith(clearJoinGroup: true) : t.copyWith(joinGroup: v)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(onPressed: onRotate, icon: const Icon(Icons.rotate_90_degrees_cw), label: const Text('Xoay')),
            OutlinedButton.icon(onPressed: onDuplicate, icon: const Icon(Icons.copy), label: const Text('Nhân bản')),
            OutlinedButton.icon(
              onPressed: onDelete,
              style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Xoá'),
            ),
          ],
        ),
      ],
    );
  }
}

class ElementInspector extends StatelessWidget {
  const ElementInspector({
    super.key,
    required this.index,
    required this.element,
    required this.onChanged,
    required this.onRotate,
    required this.onDelete,
  });

  final int index;
  final MapElement element;
  final ValueChanged<MapElement Function(MapElement)> onChanged;
  final VoidCallback onRotate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(elementName(element.kind), style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        _TextField(
          key: ValueKey('label-$index-${element.kind.name}'),
          label: 'Nhãn (không bắt buộc)',
          initial: element.label ?? '',
          maxLength: 40,
          onChanged: (v) => onChanged((e) => v.trim().isEmpty ? e.copyWith(clearLabel: true) : e.copyWith(label: v)),
        ),
        _Stepper(
          label: 'Rộng (ô)',
          value: element.width,
          min: 1,
          max: LayoutDraft.maxTableSize,
          onChanged: (v) => onChanged((e) => e.copyWith(width: v)),
        ),
        _Stepper(
          label: 'Dài (ô)',
          value: element.height,
          min: 1,
          max: LayoutDraft.maxTableSize,
          onChanged: (v) => onChanged((e) => e.copyWith(height: v)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(onPressed: onRotate, icon: const Icon(Icons.rotate_90_degrees_cw), label: const Text('Xoay')),
            OutlinedButton.icon(
              onPressed: onDelete,
              style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Xoá'),
            ),
          ],
        ),
      ],
    );
  }
}

String shapeName(TableShape s) => switch (s) {
  TableShape.rect => 'Chữ nhật',
  TableShape.square => 'Vuông',
  TableShape.round => 'Tròn',
  TableShape.booth => 'Sofa',
  TableShape.barSeat => 'Ghế quầy',
};

String problemText(LayoutProblem p) => switch (p.type) {
  LayoutProblemType.outOfBounds => '${p.codes.join(', ')} nằm ngoài khu vực',
  LayoutProblemType.overlap => '${p.codes.join(' và ')} chồng lên nhau',
  LayoutProblemType.duplicateCode => 'Trùng mã bàn ${p.codes.join(', ')}',
  LayoutProblemType.badSeats => 'Số chỗ của ${p.codes.join(', ')} không hợp lệ',
};

/// Text field that keeps its own controller (the draft updates on every keystroke).
class _TextField extends StatefulWidget {
  const _TextField({super.key, required this.label, required this.initial, required this.onChanged, this.helper, this.maxLength});
  final String label;
  final String initial;
  final String? helper;
  final int? maxLength;
  final ValueChanged<String> onChanged;

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  late final _c = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _c,
    maxLength: widget.maxLength,
    decoration: InputDecoration(labelText: widget.label, helperText: widget.helper, counterText: ''),
    onChanged: widget.onChanged,
  );
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.label, required this.value, required this.min, required this.max, required this.onChanged});
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(label)),
      IconButton(tooltip: 'Bớt', onPressed: value > min ? () => onChanged(value - 1) : null, icon: const Icon(Icons.remove_circle_outline)),
      SizedBox(
        width: 32,
        child: Text(
          '$value',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      IconButton(tooltip: 'Thêm', onPressed: value < max ? () => onChanged(value + 1) : null, icon: const Icon(Icons.add_circle_outline)),
    ],
  );
}
