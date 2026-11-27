import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/notifications/notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  Future<void> pump(WidgetTester tester, FakeNotifications repo, {bool loggedIn = true}) async {
    final c = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore()..value = loggedIn ? const StoredSession(accessToken: 'a', refreshToken: 'r') : const StoredSession(),
        ),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        notificationsRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(c.dispose);
    await c.read(sessionProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(
          theme: ComiTheme.light(),
          home: Scaffold(appBar: AppBar(actions: const [NotificationBell()])),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('bell shows unread count; opening one marks it read; read all', (tester) async {
    final repo = FakeNotifications();
    await pump(tester, repo);
    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byTooltip('Thông báo (2 mới)'));
    await tester.pumpAndSettle();
    expect(find.text('Bữa ăn thế nào?'), findsOneWidget);
    await tester.tap(find.text('Đã đọc hết'));
    await tester.pumpAndSettle();
    expect(repo.reads, ['all']);
    expect(find.text('Đã đọc hết'), findsNothing);
  });

  testWidgets('no bell when logged out', (tester) async {
    await pump(tester, FakeNotifications(), loggedIn: false);
    expect(find.byIcon(Icons.notifications_outlined), findsNothing);
  });
}
