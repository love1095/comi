import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerVouchersApi
void main() {
  final instance = ComiApi().getCustomerVouchersApi();

  group(CustomerVouchersApi, () {
    //Future<VoucherCheckResultDto> customerVouchersCheck(VoucherCheckDto voucherCheckDto) async
    test('test customerVouchersCheck', () async {
      // TODO
    });

  });
}
