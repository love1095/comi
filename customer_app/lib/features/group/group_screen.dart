import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../booking/bookings_repository.dart' show arrivalLabel;
import '../discovery/discovery_repository.dart';
import 'group_repository.dart';

/// Shared cart of a group order (§8.4): everyone adds their own dishes until the cutoff.
/// Opened from the host's booking or from a share link `/g/{token}`.
class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({super.key, required this.token});
  final String token;

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  ({String guestId, String guestKey})? _me;
  var _keyLoaded = false;
  final _name = TextEditingController();
  final _qty = <String, int>{};
  var _busy = false;

  GroupRepository get _repo => ref.read(groupRepositoryProvider);

  @override
  void initState() {
    super.initState();
    ref.read(groupKeyStoreProvider).read(widget.token).then((k) {
      if (mounted) {
        setState(() {
          _me = k;
          _keyLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _toast(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
      ref.invalidate(groupProvider(widget.token));
    } catch (e) {
      final err = ApiError.from(e);
      if (err.code == 'GUEST_KEY_INVALID') {
        await ref.read(groupKeyStoreProvider).clear(widget.token);
        if (mounted) setState(() => _me = null);
      }
      if (mounted) _toast(_groupError(err));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _join() => _run(() async {
    final name = _name.text.trim();
    if (name.isEmpty) throw const ApiError('VALIDATION_FAILED', 'Nhập tên của bạn');
    final r = await _repo.join(widget.token, name);
    await ref.read(groupKeyStoreProvider).write(widget.token, r.guestId!, r.guestKey);
    if (mounted) setState(() => _me = (guestId: r.guestId!, guestKey: r.guestKey));
  });

  Future<void> _send(List<PublicMenuCategoryDto> menu) async {
    final dishes = {
      for (final c in menu)
        for (final i in c.items) i.id: i,
    };
    final lines = [
      for (final e in _qty.entries)
        if (e.value > 0 && dishes[e.key] != null)
          CartLineDto(
            menuItemId: e.key,
            quantity: e.value,
            optionIds: [
              for (final g in dishes[e.key]!.optionGroups)
                if (g.minSelect > 0 && g.options.isNotEmpty) g.options.first.id,
            ],
          ),
    ];
    var age = false;
    if (lines.any((l) => dishes[l.menuItemId]!.isAlcohol)) {
      age =
          await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text('Đồ uống có cồn'),
              content: const Text('Bạn xác nhận đã đủ 18 tuổi?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Không')),
                FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Đủ 18 tuổi')),
              ],
            ),
          ) ??
          false;
      if (!age) return;
    }
    await _run(() async {
      await _repo.addItems(widget.token, _me!.guestKey, lines, ageConfirmed: age ? true : null);
      _qty.clear();
      if (mounted) _toast('Đã thêm món của bạn');
    });
  }

  @override
  Widget build(BuildContext context) {
    final group = ref.watch(groupProvider(widget.token));
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt món cùng nhóm')),
      body: group.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(_groupError(ApiError.from(e)))),
        data: (g) => _body(g),
      ),
      bottomNavigationBar: _sendBar(group.value),
    );
  }

  Widget? _sendBar(GroupViewDto? g) {
    final n = _qty.values.fold(0, (s, q) => s + q);
    if (g == null || g.locked || _me == null || n == 0) return null;
    final menu = ref.watch(menuProvider(g.restaurant.id)).value ?? const [];
    final prices = {
      for (final c in menu)
        for (final i in c.items) i.id: i.price,
    };
    final total = _qty.entries.fold<num>(0, (s, e) => s + (prices[e.key] ?? 0) * e.value);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: _busy ? null : () => _send(menu),
          child: Text('Gửi $n món · ${formatVnd(total)}'),
        ),
      ),
    );
  }

  Widget _body(GroupViewDto g) {
    final theme = Theme.of(context);
    final me = _me;
    final isHost = me != null && g.guests.any((x) => x.id == me.guestId && x.isHost);
    final cutoff = DateTime.parse(g.cutoffAt);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(g.restaurant.name, style: theme.textTheme.headlineSmall),
        Text('${arrivalLabel(g.arrivalAt)} · ${g.partySize} người'),
        const SizedBox(height: 8),
        Card(
          color: g.locked ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primaryContainer,
          child: ListTile(
            leading: Icon(g.locked ? Icons.lock : Icons.timer_outlined),
            title: Text(g.locked ? 'Đã chốt đơn' : 'Chốt món lúc ${formatLocalTime(cutoff)}'),
            subtitle: Text(g.locked ? 'Không thêm món được nữa — gọi thêm khi đến quán.' : 'Mỗi người tự chọn món của mình, trả tại quán.'),
          ),
        ),
        if (isHost && !g.locked)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: g.link));
                    _toast('Đã chép link — gửi vào nhóm Zalo / Messenger');
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('Chép link mời'),
                ),
                OutlinedButton.icon(
                  onPressed: _busy ? null : () => _run(() => _repo.lock(g.bookingId)),
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('Chốt đơn ngay'),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Text('Cả nhóm (${g.guests.length}/${g.maxGuests})', style: theme.textTheme.titleMedium),
        for (final guest in g.guests) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(child: Text(guest.displayName.isEmpty ? '?' : guest.displayName.substring(0, 1).toUpperCase())),
            title: Text('${guest.displayName}${guest.isHost ? ' (chủ bàn)' : ''}${guest.id == me?.guestId ? ' · bạn' : ''}'),
            trailing: Text(formatVnd(guest.subtotal)),
          ),
          for (final i in g.items.where((i) => i.guestId == guest.id))
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: Row(
                children: [
                  Expanded(child: Text('${i.quantity}× ${[i.nameSnapshot, ...i.optionsSnapshot.map((o) => o.option)].join(' · ')}')),
                  if (guest.id == me?.guestId && !g.locked)
                    IconButton(
                      tooltip: 'Bỏ ${i.nameSnapshot}',
                      onPressed: _busy ? null : () => _run(() => _repo.removeItem(widget.token, me!.guestKey, i.id)),
                      icon: const Icon(Icons.close, size: 18),
                    ),
                ],
              ),
            ),
        ],
        const Divider(height: 24),
        Row(
          children: [
            Expanded(child: Text('Tổng (trả tại quán)', style: theme.textTheme.titleMedium)),
            Text(formatVnd(g.total), style: theme.textTheme.titleMedium),
          ],
        ),
        if (!g.locked && _keyLoaded && me == null) ..._joinForm(),
        if (!g.locked && me != null) ..._menu(g),
      ],
    );
  }

  List<Widget> _joinForm() => [
    const SizedBox(height: 24),
    Text('Tham gia đặt món', style: Theme.of(context).textTheme.titleMedium),
    const SizedBox(height: 8),
    TextField(
      controller: _name,
      maxLength: 40,
      decoration: const InputDecoration(labelText: 'Tên của bạn', border: OutlineInputBorder()),
      onSubmitted: (_) => _join(),
    ),
    FilledButton(onPressed: _busy ? null : _join, child: const Text('Tham gia')),
  ];

  List<Widget> _menu(GroupViewDto g) {
    final theme = Theme.of(context);
    final menu = ref.watch(menuProvider(g.restaurant.id));
    return [
      const SizedBox(height: 24),
      Text('Chọn món của bạn', style: theme.textTheme.titleMedium),
      ...menu.when(
        loading: () => [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
        error: (e, _) => [Text(ApiError.from(e).userMessage)],
        data: (cats) => [
          for (final c in cats) ...[
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(c.name, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
            ),
            for (final d in c.items.where((d) => d.isAvailable && d.isPreorderable))
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(d.name),
                subtitle: Text('${formatVnd(d.price)}${d.isAlcohol ? ' · 18+' : ''}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((_qty[d.id] ?? 0) > 0) ...[
                      IconButton(
                        tooltip: 'Bớt ${d.name}',
                        onPressed: () => setState(() => _qty[d.id] = _qty[d.id]! - 1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${_qty[d.id]}'),
                    ],
                    IconButton(
                      tooltip: 'Thêm ${d.name}',
                      onPressed: () => setState(() => _qty[d.id] = (_qty[d.id] ?? 0) + 1),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    ];
  }
}

String _groupError(ApiError e) => switch (e.code) {
  'GROUP_LOCKED' => 'Nhóm đã chốt đơn',
  'GROUP_FULL' => 'Nhóm đã đủ người',
  'GUEST_KEY_INVALID' => 'Vui lòng tham gia lại',
  'KITCHEN_FULL' => 'Bếp đã kín giờ này — gọi món khi đến quán',
  'NOT_FOUND' => 'Link nhóm không còn',
  _ => e.userMessage,
};
