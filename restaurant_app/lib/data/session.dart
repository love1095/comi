import 'package:comi_api/comi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/config.dart';
import 'token_store.dart';

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

final apiBaseUrlProvider = Provider<String>((ref) => apiBaseUrl);

class Session {
  const Session({this.accessToken, this.refreshToken, this.restaurantId, this.restaurantName});

  final String? accessToken;
  final String? refreshToken;
  final String? restaurantId;
  final String? restaurantName;

  bool get loggedIn => refreshToken != null;
  bool get hasRestaurant => restaurantId != null;

  Session copyWith({String? accessToken, String? refreshToken, String? restaurantId, String? restaurantName}) => Session(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    restaurantId: restaurantId ?? this.restaurantId,
    restaurantName: restaurantName ?? this.restaurantName,
  );

  StoredSession toStored() =>
      StoredSession(accessToken: accessToken, refreshToken: refreshToken, restaurantId: restaurantId, restaurantName: restaurantName);
}

/// Staff session: tokens + the restaurant being managed (sent as `X-Restaurant-Id`).
class SessionController extends AsyncNotifier<Session> {
  @override
  Future<Session> build() async {
    final s = await ref.read(tokenStoreProvider).read();
    return Session(
      accessToken: s.accessToken,
      refreshToken: s.refreshToken,
      restaurantId: s.restaurantId,
      restaurantName: s.restaurantName,
    );
  }

  Session get _current => state.value ?? const Session();

  Future<void> _set(Session s) async {
    state = AsyncData(s);
    await ref.read(tokenStoreProvider).write(s.toStored());
  }

  Future<void> login(String email, String password) async {
    final res = await ref
        .read(apiProvider)
        .getAuthApi()
        .authLogin(
          staffLoginDto: StaffLoginDto(email: email.trim(), password: password),
        );
    final t = res.data!;
    await _set(Session(accessToken: t.accessToken, refreshToken: t.refreshToken));
  }

  /// New staff account (restaurant owner signing up). Next step: register the restaurant.
  Future<void> register({required String email, required String password, required String name, String? phone}) async {
    final res = await ref
        .read(apiProvider)
        .getAuthApi()
        .authRegister(
          staffRegisterDto: StaffRegisterDto(email: email.trim(), password: password, name: name.trim(), phone: phone),
        );
    final t = res.data!;
    await _set(Session(accessToken: t.accessToken, refreshToken: t.refreshToken));
  }

  /// Called by the auth interceptor after a successful refresh.
  Future<void> updateTokens(TokenPairDto t) => _set(_current.copyWith(accessToken: t.accessToken, refreshToken: t.refreshToken));

  Future<void> selectRestaurant(String id, String name) => _set(_current.copyWith(restaurantId: id, restaurantName: name));

  Future<void> switchRestaurant() => _set(Session(accessToken: _current.accessToken, refreshToken: _current.refreshToken));

  Future<void> logout() async {
    final refresh = _current.refreshToken;
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

/// The restaurant id for `X-Restaurant-Id`. Only read on screens behind the restaurant picker.
final restaurantIdProvider = Provider<String>((ref) {
  final id = ref.watch(sessionProvider).value?.restaurantId;
  if (id == null) throw StateError('No restaurant selected');
  return id;
});

final apiProvider = Provider<ComiApi>((ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 20)));
  dio.interceptors.add(
    AuthInterceptor(
      dio: dio,
      readSession: () => ref.read(sessionProvider).value ?? const Session(),
      refresh: (token) async {
        // Plain client without this interceptor, so a failing refresh cannot loop.
        final plain = ComiApi(basePathOverride: baseUrl, interceptors: []);
        return (await plain.getAuthApi().authRefresh(refreshDto: RefreshDto(refreshToken: token))).data!;
      },
      onRefreshed: (t) => ref.read(sessionProvider.notifier).updateTokens(t),
      onExpired: () => ref.read(sessionProvider.notifier).logout(),
    ),
  );
  return ComiApi(dio: dio);
});

/// Adds the bearer token; on 401 refreshes once (refresh tokens rotate, so requests are
/// queued and a request that waited behind a refresh just reuses the new token).
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required Dio dio, required this.readSession, required this.refresh, required this.onRefreshed, required this.onExpired})
    : _retryDio = Dio(dio.options);

  final Dio _retryDio;
  final Session Function() readSession;
  final Future<TokenPairDto> Function(String refreshToken) refresh;
  final Future<void> Function(TokenPairDto) onRefreshed;
  final Future<void> Function() onExpired;

  static const _retried = 'comi.retried';

  bool _isAuthPath(String path) => path.contains('/auth/login') || path.contains('/auth/refresh') || path.contains('/auth/register');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = readSession().accessToken;
    if (token != null && !_isAuthPath(options.path)) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final req = err.requestOptions;
    if (err.response?.statusCode != 401 || _isAuthPath(req.path) || req.extra[_retried] == true) {
      return handler.next(err);
    }
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
      // Retry on a client without this interceptor: re-entering a QueuedInterceptor from
      // its own onError would deadlock if the retry failed too.
      handler.resolve(await _retryDio.fetch(req));
    } on DioException catch (e) {
      if (_isAuthPath(e.requestOptions.path)) {
        // Server rejected the refresh token → sign out. Offline → keep the session.
        if (e.response != null) await onExpired();
        return handler.next(err);
      }
      handler.next(e);
    }
  }
}
