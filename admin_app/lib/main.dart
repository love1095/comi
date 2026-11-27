import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'data/session.dart';
import 'features/login.dart';
import 'features/shell.dart';

void main() => runApp(const ProviderScope(child: AdminApp()));

class AdminApp extends ConsumerWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(sessionProvider);
    return MaterialApp(
      title: 'comi admin',
      debugShowCheckedModeBanner: false,
      theme: ComiTheme.light(),
      darkTheme: ComiTheme.dark(),
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // Signed out → login; signed in without 2FA → set it up; with 2FA → the admin pages.
      home: !s.signedIn ? const LoginScreen() : (s.mfa ? const AdminShell() : const MfaSetupScreen()),
    );
  }
}
