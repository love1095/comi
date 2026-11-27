import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantPaymentsApi
void main() {
  final instance = ComiApi().getRestaurantPaymentsApi();

  group(RestaurantPaymentsApi, () {
    //Future<PaymentAccountStatusDto> restaurantPaymentsAccount(String xRestaurantId) async
    test('test restaurantPaymentsAccount', () async {
      // TODO
    });

    //Future<PaymentAccountStatusDto> restaurantPaymentsConnect(String xRestaurantId, ConnectPayOsDto connectPayOsDto) async
    test('test restaurantPaymentsConnect', () async {
      // TODO
    });

    //Future<PaymentAccountStatusDto> restaurantPaymentsDisconnect(String xRestaurantId) async
    test('test restaurantPaymentsDisconnect', () async {
      // TODO
    });

    //Future<RefundDto> restaurantPaymentsDone(String id, String xRestaurantId, RefundDoneDto refundDoneDto) async
    test('test restaurantPaymentsDone', () async {
      // TODO
    });

    //Future<List<RefundDto>> restaurantPaymentsRefunds(String xRestaurantId, { String status }) async
    test('test restaurantPaymentsRefunds', () async {
      // TODO
    });

  });
}
