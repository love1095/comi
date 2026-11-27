import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/api_error.dart';
import '../data/session.dart';

/// Email + password + 6-digit authenticator code.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    for (final c in [_email, _password, _code]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final code = _code.text.trim();
      await ref.read(sessionProvider.notifier).login(_email.text, _password.text, code: code.isEmpty ? null : code);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'comi admin',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: ComiColors.brand),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _email,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _code,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                  decoration: const InputDecoration(
                    labelText: 'Mã xác thực (6 số)',
                    helperText: 'Lần đầu đăng nhập: để trống để cài ứng dụng xác thực',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ),
                const SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                  onPressed: _busy ? null : _submit,
                  child: Text(_busy ? 'Đang đăng nhập…' : 'Đăng nhập'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// First sign-in: show the secret for an authenticator app, confirm with a code, then sign in again.
class MfaSetupScreen extends ConsumerStatefulWidget {
  const MfaSetupScreen({super.key});

  @override
  ConsumerState<MfaSetupScreen> createState() => _MfaSetupScreenState();
}

class _MfaSetupScreenState extends ConsumerState<MfaSetupScreen> {
  MfaSetupDto? _setup;
  final _code = TextEditingController();
  String? _error;
  var _done = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    try {
      final s = await ref.read(adminAuthProvider).setup(ref.read(sessionProvider).accessToken!);
      if (mounted) setState(() => _setup = s);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    }
  }

  Future<void> _enable() async {
    try {
      await ref.read(adminAuthProvider).enable(ref.read(sessionProvider).accessToken!, _code.text.trim());
      if (mounted) setState(() => _done = true);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Bật xác thực 2 bước')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: _done
                ? Column(
                    children: [
                      const Icon(Icons.verified_user, size: 48, color: ComiColors.available),
                      const SizedBox(height: 12),
                      const Text('Đã bật xác thực 2 bước. Đăng nhập lại bằng mã trong ứng dụng.'),
                      const SizedBox(height: 16),
                      FilledButton(onPressed: () => ref.read(sessionProvider.notifier).logout(), child: const Text('Đăng nhập lại')),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Trang quản trị bắt buộc xác thực 2 bước. Mở Google Authenticator, 1Password hoặc Authy → '
                        'thêm tài khoản → nhập khoá bên dưới (hoặc mở liên kết otpauth trên điện thoại).',
                      ),
                      const SizedBox(height: 16),
                      if (_setup == null && _error == null) const Center(child: CircularProgressIndicator()),
                      if (_setup != null) ...[
                        Text('Khoá bí mật', style: theme.textTheme.labelLarge),
                        SelectableText(_setup!.secret, style: const TextStyle(fontFamily: 'monospace', fontSize: 18, letterSpacing: 2)),
                        TextButton.icon(
                          onPressed: () => Clipboard.setData(ClipboardData(text: _setup!.otpauthUrl)),
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Sao chép liên kết otpauth'),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _code,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                          decoration: const InputDecoration(labelText: 'Mã 6 số trong ứng dụng', border: OutlineInputBorder()),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: _code.text.length == 6 ? _enable : null, child: const Text('Bật')),
                      ],
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                        ),
                      TextButton(onPressed: () => ref.read(sessionProvider.notifier).logout(), child: const Text('Huỷ')),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
