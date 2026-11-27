import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../kitchen/kitchen_repository.dart';
import '../menu/menu_repository.dart';
import 'booking_widgets.dart';
import 'bookings_repository.dart';

/// Staff actions at the restaurant (§8.5, §9): guest arrived, keep table, more dishes, fire, close the bill.
class TableActions extends ConsumerWidget {
  const TableActions({super.key, required this.booking, this.now});
  final BookingDetailDto booking;

  /// For tests; defaults to the device clock.
  final DateTime? now;

  void _refresh(WidgetRef ref) {
    ref.invalidate(bookingDetailProvider(booking.id));
    ref.invalidate(boardBookingsProvider);
    ref.invalidate(billProvider(booking.id));
  }

  Future<void> _run(BuildContext context, WidgetRef ref, Future<Object?> Function() action, String done) async {
    if (await runBookingAction(context, action, done: done)) _refresh(ref);
  }

  Future<void> _addDishes(BuildContext context, WidgetRef ref) async {
    final lines = await showModalBottomSheet<List<CartLineDto>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const DishPicker(),
    );
    if (lines == null || lines.isEmpty || !context.mounted) return;
    await _run(context, ref, () => ref.read(kitchenRepositoryProvider).addRound(booking.id, lines), 'Đã gửi ${lines.length} món vào bếp');
  }

  Future<void> _close(BuildContext context, WidgetRef ref) async {
    // Prefill with the live bill; if it cannot load, staff type the amount.
    var total = 0;
    try {
      total = (await ref.read(kitchenRepositoryProvider).bill(booking.id)).total.toInt();
    } catch (_) {}
    if (!context.mounted) return;
    final amount = await showDialog<int>(
      context: context,
      builder: (_) => _CloseBillDialog(total: total),
    );
    if (amount == null || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref.read(kitchenRepositoryProvider).closeBill(booking.id, amount: amount),
      'Đã tính tiền ${formatVnd(amount)}',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = booking;
    final repo = ref.read(kitchenRepositoryProvider);
    final arrived = b.status == BookingStatus.CHECKED_IN;
    final late = b.status == BookingStatus.CONFIRMED && (now ?? DateTime.now()).isAfter(DateTime.parse(b.arrivalAt));

    final buttons = <Widget>[
      if (b.status == BookingStatus.CONFIRMED)
        FilledButton.icon(
          onPressed: () => _run(context, ref, () => repo.checkIn(b.id), 'Khách ${b.code} đã đến — bếp bắt đầu nấu'),
          icon: const Icon(Icons.how_to_reg),
          label: const Text('Khách đã đến'),
        ),
      if (late)
        OutlinedButton.icon(
          onPressed: () => _run(context, ref, () => repo.extendGrace(b.id), 'Giữ bàn thêm 15 phút'),
          icon: const Icon(Icons.more_time),
          label: const Text('Khách đến trễ, giữ bàn +15′'),
        ),
      if (arrived) ...[
        FilledButton.icon(onPressed: () => _addDishes(context, ref), icon: const Icon(Icons.add), label: const Text('Gọi thêm món')),
        OutlinedButton.icon(
          onPressed: () => _run(context, ref, () => repo.fire(b.id), 'Đã báo bếp làm các món còn chờ'),
          icon: const Icon(Icons.local_fire_department_outlined),
          label: const Text('Ra món tiếp'),
        ),
        FilledButton.tonalIcon(
          onPressed: () => _close(context, ref),
          icon: const Icon(Icons.point_of_sale),
          label: const Text('Tính tiền'),
        ),
      ],
    ];
    if (buttons.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Wrap(spacing: 8, runSpacing: 8, children: buttons),
    );
  }
}

