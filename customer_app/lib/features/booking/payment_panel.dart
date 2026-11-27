import 'dart:async';

import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../group/split_screen.dart' show openUrlProvider;
import 'bookings_repository.dart';

/// Common Vietnamese banks (NAPAS BIN) for the refund account form.
const vnBanks = [
  ('970436', 'Vietcombank'),
  ('970415', 'VietinBank'),
  ('970418', 'BIDV'),
  ('970405', 'Agribank'),
  ('970407', 'Techcombank'),
  ('970422', 'MB Bank'),
  ('970416', 'ACB'),
  ('970432', 'VPBank'),
  ('970423', 'TPBank'),
  ('970403', 'Sacombank'),
];

String refundReasonText(String r) => switch (r) {
  'RESTAURANT_CANCELLED' => 'quán huỷ đơn',
  'CUSTOMER_CANCELLED' => 'bạn huỷ đơn',
  'LATE_PAYMENT_NO_TABLE' => 'thanh toán trễ, bàn đã hết',
  'AMOUNT_MISMATCH' => 'số tiền chuyển không khớp',
  _ => r,
};

/// Pay a prepaid booking (§10.3) and follow refunds. Confirmation always comes from the server.
class PaymentPanel extends ConsumerStatefulWidget {
  const PaymentPanel({super.key, required this.booking, this.now});
  final CustomerBookingDto booking;
  final DateTime? now;

  @override
  ConsumerState<PaymentPanel> createState() => _PaymentPanelState();
}

class _PaymentPanelState extends ConsumerState<PaymentPanel> {
  var _busy = false;
  Timer? _tick;

  CustomerBookingDto get b => widget.booking;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _waitingForPayment) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  bool get _waitingForPayment => b.paymentMode == PaymentMode.PREPAID && b.status == BookingStatus.PENDING && !b.needsApproval;

  Future<void> _pay() async {
    setState(() => _busy = true);
    try {
      final p = await ref.read(bookingsRepositoryProvider).pay(b.id);
      if (p.checkoutUrl != null) await ref.read(openUrlProvider)(Uri.parse(p.checkoutUrl!));
      ref.invalidate(bookingProvider(b.id));
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(switch (err.code) {
              'PAYMENT_NOT_CONNECTED' => 'Quán chưa nhận thanh toán online',
              'PAYMENT_PROVIDER_ERROR' => 'Cổng thanh toán đang lỗi, thử lại sau ít phút',
              'AWAITING_APPROVAL' => 'Chờ quán duyệt nhóm trước',
              _ => err.userMessage,
            }),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _refundAccount() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => _RefundAccountDialog(bookingId: b.id),
    );
    if (ok == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã gửi tài khoản nhận hoàn tiền cho quán')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prepaid = b.paymentMode == PaymentMode.PREPAID;
    final bookingPayments = b.payments.where((p) => p.purpose.value == 'BOOKING').toList();
    final paid = bookingPayments.where((p) => p.status.value == 'PAID' || p.status.value.contains('REFUNDED')).toList();
    final open = bookingPayments.where((p) => p.status.value == 'PENDING' || p.status.value == 'CREATED').firstOrNull;
    final amount = b.order?.total ?? 0;
    final children = <Widget>[];

    if (prepaid && b.status == BookingStatus.PENDING && b.needsApproval) {
      children.add(
        const ListTile(
          leading: Icon(Icons.hourglass_top),
          title: Text('Chờ quán duyệt nhóm'),
          subtitle: Text('Duyệt xong bạn sẽ thanh toán để giữ bàn.'),
        ),
      );
    } else if (_waitingForPayment) {
      final now = widget.now ?? DateTime.now();
      final left = open == null ? null : DateTime.parse(open.expiresAt).difference(now);
      children.add(
        Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Chờ thanh toán ${formatVnd(amount)}', style: theme.textTheme.titleMedium),
                Text(
                  left == null || left.isNegative
                      ? 'Thanh toán để giữ bàn — đơn tự huỷ nếu không thanh toán.'
                      : 'Còn ${left.inMinutes}:${(left.inSeconds % 60).toString().padLeft(2, '0')} để thanh toán.',
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _busy ? null : _pay,
                  icon: const Icon(Icons.qr_code_2),
                  label: Text(_busy ? 'Đang mở…' : 'Thanh toán bằng VietQR'),
                ),
                const SizedBox(height: 4),
                Text('Tiền chuyển thẳng cho quán qua PayOS. Bàn được giữ khi quán nhận được tiền.', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ),
      );
    } else if (prepaid && paid.isNotEmpty) {
      children.add(
        ListTile(
          leading: const Icon(Icons.verified, color: ComiColors.available),
          title: Text('Đã thanh toán ${formatVnd(paid.first.amount)}'),
        ),
      );
    } else if (prepaid && b.status == BookingStatus.EXPIRED) {
      children.add(
        ListTile(
          leading: Icon(Icons.timer_off, color: theme.colorScheme.error),
          title: const Text('Hết hạn thanh toán — đơn đã huỷ'),
        ),
      );
    }

    for (final r in b.refunds) {
      final done = r.status.value == 'DONE';
      children.add(
        ListTile(
          leading: Icon(done ? Icons.check_circle : Icons.currency_exchange, color: done ? ComiColors.available : null),
          title: Text('${done ? 'Đã hoàn' : 'Đang hoàn'} ${formatVnd(r.amount)}'),
          subtitle: Text('Lý do: ${refundReasonText(r.reason)}${done ? '' : ' · quán chuyển khoản lại cho bạn'}'),
        ),
      );
    }
    if (b.refunds.any((r) => r.status.value == 'PENDING')) {
      children.add(
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _refundAccount,
            icon: const Icon(Icons.account_balance),
            label: const Text('Nhập tài khoản nhận hoàn tiền'),
          ),
        ),
      );
    }
    if (children.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }
}

class _RefundAccountDialog extends ConsumerStatefulWidget {
  const _RefundAccountDialog({required this.bookingId});
  final String bookingId;

  @override
  ConsumerState<_RefundAccountDialog> createState() => _RefundAccountDialogState();
}

class _RefundAccountDialogState extends ConsumerState<_RefundAccountDialog> {
  var _bank = vnBanks.first.$1;
  final _no = TextEditingController();
  final _name = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _no.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!RegExp(r'^\d{6,20}$').hasMatch(_no.text.trim()) || _name.text.trim().length < 2) {
      setState(() => _error = 'Kiểm tra số tài khoản và tên chủ tài khoản');
      return;
    }
    try {
      await ref
          .read(bookingsRepositoryProvider)
          .setRefundAccount(widget.bookingId, bankBin: _bank, accountNo: _no.text.trim(), accountName: _name.text.trim());
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => _error = ApiError.from(e).userMessage);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Tài khoản nhận hoàn tiền'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _bank,
          decoration: const InputDecoration(labelText: 'Ngân hàng'),
          items: [for (final b in vnBanks) DropdownMenuItem(value: b.$1, child: Text(b.$2))],
          onChanged: (v) => setState(() => _bank = v!),
        ),
        TextField(
          controller: _no,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(labelText: 'Số tài khoản'),
        ),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(labelText: 'Tên chủ tài khoản', errorText: _error),
        ),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: _save, child: const Text('Gửi')),
    ],
  );
}
