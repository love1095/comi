import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/admin_repository.dart';
import 'common.dart';

final dashboardProvider = FutureProvider.autoDispose<AdminDashboardDto>((ref) => ref.watch(adminRepositoryProvider).dashboard());

const restaurantStatusLabel = {
  'PENDING_REVIEW': 'Chờ duyệt',
  'ACTIVE': 'Đang hoạt động',
  'PAUSED': 'Tạm dừng',
  'REJECTED': 'Từ chối',
  'DRAFT': 'Nháp',
};

/// Overview: what needs attention today.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key, required this.go});

  /// Jump to another page (index in the shell).
  final ValueChanged<int> go;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      PageHeader(
        'Tổng quan',
        actions: [IconButton(tooltip: 'Tải lại', onPressed: () => ref.invalidate(dashboardProvider), icon: const Icon(Icons.refresh))],
      ),
      Expanded(
        child: AsyncPage(
          value: ref.watch(dashboardProvider),
          onRetry: () => ref.invalidate(dashboardProvider),
          data: (d) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Stat(
                    'Quán chờ duyệt',
                    '${d.restaurants['PENDING_REVIEW'] ?? 0}',
                    alert: (d.restaurants['PENDING_REVIEW'] ?? 0) > 0,
                    onTap: () => go(1),
                  ),
                  _Stat('Đánh giá bị báo cáo', '${d.reportedReviews}', alert: d.reportedReviews > 0, onTap: () => go(2)),
                  _Stat('Phí quá hạn', '${d.overdueStatements}', alert: d.overdueStatements > 0, onTap: () => go(5)),
                  _Stat('Hoàn tiền đang chờ', '${d.pendingRefunds}', alert: d.pendingRefunds > 0),
                  _Stat('Quán hoạt động', '${d.restaurants['ACTIVE'] ?? 0}'),
                  _Stat('Đơn hôm nay', '${d.bookingsToday}'),
                  _Stat('Đơn tháng này', '${d.bookingsMonth}'),
                  _Stat('Giá trị đơn tháng này', formatVnd(d.gmvMonth)),
                  _Stat('Vắng mặt tháng này', '${d.noShowsMonth}'),
                  _Stat('Khách mới tháng này', '${d.newUsersMonth}'),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value, {this.alert = false, this.onTap});
  final String label;
  final String value;
  final bool alert;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 220,
      child: Card(
        color: alert ? theme.colorScheme.errorContainer : null,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.labelLarge),
                const SizedBox(height: 6),
                Text(value, style: theme.textTheme.headlineMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final restaurantStatusFilterProvider = NotifierProvider<_StatusFilter, String>(_StatusFilter.new);

class _StatusFilter extends Notifier<String> {
  @override
  String build() => 'PENDING_REVIEW';
  void set(String s) => state = s;
}

final adminRestaurantsProvider = FutureProvider.autoDispose<List<AdminRestaurantRowDto>>(
  (ref) => ref.watch(adminRepositoryProvider).restaurants(ref.watch(restaurantStatusFilterProvider)),
);

/// Restaurant review queue (§18.4): open one, check the profile, approve / reject with a reason / pause.
class RestaurantsPage extends ConsumerWidget {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(restaurantStatusFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PageHeader('Quán'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 8,
            children: [
              for (final s in ['PENDING_REVIEW', 'ACTIVE', 'PAUSED', 'REJECTED'])
                ChoiceChip(
                  label: Text(restaurantStatusLabel[s]!),
                  selected: s == status,
                  onSelected: (_) => ref.read(restaurantStatusFilterProvider.notifier).set(s),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: AsyncPage(
            value: ref.watch(adminRestaurantsProvider),
            onRetry: () => ref.invalidate(adminRestaurantsProvider),
            data: (rows) => rows.isEmpty
                ? const Center(child: Text('Không có quán nào'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: rows.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final r = rows[i];
                      return ListTile(
                        title: Text(r.name),
                        subtitle: Text('${r.address} · ${r.phone}${r.submittedAt == null ? '' : ' · gửi ${date(r.submittedAt!)}'}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showDialog<void>(
                          context: context,
                          builder: (_) => RestaurantReviewDialog(id: r.id),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

final adminRestaurantProvider = FutureProvider.autoDispose.family<RestaurantProfileDto, String>(
  (ref, id) => ref.watch(adminRepositoryProvider).restaurant(id),
);

class RestaurantReviewDialog extends ConsumerWidget {
  const RestaurantReviewDialog({super.key, required this.id});
  final String id;

  Future<void> _act(BuildContext context, WidgetRef ref, Future<Object?> Function() action, String done) async {
    if (await runAction(context, action, done: done)) {
      ref.invalidate(adminRestaurantsProvider);
      ref.invalidate(dashboardProvider);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(adminRepositoryProvider);
    final value = ref.watch(adminRestaurantProvider(id));
    final r = value.value;
    return AlertDialog(
      title: Text(r?.name ?? 'Quán'),
      content: SizedBox(
        width: 520,
        child: AsyncPage(
          value: value,
          onRetry: () => ref.invalidate(adminRestaurantProvider(id)),
          data: (r) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Row('Trạng thái', restaurantStatusLabel[r.status.value] ?? r.status.value),
                _Row('Địa chỉ', r.address),
                _Row('Điện thoại', r.phone),
                _Row('Toạ độ', r.lat == null ? 'Chưa có' : '${r.lat!.toStringAsFixed(5)}, ${r.lng!.toStringAsFixed(5)}'),
                _Row('Loại món', r.cuisineTags.isEmpty ? '—' : r.cuisineTags.join(', ')),
                _Row('Mức giá', '₫' * r.priceLevel.toInt()),
                _Row('Giờ mở cửa', r.openingHours.isEmpty ? 'Chưa nhập' : '${r.openingHours.length} khung giờ'),
                _Row('Trả tại quán', r.allowCod ? 'Có' : 'Không'),
                if (r.description != null) _Row('Giới thiệu', r.description!),
                if (r.rejectReason != null) _Row('Lý do từ chối trước', r.rejectReason!),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
        if (r?.status == RestaurantStatus.PENDING_REVIEW)
          TextButton(
            onPressed: () async {
              final reason = await askText(context, title: 'Từ chối ${r!.name}', label: 'Lý do (quán sẽ thấy)', ok: 'Từ chối');
              if (reason != null && context.mounted) await _act(context, ref, () => repo.reject(id, reason), 'Đã từ chối');
            },
            child: const Text('Từ chối'),
          ),
        if (r?.status == RestaurantStatus.ACTIVE)
          TextButton(
            onPressed: () async {
              if (await confirm(
                    context,
                    'Tạm dừng ${r!.name}?',
                    'Quán sẽ không hiện với khách cho đến khi được duyệt lại.',
                    ok: 'Tạm dừng',
                  ) &&
                  context.mounted) {
                await _act(context, ref, () => repo.pause(id), 'Đã tạm dừng');
              }
            },
            child: const Text('Tạm dừng'),
          ),
        if (r?.status == RestaurantStatus.PENDING_REVIEW || r?.status == RestaurantStatus.PAUSED)
          FilledButton(onPressed: () => _act(context, ref, () => repo.approve(id), 'Đã duyệt ${r!.name}'), child: const Text('Duyệt')),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(label, style: Theme.of(context).textTheme.labelLarge)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

final reportedReviewsProvider = FutureProvider.autoDispose<List<ReviewDto>>((ref) => ref.watch(adminRepositoryProvider).reportedReviews());

/// Reviews reported by restaurants (§15): hide or keep.
class ReportedReviewsPage extends ConsumerWidget {
  const ReportedReviewsPage({super.key});

  Future<void> _decide(BuildContext context, WidgetRef ref, ReviewDto r, bool hide) async {
    if (await runAction(
      context,
      () => ref.read(adminRepositoryProvider).decideReview(r.id, hide: hide),
      done: hide ? 'Đã ẩn đánh giá' : 'Đã giữ đánh giá',
    )) {
      ref.invalidate(reportedReviewsProvider);
      ref.invalidate(dashboardProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const PageHeader('Đánh giá bị báo cáo'),
      Expanded(
        child: AsyncPage(
          value: ref.watch(reportedReviewsProvider),
          onRetry: () => ref.invalidate(reportedReviewsProvider),
          data: (rows) => rows.isEmpty
              ? const Center(child: Text('Không có đánh giá nào cần xem'))
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    for (final r in rows)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${r.authorName} · ${'★' * r.rating.toInt()} · đến quán ${date(r.visitedAt)}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              if (r.text != null) Padding(padding: const EdgeInsets.only(top: 6), child: Text(r.text!)),
                              if (r.reply != null) Text('Quán trả lời: ${r.reply}', style: Theme.of(context).textTheme.bodySmall),
                              if (r.reportReason != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Lý do quán báo cáo: ${r.reportReason}',
                                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: () => _decide(context, ref, r, false), child: const Text('Giữ lại')),
                                  const SizedBox(width: 8),
                                  FilledButton(onPressed: () => _decide(context, ref, r, true), child: const Text('Ẩn')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    ],
  );
}
