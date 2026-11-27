import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for PublicGroupOrderApi
void main() {
  final instance = ComiApi().getPublicGroupOrderApi();

  group(PublicGroupOrderApi, () {
    //Future<GroupViewDto> publicGroupAdd(String token, GroupItemsDto groupItemsDto) async
    test('test publicGroupAdd', () async {
      // TODO
    });

    //Future<GroupViewDto> publicGroupGet(String token) async
    test('test publicGroupGet', () async {
      // TODO
    });

    //Future<GroupMemberDto> publicGroupJoin(String token, JoinGroupDto joinGroupDto) async
    test('test publicGroupJoin', () async {
      // TODO
    });

    //Future<GroupViewDto> publicGroupRemove(String token, String itemId, GuestKeyDto guestKeyDto) async
    test('test publicGroupRemove', () async {
      // TODO
    });

  });
}
