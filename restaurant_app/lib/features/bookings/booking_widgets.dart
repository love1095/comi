import 'package:comi_api/comi_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import 'bookings_repository.dart';

const rejectReasons = ['Hết bàn cho nhóm đông', 'Quán đóng cửa / bận việc riêng', 'Không đủ nguyên liệu'];
const cancelReasons = ['Quán đóng cửa đột xuất', 'Bàn gặp sự cố', 'Khách yêu cầu huỷ qua điện thoại'];

/// Runs [action], shows a snackbar, returns true on success.
Future<bool> runBookingAction(BuildContext context, Future<Object?> Function() action, {required String done}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    messenger.showSnackBar(SnackBar(content: Text(done)));
    return true;
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(bookingErrorMessage(e))));
    return false;
  }
}

String bookingErrorMessage(Object e) {
  final err = ApiError.from(e);
  return switch (err.code) {
    'INVALID_STATUS' => 'Đơn đã đổi trạng thái, tải lại để xem',
    'TABLE_TAKEN' => 'Bàn này đã có khách giờ đó',
    'CONFLICT' => 'Đơn vừa được cập nhật ở máy khác, tải lại',
    _ => err.userMessage,
  };
}

/// Reason picker + free text. Returns null when dismissed. Backend needs 3–300 chars.
Future<String?> askCancelReason(BuildContext context, {required String title, required List<String> reasons}) => showDialog<String>(
  context: context,
  builder: (_) => _ReasonDialog(title: title, reasons: reasons),
);

class _ReasonDialog extends StatefulWidget {
  const _ReasonDialog({required this.title, required this.reasons});
  final String title;
  final List<String> reasons;

  @override
  State<_ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<_ReasonDialog> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _valid => _text.text.trim().length >= 3;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Khách sẽ thấy lý do này.'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [for (final r in widget.reasons) ActionChip(label: Text(r), onPressed: () => setState(() => _text.text = r))],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _text,
          maxLength: 300,
          maxLines: 2,
          decoration: const InputDecoration(labelText: 'Lý do', border: OutlineInputBorder()),
          onChanged: (_) => setState(() {}),
        ),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Quay lại')),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
        onPressed: _valid ? () => Navigator.pop(context, _text.text.trim()) : null,
        child: const Text('Xác nhận huỷ'),
      ),
    ],
  );
}

class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});
  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (status) {
      BookingStatus.PENDING => ComiColors.held,
      BookingStatus.CONFIRMED => ComiColors.available,
      BookingStatus.CHECKED_IN => scheme.primary,
      BookingStatus.COMPLETED => scheme.outline,
      _ => scheme.error,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
      child: Text(
        statusLabel(status),
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Table codes: main table + joined tables count.
String tableText(BoardBookingDto b) {
  final code = b.table?.code;
  if (code == null) return 'Chưa xếp bàn';
  return b.extraTableIds.isEmpty ? 'Bàn $code' : 'Bàn $code +${b.extraTableIds.length}';
}

String guestName(BoardUserDto u) => (u.name?.trim().isNotEmpty ?? false) ? u.name!.trim() : (u.phone ?? 'Khách');

class BookingTile extends StatelessWidget {
  const BookingTile({super.key, required this.booking, required this.onTap});
  final BoardBookingDto booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final theme = Theme.of(context);
    final faded = !isActive(b.status) && b.status != BookingStatus.COMPLETED;
    return Opacity(
      opacity: faded ? 0.55 : 1,
      child: ListTile(
        onTap: onTap,
        leading: SizedBox(width: 52, child: Text(formatLocalTime(DateTime.parse(b.arrivalAt)), style: theme.textTheme.titleMedium)),
        title: Row(
          children: [
            Flexible(child: Text(guestName(b.user), overflow: TextOverflow.ellipsis)),
            const SizedBox(width: 8),
            if (b.user.noShowCount > 0)
              Tooltip(
                message: 'Đã vắng ${b.user.noShowCount} lần',
                child: Icon(Icons.warning_amber, size: 18, color: theme.colorScheme.error),
              ),
          ],
        ),
        subtitle: Text(
          [
            '${b.partySize} khách',
            tableText(b),
            if (b.order != null) formatVnd(b.order!.total),
            if (b.paymentMode == PaymentMode.PREPAID) 'Đã trả trước',
            if (b.note?.isNotEmpty ?? false) '“${b.note}”',
          ].join(' · '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: StatusChip(b.status),
      ),
    );
  }
}

class ApprovalCard extends StatelessWidget {
  const ApprovalCard({super.key, required this.booking, required this.onOpen, required this.onApprove, required this.onReject});
  final BoardBookingDto booking;
  final VoidCallback onOpen;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatLocalTime(DateTime.parse(b.arrivalAt)), style: theme.textTheme.titleLarge),
                  Text('${b.partySize} khách', style: theme.textTheme.titleSmall),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${guestName(b.user)} · ${b.code}', style: theme.textTheme.titleSmall),
                    Text([tableText(b), if (b.order != null) 'Đặt món ${formatVnd(b.order!.total)}'].join(' · ')),
                    if (b.note?.isNotEmpty ?? false) Text('“${b.note}”', maxLines: 2, overflow: TextOverflow.ellipsis),
                    if (b.user.noShowCount > 0) Text('Đã vắng ${b.user.noShowCount} lần', style: TextStyle(color: theme.colorScheme.error)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 104,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(onPressed: onApprove, child: const Text('Duyệt')),
                    const SizedBox(height: 4),
                    OutlinedButton(onPressed: onReject, child: const Text('Từ chối')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
