import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantSplitBillApi
void main() {
  final instance = ComiApi().getRestaurantSplitBillApi();

  group(RestaurantSplitBillApi, () {
    //Future<SplitDto> restaurantSplitPaid(String id, String guestId, String xRestaurantId, MarkPaidDto markPaidDto) async
    test('test restaurantSplitPaid', () async {
      // TODO
    });

    //Future<SplitDto> restaurantSplitSaveSplit(String id, String xRestaurantId, SaveSplitDto saveSplitDto) async
    test('test restaurantSplitSaveSplit', () async {
      // TODO
    });

    //Future<SplitDto> restaurantSplitSplit(String id, String xRestaurantId) async
    test('test restaurantSplitSplit', () async {
      // TODO
    });

  });
}
