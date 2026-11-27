import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../bookings/booking_widgets.dart' show runBookingAction;
import 'business_repository.dart';

/// Guest reviews (§15): reply once, or report one that breaks the rules.
class ReviewsManageScreen extends ConsumerWidget {
  const ReviewsManageScreen({super.key});

  Future<void> _reply(BuildContext context, WidgetRef ref, ReviewDto r) async {
    final text = await _ask(context, title: 'Trả lời ${r.authorName}', label: 'Lời cảm ơn / giải thích', min: 2);
    if (text == null || !context.mounted) return;
    if (await runBookingAction(context, () => ref.read(businessRepositoryProvider).replyReview(r.id, text), done: 'Đã trả lời'))
      ref.invalidate(reviewsProvider);
  }

  Future<void> _report(BuildContext context, WidgetRef ref, ReviewDto r) async {
    final text = await _ask(context, title: 'Báo cáo đánh giá', label: 'Lý do (comi sẽ xem xét)', min: 5);
    if (text == null || !context.mounted) return;
    if (await runBookingAction(context, () => ref.read(businessRepositoryProvider).reportReview(r.id, text), done: 'Đã gửi comi xem xét')) {
      ref.invalidate(reviewsProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final page = ref.watch(reviewsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Đánh giá của khách')),
      body: page.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('${p.ratingAvg.toStringAsFixed(1)} ★ · ${p.ratingCount} đánh giá', style: theme.textTheme.headlineSmall),
            for (var s = 5; s >= 1; s--)
              Row(
                children: [
                  SizedBox(width: 32, child: Text('$s★')),
                  Expanded(
                    child: LinearProgressIndicator(value: p.ratingCount == 0 ? 0 : p.histogram[s - 1] / p.ratingCount, minHeight: 6),
                  ),
                  SizedBox(width: 32, child: Text(' ${p.histogram[s - 1]}')),
                ],
              ),
            const Divider(height: 24),
            if (p.items.isEmpty) const Text('Chưa có đánh giá'),
            for (final r in p.items)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('${r.authorName} · ${'★' * r.rating.toInt()}', style: theme.textTheme.titleSmall)),
                          if (r.status != ReviewDtoStatusEnum.PUBLISHED)
                            Text(
                              r.status == ReviewDtoStatusEnum.HIDDEN ? 'Đã ẩn' : 'Đang chờ comi xem xét',
                              style: theme.textTheme.labelSmall,
                            ),
                        ],
                      ),
                      Text('${r.visitedAt.substring(0, 10)} · ${r.partySize} người', style: theme.textTheme.bodySmall),
                      if (r.text != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(r.text!)),
                      if (r.reply != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text('Quán đã trả lời: ${r.reply}', style: theme.textTheme.bodySmall),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (r.status == ReviewDtoStatusEnum.PUBLISHED)
                            TextButton(onPressed: () => _report(context, ref, r), child: const Text('Báo cáo')),
                          if (r.reply == null) FilledButton.tonal(onPressed: () => _reply(context, ref, r), child: const Text('Trả lời')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Restaurant-funded vouchers (§12). The discount lowers the comi fee base; alcohol is never discounted.
class VouchersScreen extends ConsumerWidget {
  const VouchersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(vouchersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Mã giảm giá')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => const NewVoucherScreen()));
          if (created == true) ref.invalidate(vouchersProvider);
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo mã'),
      ),
      body: list.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (rows) => rows.isEmpty
            ? const Center(child: Text('Chưa có mã giảm giá'))
            : ListView(
                padding: const EdgeInsets.only(bottom: 96),
                children: [
                  for (final v in rows)
                    SwitchListTile(
                      title: Text(v.code),
                      subtitle: Text(
                        '${voucherValueText(v)} · đã dùng ${v.usedCount}${v.totalLimit == null ? '' : '/${v.totalLimit}'}'
                        ' · đến ${v.endsAt.substring(0, 10)}',
                      ),
                      value: v.isActive,
                      onChanged: (on) async {
                        if (await runBookingAction(
                          context,
                          () => ref.read(businessRepositoryProvider).setVoucherActive(v.id, on),
                          done: on ? 'Đã bật mã' : 'Đã tạm dừng mã',
                        )) {
                          ref.invalidate(vouchersProvider);
                        }
                      },
                    ),
                ],
              ),
      ),
    );
  }
}

String voucherValueText(VoucherDto v) => v.type == VoucherType.FIXED
    ? 'Giảm ${formatVnd(v.value)}'
    : 'Giảm ${v.value / 100}%${v.maxDiscount == null ? '' : ' (tối đa ${formatVnd(v.maxDiscount!)})'}'
          '${v.minOrder > 0 ? ' · đơn từ ${formatVnd(v.minOrder)}' : ''}';

class NewVoucherScreen extends ConsumerStatefulWidget {
  const NewVoucherScreen({super.key, this.now});
  final DateTime? now;

