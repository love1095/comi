import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../bookings/booking_widgets.dart' show runBookingAction;
import 'business_repository.dart';

/// Connect the restaurant's own PayOS account (§10.1): guests' money goes straight to the restaurant.
class PaymentSettingsScreen extends ConsumerStatefulWidget {
  const PaymentSettingsScreen({super.key});

  @override
  ConsumerState<PaymentSettingsScreen> createState() => _PaymentSettingsScreenState();
}

class _PaymentSettingsScreenState extends ConsumerState<PaymentSettingsScreen> {
  final _form = GlobalKey<FormState>();
  final _clientId = TextEditingController();
  final _apiKey = TextEditingController();
  final _checksum = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    for (final c in [_clientId, _apiKey, _checksum]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _connect() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    final ok = await runBookingAction(
      context,
      () => ref
          .read(businessRepositoryProvider)
          .connectPayOs(clientId: _clientId.text.trim(), apiKey: _apiKey.text.trim(), checksumKey: _checksum.text.trim()),
      done: 'Đã kết nối PayOS — khách có thể trả trước',
    );
    if (ok) {
      for (final c in [_clientId, _apiKey, _checksum]) {
        c.clear();
      }
      ref.invalidate(paymentAccountProvider);
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _disconnect() async {
    final ok = await runBookingAction(
      context,
      () => ref.read(businessRepositoryProvider).disconnectPayOs(),
      done: 'Đã tắt thanh toán online',
    );
    if (ok) ref.invalidate(paymentAccountProvider);
  }

  String? _required(String? v) => (v ?? '').trim().length < 8 ? 'Dán đúng khoá từ trang PayOS' : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = ref.watch(paymentAccountProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán online')),
      body: status.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (s) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    color: s.connected ? ComiColors.available.withValues(alpha: 0.12) : null,
                    child: ListTile(
                      leading: Icon(s.connected ? Icons.check_circle : Icons.qr_code_2, color: s.connected ? ComiColors.available : null),
                      title: Text(s.connected ? 'Đã kết nối PayOS (${s.clientIdHint ?? ''})' : 'Chưa nhận trả trước'),
                      subtitle: const Text('Khách quét VietQR, tiền vào thẳng tài khoản ngân hàng của quán. comi không giữ tiền.'),
                    ),
                  ),
                  if (!s.serverReady)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('Máy chủ chưa bật thanh toán online — liên hệ comi.', style: TextStyle(color: theme.colorScheme.error)),
                    ),
                  const SizedBox(height: 16),
                  Text(s.connected ? 'Đổi khoá PayOS' : 'Kết nối PayOS', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  const Text('Tạo tài khoản ở payos.vn → Kênh thanh toán → Thông tin tích hợp, rồi dán 3 khoá dưới đây.'),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _clientId,
                    decoration: const InputDecoration(labelText: 'Client ID', border: OutlineInputBorder()),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _apiKey,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'API Key', border: OutlineInputBorder()),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _checksum,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Checksum Key', border: OutlineInputBorder()),
                    validator: _required,
                  ),
                  const SizedBox(height: 4),
                  Text('Khoá được mã hoá trước khi lưu và không hiển thị lại.', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _busy || !s.serverReady ? null : _connect,
                    child: Text(_busy ? 'Đang lưu…' : (s.connected ? 'Cập nhật khoá' : 'Kết nối')),
                  ),
                  if (s.connected) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(onPressed: _disconnect, child: const Text('Tắt thanh toán online')),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Webhook trên PayOS: <địa chỉ API>/api/v1/webhooks/payos. Phí cổng PayOS do PayOS thu trên tài khoản của quán.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Money to send back (PayOS has no refund API): staff transfer, then tick "Đã hoàn tiền".
class RefundsScreen extends ConsumerStatefulWidget {
  const RefundsScreen({super.key});

  @override
  ConsumerState<RefundsScreen> createState() => _RefundsScreenState();
}

class _RefundsScreenState extends ConsumerState<RefundsScreen> {
  var _pendingOnly = true;

  Future<void> _done(RefundDto r) async {
    final note = await showDialog<String>(context: context, builder: (_) => const _NoteDialog());
    if (note == null || !mounted) return;
    final ok = await runBookingAction(
      context,
      () => ref.read(businessRepositoryProvider).refundDone(r.id, note: note.isEmpty ? null : note),
      done: 'Đã ghi nhận hoàn ${formatVnd(r.amount)}',
    );
    if (ok) ref.invalidate(refundsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = ref.watch(refundsProvider(_pendingOnly));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoàn tiền'),
        actions: [
          FilterChip(label: const Text('Chỉ chưa hoàn'), selected: _pendingOnly, onSelected: (v) => setState(() => _pendingOnly = v)),
          const SizedBox(width: 8),
        ],
      ),
      body: list.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (rows) => rows.isEmpty
            ? const Center(child: Text('Không có khoản cần hoàn'))
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
                                Expanded(child: Text('${formatVnd(r.amount)} · ${r.bookingCode}', style: theme.textTheme.titleMedium)),
                                Text(r.status == RefundDtoStatusEnum.DONE ? 'Đã hoàn' : 'Chưa hoàn', style: theme.textTheme.labelMedium),
                              ],
                            ),
                            Text('${refundReasonLabel(r.reason.value)} · ${r.guestName ?? ''} ${r.guestPhone ?? ''}'),
                            if (r.toAccountNo != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: SelectableText(
                                      'Chuyển tới: ${r.toAccountName ?? ''} · STK ${r.toAccountNo} · NH ${r.toBankBin ?? ''}',
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Chép số tài khoản',
                                    icon: const Icon(Icons.copy, size: 18),
                                    onPressed: () => Clipboard.setData(ClipboardData(text: r.toAccountNo!)),
                                  ),
                                ],
                              )
                            else
                              Text('Chưa có tài khoản nhận — gọi khách hoặc chờ khách nhập trong app.', style: theme.textTheme.bodySmall),
                            if (r.note != null) Text('Mã giao dịch: ${r.note}', style: theme.textTheme.bodySmall),
                            if (r.status == RefundDtoStatusEnum.PENDING)
                              Align(
                                alignment: Alignment.centerRight,
                                child: FilledButton(onPressed: () => _done(r), child: const Text('Đã hoàn tiền')),
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

class _NoteDialog extends StatefulWidget {
  const _NoteDialog();

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Đã chuyển khoản hoàn tiền?'),
    content: TextField(
      controller: _note,
      maxLength: 100,
      decoration: const InputDecoration(labelText: 'Mã giao dịch (không bắt buộc)', border: OutlineInputBorder()),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: () => Navigator.pop(context, _note.text.trim()), child: const Text('Xác nhận')),
    ],
  );
}
