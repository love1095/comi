import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';

/// Staff login (email + password, §18). The router moves on once the session has tokens.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _form = GlobalKey<FormState>();
  // Seed account for local dev (backend prisma/seed.ts).
  final _email = TextEditingController(text: kDebugMode ? 'owner@comi.vn' : '');
  final _password = TextEditingController(text: kDebugMode ? 'comi12345' : '');
  final _name = TextEditingController();
  final _phone = TextEditingController();
  var _busy = false;
  var _obscure = true;
  var _signUp = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _toggleMode() => setState(() {
    _signUp = !_signUp;
    _error = null;
    if (_signUp) {
      _email.clear();
      _password.clear();
    }
  });

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final session = ref.read(sessionProvider.notifier);
      if (_signUp) {
        final phone = _phone.text.replaceAll(RegExp(r'[\s.-]'), '');
        await session.register(email: _email.text, password: _password.text, name: _name.text, phone: phone.isEmpty ? null : phone);
      } else {
        await session.login(_email.text, _password.text);
      }
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        setState(() => _error = _signUp && err.code == 'CONFLICT' ? 'Email này đã có tài khoản, hãy đăng nhập' : err.userMessage);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _form,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'comi',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: ComiColors.brand),
                      ),
                      Text(
                        'Dành cho nhà hàng',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      if (_signUp) ...[
                        TextFormField(
                          controller: _name,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                          decoration: const InputDecoration(labelText: 'Họ tên', prefixIcon: Icon(Icons.person_outline)),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Nhập họ tên' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          decoration: const InputDecoration(
                            labelText: 'Số điện thoại (không bắt buộc)',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: (v) {
                            final p = (v ?? '').replaceAll(RegExp(r'[\s.-]'), '');
                            return p.isEmpty || RegExp(r'^\+?[0-9]{8,15}$').hasMatch(p) ? null : 'Số điện thoại chưa đúng';
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline)),
                        validator: (v) => (v == null || !v.contains('@')) ? 'Nhập email' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _password,
                        obscureText: _obscure,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _obscure ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                            onPressed: () => setState(() => _obscure = !_obscure),
                            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Nhập mật khẩu';
                          if (_signUp && v.length < 8) return 'Mật khẩu ít nhất 8 ký tự';
                          return null;
                        },
                      ),
                      if (_error != null) ...[const SizedBox(height: 12), Text(_error!, style: TextStyle(color: scheme.error))],
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _busy ? null : _submit,
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                        child: _busy
                            ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : Text(_signUp ? 'Tạo tài khoản' : 'Đăng nhập'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _busy ? null : _toggleMode,
                        child: Text(_signUp ? 'Đã có tài khoản? Đăng nhập' : 'Chủ quán mới? Đăng ký'),
                      ),
                      if (_signUp)
                        Text(
                          'Tạo tài khoản nghĩa là bạn đồng ý với Điều khoản sử dụng và Chính sách quyền riêng tư của comi (xem trong Tài khoản).',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
