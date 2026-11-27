import 'package:flutter/foundation.dart';

/// API base URL. Override with `--dart-define=API_URL=https://staging.example.com`.
/// Default: local backend (port 3100); the Android emulator reaches the host via 10.0.2.2.
String get apiBaseUrl {
  const fromEnv = String.fromEnvironment('API_URL');
  if (fromEnv.isNotEmpty) return fromEnv;
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) return 'http://10.0.2.2:3100';
  return 'http://localhost:3100';
}