  @override
  ConsumerState<NewVoucherScreen> createState() => _NewVoucherScreenState();
}

class _NewVoucherScreenState extends ConsumerState<NewVoucherScreen> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _value = TextEditingController();
  final _max = TextEditingController();
  final _min = TextEditingController();
  final _limit = TextEditingController();
  var _percent = true;
  var _days = 30;
  var _firstOnly = false;

  @override
  void dispose() {
    for (final c in [_code, _value, _max, _min, _limit]) {
      c.dispose();
    }
    super.dispose();
  }

  int? _int(TextEditingController c) => int.tryParse(c.text.replaceAll(RegExp(r'\D'), ''));

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final start = (widget.now ?? DateTime.now()).toUtc();
    final value = _int(_value)!;
    final ok = await runBookingAction(
      context,
      () => ref
          .read(businessRepositoryProvider)
          .createVoucher(
            VoucherInputDto(
              code: _code.text.trim().toUpperCase(),
              type: _percent ? VoucherType.PERCENT : VoucherType.FIXED,
              value: _percent ? value * 100 : value,
              maxDiscount: _percent ? _int(_max) : null,
              minOrder: _int(_min),
              startsAt: start.toIso8601String(),
              endsAt: start.add(Duration(days: _days)).toIso8601String(),
              totalLimit: _int(_limit),
              firstOrderOnly: _firstOnly,
            ),
          ),
      done: 'Đã tạo mã ${_code.text.trim().toUpperCase()}',
    );
    if (ok && mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Mã giảm giá mới'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FilledButton(onPressed: _save, child: const Text('Tạo')),
        ),
      ],
    ),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _code,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'))],
            decoration: const InputDecoration(labelText: 'Mã (VD: TRUA20)', border: OutlineInputBorder()),
            validator: (v) => RegExp(r'^[A-Z0-9]{3,20}$').hasMatch((v ?? '').toUpperCase()) ? null : '3–20 chữ hoặc số',
          ),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Giảm %')),
              ButtonSegment(value: false, label: Text('Giảm số tiền')),
            ],
            selected: {_percent},
            onSelectionChanged: (s) => setState(() => _percent = s.first),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _value,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: _percent ? 'Phần trăm (1–100)' : 'Số tiền (đ)', border: const OutlineInputBorder()),
            validator: (v) {
              final n = int.tryParse((v ?? '').replaceAll(RegExp(r'\D'), ''));
              if (n == null || n <= 0) return 'Nhập số';
              if (_percent && n > 100) return 'Tối đa 100%';
              return null;
            },
          ),
          if (_percent) ...[
            const SizedBox(height: 12),
            TextFormField(
              controller: _max,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Giảm tối đa (đ, không bắt buộc)', border: OutlineInputBorder()),
            ),
          ],
          const SizedBox(height: 12),
          TextFormField(
            controller: _min,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Đơn tối thiểu (đ, không tính đồ có cồn)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _limit,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Tổng số lượt (không bắt buộc)', border: OutlineInputBorder()),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Thời hạn'),
            trailing: DropdownButton<int>(
              value: _days,
              items: const [
                DropdownMenuItem(value: 7, child: Text('7 ngày')),
                DropdownMenuItem(value: 30, child: Text('30 ngày')),
                DropdownMenuItem(value: 90, child: Text('90 ngày')),
              ],
              onChanged: (v) => setState(() => _days = v!),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Chỉ cho khách đặt lần đầu'),
            value: _firstOnly,
            onChanged: (v) => setState(() => _firstOnly = v),
          ),
        ],
      ),
    ),
  );
}

Future<String?> _ask(BuildContext context, {required String title, required String label, required int min}) => showDialog<String>(
  context: context,
  builder: (_) => _AskDialog(title: title, label: label, min: min),
);

class _AskDialog extends StatefulWidget {
  const _AskDialog({required this.title, required this.label, required this.min});
  final String title;
  final String label;
  final int min;

  @override
  State<_AskDialog> createState() => _AskDialogState();
}

class _AskDialogState extends State<_AskDialog> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _text,
      maxLines: 3,
      maxLength: 1000,
      decoration: InputDecoration(labelText: widget.label, border: const OutlineInputBorder()),
      onChanged: (_) => setState(() {}),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(
        onPressed: _text.text.trim().length < widget.min ? null : () => Navigator.pop(context, _text.text.trim()),
        child: const Text('Gửi'),
      ),
    ],
  );
}
