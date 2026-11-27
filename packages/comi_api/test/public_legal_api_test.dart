import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for PublicLegalApi
void main() {
  final instance = ComiApi().getPublicLegalApi();

  group(PublicLegalApi, () {
    //Future<LegalInfoDto> legalInfo() async
    test('test legalInfo', () async {
      // TODO
    });

    //Future legalPage(String doc, { String lang }) async
    test('test legalPage', () async {
      // TODO
    });

  });
}
