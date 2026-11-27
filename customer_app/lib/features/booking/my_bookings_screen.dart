import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import 'bookings_repository.dart';

/// Upcoming and past bookings. Logged out → a login prompt.
class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(sessionProvider).value?.loggedIn ?? false;
    if (!loggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Đơn của tôi')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long_outlined, size: 56),
                const SizedBox(height: 12),
                const Text('Đăng nhập để xem các bàn đã đặt'),
                const SizedBox(height: 16),
                FilledButton(onPressed: () => context.push('/login'), child: const Text('Đăng nhập')),
              ],
            ),
          ),
        ),
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đơn của tôi'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sắp tới'),
              Tab(text: 'Đã qua'),
            ],
          ),
        ),
        body: const TabBarView(children: [_BookingList(upcoming: true), _BookingList(upcoming: false)]),
      ),
    );
  }
}

class _BookingList extends ConsumerWidget {
  const _BookingList({required this.upcoming});
  final bool upcoming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(myBookingsProvider(upcoming));
    return RefreshIndicator(
      onRefresh: () => ref.refresh(myBookingsProvider(upcoming).future),
      child: page.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(
          children: [
            const SizedBox(height: 120),
            Center(child: Text(ApiError.from(e).userMessage)),
          ],
        ),
        data: (p) => p.items.isEmpty
            ? ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(upcoming ? 'Chưa có bàn nào sắp tới' : 'Chưa có đơn nào')),
                  if (upcoming)
                    Center(
                      child: TextButton(onPressed: () => context.go('/'), child: const Text('Tìm quán')),
                    ),
                ],
              )
            : ListView.separated(
                itemCount: p.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, i) => BookingTile(booking: p.items[i], onTap: () => context.push('/bookings/${p.items[i].id}')),
              ),
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  const BookingTile({super.key, required this.booking, required this.onTap});
  final CustomerBookingDto booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      title: Text(b.restaurant.name),
      subtitle: Text([arrivalLabel(b.arrivalAt), '${b.partySize} người', if (b.order != null) formatVnd(b.order!.total)].join(' · ')),
      trailing: Text(
        bookingStatusLabel(b.status, needsApproval: b.needsApproval),
        style: theme.textTheme.labelMedium?.copyWith(color: statusColor(context, b.status)),
      ),
    );
  }
}

Color statusColor(BuildContext context, BookingStatus s) {
  final scheme = Theme.of(context).colorScheme;
  return switch (s) {
    BookingStatus.PENDING => ComiColors.held,
    BookingStatus.CONFIRMED || BookingStatus.CHECKED_IN => ComiColors.available,
    BookingStatus.COMPLETED => scheme.outline,
    _ => scheme.error,
  };
}
