import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../features/account/account_screen.dart';
import '../features/account/login_screen.dart';
import '../features/booking/booking_detail_screen.dart';
import '../features/booking/booking_screen.dart';
import '../features/booking/my_bookings_screen.dart';
import '../features/discovery/list_screen.dart';
import '../features/discovery/search_screen.dart';
import '../features/home/home_screen.dart';
import '../features/restaurant/restaurant_screen.dart';

/// Browsing is public; login is asked for at checkout and on "Đơn của tôi" (§18).
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => _TabShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/', builder: (_, _) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                builder: (_, _) => const MyBookingsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, s) =>
                        BookingDetailScreen(bookingId: s.pathParameters['id']!, justBooked: s.uri.queryParameters['new'] == '1'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/account', builder: (_, _) => const AccountScreen())],
          ),
        ],
      ),
      GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
      GoRoute(
        path: '/list',
        builder: (_, s) => ListScreen(initial: filtersFromQuery(s.uri.queryParameters)),
      ),
      GoRoute(
        path: '/r/:slug',
        builder: (_, s) => RestaurantScreen(slug: s.pathParameters['slug']!, tableBookingId: s.uri.queryParameters['table']),
        routes: [
          GoRoute(
            path: 'book',
            builder: (_, s) => BookingScreen(slug: s.pathParameters['slug']!),
          ),
        ],
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
    ],
  );
});

class _TabShell extends StatelessWidget {
  const _TabShell({required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: shell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Khám phá'),
        NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Đơn của tôi'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Tài khoản'),
      ],
    ),
  );
}
