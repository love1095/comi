import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for AdminApi
void main() {
  final instance = ComiApi().getAdminApi();

  group(AdminApi, () {
    //Future adminRestaurantsApprove(String id) async
    test('test adminRestaurantsApprove', () async {
      // TODO
    });

    //Future adminRestaurantsGet(String id) async
    test('test adminRestaurantsGet', () async {
      // TODO
    });

    //Future adminRestaurantsList({ String status }) async
    test('test adminRestaurantsList', () async {
      // TODO
    });

    //Future adminRestaurantsPause(String id) async
    test('test adminRestaurantsPause', () async {
      // TODO
    });

    //Future adminRestaurantsReject(String id, RejectDto rejectDto) async
    test('test adminRestaurantsReject', () async {
      // TODO
    });

  });
}
