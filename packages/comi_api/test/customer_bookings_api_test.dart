import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerBookingsApi
void main() {
  final instance = ComiApi().getCustomerBookingsApi();

  group(CustomerBookingsApi, () {
    //Future bookingsCancel(String id, CancelDto cancelDto) async
    test('test bookingsCancel', () async {
      // TODO
    });

    //Future bookingsCreate(String idempotencyKey, CreateBookingDto createBookingDto, { String idempotencyKey2 }) async
    test('test bookingsCreate', () async {
      // TODO
    });

    //Future bookingsGet(String id) async
    test('test bookingsGet', () async {
      // TODO
    });

    //Future bookingsList({ String status, String cursor, num limit }) async
    test('test bookingsList', () async {
      // TODO
    });

    //Future bookingsReorder(String id) async
    test('test bookingsReorder', () async {
      // TODO
    });

  });
}
