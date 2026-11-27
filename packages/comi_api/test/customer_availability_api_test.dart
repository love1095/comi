import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerAvailabilityApi
void main() {
  final instance = ComiApi().getCustomerAvailabilityApi();

  group(CustomerAvailabilityApi, () {
    //Future availabilityGet(String id, String date, num partySize, { String areaId }) async
    test('test availabilityGet', () async {
      // TODO
    });

    //Future availabilityHold(String id, CreateHoldDto createHoldDto) async
    test('test availabilityHold', () async {
      // TODO
    });

    //Future availabilityRelease(String holdId) async
    test('test availabilityRelease', () async {
      // TODO
    });

    //Future availabilityTableMap(String id, String arrivalAt, num partySize, { String areaId }) async
    test('test availabilityTableMap', () async {
      // TODO
    });

  });
}
