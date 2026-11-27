import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/api_error.dart';
import 'group_repository.dart';

/// Who pays what (§8.5). The host picks equal or by-items; the restaurant marks cash payments.
class SplitScreen extends ConsumerStatefulWidget {
  const SplitScreen({super.key, required this.bookingId});
  final String bookingId;

  @override
  ConsumerState<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends ConsumerState<SplitScreen> {
  var _busy = false;

  Future<void> _choose(SplitMode mode) async {
    setState(() => _busy = true);
    try {
      await ref.read(groupRepositoryProvider).saveSplit(widget.bookingId, mode);
      ref.invalidate(splitProvider(widget.bookingId));
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.code == 'SPLIT_MISMATCH' ? 'Không chia được: tổng tiền ít hơn các món đã gọi' : err.userMessage)),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final split = ref.watch(splitProvider(widget.bookingId));
    return Scaffold(
      appBar: AppBar(title: const Text('Chia hoá đơn')),
      body: split.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (s) {
          final current = s.mode == null ? null : SplitMode.values.byName(s.mode!.value);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Tổng hoá đơn: ${formatVnd(s.total)}', style: theme.textTheme.titleLarge),
              if (s.paid > 0) Text('Đã thu: ${formatVnd(s.paid)}', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 12),
              SegmentedButton<SplitMode>(
                emptySelectionAllowed: true,
                showSelectedIcon: false,
                segments: [
                  for (final m in const [SplitMode.EQUAL, SplitMode.BY_ITEMS]) ButtonSegment(value: m, label: Text(splitModeLabel(m))),
                ],
                selected: {?current},
                onSelectionChanged: _busy ? null : (v) => v.isEmpty ? null : _choose(v.first),
              ),
              const SizedBox(height: 4),
              Text(
                current == SplitMode.BY_ITEMS
                    ? 'Mỗi người trả món mình gọi, món chung (và món gọi ngoài app) chia đều.'
                    : 'Chia đều cho mọi người trong nhóm.',
                style: theme.textTheme.bodySmall,
              ),
              const Divider(height: 32),
              if (s.guests.isEmpty) const Text('Chọn cách chia để xem mỗi người trả bao nhiêu.'),
              for (final g in s.guests)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    g.paidAt != null ? Icons.check_circle : Icons.person_outline,
                    color: g.paidAt != null ? ComiColors.available : null,
                  ),
                  title: Text('${g.displayName}${g.isHost ? ' (chủ bàn)' : ''}'),
                  subtitle: Text(g.paidAt != null ? 'Đã trả' : 'Chưa trả'),
                  trailing: Text(formatVnd(g.amountDue), style: theme.textTheme.titleMedium),
                ),
              const SizedBox(height: 8),
              Text('Trả tiền mặt hoặc chuyển khoản cho quán; nhân viên đánh dấu từng người đã trả.', style: theme.textTheme.bodySmall),
            ],
          );
        },
      ),
    );
  }
}

/// Ride apps (§8.5 "Get home safe"). Their websites open the app when installed.
/// ⬜ Official deep links with the destination prefilled need partner agreements.
const rideApps = [
  (name: 'Grab', url: 'https://www.grab.com/vn/'),
  (name: 'Be', url: 'https://be.com.vn/'),
  (name: 'Xanh SM', url: 'https://www.xanhsm.com/'),
];

final openUrlProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.externalApplication),
);

class GetHomeSafeCard extends ConsumerWidget {
  const GetHomeSafeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_taxi_outlined),
                const SizedBox(width: 8),
                Text('Về nhà an toàn', style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 4),
            const Text('Đã uống rượu bia thì đừng lái xe — gọi xe về nhé.'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final app in rideApps)
                  OutlinedButton(onPressed: () => ref.read(openUrlProvider)(Uri.parse(app.url)), child: Text(app.name)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
