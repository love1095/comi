import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'app/router.dart';
import 'data/session.dart';

void main() {
  runApp(const ProviderScope(child: CustomerApp()));
}

class CustomerApp extends ConsumerWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Load the saved login at start so the first API calls already carry the token.
    ref.watch(sessionProvider);
    return MaterialApp.router(
      title: 'comi',
      debugShowCheckedModeBanner: false,
      theme: ComiTheme.light(),
      darkTheme: ComiTheme.dark(),
      routerConfig: ref.watch(routerProvider),
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
