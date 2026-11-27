import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/location.dart';
import '../cart/cart.dart';
import 'bookings_repository.dart';
import 'scan_screen.dart';

/// Opens the scanner. Overridden in tests (no camera).
final scanQrProvider = Provider<Future<String?> Function(BuildContext)>(
  (ref) =>
      (context) => Navigator.of(context).push<String>(MaterialPageRoute(builder: (_) => const ScanScreen())),
);

const _leaveWindow = Duration(minutes: 45); // §7.5
const _checkInWindow = Duration(minutes: 60); // §9.2

String dishStatus(KitchenStatus s) => switch (s) {
  KitchenStatus.HOLD => 'Chờ',
  KitchenStatus.SCHEDULED => 'Đã hẹn bếp',
  KitchenStatus.QUEUED => 'Chờ nấu',
  KitchenStatus.COOKING => 'Đang nấu',
  KitchenStatus.READY => 'Sắp lên',
  KitchenStatus.SERVED => 'Đã lên',
  KitchenStatus.CANCELLED => 'Huỷ',
};

/// What the guest can do around arrival: "I'm leaving now", check in, then order more / call staff.
class AtTablePanel extends ConsumerStatefulWidget {
  const AtTablePanel({super.key, required this.booking, this.now});
  final CustomerBookingDto booking;
  final DateTime? now;

  @override
  ConsumerState<AtTablePanel> createState() => _AtTablePanelState();
}

class _AtTablePanelState extends ConsumerState<AtTablePanel> {
  String? _eta;
  var _busy = false;

  CustomerBookingDto get b => widget.booking;

  void _toast(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  Future<void> _act(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      if (mounted) _toast(ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _depart() => _act(() async {
    final here = await ref.read(locationServiceProvider).current();
    final r = await ref.read(bookingsRepositoryProvider).depart(b.id, here.lat, here.lng);
    if (!mounted) return;
    setState(() => _eta = r.etaAt);
    _toast('Quán đã biết bạn đang tới — khoảng ${r.travelMinutes} phút');
  });

  Future<void> _checkIn() async {
    final payload = await ref.read(scanQrProvider)(context);
    if (payload == null || !mounted) return;
    await _act(() async {
      await ref.read(bookingsRepositoryProvider).checkIn(b.id, payload);
      ref.invalidate(bookingProvider(b.id));
      ref.invalidate(myBookingsProvider);
      if (mounted) _toast('Đã check-in — bếp bắt đầu làm món');
    });
  }

  Future<void> _service(ServiceType type, String label) => _act(() async {
    await ref.read(bookingsRepositoryProvider).requestService(b.id, type);
    if (mounted) _toast('Đã báo nhân viên: $label');
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = widget.now ?? DateTime.now();
    final arrival = DateTime.parse(b.arrivalAt);

    if (b.status == BookingStatus.CONFIRMED) {
      final canLeave = now.isAfter(arrival.subtract(_leaveWindow));
      final canCheckIn = now.isAfter(arrival.subtract(_checkInWindow));
      if (!canCheckIn) return const SizedBox.shrink();
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Sắp tới giờ', style: theme.textTheme.titleMedium),
              if (_eta != null) Text('Quán đợi bạn lúc ${formatLocalTime(DateTime.parse(_eta!))}', style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              if (canLeave)
                OutlinedButton.icon(
                  onPressed: _busy ? null : _depart,
                  icon: const Icon(Icons.directions_walk),
                  label: const Text('Tôi đi bây giờ'),
                ),
              const SizedBox(height: 8),
              FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _busy ? null : _checkIn,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Tới quán rồi — quét mã check-in'),
              ),
            ],
          ),
        ),
      );
    }

    if (b.status != BookingStatus.CHECKED_IN) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          onPressed: () => context.push('/r/${b.restaurant.slug}?table=${b.id}'),
          icon: const Icon(Icons.add),
          label: const Text('Gọi thêm món'),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (type, label, icon) in const [
              (ServiceType.CALL_WAITER, 'Gọi nhân viên', Icons.waving_hand_outlined),
              (ServiceType.MORE_ICE, 'Thêm đá', Icons.ac_unit),
              (ServiceType.MORE_BOWLS, 'Thêm chén bát', Icons.rice_bowl_outlined),
              (ServiceType.BILL_PLEASE, 'Tính tiền', Icons.receipt_long),
            ])
              ActionChip(avatar: Icon(icon, size: 18), label: Text(label), onPressed: _busy ? null : () => _service(type, label)),
          ],
        ),
      ],
    );
  }
}

/// Every round with live dish status (cooking / coming / served).
class LiveBillView extends ConsumerWidget {
  const LiveBillView({super.key, required this.bookingId});
  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ref
        .watch(billProvider(bookingId))
        .when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text(ApiError.from(e).userMessage),
          data: (bill) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Món của bàn', style: theme.textTheme.titleMedium),
              for (final r in bill.rounds) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 4),
                  child: Text(
                    r.round == 0 ? 'Đặt trước' : 'Gọi thêm lần ${r.round}${r.waitingForStaff ? ' · chờ nhân viên xác nhận' : ''}',
                    style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
                  ),
                ),
                for (final i in r.items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(width: 32, child: Text('${i.quantity}×')),
                        Expanded(child: Text([i.nameSnapshot, ...i.optionsSnapshot.map((o) => o.option)].join(' · '))),
                        Text(
                          dishStatus(i.kitchenStatus),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: i.kitchenStatus == KitchenStatus.READY ? ComiColors.available : null,
                            fontWeight: i.kitchenStatus == KitchenStatus.READY ? FontWeight.bold : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(width: 80, child: Text(formatVnd(i.unitPrice * i.quantity), textAlign: TextAlign.right)),
                      ],
                    ),
                  ),
              ],
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(child: Text('Tạm tính (trả tại quán)', style: theme.textTheme.titleMedium)),
                  Text(formatVnd(bill.total), style: theme.textTheme.titleMedium),
                ],
              ),
            ],
          ),
        );
  }
}

/// Sends the cart as a new round for a seated booking (§8.5). Returns true when sent.
Future<bool> sendTableOrder(BuildContext context, WidgetRef ref, String bookingId) async {
  final cart = ref.read(cartProvider);
  if (cart.isEmpty) return false;
  bool? age;
  if (cart.hasAlcohol) {
    age = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Đồ uống có cồn'),
        content: const Text('Bạn xác nhận đã đủ 18 tuổi?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Không')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Đủ 18 tuổi')),
        ],
      ),
    );
    if (age != true) return false;
  }
  try {
    final r = await ref.read(bookingsRepositoryProvider).orderMore(bookingId, [for (final l in cart.lines) l.toDto()], ageConfirmed: age);
    ref.read(cartProvider.notifier).clear();
    ref.invalidate(billProvider(bookingId));
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(r.needsApproval ? 'Đã gửi — chờ nhân viên xác nhận' : 'Đã gửi ${cart.count} món vào bếp')));
    }
    return true;
  } catch (e) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    return false;
  }
}
