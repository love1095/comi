import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for WebhooksApi
void main() {
  final instance = ComiApi().getWebhooksApi();

  group(WebhooksApi, () {
    //Future webhooksPayos() async
    test('test webhooksPayos', () async {
      // TODO
    });

  });
}
