import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for AdminStatementsApi
void main() {
  final instance = ComiApi().getAdminStatementsApi();

  group(AdminStatementsApi, () {
    //Future adminStatementsGenerate(String month) async
    test('test adminStatementsGenerate', () async {
      // TODO
    });

    //Future<List<StatementDto>> adminStatementsList({ String status }) async
    test('test adminStatementsList', () async {
      // TODO
    });

    //Future<StatementDetailDto> adminStatementsPaid(String id) async
    test('test adminStatementsPaid', () async {
      // TODO
    });

  });
}
