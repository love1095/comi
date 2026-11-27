import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import '../kitchen/kitchen_repository.dart';
import '../onboarding/onboarding_repository.dart';

final capacityRulesProvider = FutureProvider.autoDispose<List<CapacityRuleDto>>(
  (ref) => ref.watch(kitchenRepositoryProvider).capacityRules(),
);

/// Lunch, kitchen and at-the-table settings (§7, §8.5, §22.2).
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  RestaurantProfileDto? _p;
  var _limitOn = false;
  var _maxItems = 20;
  var _otherRules = 0;
  var _saving = false;
  var _loaded = false;
  Object? _error;

  // Edited values.
  late bool _lunch, _nhau, _tableOrdering, _approve, _startEarly, _codDepart;
  late int _grace, _cutoff;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rid = ref.read(restaurantIdProvider);
      final p = await ref.read(onboardingRepositoryProvider).profile(rid);
      final rules = await ref.read(kitchenRepositoryProvider).capacityRules();
      if (!mounted) return;
      setState(() {
        _p = p;
        _lunch = p.servesLunch;
        _nhau = p.servesNhau;
        _tableOrdering = p.allowTableOrdering;
        _approve = p.tableOrderingNeedsApproval;
        _startEarly = p.startEarlyOnCheckIn;
        _codDepart = p.codStartOnDepart;
        _grace = p.graceMinutes.toInt();
        _cutoff = p.cancelCutoffMinutes.toInt();
        _limitOn = rules.isNotEmpty;
        _maxItems = rules.isEmpty ? 20 : rules.first.maxItems.toInt();
        _otherRules = rules.length > 1 ? rules.length : 0;
        _loaded = true;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final rid = ref.read(restaurantIdProvider);
      await ref
          .read(onboardingRepositoryProvider)
          .updateSettings(
            rid,
            UpdateSettingsDto(
              servesLunch: _lunch,
              servesNhau: _nhau,
              allowTableOrdering: _tableOrdering,
              tableOrderingNeedsApproval: _approve,
              startEarlyOnCheckIn: _startEarly,
              codStartOnDepart: _codDepart,
              graceMinutes: _grace,
              cancelCutoffMinutes: _cutoff,
            ),
          );
      await ref.read(kitchenRepositoryProvider).saveCapacityRules([
        if (_limitOn)
          CapacityRuleInput(weekdays: const [0, 1, 2, 3, 4, 5, 6], startMinute: 0, endMinute: 1440, windowMinutes: 15, maxItems: _maxItems),
      ]);
      if (!mounted) return;
      setState(() => _otherRules = 0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu cài đặt')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilledButton(onPressed: !_loaded || _saving ? null : _save, child: Text(_saving ? 'Đang lưu…' : 'Lưu')),
          ),
        ],
      ),
      body: !_loaded
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(ApiError.from(_error!).userMessage),
                        TextButton(onPressed: _load, child: const Text('Thử lại')),
                      ],
                    ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(_p!.name, style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    _Header('Quán phục vụ'),
                    SwitchListTile(title: const Text('Cơm trưa văn phòng'), value: _lunch, onChanged: (v) => setState(() => _lunch = v)),
                    SwitchListTile(title: const Text('Nhậu / đi nhóm buổi tối'), value: _nhau, onChanged: (v) => setState(() => _nhau = v)),
                    _Header('Khách đến quán'),
                    _Stepper(
                      label: 'Giữ bàn khi khách trễ',
                      value: _grace,
                      unit: 'phút',
                      min: 5,
                      max: 120,
                      step: 5,
                      onChanged: (v) => setState(() => _grace = v),
                    ),
                    _Stepper(
                      label: 'Khách được huỷ online trước',
                      value: _cutoff,
                      unit: 'phút',
                      min: 0,
                      max: 1440,
                      step: 15,
                      onChanged: (v) => setState(() => _cutoff = v),
                    ),
                    SwitchListTile(
                      title: const Text('Khách đến sớm thì nấu sớm'),
                      subtitle: const Text('Khi khách check-in trước giờ hẹn, bếp bắt đầu ngay'),
                      value: _startEarly,
                      onChanged: (v) => setState(() => _startEarly = v),
                    ),
                    SwitchListTile(
                      title: const Text('Bấm "Tôi đi bây giờ" là nấu luôn (trả tại quán)'),
                      subtitle: const Text('Món lên ngay khi khách tới, nhưng quán chịu rủi ro nếu khách không đến'),
                      value: _codDepart,
                      onChanged: (v) => setState(() => _codDepart = v),
                    ),
                    _Header('Gọi món tại bàn'),
                    SwitchListTile(
                      title: const Text('Khách tự gọi thêm món trên app'),
                      value: _tableOrdering,
                      onChanged: (v) => setState(() => _tableOrdering = v),
                    ),
                    SwitchListTile(
                      title: const Text('Nhân viên xác nhận trước khi gửi bếp'),
                      subtitle: const Text('Mỗi lần khách gọi thêm, nhân viên bấm "Xác nhận gửi bếp"'),
                      value: _approve,
                      onChanged: _tableOrdering ? (v) => setState(() => _approve = v) : null,
                    ),
                    _Header('Sức chứa của bếp'),
                    SwitchListTile(
                      title: const Text('Giới hạn món đặt trước'),
                      subtitle: const Text('Giờ cao điểm: không nhận thêm món đặt trước khi bếp đã kín (khách vẫn đặt bàn được)'),
                      value: _limitOn,
                      onChanged: (v) => setState(() => _limitOn = v),
                    ),
                    if (_limitOn)
                      _Stepper(
                        label: 'Tối đa mỗi 15 phút',
                        value: _maxItems,
                        unit: 'món',
                        min: 1,
                        max: 500,
                        step: 5,
                        onChanged: (v) => setState(() => _maxItems = v),
                      ),
                    if (_otherRules > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Đang có $_otherRules quy tắc riêng theo giờ. Lưu ở đây sẽ thay bằng một quy tắc cho cả ngày.',
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
  );
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
  });
  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(label),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Bớt',
          onPressed: value > min ? () => onChanged((value - step).clamp(min, max)) : null,
          icon: const Icon(Icons.remove),
        ),
        SizedBox(width: 72, child: Text('$value $unit', textAlign: TextAlign.center)),
        IconButton(
          tooltip: 'Thêm',
          onPressed: value < max ? () => onChanged((value + step).clamp(min, max)) : null,
          icon: const Icon(Icons.add),
        ),
      ],
    ),
  );
}
