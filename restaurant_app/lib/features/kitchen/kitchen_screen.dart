import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../app/home_shell.dart';
import '../../data/api_error.dart';
import '../../data/realtime.dart';
import '../bookings/booking_widgets.dart' show runBookingAction;
import 'kitchen_repository.dart';
import 'service_requests.dart';

/// Keeps the tablet awake while the kitchen screen is open. Overridden in tests.
final wakelockProvider = Provider<void Function(bool on)>(
  (ref) =>
      (on) => WakelockPlus.toggle(enable: on).catchError((_) {}),
);

/// Plays the "new dish" sound. Overridden in tests.
final newItemSoundProvider = Provider<void Function()>(
  (ref) =>
      () => SystemSound.play(SystemSoundType.alert),
);

/// Minutes between two instants, for "late by" / "cooking for" labels.
int minutesBetween(String? fromIso, DateTime now) => fromIso == null ? 0 : now.difference(DateTime.parse(fromIso)).inMinutes;

String courseShort(Course c) => switch (c) {
  Course.DRINK => 'Uống',
  Course.STARTER => 'Khai vị',
  Course.MAIN => 'Chính',
  Course.DESSERT => 'Tráng miệng',
};

/// Kitchen display (§7.3): what to cook now, what is done, what is coming.
class KitchenScreen extends ConsumerStatefulWidget {
  const KitchenScreen({super.key});

