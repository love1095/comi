import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerPaymentsApi
void main() {
  final instance = ComiApi().getCustomerPaymentsApi();

  group(CustomerPaymentsApi, () {
    //Future<PaymentDto> customerPaymentsPay(String id) async
    test('test customerPaymentsPay', () async {
      // TODO
    });

    //Future<UpdatedDto> customerPaymentsRefundAccount(String id, RefundAccountDto refundAccountDto) async
    test('test customerPaymentsRefundAccount', () async {
      // TODO
    });

  });
}
