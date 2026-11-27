import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/language.dart';
import '../../data/session.dart';

/// Tourist helpers: approximate foreign prices and the "show to taxi driver" card.
abstract class TouristRepository {
  Future<Map<String, double>> rates();
}

class ApiTouristRepository implements TouristRepository {
  ApiTouristRepository(this._api);
  final PublicExchangeRatesApi _api;

  @override
  Future<Map<String, double>> rates() async => {
    for (final r in (await _api.placesRates()).data ?? const <ExchangeRateDto>[]) r.currency.value: r.vndPerUnit.toDouble(),
  };
}

final touristRepositoryProvider = Provider<TouristRepository>(
  (ref) => ApiTouristRepository(ref.watch(apiProvider).getPublicExchangeRatesApi()),
);

final exchangeRatesProvider = FutureProvider<Map<String, double>>((ref) => ref.watch(touristRepositoryProvider).rates());

/// Currency shown next to VND, from the app language (none for Vietnamese).
final foreignCurrencyProvider = Provider<String?>(
  (ref) => switch (ref.watch(contentLocaleProvider)) {
    'en' => 'USD',
    'ko' => 'KRW',
    'zh' => 'CNY',
    'ja' => 'JPY',
    _ => null,
  },
);

const _symbol = {'USD': r'$', 'KRW': '₩', 'CNY': '¥', 'JPY': '¥'};

/// "≈ $5.91" — same rounding as the backend helper.
String approxPrice(num vnd, double vndPerUnit, String currency) {
  final v = vnd / vndPerUnit;
  final s = _symbol[currency] ?? '$currency ';
  if (currency == 'KRW' || currency == 'JPY') {
    final step = v >= 1000 ? 100 : 10;
    final n = (v / step).round() * step;
    return '≈ $s${n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+$)'), (_) => ',')}';
  }
  return '≈ $s${v.toStringAsFixed(2)}';
}

/// Small grey approximate price, or nothing for Vietnamese users / missing rates.
class ApproxPrice extends ConsumerWidget {
  const ApproxPrice(this.vnd, {super.key});
  final num vnd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cur = ref.watch(foreignCurrencyProvider);
    if (cur == null) return const SizedBox.shrink();
    final rate = ref.watch(exchangeRatesProvider).value?[cur];
    if (rate == null) return const SizedBox.shrink();
    return Text(
      approxPrice(vnd, rate, cur),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
    );
  }
}

/// Big, high-contrast name + address in Vietnamese for a taxi / Grab driver.
class TaxiCardScreen extends StatelessWidget {
  const TaxiCardScreen({super.key, required this.name, required this.address, this.phone});
  final String name;
  final String address;
  final String? phone;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Text(context.l10n.showToDriver),
      actions: [
        IconButton(
          tooltip: 'Copy address',
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: '$name, $address'));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Copied')));
          },
        ),
      ],
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cho tôi đến:', style: TextStyle(fontSize: 22, color: Colors.black54)),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(address, style: const TextStyle(fontSize: 28, color: Colors.black)),
            if (phone != null) ...[
              const SizedBox(height: 16),
              Text('ĐT: $phone', style: const TextStyle(fontSize: 22, color: Colors.black87)),
            ],
            const Spacer(),
            const Text('Cảm ơn anh/chị!', style: TextStyle(fontSize: 22, color: Colors.black54)),
          ],
        ),
      ),
    ),
  );
}
