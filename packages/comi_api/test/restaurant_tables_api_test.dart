import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantTablesApi
void main() {
  final instance = ComiApi().getRestaurantTablesApi();

  group(RestaurantTablesApi, () {
    //Future tablesCreateArea(String xRestaurantId, AreaDto areaDto) async
    test('test tablesCreateArea', () async {
      // TODO
    });

    //Future tablesCreateTable(String xRestaurantId, CreateTableDto createTableDto) async
    test('test tablesCreateTable', () async {
      // TODO
    });

    //Future tablesDeleteArea(String id, String xRestaurantId) async
    test('test tablesDeleteArea', () async {
      // TODO
    });

    //Future tablesDeleteTable(String id, String xRestaurantId) async
    test('test tablesDeleteTable', () async {
      // TODO
    });

    //Future tablesEntranceQr(String xRestaurantId) async
    test('test tablesEntranceQr', () async {
      // TODO
    });

    //Future tablesGetLayout(String id, String xRestaurantId) async
    test('test tablesGetLayout', () async {
      // TODO
    });

    //Future tablesListAreas(String xRestaurantId) async
    test('test tablesListAreas', () async {
      // TODO
    });

    //Future tablesListTables(String xRestaurantId, { String areaId }) async
    test('test tablesListTables', () async {
      // TODO
    });

    //Future tablesPrintQr(String xRestaurantId, { String areaId }) async
    test('test tablesPrintQr', () async {
      // TODO
    });

    //Future tablesRotateQr(String id, String xRestaurantId) async
    test('test tablesRotateQr', () async {
      // TODO
    });

    //Future tablesSaveLayout(String id, String xRestaurantId, SaveLayoutDto saveLayoutDto) async
    test('test tablesSaveLayout', () async {
      // TODO
    });

    //Future tablesTableQr(String id, String xRestaurantId) async
    test('test tablesTableQr', () async {
      // TODO
    });

    //Future tablesUpdateArea(String id, String xRestaurantId, UpdateAreaDto updateAreaDto) async
    test('test tablesUpdateArea', () async {
      // TODO
    });

    //Future tablesUpdateTable(String id, String xRestaurantId, UpdateTableDto updateTableDto) async
    test('test tablesUpdateTable', () async {
      // TODO
    });

  });
}
