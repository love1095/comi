import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/admin_repository.dart';
import 'common.dart';
import 'moderation.dart' show dashboardProvider;

final statementFilterProvider = NotifierProvider<_Filter, String?>(_Filter.new);

class _Filter extends Notifier<String?> {
  @override
  String? build() => 'ISSUED';
  void set(String? s) => state = s;
}

final statementsProvider = FutureProvider.autoDispose<List<StatementDto>>(
  (ref) => ref.watch(adminRepositoryProvider).statements(ref.watch(statementFilterProvider)),
);

const statementStatusLabel = {'ISSUED': 'Chờ thanh toán', 'OVERDUE': 'Quá hạn', 'PAID': 'Đã thanh toán', 'DRAFT': 'Nháp'};

/// Monthly comi fee statements (§11.3): mark bank transfers received, run the monthly job by hand.
class StatementsPage extends ConsumerWidget {
  const StatementsPage({super.key});

  Future<void> _generate(BuildContext context, WidgetRef ref) async {
    final month = await askText(context, title: 'Tạo bảng phí', label: 'Tháng (YYYY-MM)', minLength: 7, ok: 'Tạo');
    if (month == null || !context.mounted) return;
    if (!RegExp(r'^\d{4}-(0[1-9]|1[0-2])$').hasMatch(month)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tháng phải có dạng 2026-12')));
      return;
    }
    if (await runAction(context, () => ref.read(adminRepositoryProvider).generateStatements(month), done: 'Đã tạo bảng phí tháng $month')) {
      ref.invalidate(statementsProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statementFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          'Phí comi',
          actions: [
            OutlinedButton.icon(
              onPressed: () => _generate(context, ref),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Tạo bảng phí'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 8,
            children: [
              for (final s in ['ISSUED', 'OVERDUE', 'PAID'])
                ChoiceChip(
                  label: Text(statementStatusLabel[s]!),
                  selected: status == s,
                  onSelected: (_) => ref.read(statementFilterProvider.notifier).set(s),
                ),
            ],
          ),
        ),
        Expanded(
          child: AsyncPage(
            value: ref.watch(statementsProvider),
            onRetry: () => ref.invalidate(statementsProvider),
            data: (rows) => rows.isEmpty
                ? const Center(child: Text('Không có bảng phí'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: rows.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final s = rows[i];
                      return ListTile(
                        title: Text('${s.transferMemo} · tháng ${s.periodMonth}'),
                        subtitle: Text(
                          '${s.bookingCount} đơn · phí ${formatVnd(s.totalFee)} · cần trả ${formatVnd(s.amountDue)}'
                          '${s.dueAt == null ? '' : ' · hạn ${date(s.dueAt!)}'}',
                        ),
                        trailing: s.status == StatementDtoStatusEnum.PAID
                            ? Text('Đã trả ${s.paidAt == null ? '' : date(s.paidAt!)}')
                            : FilledButton.tonal(
                                onPressed: () async {
                                  if (!await confirm(
                                    context,
                                    'Đã nhận ${formatVnd(s.amountDue)}?',
                                    'Kiểm tra sao kê có nội dung "${s.transferMemo}".',
                                    ok: 'Đã nhận tiền',
                                  )) {
                                    return;
                                  }
                                  if (context.mounted &&
                                      await runAction(
                                        context,
                                        () => ref.read(adminRepositoryProvider).markStatementPaid(s.id),
                                        done: 'Đã ghi nhận thanh toán',
                                      )) {
                                    ref.invalidate(statementsProvider);
                                    ref.invalidate(dashboardProvider);
                                  }
                                },
                                child: const Text('Đã nhận tiền'),
                              ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

final platformVouchersProvider = FutureProvider.autoDispose<List<VoucherDto>>((ref) => ref.watch(adminRepositoryProvider).vouchers());

/// comi-funded vouchers (§12): comi pays the discount back to restaurants on their statement.
class VouchersPage extends ConsumerWidget {
  const VouchersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      PageHeader(
        'Mã giảm giá của comi',
        actions: [
          FilledButton.icon(
            onPressed: () async {
              final ok = await showDialog<bool>(context: context, builder: (_) => const NewPlatformVoucherDialog());
              if (ok == true) ref.invalidate(platformVouchersProvider);
            },
            icon: const Icon(Icons.add),
            label: const Text('Tạo mã'),
          ),
        ],
      ),
      Expanded(
        child: AsyncPage(
          value: ref.watch(platformVouchersProvider),
          onRetry: () => ref.invalidate(platformVouchersProvider),
          data: (rows) => rows.isEmpty
              ? const Center(child: Text('Chưa có mã'))
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final v in rows)
                      SwitchListTile(
                        title: Text(v.code),
                        subtitle: Text(
                          '${v.type == VoucherType.FIXED ? 'Giảm ${formatVnd(v.value)}' : 'Giảm ${v.value / 100}%${v.maxDiscount == null ? '' : ' tối đa ${formatVnd(v.maxDiscount!)}'}'}'
                          ' · đã dùng ${v.usedCount}${v.totalLimit == null ? '' : '/${v.totalLimit}'} · ${date(v.startsAt)}–${date(v.endsAt)}'
                          '${v.restaurantId == null ? ' · mọi quán' : ' · 1 quán'}',
                        ),
                        value: v.isActive,
                        onChanged: (on) async {
                          if (await runAction(
                            context,
                            () => ref.read(adminRepositoryProvider).setVoucherActive(v.id, on),
                            done: on ? 'Đã bật' : 'Đã tắt',
                          )) {
                            ref.invalidate(platformVouchersProvider);
                          }
                        },
                      ),
                  ],
                ),
        ),
      ),
    ],
  );
}

class NewPlatformVoucherDialog extends ConsumerStatefulWidget {
  const NewPlatformVoucherDialog({super.key, this.now});
  final DateTime? now;

  @override
  ConsumerState<NewPlatformVoucherDialog> createState() => _NewPlatformVoucherDialogState();
}

class _NewPlatformVoucherDialogState extends ConsumerState<NewPlatformVoucherDialog> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _value = TextEditingController();
  final _max = TextEditingController();
  final _min = TextEditingController();
  final _limit = TextEditingController();
  var _percent = false;
  var _days = 30;
  var _firstOnly = true;

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
    final dto = AdminVoucherInputDto(
      code: _code.text.trim().toUpperCase(),
      type: _percent ? VoucherType.PERCENT : VoucherType.FIXED,
      value: _percent ? value * 100 : value,
      maxDiscount: _percent ? _int(_max) : null,
      minOrder: _int(_min),
      startsAt: start.toIso8601String(),
      endsAt: start.add(Duration(days: _days)).toIso8601String(),
      totalLimit: _int(_limit),
      firstOrderOnly: _firstOnly,
    );
    if (await runAction(context, () => ref.read(adminRepositoryProvider).createVoucher(dto), done: 'Đã tạo mã ${dto.code}') && mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Mã giảm giá mới (comi trả)'),
    content: SizedBox(
      width: 440,
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _code,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'))],
                decoration: const InputDecoration(labelText: 'Mã (VD: COMI30K)'),
                validator: (v) => RegExp(r'^[A-Z0-9]{3,20}$').hasMatch((v ?? '').toUpperCase()) ? null : '3–20 chữ hoặc số',
              ),
              const SizedBox(height: 8),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: false, label: Text('Số tiền')),
                  ButtonSegment(value: true, label: Text('Phần trăm')),
                ],
                selected: {_percent},
                onSelectionChanged: (s) => setState(() => _percent = s.first),
              ),
              TextFormField(
                controller: _value,
                decoration: InputDecoration(labelText: _percent ? 'Phần trăm (1–100)' : 'Số tiền (đ)'),
                validator: (v) {
                  final n = int.tryParse((v ?? '').replaceAll(RegExp(r'\D'), ''));
                  if (n == null || n <= 0) return 'Nhập số';
                  if (_percent && n > 100) return 'Tối đa 100%';
                  return null;
                },
              ),
              if (_percent)
                TextFormField(
                  controller: _max,
                  decoration: const InputDecoration(labelText: 'Giảm tối đa (đ)'),
                ),
              TextFormField(
                controller: _min,
                decoration: const InputDecoration(labelText: 'Đơn tối thiểu (đ, không tính đồ có cồn)'),
              ),
              TextFormField(
                controller: _limit,
                decoration: const InputDecoration(labelText: 'Tổng số lượt (không bắt buộc)'),
              ),
              Row(
                children: [
                  const Expanded(child: Text('Thời hạn')),
                  DropdownButton<int>(
                    value: _days,
                    items: const [
                      DropdownMenuItem(value: 7, child: Text('7 ngày')),
                      DropdownMenuItem(value: 30, child: Text('30 ngày')),
                      DropdownMenuItem(value: 90, child: Text('90 ngày')),
                    ],
                    onChanged: (v) => setState(() => _days = v!),
                  ),
                ],
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
      ),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: _save, child: const Text('Tạo')),
    ],
  );
}

