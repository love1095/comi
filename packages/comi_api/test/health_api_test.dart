import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for HealthApi
void main() {
  final instance = ComiApi().getHealthApi();

  group(HealthApi, () {
    //Future healthCheck() async
    test('test healthCheck', () async {
      // TODO
    });

  });
}
