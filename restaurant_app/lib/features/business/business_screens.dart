import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../bookings/booking_widgets.dart' show runBookingAction;
import 'business_repository.dart';

String _ymd(DateTime d) => '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Report periods offered as chips: this week, this month, last month (Vietnam dates).
List<(String, String, String)> reportPeriods(DateTime nowUtc) {
  final t = toVietnamTime(nowUtc);
  final today = DateTime(t.year, t.month, t.day);
  final weekStart = today.subtract(Duration(days: today.weekday - 1));
  final monthStart = DateTime(today.year, today.month);
  final lastMonthStart = DateTime(today.year, today.month - 1);
  final lastMonthEnd = monthStart.subtract(const Duration(days: 1));
  return [
    ('Tuần này', _ymd(weekStart), _ymd(today)),
    ('Tháng này', _ymd(monthStart), _ymd(today)),
    ('Tháng trước', _ymd(lastMonthStart), _ymd(lastMonthEnd)),
  ];
}

final _reportProvider = FutureProvider.autoDispose.family<ReportDto, (String, String)>(
  (ref, p) => ref.watch(businessRepositoryProvider).report(p.$1, p.$2),
);

/// Bookings, guests, revenue, no-shows, comi fees and best dishes for a period.
class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key, this.now});
  final DateTime? now;

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  var _period = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final periods = reportPeriods(widget.now ?? DateTime.now());
    final (_, from, to) = periods[_period];
    final report = ref.watch(_reportProvider((from, to)));

    Widget stat(String label, String value) => SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: theme.textTheme.titleLarge),
              Text(label, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Báo cáo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            children: [
              for (final (i, p) in periods.indexed)
                ChoiceChip(label: Text(p.$1), selected: i == _period, onSelected: (_) => setState(() => _period = i)),
            ],
          ),
          const SizedBox(height: 12),
          ...report.when(
            loading: () => [
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
            error: (e, _) => [Text(ApiError.from(e).userMessage)],
            data: (r) => [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  stat('Doanh thu (đã tính tiền)', formatVnd(r.revenue)),
                  stat('Đơn hoàn tất', '${r.completed} / ${r.bookings}'),
                  stat('Khách', '${r.guests}'),
                  stat('Hoá đơn trung bình', formatVnd(r.averageBill)),
                  stat('Món đặt trước', formatVnd(r.preOrderValue)),
                  stat('Không đến', '${r.noShows} (${r.noShowRate}%)'),
                  stat('Huỷ', '${r.cancelled}'),
                  stat('Phí comi', formatVnd(r.platformFees)),
                ],
              ),
              const SizedBox(height: 16),
              Text('Theo ngày', style: theme.textTheme.titleMedium),
              if (r.byDay.isEmpty) const Text('Chưa có đơn nào'),
              for (final d in r.byDay)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(d.date),
                  subtitle: Text('${d.bookings} đơn · ${d.guests} khách'),
                  trailing: Text(formatVnd(d.revenue)),
                ),
              const SizedBox(height: 16),
              Text('Món bán chạy', style: theme.textTheme.titleMedium),
              for (final (i, d) in r.topDishes.indexed)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(radius: 14, child: Text('${i + 1}', style: const TextStyle(fontSize: 12))),
                  title: Text(d.name),
                  subtitle: Text('${d.quantity} phần'),
                  trailing: Text(formatVnd(d.revenue)),
                ),
              const SizedBox(height: 8),
              Text(
                'Phí cổng thanh toán (PayOS, MoMo…) do cổng thu trực tiếp trên tài khoản của quán, không nằm trong phí comi.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Monthly comi fee statements with the transfer details (§11.3).
class StatementsScreen extends ConsumerWidget {
  const StatementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final list = ref.watch(statementsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Phí comi hàng tháng')),
      body: list.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (rows) => rows.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Chưa có bảng phí. Bảng phí được gửi ngày 1 hằng tháng.', textAlign: TextAlign.center),
                ),
              )
            : ListView(
                children: [
                  for (final s in rows)
                    ListTile(
                      title: Text('Tháng ${s.periodMonth} · ${s.bookingCount} đơn'),
                      subtitle: Text(statementStatusLabel(s.status)),
                      trailing: Text(
                        s.amountDue < 0 ? '+${formatVnd(-s.amountDue)}' : formatVnd(s.amountDue),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: s.status == StatementDtoStatusEnum.OVERDUE ? theme.colorScheme.error : null,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => StatementDetailScreen(id: s.id))),
                    ),
                ],
              ),
      ),
    );
  }
}

