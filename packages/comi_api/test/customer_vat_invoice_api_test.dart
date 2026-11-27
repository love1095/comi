import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerVATInvoiceApi
void main() {
  final instance = ComiApi().getCustomerVATInvoiceApi();

  group(CustomerVATInvoiceApi, () {
    //Future<InvoiceRequestDto> customerInvoiceGet(String id) async
    test('test customerInvoiceGet', () async {
      // TODO
    });

    //Future<List<InvoiceProfileDto>> customerInvoiceProfiles() async
    test('test customerInvoiceProfiles', () async {
      // TODO
    });

    //Future<InvoiceRequestDto> customerInvoiceRequest(String id, InvoiceRequestCreateDto invoiceRequestCreateDto) async
    test('test customerInvoiceRequest', () async {
      // TODO
    });

  });
}
