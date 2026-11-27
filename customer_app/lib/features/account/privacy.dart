import 'dart:convert';

import 'package:comi_api/comi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/language.dart';
import '../../data/session.dart';
import '../group/split_screen.dart' show openUrlProvider;

/// Privacy (Decree 13/2023, store rules): consent record, data copy, account deletion.
abstract class PrivacyRepository {
  /// Records consent to the current terms; returns the version accepted.
  Future<String> consent({bool marketing = false});
  Future<String> exportJson();
  Future<void> deleteAccount();
}

class ApiPrivacyRepository implements PrivacyRepository {
  ApiPrivacyRepository(this._me, this._legal, this._dio);
  final MeApi _me;
  final PublicLegalApi _legal;
  final Dio _dio;

  @override
  Future<String> consent({bool marketing = false}) async {
    final version = (await _legal.legalInfo()).data!.termsVersion;
    await _me.usersConsent(
      consentDto: ConsentDto(termsVersion: version, marketing: marketing),
    );
    return version;
  }

  @override
  Future<String> exportJson() async {
    // The generated client drops the body of this untyped route, so read it with Dio directly.
    final res = await _dio.get<dynamic>('/api/v1/me/export');
    final raw = res.data;
    return raw is String ? const JsonEncoder.withIndent('  ').convert(jsonDecode(raw)) : const JsonEncoder.withIndent('  ').convert(raw);
  }

  @override
  Future<void> deleteAccount() => _me.usersRemove();
}

final privacyRepositoryProvider = Provider<PrivacyRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiPrivacyRepository(api.getMeApi(), api.getPublicLegalApi(), api.dio);
});

/// Opens the privacy policy / terms page in the browser (Vietnamese or English).
Future<void> openLegal(WidgetRef ref, String doc) {
  final lang = ref.read(appLanguageProvider) == 'vi' ? 'vi' : 'en';
  return ref.read(openUrlProvider)(Uri.parse('${ref.read(apiBaseUrlProvider)}/api/v1/legal/$doc?lang=$lang'));
}

/// "By continuing you agree to the terms and privacy policy" with tappable links.
class LegalNotice extends ConsumerWidget {
  const LegalNotice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final small = Theme.of(context).textTheme.bodySmall;
    final vi = ref.watch(appLanguageProvider) == 'vi';
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(vi ? 'Tiếp tục nghĩa là bạn đồng ý với ' : 'By continuing you agree to the ', style: small),
        InkWell(
          onTap: () => openLegal(ref, 'terms'),
          child: Text(vi ? 'Điều khoản' : 'Terms', style: small?.copyWith(decoration: TextDecoration.underline)),
        ),
        Text(vi ? ' và ' : ' and ', style: small),
        InkWell(
          onTap: () => openLegal(ref, 'privacy'),
          child: Text(vi ? 'Chính sách quyền riêng tư' : 'Privacy policy', style: small?.copyWith(decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}

/// Account deletion with a clear confirmation. Pops nothing: the caller logs out on success.
Future<bool> confirmDeleteAccount(BuildContext context, WidgetRef ref) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('Xoá tài khoản?'),
      content: const Text(
        'Tên, số điện thoại, email, hồ sơ hoá đơn và món yêu thích sẽ bị xoá. '
        'Lịch sử đặt bàn được giữ ẩn danh cho sổ sách của quán. Không thể hoàn tác.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Giữ tài khoản')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Theme.of(c).colorScheme.error),
          onPressed: () => Navigator.pop(c, true),
          child: const Text('Xoá vĩnh viễn'),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return false;
  try {
    await ref.read(privacyRepositoryProvider).deleteAccount();
    await ref.read(sessionProvider.notifier).logout();
    return true;
  } catch (e) {
    final err = ApiError.from(e);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.code == 'ACTIVE_BOOKINGS' ? 'Hãy huỷ hoặc hoàn tất các đơn sắp tới trước khi xoá tài khoản' : err.userMessage),
        ),
      );
    }
    return false;
  }
}

final myDataProvider = FutureProvider.autoDispose<String>((ref) => ref.watch(privacyRepositoryProvider).exportJson());

/// "My data": the full copy the server keeps about the guest, with a copy button.
class MyDataScreen extends ConsumerWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text('Dữ liệu của tôi')),
    body: ref
        .watch(myDataProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
          data: (json) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: SelectableText(json, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: FilledButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: json));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Đã sao chép')));
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Sao chép'),
                ),
              ),
            ],
          ),
        ),
  );
}
