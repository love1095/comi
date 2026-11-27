import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantVATInvoiceApi
void main() {
  final instance = ComiApi().getRestaurantVATInvoiceApi();

  group(RestaurantVATInvoiceApi, () {
    //Future<InvoiceRequestDto> restaurantInvoiceIssued(String id, String xRestaurantId, MarkIssuedDto markIssuedDto) async
    test('test restaurantInvoiceIssued', () async {
      // TODO
    });

    //Future<List<InvoiceRequestDto>> restaurantInvoiceList(String xRestaurantId, { String all }) async
    test('test restaurantInvoiceList', () async {
      // TODO
    });

    //Future<InvoiceRequestDto> restaurantInvoiceReject(String id, String xRestaurantId) async
    test('test restaurantInvoiceReject', () async {
      // TODO
    });

  });
}
