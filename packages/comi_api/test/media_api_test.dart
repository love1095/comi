import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for MediaApi
void main() {
  final instance = ComiApi().getMediaApi();

  group(MediaApi, () {
    //Future mediaSignature(String kind, String xRestaurantId) async
    test('test mediaSignature', () async {
      // TODO
    });

  });
}
