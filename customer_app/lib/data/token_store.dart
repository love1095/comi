import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// What we keep across app restarts.
class StoredSession {
  const StoredSession({this.accessToken, this.refreshToken});
  final String? accessToken;
  final String? refreshToken;
}

abstract class TokenStore {
  Future<StoredSession> read();
  Future<void> write(StoredSession s);
  Future<void> clear();
}

class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage]) : _s = storage ?? const FlutterSecureStorage();
  final FlutterSecureStorage _s;

  static const _access = 'comi.customer.access', _refresh = 'comi.customer.refresh';

  @override
  Future<StoredSession> read() async {
    final all = await _s.readAll();
    return StoredSession(accessToken: all[_access], refreshToken: all[_refresh]);
  }

  @override
  Future<void> write(StoredSession s) async {
    Future<void> put(String k, String? v) => v == null ? _s.delete(key: k) : _s.write(key: k, value: v);
    await put(_access, s.accessToken);
    await put(_refresh, s.refreshToken);
  }

  @override
  Future<void> clear() async {
    await _s.delete(key: _access);
    await _s.delete(key: _refresh);
  }
}

/// For tests.
class MemoryTokenStore implements TokenStore {
  StoredSession value = const StoredSession();

  @override
  Future<StoredSession> read() async => value;

  @override
  Future<void> write(StoredSession s) async => value = s;

  @override
  Future<void> clear() async => value = const StoredSession();
}
