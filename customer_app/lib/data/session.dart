import 'package:comi_api/comi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/config.dart';
import 'token_store.dart';

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

final apiBaseUrlProvider = Provider<String>((ref) => apiBaseUrl);

/// Menu / restaurant text language sent as Accept-Language (§17). Vietnamese until the app has a language picker.
final contentLocaleProvider = Provider<String>((ref) => 'vi');

class Session {
  const Session({this.accessToken, this.refreshToken});
  final String? accessToken;
  final String? refreshToken;

  bool get loggedIn => refreshToken != null;
}

/// Turns a phone sign-in into an ID token for `POST /auth/customer/exchange`.
/// Production: Firebase phone auth (⬜ needs real Firebase projects).
/// Dev: the backend accepts `dev:<uid>:<phone>` when Firebase is not configured.
abstract class PhoneAuth {
  Future<String> idTokenFor(String phone);
}

class DevPhoneAuth implements PhoneAuth {
  @override
  Future<String> idTokenFor(String phone) async {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return 'dev:u$digits:+84${digits.startsWith('0') ? digits.substring(1) : digits}';
  }
}

final phoneAuthProvider = Provider<PhoneAuth>((ref) => DevPhoneAuth());

/// Diner session. Browsing works logged out; booking needs a login.
class SessionController extends AsyncNotifier<Session> {
  @override
  Future<Session> build() async {
    final s = await ref.read(tokenStoreProvider).read();
    return Session(accessToken: s.accessToken, refreshToken: s.refreshToken);
  }

  Future<void> _set(Session s) async {
    state = AsyncData(s);
    await ref.read(tokenStoreProvider).write(StoredSession(accessToken: s.accessToken, refreshToken: s.refreshToken));
  }

  Future<void> loginWithPhone(String phone) async {
    final idToken = await ref.read(phoneAuthProvider).idTokenFor(phone);
    final res = await ref.read(apiProvider).getAuthApi().authExchange(customerExchangeDto: CustomerExchangeDto(idToken: idToken));
    final t = res.data!;
    await _set(Session(accessToken: t.accessToken, refreshToken: t.refreshToken));
  }

  Future<void> updateTokens(TokenPairDto t) => _set(Session(accessToken: t.accessToken, refreshToken: t.refreshToken));

  Future<void> logout() async {
    final refresh = state.value?.refreshToken;
    state = const AsyncData(Session());
    await ref.read(tokenStoreProvider).clear();
    if (refresh != null) {
      try {
        await ref.read(apiProvider).getAuthApi().authLogout(refreshDto: RefreshDto(refreshToken: refresh));
      } catch (_) {
        // Best effort: the token expires on its own.
      }
    }
  }
}

final sessionProvider = AsyncNotifierProvider<SessionController, Session>(SessionController.new);

final apiProvider = Provider<ComiApi>((ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 20)));
  dio.interceptors.add(
    AuthInterceptor(
      dio: dio,
      readSession: () => ref.read(sessionProvider).value ?? const Session(),
      refresh: (token) async {
        final plain = ComiApi(basePathOverride: baseUrl, interceptors: []);
        return (await plain.getAuthApi().authRefresh(refreshDto: RefreshDto(refreshToken: token))).data!;
      },
      onRefreshed: (t) => ref.read(sessionProvider.notifier).updateTokens(t),
      onExpired: () => ref.read(sessionProvider.notifier).logout(),
    ),
  );
  return ComiApi(dio: dio);
});

/// Bearer token + one refresh on 401 (refresh tokens rotate). Same logic as the restaurant app.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required Dio dio, required this.readSession, required this.refresh, required this.onRefreshed, required this.onExpired})
    : _retryDio = Dio(dio.options);

  final Dio _retryDio;
  final Session Function() readSession;
  final Future<TokenPairDto> Function(String refreshToken) refresh;
  final Future<void> Function(TokenPairDto) onRefreshed;
  final Future<void> Function() onExpired;

  static const _retried = 'comi.retried';

  bool _isAuthPath(String path) => path.contains('/auth/');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = readSession().accessToken;
    if (token != null && !_isAuthPath(options.path)) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final req = err.requestOptions;
    if (err.response?.statusCode != 401 || _isAuthPath(req.path) || req.extra[_retried] == true) return handler.next(err);
    final session = readSession();
    final sentWith = (req.headers['Authorization'] as String?)?.replaceFirst('Bearer ', '');
    try {
      var access = session.accessToken;
      if (access == null || access == sentWith) {
        final rt = session.refreshToken;
        if (rt == null) return handler.next(err);
        final pair = await refresh(rt);
        await onRefreshed(pair);
        access = pair.accessToken;
      }
      req.extra[_retried] = true;
      req.headers['Authorization'] = 'Bearer $access';
      handler.resolve(await _retryDio.fetch(req));
    } on DioException catch (e) {
      if (_isAuthPath(e.requestOptions.path)) {
        if (e.response != null) await onExpired();
        return handler.next(err);
      }
      handler.next(e);
    }
  }
}
