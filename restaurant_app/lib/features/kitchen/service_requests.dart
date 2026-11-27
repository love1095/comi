import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../bookings/booking_widgets.dart' show runBookingAction;
import 'kitchen_repository.dart';

/// Bell with the number of open guest requests (more ice, bill please…). Tap → list.
class ServiceRequestsButton extends ConsumerWidget {
  const ServiceRequestsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(serviceRequestsProvider).value ?? const <ServiceRequestDto>[];
    return IconButton(
      tooltip: 'Yêu cầu của khách',
      onPressed: () => showModalBottomSheet<void>(context: context, builder: (_) => const ServiceRequestsSheet()),
      icon: Badge(isLabelVisible: open.isNotEmpty, label: Text('${open.length}'), child: const Icon(Icons.notifications_outlined)),
    );
  }
}

class ServiceRequestsSheet extends ConsumerWidget {
  const ServiceRequestsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(serviceRequestsProvider);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: Text('Yêu cầu của khách', style: Theme.of(context).textTheme.titleMedium)),
          const Divider(height: 1),
          Flexible(
            child: requests.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => const Padding(padding: EdgeInsets.all(32), child: Text('Không tải được')),
              data: (list) => list.isEmpty
                  ? const Padding(padding: EdgeInsets.all(32), child: Text('Không có yêu cầu nào'))
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        for (final r in list)
                          ListTile(
                            leading: Icon(_icon(r.type)),
                            title: Text('${r.tableCode == null ? r.bookingCode : 'Bàn ${r.tableCode}'} · ${serviceLabel(r.type)}'),
                            subtitle: Text([formatLocalTime(DateTime.parse(r.createdAt)), if (r.note != null) r.note!].join(' · ')),
                            trailing: FilledButton(
                              onPressed: () async {
                                final ok = await runBookingAction(
                                  context,
                                  () => ref.read(kitchenRepositoryProvider).finishRequest(r.id),
                                  done: 'Đã xong: ${serviceLabel(r.type)}',
                                );
                                if (ok) ref.invalidate(serviceRequestsProvider);
                              },
                              child: const Text('Xong'),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _icon(ServiceType t) => switch (t) {
    ServiceType.MORE_ICE => Icons.ac_unit,
    ServiceType.MORE_BOWLS => Icons.rice_bowl_outlined,
    ServiceType.BILL_PLEASE => Icons.receipt_long,
    ServiceType.CALL_WAITER => Icons.waving_hand_outlined,
    ServiceType.OTHER => Icons.help_outline,
  };
}
