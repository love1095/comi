import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/language.dart';
import '../../data/session.dart';
import '../booking/bookings_repository.dart';
import 'privacy.dart';

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
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.language),
            subtitle: Text(appLanguages[ref.watch(appLanguageProvider)]!),
            onTap: () => showModalBottomSheet<void>(
              context: context,
              builder: (c) => SafeArea(
                child: RadioGroup<String>(
                  groupValue: ref.read(appLanguageProvider),
                  onChanged: (v) {
                    if (v != null) ref.read(appLanguageProvider.notifier).set(v);
                    Navigator.pop(c);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [for (final e in appLanguages.entries) RadioListTile<String>(value: e.key, title: Text(e.value))],
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Quyền riêng tư'),
            onTap: () => openLegal(ref, 'privacy'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Điều khoản sử dụng'),
            onTap: () => openLegal(ref, 'terms'),
          ),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.download_outlined),
              title: const Text('Dữ liệu của tôi'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const MyDataScreen())),
            ),
          const ListTile(leading: Icon(Icons.help_outline), title: Text('Hỗ trợ'), subtitle: Text('support@comi.vn')),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () => ref.read(sessionProvider.notifier).logout(),
            ),
          if (user != null)
            ListTile(
              leading: Icon(Icons.delete_forever_outlined, color: Theme.of(context).colorScheme.error),
              title: Text('Xoá tài khoản', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => confirmDeleteAccount(context, ref),
            ),
        ],
      ),
    );
  }
}
