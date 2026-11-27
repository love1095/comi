import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerDiscoveryApi
void main() {
  final instance = ComiApi().getCustomerDiscoveryApi();

  group(CustomerDiscoveryApi, () {
    //Future discoveryDetail(String slug, String acceptLanguage, { String acceptLanguage2 }) async
    test('test discoveryDetail', () async {
      // TODO
    });

    //Future discoveryHome(num lat, num lng, String acceptLanguage, { String acceptLanguage2 }) async
    test('test discoveryHome', () async {
      // TODO
    });

    //Future discoveryMap(String bbox) async
    test('test discoveryMap', () async {
      // TODO
    });

    //Future discoveryMenu(String id, String acceptLanguage, { String acceptLanguage2 }) async
    test('test discoveryMenu', () async {
      // TODO
    });

    //Future discoveryNearby(num lat, num lng, String acceptLanguage, { num radius, String q, String cuisine, num priceMax, num minRating, bool openNow, num maxMainPrice, num groupSize, bool openLate, bool privateRoom, String mode, String sort, num cursor, num limit, String acceptLanguage2 }) async
    test('test discoveryNearby', () async {
      // TODO
    });

    //Future discoverySuggest(String q, { num lat, num lng }) async
    test('test discoverySuggest', () async {
      // TODO
    });

  });
}
