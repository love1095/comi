import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../data/session.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/restaurant_picker_screen.dart';
import '../features/bookings/board_screen.dart';
import '../features/bookings/booking_detail_screen.dart';
import '../features/menu/menu_screen.dart';
import '../features/onboarding/register_restaurant_screen.dart';
import '../features/onboarding/setup_screen.dart';
import '../features/tables/areas_screen.dart';
import '../features/tables/map_editor_screen.dart';
import 'home_shell.dart';

/// Where the session says we must be, or null if [location] is fine.
String? sessionRedirect(AsyncValue<Session> session, String location) {
  if (session.isLoading && !session.hasValue) return location == '/splash' ? null : '/splash';
  final s = session.value ?? const Session();
  if (!s.loggedIn) return location == '/login' ? null : '/login';
  // /restaurants = picker, /restaurants/new = register a restaurant (onboarding step 1).
  if (!s.hasRestaurant) return location.startsWith('/restaurants') ? null : '/restaurants';
  if (location == '/splash' || location == '/login' || location == '/' || location.startsWith('/restaurants')) return '/board';
  return null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) => sessionRedirect(ref.read(sessionProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) => const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/restaurants', builder: (_, _) => const RestaurantPickerScreen()),
      GoRoute(path: '/restaurants/new', builder: (_, _) => const RegisterRestaurantScreen()),
      ShellRoute(
        builder: (_, state, child) => HomeShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: '/board',
            builder: (_, _) => const BoardScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) => BookingDetailScreen(bookingId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(path: '/menu', builder: (_, _) => const MenuScreen()),
          GoRoute(path: '/setup', builder: (_, _) => const SetupScreen()),
          GoRoute(path: '/areas', builder: (_, _) => const AreasScreen()),
        ],
      ),
      // Full screen: the editor needs the whole tablet width.
      GoRoute(
        path: '/areas/:id',
        builder: (_, state) => MapEditorScreen(areaId: state.pathParameters['id']!),
      ),
    ],
  );
});
