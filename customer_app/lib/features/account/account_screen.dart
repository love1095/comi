import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/session.dart';
import '../booking/bookings_repository.dart';

final meProvider = FutureProvider.autoDispose<MeDto?>((ref) async {
  final loggedIn = ref.watch(sessionProvider).value?.loggedIn ?? false;
  if (!loggedIn) return null;
  return ref.watch(bookingsRepositoryProvider).me();
});

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider);
    final user = me.value;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tài khoản')),
      body: ListView(
        children: [
          if (user == null && !me.isLoading)
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_outline)),
              title: const Text('Chưa đăng nhập'),
              subtitle: const Text('Đăng nhập để đặt bàn và xem lịch sử'),
              trailing: FilledButton(onPressed: () => context.push('/login'), child: const Text('Đăng nhập')),
            ),
          if (user != null) ...[
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user.name ?? 'Bạn'),
              subtitle: Text(user.phone ?? user.email ?? ''),
            ),
            if (user.noShowCount > 0)
              ListTile(
                leading: Icon(Icons.warning_amber, color: theme.colorScheme.error),
                title: Text('Đã vắng mặt ${user.noShowCount} lần'),
                subtitle: Text(user.mustPrepay ? 'Các lần đặt sau cần trả trước' : 'Vắng nhiều lần sẽ phải trả trước khi đặt'),
              ),
          ],
          const Divider(),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Ngôn ngữ'),
            subtitle: Text('Tiếng Việt (sắp có English, 한국어, 中文, 日本語)'),
          ),
          const ListTile(leading: Icon(Icons.help_outline), title: Text('Hỗ trợ'), subtitle: Text('Sắp có')),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () => ref.read(sessionProvider.notifier).logout(),
            ),
        ],
      ),
    );
  }
}