class StatementDetailScreen extends ConsumerWidget {
  const StatementDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final st = ref.watch(statementProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Bảng phí')),
      body: st.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (s) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Tháng ${s.periodMonth}', style: theme.textTheme.headlineSmall),
            Text(statementStatusLabel(StatementDtoStatusEnum.values.byName(s.status.value))),
            const SizedBox(height: 12),
            _row(context, 'Doanh thu tính phí', formatVnd(s.totalBase)),
            _row(context, 'Phí nền tảng', formatVnd(s.totalFee)),
            if (s.platformVoucherCredit > 0) _row(context, 'Trừ voucher comi tài trợ', '−${formatVnd(s.platformVoucherCredit)}'),
            const Divider(),
            _row(context, s.amountDue >= 0 ? 'Cần thanh toán' : 'comi chuyển trả quán', formatVnd(s.amountDue.abs()), bold: true),
            if (s.amountDue > 0 && s.status.value != 'PAID') ...[
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chuyển khoản', style: theme.textTheme.titleMedium),
                      Row(
                        children: [
                          Expanded(child: Text('Nội dung: ${s.transferMemo}')),
                          IconButton(
                            tooltip: 'Chép nội dung',
                            icon: const Icon(Icons.copy, size: 18),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: s.transferMemo));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã chép nội dung chuyển khoản')));
                            },
                          ),
                        ],
                      ),
                      if (s.dueAt != null) Text('Hạn: ${s.dueAt!.substring(0, 10)}'),
                      if (s.vietQrUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(
                            child: Image.network(
                              s.vietQrUrl!,
                              width: 240,
                              errorBuilder: (_, _, _) => const Text('Không tải được mã VietQR'),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text('Chi tiết (${s.lines.length} đơn)', style: theme.textTheme.titleMedium),
            for (final l in s.lines)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text('${l.bookingCode} · ${formatLocalTime(DateTime.parse(l.arrivalAt))} ${l.arrivalAt.substring(0, 10)}'),
                subtitle: Text('${formatVnd(l.baseAmount)} × ${l.rateBps / 100}%'),
                trailing: Text(formatVnd(l.feeAmount)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, {bool bold = false}) {
    final style = bold ? Theme.of(context).textTheme.titleMedium : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

/// VAT invoice requests from guests (§13): the restaurant issues in its own e-invoice system, then marks it here.
class InvoiceRequestsScreen extends ConsumerStatefulWidget {
  const InvoiceRequestsScreen({super.key});

  @override
  ConsumerState<InvoiceRequestsScreen> createState() => _InvoiceRequestsScreenState();
}

class _InvoiceRequestsScreenState extends ConsumerState<InvoiceRequestsScreen> {
  var _all = false;

  Future<void> _issue(InvoiceRequestDto r) async {
    final no = await showDialog<String>(context: context, builder: (_) => const _InvoiceNoDialog());
    if (no == null || !mounted) return;
    final ok = await runBookingAction(
      context,
      () => ref.read(businessRepositoryProvider).markIssued(r.id, invoiceNo: no.isEmpty ? null : no),
      done: 'Đã đánh dấu xuất hoá đơn ${r.bookingCode}',
    );
    if (ok) ref.invalidate(invoiceRequestsProvider);
  }

  Future<void> _reject(InvoiceRequestDto r) async {
    final ok = await runBookingAction(context, () => ref.read(businessRepositoryProvider).reject(r.id), done: 'Đã từ chối');
    if (ok) ref.invalidate(invoiceRequestsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = ref.watch(invoiceRequestsProvider(_all));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoá đơn VAT'),
        actions: [
          FilterChip(label: const Text('Xem tất cả'), selected: _all, onSelected: (v) => setState(() => _all = v)),
          const SizedBox(width: 8),
        ],
      ),
      body: list.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (rows) => rows.isEmpty
            ? const Center(child: Text('Không có yêu cầu xuất hoá đơn'))
            : ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  for (final r in rows)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(r.companyName, style: theme.textTheme.titleMedium)),
                                Text(invoiceStatusLabel(r.status), style: theme.textTheme.labelMedium),
                              ],
                            ),
                            SelectableText('MST: ${r.taxCode}\n${r.address}\n${r.email}'),
                            Text('Đơn ${r.bookingCode} · ${formatVnd(r.amount)}${r.invoiceNo == null ? '' : ' · Số HĐ ${r.invoiceNo}'}'),
                            if (r.status == InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT ||
                                r.status == InvoiceRequestDtoStatusEnum.REQUESTED)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: () => _reject(r), child: const Text('Từ chối')),
                                  const SizedBox(width: 8),
                                  FilledButton(onPressed: () => _issue(r), child: const Text('Đã xuất hoá đơn')),
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

class _InvoiceNoDialog extends StatefulWidget {
  const _InvoiceNoDialog();

  @override
  State<_InvoiceNoDialog> createState() => _InvoiceNoDialogState();
}

class _InvoiceNoDialogState extends State<_InvoiceNoDialog> {
  final _no = TextEditingController();

  @override
  void dispose() {
    _no.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Đã xuất hoá đơn'),
    content: TextField(
      controller: _no,
      maxLength: 50,
      decoration: const InputDecoration(labelText: 'Số hoá đơn (không bắt buộc)', border: OutlineInputBorder()),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: () => Navigator.pop(context, _no.text.trim()), child: const Text('Xác nhận')),
    ],
  );
}
