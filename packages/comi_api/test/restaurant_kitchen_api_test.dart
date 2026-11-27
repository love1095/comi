import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantKitchenApi
void main() {
  final instance = ComiApi().getRestaurantKitchenApi();

  group(RestaurantKitchenApi, () {
    //Future<FireResultDto> kitchenFire(String id, String xRestaurantId, FireDto fireDto) async
    test('test kitchenFire', () async {
      // TODO
    });

    //Future<KitchenQueueDto> kitchenQueue(String xRestaurantId) async
    test('test kitchenQueue', () async {
      // TODO
    });

    //Future<KitchenItemDto> kitchenSetStatus(String id, String xRestaurantId, KitchenStatusDto kitchenStatusDto) async
    test('test kitchenSetStatus', () async {
      // TODO
    });

  });
}
