import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerNotificationsApi
void main() {
  final instance = ComiApi().getCustomerNotificationsApi();

  group(CustomerNotificationsApi, () {
    //Future<NotificationPageDto> notificationsList({ String cursor }) async
    test('test notificationsList', () async {
      // TODO
    });

    //Future<UnreadDto> notificationsReadAll() async
    test('test notificationsReadAll', () async {
      // TODO
    });

    //Future<UnreadDto> notificationsReadOne(String id) async
    test('test notificationsReadOne', () async {
      // TODO
    });

  });
}
