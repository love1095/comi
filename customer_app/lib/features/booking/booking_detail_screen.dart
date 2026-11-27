import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../cart/cart.dart';
import '../discovery/discovery_repository.dart';
import '../group/group_actions.dart';
import 'at_table.dart';
import 'payment_panel.dart';
import 'bookings_repository.dart';
import 'my_bookings_screen.dart' show statusColor;

/// One booking: what, when, where; cancel before the cutoff; order the same again.
class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({super.key, required this.bookingId, this.justBooked = false});
  final String bookingId;
  final bool justBooked;

  Future<void> _cancel(BuildContext context, WidgetRef ref, CustomerBookingDto b) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Huỷ bàn?'),
        content: Text('${b.restaurant.name} · ${arrivalLabel(b.arrivalAt)} · ${b.partySize} người'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Giữ bàn')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Huỷ bàn')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await ref.read(bookingsRepositoryProvider).cancel(b.id);
      ref.invalidate(bookingProvider(bookingId));
      ref.invalidate(myBookingsProvider);
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã huỷ bàn')));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    }
  }

  /// "Order again": same dishes into the cart, then the restaurant page to pick a new time.
  Future<void> _orderAgain(BuildContext context, WidgetRef ref, CustomerBookingDto b) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final draft = await ref.read(bookingsRepositoryProvider).reorder(b.id);
      final menu = await ref.read(discoveryRepositoryProvider).menu(b.restaurantId);
      final byId = {
        for (final c in menu)
          for (final i in c.items) i.id: i,
      };
      final cart = ref.read(cartProvider.notifier)..clear();
      final r = (id: b.restaurantId, slug: b.restaurant.slug, name: b.restaurant.name);
      for (final l in draft.items) {
        final item = byId[l.menuItemId];
        if (item != null) cart.add(r, CartLine(item: item, quantity: l.quantity.toInt(), note: l.note));
      }
      if (draft.unavailable.isNotEmpty) {
        messenger.showSnackBar(SnackBar(content: Text('Hết món: ${draft.unavailable.map((u) => u.name).join(', ')}')));
      }
      if (context.mounted) context.push('/r/${b.restaurant.slug}');
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết đặt bàn')),
      body: booking.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(bookingProvider(bookingId)), child: const Text('Thử lại')),
            ],
          ),
        ),
        data: (b) => _body(context, ref, b),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, CustomerBookingDto b) {
    final theme = Theme.of(context);
    final active = b.status == BookingStatus.PENDING || b.status == BookingStatus.CONFIRMED;
    final items = b.order?.items.where((i) => i.kitchenStatus != KitchenStatus.CANCELLED).toList() ?? const <BoardOrderItemDto>[];
    final hasItems = items.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (justBooked)
          Card(
            color: ComiColors.available.withValues(alpha: 0.15),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: ComiColors.available, size: 32),
              title: Text(b.needsApproval ? 'Đã gửi yêu cầu!' : 'Đặt bàn thành công!'),
              subtitle: Text(b.needsApproval ? 'Quán sẽ xác nhận trong vòng 2 giờ.' : 'Đưa mã ${b.code} cho nhân viên khi đến.'),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text(b.restaurant.name, style: theme.textTheme.headlineSmall)),
            Text(
              bookingStatusLabel(b.status, needsApproval: b.needsApproval),
              style: theme.textTheme.labelLarge?.copyWith(color: statusColor(context, b.status)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _Info(icon: Icons.schedule, text: arrivalLabel(b.arrivalAt)),
        _Info(icon: Icons.people_outline, text: '${b.partySize} người${b.table == null ? '' : ' · Bàn ${b.table!.code}'}'),
        _Info(icon: Icons.place_outlined, text: b.restaurant.address),
        _Info(
          icon: Icons.phone_outlined,
          text: b.restaurant.phone,
          trailing: IconButton(
            tooltip: 'Chép số điện thoại',
            icon: const Icon(Icons.copy, size: 18),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: b.restaurant.phone));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã chép số điện thoại quán')));
            },
          ),
        ),
        _Info(icon: Icons.confirmation_number_outlined, text: 'Mã đặt bàn: ${b.code}'),
        if (b.note != null) _Info(icon: Icons.notes, text: b.note!),
        if (b.status == BookingStatus.CANCELLED)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              [
                b.cancelledBy == 'RESTAURANT'
                    ? 'Quán đã huỷ'
                    : b.cancelledBy == 'SYSTEM'
                    ? 'Tự huỷ (quán chưa xác nhận)'
                    : 'Bạn đã huỷ',
                if (b.cancelReason != null) b.cancelReason!,
              ].join(': '),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        const SizedBox(height: 12),
        PaymentPanel(booking: b),
        AtTablePanel(booking: b),
        const SizedBox(height: 8),
        GroupActions(booking: b),
        const Divider(height: 32),
        if (b.status == BookingStatus.CHECKED_IN) LiveBillView(bookingId: b.id),
        if (!hasItems && b.status != BookingStatus.CHECKED_IN)
          Text('Không đặt món trước — gọi món khi đến quán.', style: theme.textTheme.bodyMedium),
        if (hasItems && b.status != BookingStatus.CHECKED_IN) ...[
          Text('Món đã đặt', style: theme.textTheme.titleMedium),
          for (final course in Course.values)
            if (items.any((i) => i.course == course)) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(courseName(course), style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
              ),
              for (final i in items.where((i) => i.course == course))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(width: 32, child: Text('${i.quantity}×')),
                      Expanded(child: Text([i.nameSnapshot, ...i.optionsSnapshot.map((o) => o.option)].join(' · '))),
                      Text(formatVnd(i.unitPrice * i.quantity)),
                    ],
                  ),
                ),
            ],
          const Divider(height: 24),
          Row(
            children: [
              Expanded(child: Text('Tổng (trả tại quán)', style: theme.textTheme.titleMedium)),
              Text(formatVnd(b.order!.total), style: theme.textTheme.titleMedium),
            ],
          ),
        ],
        const SizedBox(height: 24),
        if (active)
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error, minimumSize: const Size.fromHeight(48)),
            onPressed: () => _cancel(context, ref, b),
            icon: const Icon(Icons.close),
            label: const Text('Huỷ bàn'),
          ),
        if (!active && hasItems)
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            onPressed: () => _orderAgain(context, ref, b),
            icon: const Icon(Icons.replay),
            label: const Text('Đặt lại như lần này'),
          ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text, this.trailing});
  final IconData icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
        ?trailing,
      ],
    ),
  );
}
