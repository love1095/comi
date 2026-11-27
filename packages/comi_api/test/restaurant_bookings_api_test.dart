import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantBookingsApi
void main() {
  final instance = ComiApi().getRestaurantBookingsApi();

  group(RestaurantBookingsApi, () {
    //Future restaurantBookingsApprove(String id, String xRestaurantId) async
    test('test restaurantBookingsApprove', () async {
      // TODO
    });

    //Future restaurantBookingsCancel(String id, String xRestaurantId, RestaurantCancelDto restaurantCancelDto) async
    test('test restaurantBookingsCancel', () async {
      // TODO
    });

    //Future restaurantBookingsGet(String id, String xRestaurantId) async
    test('test restaurantBookingsGet', () async {
      // TODO
    });

    //Future restaurantBookingsList(String date, String xRestaurantId, { String status, String q }) async
    test('test restaurantBookingsList', () async {
      // TODO
    });

    //Future restaurantBookingsMoveTable(String id, String xRestaurantId, MoveTableDto moveTableDto) async
    test('test restaurantBookingsMoveTable', () async {
      // TODO
    });

  });
}
