import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../data/session.dart';

/// Top-level sections. Side rail on tablets, bottom bar on phones.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  static const _tabs = [
    (path: '/board', icon: Icons.event_note_outlined, selected: Icons.event_note, label: 'Đặt bàn'),
    (path: '/kitchen', icon: Icons.soup_kitchen_outlined, selected: Icons.soup_kitchen, label: 'Bếp'),
    (path: '/menu', icon: Icons.restaurant_menu_outlined, selected: Icons.restaurant_menu, label: 'Thực đơn'),
    (path: '/areas', icon: Icons.table_restaurant_outlined, selected: Icons.table_restaurant, label: 'Sơ đồ bàn'),
  ];

  int get _index {
    final i = _tabs.indexWhere((t) => location.startsWith(t.path));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    void go(int i) => context.go(_tabs[i].path);

    if (!wide) {
      return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: go,
          destinations: [for (final t in _tabs) NavigationDestination(icon: Icon(t.icon), selectedIcon: Icon(t.selected), label: t.label)],
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: go,
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final t in _tabs) NavigationRailDestination(icon: Icon(t.icon), selectedIcon: Icon(t.selected), label: Text(t.label)),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// "Đổi quán / Đăng xuất" menu for app bars.
class AccountMenu extends ConsumerWidget {
  const AccountMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PopupMenuButton<String>(
    tooltip: 'Tài khoản',
    onSelected: (v) => switch (v) {
      'settings' => context.go('/settings'),
      'reports' => context.go('/reports'),
      'statements' => context.go('/statements'),
      'invoices' => context.go('/invoices'),
      'payments' => context.go('/payments'),
      'refunds' => context.go('/refunds'),
      'switch' => ref.read(sessionProvider.notifier).switchRestaurant(),
      _ => ref.read(sessionProvider.notifier).logout(),
    },
    itemBuilder: (_) => const [
      PopupMenuItem(value: 'reports', child: Text('Báo cáo')),
      PopupMenuItem(value: 'invoices', child: Text('Hoá đơn VAT')),
      PopupMenuItem(value: 'statements', child: Text('Phí comi')),
      PopupMenuItem(value: 'refunds', child: Text('Hoàn tiền')),
      PopupMenuItem(value: 'payments', child: Text('Thanh toán online')),
      PopupMenuItem(value: 'settings', child: Text('Cài đặt')),
      PopupMenuItem(value: 'switch', child: Text('Đổi quán')),
      PopupMenuItem(value: 'logout', child: Text('Đăng xuất')),
    ],
  );
}