final ratesProvider = FutureProvider.autoDispose<Map<String, double>>((ref) => ref.watch(adminRepositoryProvider).rates());

const rateCurrencies = {'USD': 'Đô la Mỹ', 'KRW': 'Won Hàn', 'CNY': 'Nhân dân tệ', 'JPY': 'Yên Nhật'};

/// Exchange rates for the approximate foreign prices tourists see (§17). VND stays the real price.
class RatesPage extends ConsumerStatefulWidget {
  const RatesPage({super.key});

  @override
  ConsumerState<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends ConsumerState<RatesPage> {
  final _c = {for (final k in rateCurrencies.keys) k: TextEditingController()};
  var _loaded = false;

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final rates = <String, double>{};
    for (final e in _c.entries) {
      final v = double.tryParse(e.value.text.replaceAll(',', '.'));
      if (v == null || v <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tỷ giá ${e.key} chưa đúng')));
        return;
      }
      rates[e.key] = v;
    }
    if (await runAction(context, () => ref.read(adminRepositoryProvider).setRates(rates), done: 'Đã lưu tỷ giá')) {
      ref.invalidate(ratesProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(ratesProvider);
    final data = value.value;
    if (data != null && !_loaded) {
      for (final e in data.entries) {
        _c[e.key]?.text = e.value % 1 == 0 ? e.value.toStringAsFixed(0) : e.value.toString();
      }
      _loaded = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          'Tỷ giá',
          actions: [FilledButton(onPressed: _save, child: const Text('Lưu'))],
        ),
        Expanded(
          child: AsyncPage(
            value: value,
            onRetry: () => ref.invalidate(ratesProvider),
            data: (_) => ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const Text('Số đồng cho 1 đơn vị ngoại tệ. Chỉ để khách du lịch ước lượng; khách luôn trả bằng VND.'),
                const SizedBox(height: 12),
                for (final e in rateCurrencies.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: 320,
                      child: TextField(
                        controller: _c[e.key],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: '1 ${e.key} (${e.value}) = … đ', border: const OutlineInputBorder()),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
