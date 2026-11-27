import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for AdminVouchersApi
void main() {
  final instance = ComiApi().getAdminVouchersApi();

  group(AdminVouchersApi, () {
    //Future<VoucherDto> adminVouchersActive(String id, VoucherActiveDto voucherActiveDto) async
    test('test adminVouchersActive', () async {
      // TODO
    });

    //Future<VoucherDto> adminVouchersCreate(AdminVoucherInputDto adminVoucherInputDto) async
    test('test adminVouchersCreate', () async {
      // TODO
    });

    //Future<List<VoucherDto>> adminVouchersList() async
    test('test adminVouchersList', () async {
      // TODO
    });

  });
}
