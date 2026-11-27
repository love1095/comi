import 'package:customer_app/data/language.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _Probe extends ConsumerWidget {
  const _Probe();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: Column(
      children: [
        Text(context.l10n.navExplore),
        Text('content=${ref.watch(contentLocaleProvider)}'),
        TextButton(onPressed: () => ref.read(appLanguageProvider.notifier).set('ko'), child: const Text('ko')),
      ],
    ),
  );
}

void main() {
  test('every language has every string (ARB files complete)', () {
    final vi = lookupAppLocalizations(const Locale('vi'));
    for (final l in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(l);
      expect(t.translatedAutomatically, isNotEmpty);
      if (l.languageCode != 'vi') expect(t.navExplore, isNot(vi.navExplore), reason: l.languageCode);
    }
    expect(AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(), appLanguages.keys.toSet());
  });

  testWidgets('saved language wins over the phone; switching changes app text and API content language', (tester) async {
    final store = MemoryLanguageStore()..value = 'en';
    final c = ProviderContainer(
      overrides: [languageStoreProvider.overrideWithValue(store), deviceLanguageProvider.overrideWithValue('vi')],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: Consumer(
          builder: (_, ref, _) => MaterialApp(
            locale: Locale(ref.watch(appLanguageProvider)),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates],
            home: const _Probe(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('content=en'), findsOneWidget);
    await tester.tap(find.text('ko'));
    await tester.pumpAndSettle();
    expect(find.text('둘러보기'), findsOneWidget);
    expect(find.text('content=ko'), findsOneWidget);
    expect(store.value, 'ko');
  });
}
