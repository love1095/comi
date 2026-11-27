import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';

final myRestaurantsProvider = FutureProvider.autoDispose<List<MembershipDto>>((ref) async {
  return (await ref.watch(apiProvider).getRestaurantApi().restaurantMine()).data ?? const [];
});

String roleName(StaffRole r) => switch (r) {
  StaffRole.OWNER => 'Chủ quán',
  StaffRole.MANAGER => 'Quản lý',
  StaffRole.CASHIER => 'Thu ngân',
  StaffRole.KITCHEN => 'Bếp',
};

String statusName(RestaurantStatus s) => switch (s) {
  RestaurantStatus.DRAFT => 'Đang thiết lập',
  RestaurantStatus.PENDING_REVIEW => 'Chờ duyệt',
  RestaurantStatus.ACTIVE => 'Đang hoạt động',
  RestaurantStatus.PAUSED => 'Tạm ngưng',
  RestaurantStatus.REJECTED => 'Bị từ chối',
};

/// Staff can belong to several restaurants; pick the one to manage. One → picked automatically.
class RestaurantPickerScreen extends ConsumerWidget {
  const RestaurantPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(myRestaurantsProvider, (_, next) {
      final list = next.value;
      if (list != null && list.length == 1) {
        ref.read(sessionProvider.notifier).selectRestaurant(list.first.restaurant.id, list.first.restaurant.name);
      }
    });
    final async = ref.watch(myRestaurantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn quán'),
        actions: [TextButton(onPressed: () => ref.read(sessionProvider.notifier).logout(), child: const Text('Đăng xuất'))],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(myRestaurantsProvider), child: const Text('Thử lại')),
            ],
          ),
        ),
        data: (list) => list.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.storefront, size: 56),
                      const SizedBox(height: 12),
                      const Text('Tài khoản chưa thuộc quán nào.', textAlign: TextAlign.center),
                      const Text('Chủ quán: đăng ký quán mới. Nhân viên: nhờ chủ quán mời vào.', textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => context.go('/restaurants/new'),
                        icon: const Icon(Icons.add_business),
                        label: const Text('Đăng ký quán mới'),
                      ),
                    ],
                  ),
                ),
              )
            : ListView(
                children: [
                  for (final m in list)
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.storefront)),
                      title: Text(m.restaurant.name),
                      subtitle: Text('${roleName(m.role)} · ${statusName(m.restaurant.status)}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => ref.read(sessionProvider.notifier).selectRestaurant(m.restaurant.id, m.restaurant.name),
                    ),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.add)),
                    title: const Text('Đăng ký quán mới'),
                    onTap: () => context.go('/restaurants/new'),
                  ),
                ],
              ),
      ),
    );
  }
}
