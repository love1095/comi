import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for PublicExchangeRatesApi
void main() {
  final instance = ComiApi().getPublicExchangeRatesApi();

  group(PublicExchangeRatesApi, () {
    //Future<List<ExchangeRateDto>> placesRates() async
    test('test placesRates', () async {
      // TODO
    });

    //Future<List<ExchangeRateDto>> placesSetRates(RatesDto ratesDto) async
    test('test placesSetRates', () async {
      // TODO
    });

  });
}