/// Every round with kitchen status; rounds ordered from the guest's phone can wait for staff (§8.5).
class LiveBill extends ConsumerWidget {
  const LiveBill({super.key, required this.bookingId});
  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bill = ref.watch(billProvider(bookingId));
    return bill.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text(ApiError.from(e).userMessage),
      data: (b) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hoá đơn tạm', style: theme.textTheme.titleMedium),
          if (b.rounds.isEmpty) const Padding(padding: EdgeInsets.only(top: 8), child: Text('Chưa có món nào')),
          for (final r in b.rounds) ...[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      r.round == 0 ? 'Đặt trước' : 'Gọi thêm lần ${r.round}',
                      style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                  if (r.waitingForStaff)
                    FilledButton(
                      onPressed: () async {
                        final ok = await runBookingAction(
                          context,
                          () => ref.read(kitchenRepositoryProvider).approveRound(bookingId, r.round.toInt()),
                          done: 'Đã xác nhận, gửi vào bếp',
                        );
                        if (ok) ref.invalidate(billProvider(bookingId));
                      },
                      child: const Text('Xác nhận gửi bếp'),
                    ),
                ],
              ),
            ),
            for (final i in r.items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    SizedBox(width: 36, child: Text('${i.quantity}×')),
                    Expanded(child: Text([i.nameSnapshot, ...i.optionsSnapshot.map((o) => o.option)].join(' · '))),
                    Text(kitchenStatusLabel(i.kitchenStatus), style: theme.textTheme.bodySmall),
                    const SizedBox(width: 12),
                    SizedBox(width: 90, child: Text(formatVnd(i.unitPrice * i.quantity), textAlign: TextAlign.right)),
                  ],
                ),
              ),
          ],
          const Divider(height: 24),
          Row(
            children: [
              Expanded(child: Text('Tổng', style: theme.textTheme.titleMedium)),
              Text(formatVnd(b.total), style: theme.textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _CloseBillDialog extends StatefulWidget {
  const _CloseBillDialog({required this.total});
  final int total;

  @override
  State<_CloseBillDialog> createState() => _CloseBillDialogState();
}

class _CloseBillDialogState extends State<_CloseBillDialog> {
  late final _amount = TextEditingController(text: '${widget.total}');

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  int? get _value => int.tryParse(_amount.text.replaceAll(RegExp(r'[^\d]'), ''));

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Tính tiền'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hoá đơn trong app: ${formatVnd(widget.total)}'),
        const SizedBox(height: 4),
        const Text('Sửa nếu khách gọi thêm món ngoài app.'),
        const SizedBox(height: 12),
        TextField(
          controller: _amount,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Số tiền khách trả',
            border: const OutlineInputBorder(),
            helperText: _value == null ? null : formatVnd(_value!),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: _value == null ? null : () => Navigator.pop(context, _value), child: const Text('Xác nhận')),
    ],
  );
}

/// Staff add dishes for a seated table. Dishes with required options get the first option of each group.
class DishPicker extends ConsumerStatefulWidget {
  const DishPicker({super.key});

  @override
  ConsumerState<DishPicker> createState() => _DishPickerState();
}

class _DishPickerState extends ConsumerState<DishPicker> {
  final _qty = <String, int>{};

  List<CartLineDto> _lines(List<StaffMenuCategoryDto> menu) => [
    for (final c in menu)
      for (final i in c.items)
        if ((_qty[i.id] ?? 0) > 0)
          CartLineDto(
            menuItemId: i.id,
            quantity: _qty[i.id]!,
            optionIds: [
              for (final g in i.optionGroups)
                if (g.minSelect > 0 && g.options.isNotEmpty) g.options.first.id,
            ],
          ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menu = ref.watch(menuProvider);
    final count = _qty.values.fold(0, (s, q) => s + q);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text('Gọi thêm món', style: theme.textTheme.titleMedium)),
            const Divider(height: 1),
            Flexible(
              child: menu.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => Padding(padding: const EdgeInsets.all(32), child: Text(ApiError.from(e).userMessage)),
                data: (cats) => ListView(
                  shrinkWrap: true,
                  children: [
                    for (final c in cats)
                      if (c.items.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                          child: Text(c.name, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
                        ),
                        for (final i in c.items)
                          ListTile(
                            enabled: i.isAvailable,
                            title: Text(i.name),
                            subtitle: Text(i.isAvailable ? formatVnd(i.price) : 'Hết món'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Bớt ${i.name}',
                                  onPressed: (_qty[i.id] ?? 0) > 0 ? () => setState(() => _qty[i.id] = _qty[i.id]! - 1) : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                SizedBox(width: 24, child: Text('${_qty[i.id] ?? 0}', textAlign: TextAlign.center)),
                                IconButton(
                                  tooltip: 'Thêm ${i.name}',
                                  onPressed: i.isAvailable ? () => setState(() => _qty[i.id] = (_qty[i.id] ?? 0) + 1) : null,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),
                      ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: count == 0 ? null : () => Navigator.pop(context, _lines(menu.value ?? const [])),
                child: Text(count == 0 ? 'Chọn món' : 'Gửi $count món vào bếp'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
