import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/session.dart';
import 'money.dart';
import 'moderation.dart';
import 'people.dart';

/// Side navigation for the admin website (wide screens; collapses to icons when narrow).
class AdminShell extends ConsumerStatefulWidget {
  const AdminShell({super.key});

  @override
  ConsumerState<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends ConsumerState<AdminShell> {
  var _index = 0;

  static const _items = [
    (Icons.dashboard_outlined, 'Tổng quan'),
    (Icons.storefront_outlined, 'Quán'),
    (Icons.flag_outlined, 'Đánh giá'),
    (Icons.people_outline, 'Khách'),
    (Icons.search, 'Tra cứu đơn'),
    (Icons.receipt_long_outlined, 'Phí comi'),
    (Icons.local_offer_outlined, 'Mã giảm giá'),
    (Icons.currency_exchange, 'Tỷ giá'),
    (Icons.history, 'Nhật ký'),
  ];

  Widget _page() => switch (_index) {
    0 => DashboardPage(go: (i) => setState(() => _index = i)),
    1 => const RestaurantsPage(),
    2 => const ReportedReviewsPage(),
    3 => const UsersPage(),
    4 => const BookingLookupPage(),
    5 => const StatementsPage(),
    6 => const VouchersPage(),
    7 => const RatesPage(),
    _ => const AuditPage(),
  };

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 1000;
    final email = ref.watch(sessionProvider).email;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: wide,
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                wide ? 'comi admin' : 'comi',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: ComiColors.brand),
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (wide && email != null) Text(email, style: Theme.of(context).textTheme.bodySmall),
                      IconButton(
                        tooltip: 'Đăng xuất',
                        onPressed: () => ref.read(sessionProvider.notifier).logout(),
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            destinations: [for (final (icon, label) in _items) NavigationRailDestination(icon: Icon(icon), label: Text(label))],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: _page()),
        ],
      ),
    );
  }
}
