import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/account/account_screen.dart';
import 'package:customer_app/features/account/privacy.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/notifications/notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  Future<ProviderContainer> pump(WidgetTester tester, FakePrivacy privacy) async {
    tester.view.physicalSize = const Size(420, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final c = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(MemoryTokenStore()..value = const StoredSession(accessToken: 'a', refreshToken: 'r')),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        bookingsRepositoryProvider.overrideWithValue(FakeBookings()),
        notificationsRepositoryProvider.overrideWithValue(FakeNotifications()),
        privacyRepositoryProvider.overrideWithValue(privacy),
      ],
    );
    addTearDown(c.dispose);
    await c.read(sessionProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(theme: ComiTheme.light(), home: const AccountScreen()),
      ),
    );
    await tester.pumpAndSettle();
    return c;
  }

  Future<void> deleteFlow(WidgetTester tester) async {
    await tester.scrollUntilVisible(find.text('Xoá tài khoản'), 200, scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('Xoá tài khoản'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xoá vĩnh viễn'));
    await tester.pumpAndSettle();
  }

  testWidgets('delete account: confirm → deleted and logged out', (tester) async {
    final privacy = FakePrivacy();
    final c = await pump(tester, privacy);
    await deleteFlow(tester);
    expect(privacy.deleted, isTrue);
    expect(c.read(sessionProvider).value!.loggedIn, isFalse);
  });

  testWidgets('delete account with upcoming bookings is explained and keeps the session', (tester) async {
    final c = await pump(tester, FakePrivacy(activeBookings: true));
    await deleteFlow(tester);
    expect(find.textContaining('huỷ hoặc hoàn tất'), findsOneWidget);
    expect(c.read(sessionProvider).value!.loggedIn, isTrue);
  });

  testWidgets('my data shows the export', (tester) async {
    await pump(tester, FakePrivacy());
    await tester.scrollUntilVisible(find.text('Dữ liệu của tôi'), 200, scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('Dữ liệu của tôi'));
    await tester.pumpAndSettle();
    expect(find.textContaining('+84901234567'), findsOneWidget);
  });
}
