import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/language.dart';
import '../../data/session.dart';
import 'privacy.dart';

/// Vietnamese mobile number: 0 + 9 digits (or +84 + 9 digits).
bool isVnPhone(String raw) => RegExp(r'^(0|\+?84)[35789]\d{8}$').hasMatch(raw.replaceAll(RegExp(r'[\s.-]'), ''));
bool isEmail(String raw) => RegExp(r'^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,}$').hasMatch(raw.trim());

/// Phone login. Pops with true when logged in, so checkout can continue.
/// ⬜ Firebase phone OTP: today the dev token exchange is used (works only when the API has no Firebase config).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phone = TextEditingController();
  var _busy = false;

  /// Tourists without a Vietnamese number sign in with email.
  var _email = false;
  String? _error;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_email ? !isEmail(_phone.text) : !isVnPhone(_phone.text)) {
      setState(() => _error = _email ? 'Email is not valid' : 'Số điện thoại chưa đúng (ví dụ 0901234567)');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final s = ref.read(sessionProvider.notifier);
      await (_email ? s.loginWithEmail(_phone.text) : s.loginWithPhone(_phone.text));
      // Consent record (Decree 13/2023). Best effort: a failure must not block the login.
      await ref.read(privacyRepositoryProvider).consent().catchError((_) => '');
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'comi',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: ComiColors.brand),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _email ? context.l10n.loginEmailTitle : context.l10n.loginPhoneTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _phone,
                    autofocus: true,
                    keyboardType: _email ? TextInputType.emailAddress : TextInputType.phone,
                    inputFormatters: _email ? null : [FilteringTextInputFormatter.allow(RegExp(r'[\d+\s]'))],
                    decoration: InputDecoration(
                      labelText: _email ? 'Email' : 'Số điện thoại',
                      hintText: _email ? 'you@example.com' : '0901234567',
                      prefixIcon: Icon(_email ? Icons.email_outlined : Icons.phone_iphone),
                      errorText: _error,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                    onPressed: _busy ? null : _submit,
                    child: Text(_busy ? '…' : context.l10n.continueButton),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _email = !_email;
                      _error = null;
                      _phone.clear();
                    }),
                    child: Text(_email ? context.l10n.usePhone : context.l10n.useEmail),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Quán dùng số này để liên hệ khi cần. comi không chia sẻ số của bạn cho bên khác.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  const LegalNotice(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
