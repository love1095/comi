import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import 'onboarding_repository.dart';

/// One opening range. Minutes from midnight; close may pass 1440 (open past midnight).
typedef Range = ({int open, int close});

/// Mon..Sun as the API's weekday (0 = Sunday).
const weekdayOrder = [1, 2, 3, 4, 5, 6, 0];
const weekdayNames = {1: 'Thứ 2', 2: 'Thứ 3', 3: 'Thứ 4', 4: 'Thứ 5', 5: 'Thứ 6', 6: 'Thứ 7', 0: 'Chủ nhật'};

const hourPresets = <(String, List<Range>)>[
  ('Trưa', [(open: 600, close: 840)]),
  ('Trưa + tối', [(open: 600, close: 840), (open: 1020, close: 1320)]),
  ('Cả ngày', [(open: 600, close: 1320)]),
  ('Nhậu tới khuya', [(open: 960, close: 1560)]),
];

/// Overlaps or empty ranges for one day, as Vietnamese text. Null when fine.
String? rangeProblem(List<Range> ranges) {
  final sorted = [...ranges]..sort((a, b) => a.open.compareTo(b.open));
  for (final r in sorted) {
    if (r.close <= r.open) return 'Giờ đóng phải sau giờ mở';
    if (r.open >= 1440) return 'Giờ mở phải trước nửa đêm';
  }
  for (var i = 1; i < sorted.length; i++) {
    if (sorted[i].open < sorted[i - 1].close) return 'Các khung giờ bị chồng nhau';
  }
  return null;
}

/// Weekly opening hours with presets; a day without ranges is a day off.
class OpeningHoursScreen extends ConsumerStatefulWidget {
  const OpeningHoursScreen({super.key, required this.initial});
  final List<OpeningHoursDto> initial;

  @override
  ConsumerState<OpeningHoursScreen> createState() => _OpeningHoursScreenState();
}

class _OpeningHoursScreenState extends ConsumerState<OpeningHoursScreen> {
  late final Map<int, List<Range>> _days = {
    for (final d in weekdayOrder)
      d: [for (final h in widget.initial.where((h) => h.weekday == d)) (open: h.openMinute.toInt(), close: h.closeMinute.toInt())],
  };
  final _selected = <int>{...weekdayOrder};
  var _busy = false;

  void _applyPreset(List<Range> ranges) => setState(() {
    for (final d in _selected) {
      _days[d] = [...ranges];
    }
  });

  Future<int?> _pickTime(int minute) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: (minute % 1440) ~/ 60, minute: minute % 60),
      builder: (c, child) => MediaQuery(data: MediaQuery.of(c).copyWith(alwaysUse24HourFormat: true), child: child!),
    );
    return t == null ? null : t.hour * 60 + t.minute;
  }

  Future<void> _editRange(int day, int index) async {
    final r = _days[day]![index];
    final open = await _pickTime(r.open);
    if (open == null || !mounted) return;
    final closePicked = await _pickTime(r.close);
    if (closePicked == null) return;
    // Closing at or before opening means after midnight (16:00 → 02:00).
    final close = closePicked <= open ? closePicked + 1440 : closePicked;
    setState(() => _days[day]![index] = (open: open, close: close));
  }

  Future<void> _save() async {
    for (final d in weekdayOrder) {
      final p = rangeProblem(_days[d]!);
      if (p != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${weekdayNames[d]}: $p')));
        return;
      }
    }
    if (_days.values.every((r) => r.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chọn giờ mở cửa cho ít nhất một ngày')));
      return;
    }
    setState(() => _busy = true);
    try {
      await ref.read(onboardingRepositoryProvider).setOpeningHours(ref.read(restaurantIdProvider), [
        for (final d in weekdayOrder)
          for (final r in _days[d]!) OpeningHoursItemDto(weekday: d, openMinute: r.open, closeMinute: r.close),
      ]);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giờ mở cửa'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilledButton(onPressed: _busy ? null : _save, child: Text(_busy ? 'Đang lưu…' : 'Lưu')),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Chọn ngày rồi bấm một mẫu, hoặc chỉnh từng khung giờ.', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final p in hourPresets)
                    ActionChip(
                      label: Text('${p.$1} (${p.$2.map((r) => '${formatMinute(r.open)}–${formatMinute(r.close)}').join(', ')})'),
                      onPressed: () => _applyPreset(p.$2),
                    ),
                  ActionChip(avatar: const Icon(Icons.block, size: 18), label: const Text('Nghỉ'), onPressed: () => _applyPreset(const [])),
                ],
              ),
              const Divider(height: 24),
              for (final d in weekdayOrder) _dayRow(d),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayRow(int d) {
    final theme = Theme.of(context);
    final ranges = _days[d]!;
    final problem = rangeProblem(ranges);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(weekdayNames[d]!),
              value: _selected.contains(d),
              onChanged: (v) => setState(() => v! ? _selected.add(d) : _selected.remove(d)),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (ranges.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text('Nghỉ', style: TextStyle(color: theme.colorScheme.outline)),
                  ),
                for (final (i, r) in ranges.indexed)
                  InputChip(
                    label: Text('${formatMinute(r.open)} – ${formatMinute(r.close)}${r.close > 1440 ? ' (hôm sau)' : ''}'),
                    onPressed: () => _editRange(d, i),
                    onDeleted: () => setState(() => ranges.removeAt(i)),
                  ),
                IconButton(
                  tooltip: 'Thêm khung giờ',
                  onPressed: () => setState(
                    () => ranges.add(ranges.isEmpty ? (open: 600, close: 1320) : (open: ranges.last.close, close: ranges.last.close + 120)),
                  ),
                  icon: const Icon(Icons.add),
                ),
                if (problem != null) Text(problem, style: TextStyle(color: theme.colorScheme.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
