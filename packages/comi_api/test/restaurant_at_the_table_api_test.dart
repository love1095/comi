import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantAtTheTableApi
void main() {
  final instance = ComiApi().getRestaurantAtTheTableApi();

  group(RestaurantAtTheTableApi, () {
    //Future<FireResultDto> restaurantTableApproveRound(String id, num round, String xRestaurantId) async
    test('test restaurantTableApproveRound', () async {
      // TODO
    });

    //Future<BillDto> restaurantTableBill(String id, String xRestaurantId) async
    test('test restaurantTableBill', () async {
      // TODO
    });

    //Future<BookingDetailDto> restaurantTableCheckIn(String id, String xRestaurantId) async
    test('test restaurantTableCheckIn', () async {
      // TODO
    });

    //Future<BookingDetailDto> restaurantTableClose(String id, String xRestaurantId, CloseBillDto closeBillDto) async
    test('test restaurantTableClose', () async {
      // TODO
    });

    //Future<ServiceRequestDto> restaurantTableDone(String id, String xRestaurantId) async
    test('test restaurantTableDone', () async {
      // TODO
    });

    //Future<BookingDetailDto> restaurantTableExtendGrace(String id, String xRestaurantId) async
    test('test restaurantTableExtendGrace', () async {
      // TODO
    });

    //Future<RoundResultDto> restaurantTableOrder(String id, String xRestaurantId, TableOrderDto tableOrderDto) async
    test('test restaurantTableOrder', () async {
      // TODO
    });

    //Future<List<ServiceRequestDto>> restaurantTableRequests(String xRestaurantId) async
    test('test restaurantTableRequests', () async {
      // TODO
    });

  });
}
