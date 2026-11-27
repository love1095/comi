import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../kitchen/kitchen_repository.dart';
import 'booking_widgets.dart' show runBookingAction;

/// Split the bill and tick off who paid in cash (§8.5).
class SplitSection extends ConsumerStatefulWidget {
  const SplitSection({super.key, required this.bookingId, required this.partySize});
  final String bookingId;
  final int partySize;

  @override
  ConsumerState<SplitSection> createState() => _SplitSectionState();
}

class _SplitSectionState extends ConsumerState<SplitSection> {
  late int _people = widget.partySize;

  Future<void> _save(SplitMode mode) async {
    final ok = await runBookingAction(
      context,
      () => ref.read(kitchenRepositoryProvider).saveSplit(widget.bookingId, mode, people: _people),
      done: mode == SplitMode.EQUAL ? 'Đã chia đều' : 'Đã chia theo món',
    );
    if (ok) ref.invalidate(splitProvider(widget.bookingId));
  }

  Future<void> _paid(SplitGuestDto g, bool paid) async {
    final ok = await runBookingAction(
      context,
      () => ref.read(kitchenRepositoryProvider).markPaid(widget.bookingId, g.id, paid),
      done: paid ? '${g.displayName}: đã thu ${formatVnd(g.amountDue)}' : '${g.displayName}: bỏ đánh dấu',
    );
    if (ok) ref.invalidate(splitProvider(widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final split = ref.watch(splitProvider(widget.bookingId));
    return split.when(
      skipLoadingOnReload: true,
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text(ApiError.from(e).userMessage),
      data: (s) {
        final hasGroup = s.guests.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('Chia hoá đơn', style: theme.textTheme.titleMedium)),
                if (s.paid > 0) Text('Đã thu ${formatVnd(s.paid)} / ${formatVnd(s.total)}', style: theme.textTheme.bodySmall),
              ],
            ),
            if (!hasGroup)
              Row(
                children: [
                  const Text('Số người'),
                  IconButton(
                    tooltip: 'Bớt người',
                    onPressed: _people > 1 ? () => setState(() => _people--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_people'),
                  IconButton(
                    tooltip: 'Thêm người',
                    onPressed: _people < 50 ? () => setState(() => _people++) : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(onPressed: () => _save(SplitMode.EQUAL), child: const Text('Chia đều')),
                OutlinedButton(onPressed: () => _save(SplitMode.BY_ITEMS), child: const Text('Theo món mỗi người')),
              ],
            ),
            for (final g in s.guests)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: g.paidAt != null,
                onChanged: g.amountDue == 0 && g.paidAt == null ? null : (v) => _paid(g, v!),
                title: Text('${g.displayName}${g.isHost ? ' (chủ bàn)' : ''}'),
                subtitle: Text(g.paidAt != null ? 'Đã thu tiền mặt / chuyển khoản' : 'Chưa trả'),
                secondary: Text(formatVnd(g.amountDue), style: theme.textTheme.titleSmall),
              ),
          ],
        );
      },
    );
  }
}
