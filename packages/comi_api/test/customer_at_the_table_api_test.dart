import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerAtTheTableApi
void main() {
  final instance = ComiApi().getCustomerAtTheTableApi();

  group(CustomerAtTheTableApi, () {
    //Future<BillDto> customerTableBill(String id) async
    test('test customerTableBill', () async {
      // TODO
    });

    //Future<CustomerBookingDto> customerTableCheckIn(String id, CheckInDto checkInDto) async
    test('test customerTableCheckIn', () async {
      // TODO
    });

    //Future<DepartResultDto> customerTableDepart(String id, DepartDto departDto) async
    test('test customerTableDepart', () async {
      // TODO
    });

    //Future<RoundResultDto> customerTableOrder(String id, TableOrderDto tableOrderDto) async
    test('test customerTableOrder', () async {
      // TODO
    });

    //Future<ServiceRequestDto> customerTableService(String id, ServiceRequestCreateDto serviceRequestCreateDto) async
    test('test customerTableService', () async {
      // TODO
    });

  });
}
