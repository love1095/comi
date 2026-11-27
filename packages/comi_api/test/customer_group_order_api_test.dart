import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerGroupOrderApi
void main() {
  final instance = ComiApi().getCustomerGroupOrderApi();

  group(CustomerGroupOrderApi, () {
    //Future<GroupViewDto> customerGroupLock(String id) async
    test('test customerGroupLock', () async {
      // TODO
    });

    //Future<SplitDto> customerGroupSaveSplit(String id, SaveSplitDto saveSplitDto) async
    test('test customerGroupSaveSplit', () async {
      // TODO
    });

    //Future<SplitDto> customerGroupSplit(String id) async
    test('test customerGroupSplit', () async {
      // TODO
    });

    //Future<GroupMemberDto> customerGroupStart(String id, StartGroupDto startGroupDto) async
    test('test customerGroupStart', () async {
      // TODO
    });

  });
}
