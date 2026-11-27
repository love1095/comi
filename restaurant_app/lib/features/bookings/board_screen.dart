import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../app/home_shell.dart';
import '../../data/api_error.dart';
import '../../data/session.dart';
import '../onboarding/setup_screen.dart' show SetupBanner;
import 'booking_widgets.dart';
import 'bookings_repository.dart';

/// Today board: every booking of the day by arrival time, groups waiting for approval on top.
class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  var _filter = BoardFilter.all;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.text = ref.read(boardSearchProvider);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final current = DateTime.parse(ref.read(boardDateProvider));
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: current.subtract(const Duration(days: 365)),
      lastDate: current.add(const Duration(days: 365)),
    );
    if (picked != null) {
      ref
          .read(boardDateProvider.notifier)
          .set(
            '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}',
          );
    }
  }

  Future<void> _approve(BoardBookingDto b) async {
    final ok = await runBookingAction(context, () => ref.read(bookingsRepositoryProvider).approve(b.id), done: 'Đã duyệt đơn ${b.code}');
    if (ok) ref.invalidate(boardBookingsProvider);
  }

  Future<void> _reject(BoardBookingDto b) async {
    final reason = await askCancelReason(context, title: 'Từ chối đơn ${b.code}?', reasons: rejectReasons);
    if (reason == null || !mounted) return;
    final ok = await runBookingAction(
      context,
      () => ref.read(bookingsRepositoryProvider).cancel(b.id, reason),
      done: 'Đã từ chối đơn ${b.code}',
    );
    if (ok) ref.invalidate(boardBookingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider).value;
    final date = ref.watch(boardDateProvider);
    final bookings = ref.watch(boardBookingsProvider);
    final isToday = date == vietnamDate();

    return Scaffold(
      appBar: AppBar(
        title: Text(session?.restaurantName ?? 'comi'),
        actions: [
          IconButton(tooltip: 'Tải lại', onPressed: () => ref.invalidate(boardBookingsProvider), icon: const Icon(Icons.refresh)),
          const AccountMenu(),
        ],
      ),
      body: Column(
        children: [
          const SetupBanner(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: _HeaderLayout(
              dateControls: [
                IconButton(
                  tooltip: 'Hôm trước',
                  onPressed: () => ref.read(boardDateProvider.notifier).shift(-1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Flexible(
                  child: TextButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(dayLabel(date), overflow: TextOverflow.ellipsis),
                  ),
                ),
                IconButton(
                  tooltip: 'Hôm sau',
                  onPressed: () => ref.read(boardDateProvider.notifier).shift(1),
                  icon: const Icon(Icons.chevron_right),
                ),
                if (!isToday)
                  IconButton(
                    tooltip: 'Về hôm nay',
                    onPressed: () => ref.read(boardDateProvider.notifier).set(vietnamDate()),
                    icon: const Icon(Icons.today),
                  ),
              ],
              search: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Mã đơn hoặc SĐT',
                  border: const OutlineInputBorder(),
                  suffixIcon: _search.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Xoá',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _search.clear();
                            ref.read(boardSearchProvider.notifier).set('');
                            setState(() {});
                          },
                        ),
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (v) => ref.read(boardSearchProvider.notifier).set(v),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                for (final f in BoardFilter.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_chipLabel(f, bookings.value)),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(boardBookingsProvider.future),
              child: bookings.when(
                skipLoadingOnRefresh: true,
                skipLoadingOnReload: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ListView(
                  children: [
                    const SizedBox(height: 120),
                    Center(child: Text(ApiError.from(e).userMessage)),
                    Center(
                      child: TextButton(onPressed: () => ref.invalidate(boardBookingsProvider), child: const Text('Thử lại')),
                    ),
                  ],
                ),
                data: (list) => _BoardList(
                  all: list,
                  filter: _filter,
                  onOpen: (b) => context.go('/board/${b.id}'),
                  onApprove: _approve,
                  onReject: _reject,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _chipLabel(BoardFilter f, List<BoardBookingDto>? list) {
    if (list == null) return f.label;
    final n = list.where(f.matches).length;
    return '${f.label} ($n)';
  }
}

class _BoardList extends StatelessWidget {
  const _BoardList({required this.all, required this.filter, required this.onOpen, required this.onApprove, required this.onReject});

  final List<BoardBookingDto> all;
  final BoardFilter filter;
  final void Function(BoardBookingDto) onOpen;
  final void Function(BoardBookingDto) onApprove;
  final void Function(BoardBookingDto) onReject;

  @override
  Widget build(BuildContext context) {
    final summary = BoardSummary(all);
    final approvals = all.where((b) => b.status == BookingStatus.PENDING && b.needsApproval).toList();
    final shown = all.where(filter.matches).toList();
    final showApprovals = approvals.isNotEmpty && (filter == BoardFilter.all || filter == BoardFilter.pending);
    final rest = showApprovals ? shown.where((b) => !approvals.contains(b)).toList() : shown;

    final children = <Widget>[
      _SummaryRow(summary: summary),
      if (showApprovals) ...[
        _SectionHeader('Nhóm đông chờ duyệt (${approvals.length})', icon: Icons.groups, warn: true),
        for (final b in approvals)
          ApprovalCard(booking: b, onOpen: () => onOpen(b), onApprove: () => onApprove(b), onReject: () => onReject(b)),
      ],
    ];

    String? hour;
    for (final b in rest) {
      final h = '${formatLocalTime(DateTime.parse(b.arrivalAt)).substring(0, 2)}:00';
      if (h != hour) {
        hour = h;
        children.add(_SectionHeader(h));
      }
      children.add(BookingTile(booking: b, onTap: () => onOpen(b)));
    }

    if (rest.isEmpty && !showApprovals) {
      children.addAll(const [
        SizedBox(height: 80),
        Icon(Icons.event_available_outlined, size: 56),
        SizedBox(height: 12),
        Center(child: Text('Không có đơn đặt bàn nào')),
      ]);
    }

    return ListView(padding: const EdgeInsets.only(bottom: 32), children: children);
  }
}

/// Date controls and search on one line on tablets, two lines on phones.
class _HeaderLayout extends StatelessWidget {
  const _HeaderLayout({required this.dateControls, required this.search});
  final List<Widget> dateControls;
  final Widget search;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      if (c.maxWidth >= 640) {
        return Row(
          children: [
            ...dateControls,
            const SizedBox(width: 8),
            Expanded(child: search),
          ],
        );
      }
      return Column(
        children: [
          Row(children: dateControls),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: search),
        ],
      );
    },
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.summary});
  final BoardSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget stat(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(value, style: theme.textTheme.titleLarge),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          stat('${summary.bookings}', 'đơn'),
          stat('${summary.guests}', 'khách'),
          stat('${summary.pending}', 'chờ duyệt'),
          stat(formatVnd(summary.preOrderTotal), 'đặt món trước'),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text, {this.icon, this.warn = false});
  final String text;
  final IconData? icon;
  final bool warn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = warn ? theme.colorScheme.error : theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          if (icon != null) ...[Icon(icon, size: 18, color: color), const SizedBox(width: 6)],
          Text(text, style: theme.textTheme.titleSmall?.copyWith(color: color)),
        ],
      ),
    );
  }
}

/// `Hôm nay · 02/12` / `T4 · 03/12`.
String dayLabel(String date, {DateTime? now}) {
  final d = DateTime.parse(date);
  final dm = '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  if (date == vietnamDate(now: now)) return 'Hôm nay · $dm';
  if (date == vietnamDate(days: 1, now: now)) return 'Ngày mai · $dm';
  if (date == vietnamDate(days: -1, now: now)) return 'Hôm qua · $dm';
  const names = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  return '${names[d.weekday - 1]} · $dm';
}
