import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import 'booking_widgets.dart';
import 'bookings_repository.dart';

/// One booking: guest, table, pre-ordered dishes, and staff actions (approve, move table, cancel).
class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({super.key, required this.bookingId});
  final String bookingId;

  Future<void> _after(WidgetRef ref, bool ok) async {
    if (!ok) return;
    ref.invalidate(bookingDetailProvider(bookingId));
    ref.invalidate(boardBookingsProvider);
  }

  Future<void> _approve(BuildContext context, WidgetRef ref, BookingDetailDto b) async => _after(
    ref,
    await runBookingAction(context, () => ref.read(bookingsRepositoryProvider).approve(b.id), done: 'Đã duyệt đơn ${b.code}'),
  );

  Future<void> _cancel(BuildContext context, WidgetRef ref, BookingDetailDto b) async {
    final rejecting = b.status == BookingStatus.PENDING && b.needsApproval;
    final reason = await askCancelReason(
      context,
      title: rejecting ? 'Từ chối đơn ${b.code}?' : 'Huỷ đơn ${b.code}?',
      reasons: rejecting ? rejectReasons : cancelReasons,
    );
    if (reason == null || !context.mounted) return;
    _after(
      ref,
      await runBookingAction(context, () => ref.read(bookingsRepositoryProvider).cancel(b.id, reason), done: 'Đã huỷ đơn ${b.code}'),
    );
  }

  Future<void> _moveTable(BuildContext context, WidgetRef ref, BookingDetailDto b) async {
    final tableId = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _TablePicker(booking: b),
    );
    if (tableId == null || !context.mounted) return;
    _after(ref, await runBookingAction(context, () => ref.read(bookingsRepositoryProvider).moveTable(b.id, tableId), done: 'Đã đổi bàn'));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingDetailProvider(bookingId));
    return Scaffold(
      appBar: AppBar(title: Text(booking.value == null ? 'Đơn đặt bàn' : 'Đơn ${booking.value!.code}')),
      body: booking.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(bookingDetailProvider(bookingId)), child: const Text('Thử lại')),
            ],
          ),
        ),
        data: (b) => _Body(
          booking: b,
          onApprove: () => _approve(context, ref, b),
          onCancel: () => _cancel(context, ref, b),
          onMoveTable: () => _moveTable(context, ref, b),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.booking, required this.onApprove, required this.onCancel, required this.onMoveTable});
  final BookingDetailDto booking;
  final VoidCallback onApprove;
  final VoidCallback onCancel;
  final VoidCallback onMoveTable;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final theme = Theme.of(context);
    final arrival = DateTime.parse(b.arrivalAt);
    final ends = DateTime.parse(b.endsAt);
    final waitingApproval = b.status == BookingStatus.PENDING && b.needsApproval;
    final table = b.table == null
        ? 'Chưa xếp bàn'
        : (b.extraTableIds.isEmpty ? b.table!.code : '${b.table!.code} + ${b.extraTableIds.length} bàn ghép');

    final actions = [
      if (waitingApproval) FilledButton.icon(onPressed: onApprove, icon: const Icon(Icons.check), label: const Text('Duyệt')),
      if (isActive(b.status)) OutlinedButton.icon(onPressed: onMoveTable, icon: const Icon(Icons.swap_horiz), label: const Text('Đổi bàn')),
      if (canCancel(b.status))
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error),
          onPressed: onCancel,
          icon: const Icon(Icons.close),
          label: Text(waitingApproval ? 'Từ chối' : 'Huỷ đơn'),
        ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Text('${formatLocalTime(arrival)} – ${formatLocalTime(ends)}', style: theme.textTheme.headlineSmall),
            const Spacer(),
            StatusChip(b.status),
          ],
        ),
        const SizedBox(height: 4),
        Text('${b.partySize} khách · Bàn $table · ${b.paymentMode == PaymentMode.PREPAID ? 'Đã trả trước' : 'Trả tại quán'}'),
        if (waitingApproval)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Card(
              color: ComiColors.held.withValues(alpha: 0.15),
              child: const ListTile(
                leading: Icon(Icons.hourglass_top),
                title: Text('Nhóm đông cần quán duyệt'),
                subtitle: Text('Đơn tự huỷ nếu quán không trả lời trong 2 giờ.'),
              ),
            ),
          ),
        if (actions.isNotEmpty) ...[const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children: actions)],
        const Divider(height: 32),
        Text('Khách', style: theme.textTheme.titleMedium),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(guestName(b.user)),
          subtitle: Text(
            [if (b.user.phone != null) b.user.phone!, if (b.user.noShowCount > 0) 'Đã vắng ${b.user.noShowCount} lần'].join(' · '),
          ),
          trailing: b.user.phone == null
              ? null
              : IconButton(
                  tooltip: 'Chép SĐT',
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: b.user.phone!));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã chép số điện thoại')));
                  },
                ),
        ),
        if (b.note?.isNotEmpty ?? false) ...[Text('Ghi chú', style: theme.textTheme.titleMedium), const SizedBox(height: 4), Text(b.note!)],
        const Divider(height: 32),
        _OrderSection(order: b.order),
      ],
    );
  }
}

