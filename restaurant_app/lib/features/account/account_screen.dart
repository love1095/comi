import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';

/// Staff account deletion (store rule) — the restaurant keeps its data.
abstract class StaffAccountRepository {
  Future<void> delete();
}

class ApiStaffAccountRepository implements StaffAccountRepository {
  ApiStaffAccountRepository(this._ref);
  final Ref _ref;

  @override
  Future<void> delete() => _ref.read(apiProvider).getAuthApi().staffAccountRemove();
}

final staffAccountRepositoryProvider = Provider<StaffAccountRepository>((ref) => ApiStaffAccountRepository(ref));

final openUrlProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.externalApplication),
);

class StaffAccountScreen extends ConsumerWidget {
  const StaffAccountScreen({super.key});

  void _open(WidgetRef ref, String doc) => ref.read(openUrlProvider)(Uri.parse('${ref.read(apiBaseUrlProvider)}/api/v1/legal/$doc'));

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Xoá tài khoản nhân viên?'),
        content: const Text('Bạn sẽ rời khỏi mọi quán và không đăng nhập được nữa. Dữ liệu của quán vẫn được giữ. Không thể hoàn tác.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Huỷ')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(c).colorScheme.error),
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Xoá vĩnh viễn'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await ref.read(staffAccountRepositoryProvider).delete();
      await ref.read(sessionProvider.notifier).logout();
    } catch (e) {
      final err = ApiError.from(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              err.code == 'SOLE_OWNER' ? 'Bạn là chủ quán duy nhất: hãy thêm chủ quán khác trước khi xoá tài khoản' : err.userMessage,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = Theme.of(context).colorScheme.error;
    return Scaffold(
      appBar: AppBar(title: const Text('Tài khoản')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Quyền riêng tư'),
            onTap: () => _open(ref, 'privacy'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Điều khoản sử dụng'),
            onTap: () => _open(ref, 'terms'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined, color: error),
            title: Text('Xoá tài khoản', style: TextStyle(color: error)),
            onTap: () => _delete(context, ref),
          ),
        ],
      ),
    );
  }
}
