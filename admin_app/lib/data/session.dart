import 'package:comi_api/comi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';

final apiBaseUrlProvider = Provider<String>((ref) => apiBaseUrl);

/// Admin session, kept in memory only (reloading the page signs out — safer for an admin tool).
/// [mfa] false = a setup-only session: the admin must turn on 2FA before using anything.
class AdminSession {
  const AdminSession({this.accessToken, this.refreshToken, this.mfa = false, this.email});
  final String? accessToken;
  final String? refreshToken;
  final bool mfa;
  final String? email;

  bool get signedIn => refreshToken != null;
}

/// Sign-in calls; separate so tests can fake them.
abstract class AdminAuth {
  Future<AdminLoginResultDto> login(String email, String password, String? code);
  Future<MfaSetupDto> setup(String accessToken);
  Future<void> enable(String accessToken, String code);
}

class ApiAdminAuth implements AdminAuth {
  ApiAdminAuth(this._baseUrl);
  final String _baseUrl;

  AuthApi _api([String? token]) => ComiApi(
    basePathOverride: _baseUrl,
    interceptors: [if (token != null) InterceptorsWrapper(onRequest: (o, h) => h.next(o..headers['Authorization'] = 'Bearer $token'))],
  ).getAuthApi();

  @override
  Future<AdminLoginResultDto> login(String email, String password, String? code) async => (await _api().adminAuthLogin(
    adminLoginDto: AdminLoginDto(email: email, password: password, code: code),
  )).data!;

  @override
  Future<MfaSetupDto> setup(String accessToken) async => (await _api(accessToken).adminAuthSetup()).data!;

  @override
  Future<void> enable(String accessToken, String code) => _api(accessToken).adminAuthEnable(mfaCodeDto: MfaCodeDto(code: code));
}

final adminAuthProvider = Provider<AdminAuth>((ref) => ApiAdminAuth(ref.watch(apiBaseUrlProvider)));

class SessionController extends Notifier<AdminSession> {
  @override
  AdminSession build() => const AdminSession();

  Future<AdminSession> login(String email, String password, {String? code}) async {
    final r = await ref.read(adminAuthProvider).login(email.trim(), password, code);
    return state = AdminSession(accessToken: r.accessToken, refreshToken: r.refreshToken, mfa: r.mfa, email: email.trim());
  }

  void updateTokens(TokenPairDto t) =>
      state = AdminSession(accessToken: t.accessToken, refreshToken: t.refreshToken, mfa: state.mfa, email: state.email);

  void logout() => state = const AdminSession();
}

final sessionProvider = NotifierProvider<SessionController, AdminSession>(SessionController.new);

final apiProvider = Provider<ComiApi>((ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 30)));
  dio.interceptors.add(
    AdminAuthInterceptor(
      dio: dio,
      readSession: () => ref.read(sessionProvider),
      refresh: (token) async =>
          (await ComiApi(basePathOverride: baseUrl, interceptors: []).getAuthApi().authRefresh(refreshDto: RefreshDto(refreshToken: token)))
              .data!,
      onRefreshed: (t) => ref.read(sessionProvider.notifier).updateTokens(t),
      onExpired: () => ref.read(sessionProvider.notifier).logout(),
    ),
  );
  return ComiApi(dio: dio);
});

/// Bearer token + one refresh on 401 (refresh tokens rotate; the 2FA flag survives a refresh).
class AdminAuthInterceptor extends QueuedInterceptor {
  AdminAuthInterceptor({
    required Dio dio,
    required this.readSession,
    required this.refresh,
    required this.onRefreshed,
    required this.onExpired,
  }) : _retryDio = Dio(dio.options);

  final Dio _retryDio;
  final AdminSession Function() readSession;
  final Future<TokenPairDto> Function(String refreshToken) refresh;
  final void Function(TokenPairDto) onRefreshed;
  final void Function() onExpired;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = readSession().accessToken;
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = readSession().refreshToken;
    if (err.response?.statusCode != 401 || refreshToken == null || err.requestOptions.extra['comi.retried'] == true) {
      return handler.next(err);
    }
    try {
      final t = await refresh(refreshToken);
      onRefreshed(t);
      final o = err.requestOptions
        ..headers['Authorization'] = 'Bearer ${t.accessToken}'
        ..extra['comi.retried'] = true;
      handler.resolve(await _retryDio.fetch<dynamic>(o));
    } catch (_) {
      onExpired();
      handler.next(err);
    }
  }
}
