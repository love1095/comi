import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantSettingsApi
void main() {
  final instance = ComiApi().getRestaurantSettingsApi();

  group(RestaurantSettingsApi, () {
    //Future diningRulesCreate(String xRestaurantId, DiningRuleDto diningRuleDto) async
    test('test diningRulesCreate', () async {
      // TODO
    });

    //Future diningRulesList(String xRestaurantId) async
    test('test diningRulesList', () async {
      // TODO
    });

    //Future diningRulesRemove(String id, String xRestaurantId) async
    test('test diningRulesRemove', () async {
      // TODO
    });

  });
}