class _OrderSection extends StatelessWidget {
  const _OrderSection({required this.order});
  final BookingDetailOrderDto? order;

  static String courseLabel(Course c) => switch (c) {
    Course.DRINK => 'Đồ uống',
    Course.STARTER => 'Khai vị',
    Course.MAIN => 'Món chính',
    Course.DESSERT => 'Tráng miệng',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final o = order;
    final items = o?.items.where((i) => i.kitchenStatus != KitchenStatus.CANCELLED).toList() ?? const <BoardOrderItemDto>[];
    if (o == null || items.isEmpty) {
      return Text('Khách chưa đặt món trước', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline));
    }

    final rows = <Widget>[Text('Món đặt trước', style: theme.textTheme.titleMedium)];
    for (final course in Course.values) {
      final lines = items.where((i) => i.course == course).toList();
      if (lines.isEmpty) continue;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          child: Text(courseLabel(course), style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
        ),
      );
      for (final i in lines) {
        final extras = [
          ...i.optionsSnapshot.map((s) => s.option),
          if (i.note?.isNotEmpty ?? false) '“${i.note}”',
          if (i.round > 0) 'gọi thêm lần ${i.round}',
        ];
        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 36, child: Text('${i.quantity}×', style: theme.textTheme.titleSmall)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i.nameSnapshot),
                      if (extras.isNotEmpty) Text(extras.join(' · '), style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                Text(formatVnd(i.unitPrice * i.quantity)),
              ],
            ),
          ),
        );
      }
    }

    Widget total(String label, num v, {bool bold = false}) => Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: bold ? theme.textTheme.titleMedium : null)),
          Text(formatVnd(v), style: bold ? theme.textTheme.titleMedium : null),
        ],
      ),
    );
    final discount = o.restaurantDiscount + o.platformDiscount;
    rows.addAll([
      const Divider(height: 24),
      if (discount > 0) ...[total('Tạm tính', o.subtotal), total('Giảm giá', -discount)],
      total('Tổng', o.total, bold: true),
    ]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }
}

/// Active tables that seat the party. The server re-checks that the table is free at that time.
class _TablePicker extends ConsumerWidget {
  const _TablePicker({required this.booking});
  final BookingDetailDto booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tables = ref.watch(_tablesProvider);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Chuyển sang bàn nào?', style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text('${booking.partySize} khách · bàn bận giờ đó sẽ bị từ chối'),
            ),
            const Divider(height: 1),
            Flexible(
              child: tables.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => Padding(padding: const EdgeInsets.all(32), child: Text(ApiError.from(e).userMessage)),
                data: (list) {
                  final options = list.where((t) => t.isActive && t.id != booking.tableId).toList()
                    ..sort((a, c) {
                      final fa = a.maxSeats >= booking.partySize ? 0 : 1;
                      final fc = c.maxSeats >= booking.partySize ? 0 : 1;
                      return fa != fc ? fa - fc : a.code.compareTo(c.code);
                    });
                  if (options.isEmpty) return const Padding(padding: EdgeInsets.all(32), child: Text('Không có bàn khác'));
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      for (final t in options)
                        ListTile(
                          enabled: t.maxSeats >= booking.partySize,
                          leading: const Icon(Icons.table_restaurant),
                          title: Text('Bàn ${t.code}'),
                          subtitle: Text(t.maxSeats >= booking.partySize ? '${t.minSeats}–${t.maxSeats} chỗ' : 'Chỉ ${t.maxSeats} chỗ'),
                          onTap: () => Navigator.pop(context, t.id),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final _tablesProvider = FutureProvider.autoDispose<List<TableDto>>((ref) => ref.watch(bookingsRepositoryProvider).listTables());
