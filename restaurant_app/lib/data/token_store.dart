import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// What we keep across app restarts.
class StoredSession {
  const StoredSession({this.accessToken, this.refreshToken, this.restaurantId, this.restaurantName});

  final String? accessToken;
  final String? refreshToken;
  final String? restaurantId;
  final String? restaurantName;
}

abstract class TokenStore {
  Future<StoredSession> read();
  Future<void> write(StoredSession s);
  Future<void> clear();
}

class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage]) : _s = storage ?? const FlutterSecureStorage();
  final FlutterSecureStorage _s;

  static const _access = 'comi.access', _refresh = 'comi.refresh', _rid = 'comi.restaurantId', _rname = 'comi.restaurantName';

  @override
  Future<StoredSession> read() async {
    final all = await _s.readAll();
    return StoredSession(accessToken: all[_access], refreshToken: all[_refresh], restaurantId: all[_rid], restaurantName: all[_rname]);
  }

  @override
  Future<void> write(StoredSession s) async {
    Future<void> put(String k, String? v) => v == null ? _s.delete(key: k) : _s.write(key: k, value: v);
    await put(_access, s.accessToken);
    await put(_refresh, s.refreshToken);
    await put(_rid, s.restaurantId);
    await put(_rname, s.restaurantName);
  }

  @override
  Future<void> clear() async {
    for (final k in [_access, _refresh, _rid, _rname]) {
      await _s.delete(key: k);
    }
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
