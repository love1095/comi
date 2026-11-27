import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/data/api_error.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/account/account_screen.dart';
import 'package:shared_ui/shared_ui.dart';

class FakeStaffAccount implements StaffAccountRepository {
  FakeStaffAccount({this.soleOwner = false});
  final bool soleOwner;
  var deleted = false;

  @override
  Future<void> delete() async {
    if (soleOwner) throw const ApiError('SOLE_OWNER', 'Add another owner');
    deleted = true;
  }
}

void main() {
  Future<ProviderContainer> pump(WidgetTester tester, FakeStaffAccount repo) async {
    final c = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore()..value = const StoredSession(refreshToken: 'r', restaurantId: 'r1', restaurantName: 'Quán'),
        ),
        staffAccountRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(c.dispose);
    await c.read(sessionProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(theme: ComiTheme.light(), home: const StaffAccountScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xoá tài khoản'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xoá vĩnh viễn'));
    await tester.pumpAndSettle();
    return c;
  }

  testWidgets('staff deletes account → logged out', (tester) async {
    final repo = FakeStaffAccount();
    final c = await pump(tester, repo);
    expect(repo.deleted, isTrue);
    expect(c.read(sessionProvider).value!.refreshToken, isNull);
  });

  testWidgets('sole owner is told to add another owner first', (tester) async {
    await pump(tester, FakeStaffAccount(soleOwner: true));
    expect(find.textContaining('chủ quán duy nhất'), findsOneWidget);
  });
}
