import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../l10n/app_localizations.dart';

/// App + content languages (§17). Vietnamese is the source language.
const appLanguages = {'vi': 'Tiếng Việt', 'en': 'English', 'ko': '한국어', 'zh': '中文', 'ja': '日本語'};

/// Phone language if we support it; any other foreign language → English.
String platformLanguage() {
  final code = PlatformDispatcher.instance.locale.languageCode;
  return appLanguages.containsKey(code) ? code : 'en';
}

/// Overridden in main() with [platformLanguage]; Vietnamese elsewhere (tests).
final deviceLanguageProvider = Provider<String>((ref) => 'vi');

abstract class LanguageStore {
  Future<String?> read();
  Future<void> write(String code);
}

class SecureLanguageStore implements LanguageStore {
  const SecureLanguageStore([this._s = const FlutterSecureStorage()]);
  final FlutterSecureStorage _s;

  @override
  Future<String?> read() => _s.read(key: 'comi.lang');

  @override
  Future<void> write(String code) => _s.write(key: 'comi.lang', value: code);
}

class MemoryLanguageStore implements LanguageStore {
  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String code) async => value = code;
}

final languageStoreProvider = Provider<LanguageStore>((ref) => const SecureLanguageStore());

/// The chosen language: saved choice, else the phone language.
class LanguageController extends Notifier<String> {
  @override
  String build() {
    Future.microtask(() async {
      String? saved;
      try {
        saved = await ref.read(languageStoreProvider).read();
      } catch (_) {
        return; // storage unavailable: keep the phone language
      }
      if (saved != null && appLanguages.containsKey(saved) && saved != state) state = saved;
    });
    return ref.watch(deviceLanguageProvider);
  }

  Future<void> set(String code) async {
    state = code;
    await ref.read(languageStoreProvider).write(code);
  }
}

final appLanguageProvider = NotifierProvider<LanguageController, String>(LanguageController.new);

/// Translated app strings; falls back to Vietnamese where no delegate is set up (widget tests).
extension L10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('vi'));
}
