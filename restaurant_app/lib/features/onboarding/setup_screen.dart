import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/home_shell.dart';
import '../../data/api_error.dart';
import '../../data/session.dart';
import 'location_screen.dart';
import 'onboarding_repository.dart';
import 'opening_hours_screen.dart';

/// Setup checklist (§22.2): location → hours → tables → menu → send for review.
class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  var _submitting = false;

  void _refresh() {
    ref.invalidate(profileProvider);
    ref.invalidate(checklistProvider);
  }

  Future<void> _open(Widget screen) async {
    await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => screen));
    _refresh();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref.read(onboardingRepositoryProvider).submit(ref.read(restaurantIdProvider));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã gửi duyệt. comi sẽ liên hệ trong 1–2 ngày làm việc.')));
      }
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.code == 'RESTAURANT_INCOMPLETE' ? 'Còn bước chưa xong' : err.userMessage)));
      }
    } finally {
      _refresh();
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final checklist = ref.watch(checklistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Thiết lập quán'), actions: const [AccountMenu()]),
      body: switch ((profile, checklist)) {
        (AsyncData(value: final p), AsyncData(value: final c)) => _body(p, c),
        (AsyncError(:final error), _) || (_, AsyncError(:final error)) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(error).userMessage, maxLines: 4, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
              TextButton(onPressed: _refresh, child: const Text('Thử lại')),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _body(RestaurantProfileDto p, ChecklistDto c) {
    final theme = Theme.of(context);
    bool done(String key) => !c.missing.contains(key);
    final canSubmit = c.complete && (p.status == RestaurantStatus.DRAFT || p.status == RestaurantStatus.REJECTED);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StatusCard(profile: p),
            const SizedBox(height: 16),
            _Step(n: 1, title: 'Thông tin quán', subtitle: '${p.name} · ${p.address}', done: true),
            _Step(
              n: 2,
              title: 'Vị trí trên bản đồ',
              subtitle: done('location') ? 'Đã ghim vị trí' : 'Để khách tìm thấy quán gần họ',
              done: done('location'),
              onTap: () => _open(LocationScreen(profile: p)),
            ),
            _Step(
              n: 3,
              title: 'Giờ mở cửa',
              subtitle: done('openingHours')
                  ? '${p.openingHours.map((h) => h.weekday).toSet().length} ngày mỗi tuần'
                  : 'Khách chỉ đặt được trong giờ mở cửa',
              done: done('openingHours'),
              onTap: () => _open(OpeningHoursScreen(initial: p.openingHours)),
            ),
            _Step(
              n: 4,
              title: 'Sơ đồ bàn',
              subtitle: done('tables') ? 'Đã có bàn' : 'Vẽ khu vực và bàn, in mã QR',
              done: done('tables'),
              onTap: () => context.go('/areas'),
            ),
            _Step(
              n: 5,
              title: 'Thực đơn',
              subtitle: done('menuItems') ? 'Đã có món' : 'Nhập từ Excel hoặc thêm từng món, có ảnh',
              done: done('menuItems'),
              onTap: () => context.go('/menu'),
            ),
            const SizedBox(height: 24),
            if (p.status == RestaurantStatus.DRAFT || p.status == RestaurantStatus.REJECTED) ...[
              FilledButton.icon(
                onPressed: canSubmit && !_submitting ? _submit : null,
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                icon: const Icon(Icons.send),
                label: Text(_submitting ? 'Đang gửi…' : 'Gửi comi duyệt'),
              ),
              if (!c.complete)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Hoàn tất các bước trên để gửi duyệt', textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.profile});
  final RestaurantProfileDto profile;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (icon, color, title, body) = switch (profile.status) {
      RestaurantStatus.DRAFT => (Icons.edit_note, scheme.primary, 'Đang thiết lập', 'Hoàn tất các bước bên dưới rồi gửi duyệt.'),
      RestaurantStatus.PENDING_REVIEW => (
        Icons.hourglass_top,
        Colors.orange,
        'Đang chờ duyệt',
        'comi đang kiểm tra thông tin quán. Bạn vẫn có thể sửa thực đơn và sơ đồ bàn.',
      ),
      RestaurantStatus.ACTIVE => (Icons.check_circle, Colors.green, 'Đang hoạt động', 'Khách đã có thể tìm và đặt bàn.'),
      RestaurantStatus.PAUSED => (Icons.pause_circle, scheme.outline, 'Tạm ngưng', 'Liên hệ comi để mở lại.'),
      RestaurantStatus.REJECTED => (
        Icons.error_outline,
        scheme.error,
        'Chưa được duyệt',
        profile.rejectReason ?? 'Sửa theo góp ý rồi gửi lại.',
      ),
    };
    return Card(
      color: color.withValues(alpha: 0.12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(title),
        subtitle: Text(body),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.n, required this.title, required this.subtitle, required this.done, this.onTap});
  final int n;
  final String title;
  final String subtitle;
  final bool done;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: done ? Colors.green : scheme.surfaceContainerHighest,
        foregroundColor: done ? Colors.white : scheme.onSurface,
        child: done ? const Icon(Icons.check) : Text('$n'),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: onTap == null ? null : const Icon(Icons.chevron_right),
    );
  }
}

/// Board banner while the restaurant is not live yet.
class SetupBanner extends ConsumerWidget {
  const SetupBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.watch(profileProvider).value;
    if (p == null || p.status == RestaurantStatus.ACTIVE) return const SizedBox.shrink();
    final text = switch (p.status) {
      RestaurantStatus.PENDING_REVIEW => 'Quán đang chờ comi duyệt',
      RestaurantStatus.REJECTED => 'Quán chưa được duyệt — xem góp ý',
      RestaurantStatus.PAUSED => 'Quán đang tạm ngưng',
      _ => 'Quán chưa mở cho khách — hoàn tất thiết lập',
    };
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        leading: const Icon(Icons.storefront),
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go('/setup'),
      ),
    );
  }
}
