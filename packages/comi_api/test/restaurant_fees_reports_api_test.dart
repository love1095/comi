import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantFeesReportsApi
void main() {
  final instance = ComiApi().getRestaurantFeesReportsApi();

  group(RestaurantFeesReportsApi, () {
    //Future restaurantFeesPdf(String id, String xRestaurantId) async
    test('test restaurantFeesPdf', () async {
      // TODO
    });

    //Future<ReportDto> restaurantFeesReport(String from, String to, String xRestaurantId) async
    test('test restaurantFeesReport', () async {
      // TODO
    });

    //Future<StatementDetailDto> restaurantFeesStatement(String id, String xRestaurantId) async
    test('test restaurantFeesStatement', () async {
      // TODO
    });

    //Future<List<StatementDto>> restaurantFeesStatements(String xRestaurantId) async
    test('test restaurantFeesStatements', () async {
      // TODO
    });

  });
}
