import 'package:customer_app/features/account/login_screen.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
import 'package:customer_app/features/discovery/list_screen.dart';
import 'package:customer_app/features/tourist/tourist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  test('email sign-in for tourists', () async {
    expect(isEmail('anna@example.de'), isTrue);
    expect(isEmail('anna@'), isFalse);
    expect(await DevPhoneAuth().idTokenForEmail(' Anna@Example.de '), 'dev:eannaexamplede:anna@example.de');
  });

  test('approximate prices round like the backend', () {
    expect(approxPrice(150000, 25400, 'USD'), r'≈ $5.91');
    expect(approxPrice(150000, 18.5, 'KRW'), '≈ ₩8,100');
    expect(approxPrice(150000, 165, 'JPY'), '≈ ¥910');
  });

  test('"table soon" starts 30 min ahead on a quarter hour', () {
    expect(tableSoonAt(DateTime.utc(2026, 12, 1, 11, 2)), DateTime.utc(2026, 12, 1, 11, 45));
    expect(tableSoonAt(DateTime.utc(2026, 12, 1, 11, 45)), DateTime.utc(2026, 12, 1, 12, 15));
  });

  test('filters compare dietary sets by content', () {
    const a = SearchFilters();
    expect(a.toggleDietary('halal').toggleDietary('vegetarian'), a.toggleDietary('vegetarian').toggleDietary('halal'));
    expect(a.copyWith(best: true).sort, 'score');
  });

  Future<ProviderContainer> pump(WidgetTester tester, Widget screen, {FakeDiscovery? discovery, String lang = 'vi'}) async {
    tester.view.physicalSize = const Size(420, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final c = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(MemoryTokenStore()),
        locationServiceProvider.overrideWithValue(FakeLocation()),
        realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
        discoveryRepositoryProvider.overrideWithValue(discovery ?? FakeDiscovery()),
        touristRepositoryProvider.overrideWithValue(FakeTourist()),
        contentLocaleProvider.overrideWithValue(lang),
      ],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
    return c;
  }

  testWidgets('English users see ≈ USD next to VND; Vietnamese users do not', (tester) async {
    await pump(tester, const Scaffold(body: ApproxPrice(150000)), lang: 'en');
    expect(find.text(r'≈ $5.91'), findsOneWidget);
    await pump(tester, const Scaffold(body: ApproxPrice(150000)));
    expect(find.textContaining('≈'), findsNothing);
  });

  testWidgets('taxi card shows the Vietnamese name and address large', (tester) async {
    await pump(tester, const TaxiCardScreen(name: 'Quán Ốc Bờ Kè', address: '12 Vĩnh Khánh, Q4', phone: '0901234567'));
    expect(find.text('Cho tôi đến:'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Quán Ốc Bờ Kè')).style!.fontSize, greaterThanOrEqualTo(30));
    expect(find.text('12 Vĩnh Khánh, Q4'), findsOneWidget);
  });

  testWidgets('map/list filters: free table soon, 4★+, halal', (tester) async {
    final discovery = FakeDiscovery();
    await pump(tester, const ListScreen(initial: SearchFilters()), discovery: discovery);
    for (final chip in ['Còn bàn ngay', '4★ trở lên', 'Halal']) {
      final row = find.ancestor(of: find.byType(FilterChip).first, matching: find.byType(Scrollable)).first;
      await tester.scrollUntilVisible(find.widgetWithText(FilterChip, chip), 150, scrollable: row);
      await tester.ensureVisible(find.widgetWithText(FilterChip, chip));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilterChip, chip));
      await tester.pumpAndSettle();
    }
    final f = discovery.nearbyCalls.last;
    expect((f.tableSoon, f.rating4), (true, true));
    expect(f.dietary, {'halal'});
  });
}
