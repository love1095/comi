import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import 'group_repository.dart';
import 'split_screen.dart';

/// On the host's booking: invite friends before, split the bill and get home after (§8.4, §8.5).
class GroupActions extends ConsumerStatefulWidget {
  const GroupActions({super.key, required this.booking});
  final CustomerBookingDto booking;

  @override
  ConsumerState<GroupActions> createState() => _GroupActionsState();
}

class _GroupActionsState extends ConsumerState<GroupActions> {
  var _busy = false;

  Future<void> _invite() async {
    setState(() => _busy = true);
    try {
      final g = await ref.read(groupRepositoryProvider).start(widget.booking.id);
      await ref.read(groupKeyStoreProvider).write(g.token, g.guestId!, g.guestKey);
      if (mounted) context.push('/g/${g.token}');
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.code == 'GROUP_LOCKED' ? 'Đã quá giờ nhận món nhóm — gọi thêm khi đến quán' : err.userMessage)),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.booking.status;
    final open = s == BookingStatus.PENDING || s == BookingStatus.CONFIRMED;
    final seated = s == BookingStatus.CHECKED_IN || s == BookingStatus.COMPLETED;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (open)
          OutlinedButton.icon(
            onPressed: _busy ? null : _invite,
            icon: const Icon(Icons.group_add_outlined),
            label: const Text('Mời bạn cùng đặt món'),
          ),
        if (seated)
          OutlinedButton.icon(
            onPressed: () => context.push('/split/${widget.booking.id}'),
            icon: const Icon(Icons.call_split),
            label: const Text('Chia hoá đơn'),
          ),
        if (seated) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/invoice/${widget.booking.id}'),
            icon: const Icon(Icons.receipt_long_outlined),
            label: const Text('Yêu cầu hoá đơn VAT'),
          ),
        ],
        if (s == BookingStatus.COMPLETED) ...[const SizedBox(height: 8), const GetHomeSafeCard()],
      ],
    );
  }
}