  @override
  ConsumerState<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends ConsumerState<KitchenScreen> {
  late final void Function(bool) _wakelock;

  @override
  void initState() {
    super.initState();
    _wakelock = ref.read(wakelockProvider);
    _wakelock(true);
  }

  @override
  void dispose() {
    _wakelock(false);
    super.dispose();
  }

  Future<void> _set(KitchenItemDto item, KitchenStatusDtoStatusEnum to) async {
    final ok = await runBookingAction(
      context,
      () => ref.read(kitchenRepositoryProvider).setStatus(item.id, to),
      done: '${item.nameSnapshot}: ${_doneText(to)}',
    );
    if (ok) ref.invalidate(kitchenQueueProvider);
  }

  static String _doneText(KitchenStatusDtoStatusEnum to) => switch (to) {
    KitchenStatusDtoStatusEnum.COOKING => 'đang nấu',
    KitchenStatusDtoStatusEnum.READY => 'xong, chờ bưng',
    KitchenStatusDtoStatusEnum.SERVED => 'đã bưng',
    KitchenStatusDtoStatusEnum.QUEUED => 'trả lại chờ nấu',
  };

  @override
  Widget build(BuildContext context) {
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next.value?.name == 'kitchen.item_queued') ref.read(newItemSoundProvider)();
    });
    final queue = ref.watch(kitchenQueueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bếp'),
        actions: [
          const ServiceRequestsButton(),
          IconButton(tooltip: 'Tải lại', onPressed: () => ref.invalidate(kitchenQueueProvider), icon: const Icon(Icons.refresh)),
          const AccountMenu(),
        ],
      ),
      body: queue.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(kitchenQueueProvider), child: const Text('Thử lại')),
            ],
          ),
        ),
        data: (q) {
          final now = DateTime.parse(q.now);
          final columns = [
            _Column(
              title: 'Cần nấu',
              count: q.active.length,
              empty: 'Chưa có món cần nấu',
              children: [for (final i in q.active) _TicketCard(item: i, now: now, onSet: _set)],
            ),
            _Column(
              title: 'Xong — chờ bưng',
              count: q.ready.length,
              empty: 'Không có món chờ bưng',
              children: [for (final i in q.ready) _TicketCard(item: i, now: now, onSet: _set)],
            ),
            _Column(
              title: 'Sắp tới',
              count: q.upcoming.length,
              empty: 'Không có món nào trong 2–3 giờ tới',
              children: [for (final i in q.upcoming) _TicketCard(item: i, now: now, onSet: _set)],
            ),
          ];
          return LayoutBuilder(
            builder: (context, c) {
              if (c.maxWidth >= 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (i, col) in columns.indexed) ...[if (i > 0) const VerticalDivider(width: 1), Expanded(child: col)],
                  ],
                );
              }
              return DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [for (final col in columns) Tab(text: '${col.title} (${col.count})')]),
                    Expanded(child: TabBarView(children: columns)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.title, required this.count, required this.empty, required this.children});
  final String title;
  final int count;
  final String empty;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: Text('$title ($count)', style: Theme.of(context).textTheme.titleMedium),
      ),
      Expanded(
        child: children.isEmpty
            ? Center(
                child: Text(empty, style: TextStyle(color: Theme.of(context).colorScheme.outline)),
              )
            : ListView(padding: const EdgeInsets.fromLTRB(8, 0, 8, 24), children: children),
      ),
    ],
  );
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.item, required this.now, required this.onSet});
  final KitchenItemDto item;
  final DateTime now;
  final void Function(KitchenItemDto, KitchenStatusDtoStatusEnum) onSet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i = item;
    final waiting = i.kitchenStatus == KitchenStatus.HOLD || i.kitchenStatus == KitchenStatus.SCHEDULED;
    final late = i.kitchenStatus == KitchenStatus.QUEUED ? minutesBetween(i.scheduledStartAt, now) : 0;
    final timer = switch (i.kitchenStatus) {
      KitchenStatus.QUEUED when late >= 1 => 'Trễ $late phút',
      KitchenStatus.QUEUED => 'Nấu ngay',
      KitchenStatus.COOKING => 'Đang nấu ${minutesBetween(i.startedAt, now)}/${i.prepMinutes} phút',
      KitchenStatus.READY => 'Xong ${minutesBetween(i.readyAt, now)} phút trước',
      KitchenStatus.SCHEDULED => 'Nấu lúc ${i.scheduledStartAt == null ? '?' : formatLocalTime(DateTime.parse(i.scheduledStartAt!))}',
      KitchenStatus.HOLD =>
        'Chờ khách đến${i.scheduledStartAt == null ? '' : ' · dự kiến ${formatLocalTime(DateTime.parse(i.scheduledStartAt!))}'}',
      _ => kitchenStatusLabel(i.kitchenStatus),
    };
    final urgent =
        (i.kitchenStatus == KitchenStatus.QUEUED && late >= 5) ||
        (i.kitchenStatus == KitchenStatus.COOKING && minutesBetween(i.startedAt, now) > i.prepMinutes + 5);
    final extras = [...i.optionsSnapshot.map((o) => o.option), if (i.note?.isNotEmpty ?? false) '“${i.note}”'];

    return Opacity(
      opacity: waiting ? 0.6 : 1,
      child: Card(
        color: i.kitchenStatus == KitchenStatus.COOKING ? theme.colorScheme.primaryContainer : null,
        shape: urgent
            ? RoundedRectangleBorder(
                side: BorderSide(color: theme.colorScheme.error, width: 2),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('${i.quantity}× ${i.nameSnapshot}', style: theme.textTheme.titleLarge)),
                  Chip(label: Text(courseShort(i.course)), visualDensity: VisualDensity.compact),
                ],
              ),
              if (extras.isNotEmpty) Text(extras.join(' · '), style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                [
                  if (i.tableCode != null) 'Bàn ${i.tableCode}',
                  i.bookingCode,
                  '${i.partySize} khách',
                  if (i.round > 0) 'gọi thêm lần ${i.round}',
                ].join(' · '),
                style: theme.textTheme.bodyMedium,
              ),
              Text(timer, style: theme.textTheme.bodySmall?.copyWith(color: urgent ? theme.colorScheme.error : null)),
              if (!waiting) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (i.kitchenStatus == KitchenStatus.COOKING)
                      TextButton(onPressed: () => onSet(i, KitchenStatusDtoStatusEnum.QUEUED), child: const Text('Hoàn tác')),
                    const Spacer(),
                    switch (i.kitchenStatus) {
                      KitchenStatus.QUEUED => FilledButton.icon(
                        onPressed: () => onSet(i, KitchenStatusDtoStatusEnum.COOKING),
                        icon: const Icon(Icons.local_fire_department),
                        label: const Text('Bắt đầu'),
                      ),
                      KitchenStatus.COOKING => FilledButton.icon(
                        onPressed: () => onSet(i, KitchenStatusDtoStatusEnum.READY),
                        icon: const Icon(Icons.check),
                        label: const Text('Xong'),
                      ),
                      KitchenStatus.READY => FilledButton.tonalIcon(
                        onPressed: () => onSet(i, KitchenStatusDtoStatusEnum.SERVED),
                        icon: const Icon(Icons.room_service),
                        label: const Text('Đã bưng'),
                      ),
                      _ => const SizedBox.shrink(),
                    },
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
