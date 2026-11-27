import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantVouchersApi
void main() {
  final instance = ComiApi().getRestaurantVouchersApi();

  group(RestaurantVouchersApi, () {
    //Future<VoucherDto> restaurantVouchersActive(String id, String xRestaurantId, VoucherActiveDto voucherActiveDto) async
    test('test restaurantVouchersActive', () async {
      // TODO
    });

    //Future<VoucherDto> restaurantVouchersCreate(String xRestaurantId, VoucherInputDto voucherInputDto) async
    test('test restaurantVouchersCreate', () async {
      // TODO
    });

    //Future<List<VoucherDto>> restaurantVouchersList(String xRestaurantId) async
    test('test restaurantVouchersList', () async {
      // TODO
    });

  });
}
