import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/language.dart';
import '../../data/realtime.dart';
import '../../data/session.dart';

/// Notification center (§16): booking confirmed, refund done, "how was your meal?"…
abstract class NotificationsRepository {
  Future<NotificationPageDto> list({String? cursor});
  Future<int> readAll();
  Future<int> read(String id);
}

class ApiNotificationsRepository implements NotificationsRepository {
  ApiNotificationsRepository(this._api);
  final CustomerNotificationsApi _api;

  @override
  Future<NotificationPageDto> list({String? cursor}) async => (await _api.notificationsList(cursor: cursor)).data!;

  @override
  Future<int> readAll() async => (await _api.notificationsReadAll()).data!.unread.toInt();

  @override
  Future<int> read(String id) async => (await _api.notificationsReadOne(id: id)).data!.unread.toInt();
}

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => ApiNotificationsRepository(ref.watch(apiProvider).getCustomerNotificationsApi()),
);

/// Reloads on login/logout and whenever the server says something new arrived.
final notificationsProvider = FutureProvider<NotificationPageDto?>((ref) async {
  final loggedIn = ref.watch(sessionProvider.select((s) => s.value?.loggedIn ?? false));
  if (!loggedIn) return null;
  ref.listen(realtimeEventsProvider, (_, next) {
    final n = next.value?.name;
    if (n == 'notification.new' || n == RealtimeEvent.reconnected) ref.invalidateSelf();
  });
  return ref.watch(notificationsRepositoryProvider).list();
});

/// Bell with the unread count, for the home header.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(notificationsProvider).value;
    if (page == null) return const SizedBox.shrink();
    final unread = page.unread.toInt();
    return IconButton(
      tooltip: unread == 0 ? 'Thông báo' : 'Thông báo ($unread mới)',
      onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const NotificationsScreen())),
      icon: Badge(isLabelVisible: unread > 0, label: Text(unread > 9 ? '9+' : '$unread'), child: const Icon(Icons.notifications_outlined)),
    );
  }
}

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static IconData iconFor(String type) => switch (type.split('.').first) {
    'review' => Icons.star_outline,
    'refund' || 'payment' => Icons.payments_outlined,
    'invoice' => Icons.receipt_long_outlined,
    _ => Icons.event_available_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final page = ref.watch(notificationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.notifications),
        actions: [
          if ((page.value?.unread ?? 0) > 0)
            TextButton(
              onPressed: () async {
                await ref.read(notificationsRepositoryProvider).readAll();
                ref.invalidate(notificationsProvider);
              },
              child: Text(context.l10n.markAllRead),
            ),
        ],
      ),
      body: page.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (p) => p == null || p.items.isEmpty
            ? Center(child: Text(context.l10n.noNotifications))
            : ListView.separated(
                itemCount: p.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final n = p.items[i];
                  final unread = n.readAt == null;
                  final at = toVietnamTime(DateTime.parse(n.createdAt));
                  return ListTile(
                    tileColor: unread ? theme.colorScheme.primaryContainer.withValues(alpha: 0.25) : null,
                    leading: Icon(iconFor(n.type)),
                    title: Text(n.title, style: unread ? const TextStyle(fontWeight: FontWeight.w600) : null),
                    subtitle: Text(
                      '${n.body}\n${at.day}/${at.month} ${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}',
                    ),
                    isThreeLine: true,
                    onTap: () async {
                      if (unread) {
                        await ref.read(notificationsRepositoryProvider).read(n.id);
                        ref.invalidate(notificationsProvider);
                      }
                      if (n.bookingId != null && context.mounted) {
                        final router = GoRouter.maybeOf(context);
                        Navigator.of(context).pop();
                        router?.go('/bookings/${n.bookingId}');
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
