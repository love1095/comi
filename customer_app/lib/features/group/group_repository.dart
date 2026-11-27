import 'dart:async';

import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/realtime.dart';
import '../../data/session.dart';

/// Group orders (§8.4) and split bill (§8.5).
abstract class GroupRepository {
  Future<GroupMemberDto> start(String bookingId);
  Future<GroupViewDto> lock(String bookingId);
  Future<GroupViewDto> get(String token);
  Future<GroupMemberDto> join(String token, String displayName);
  Future<GroupViewDto> addItems(String token, String guestKey, List<CartLineDto> items, {bool? ageConfirmed});
  Future<GroupViewDto> removeItem(String token, String guestKey, String itemId);
  Future<SplitDto> split(String bookingId);
  Future<SplitDto> saveSplit(String bookingId, SplitMode mode, {Map<String, int>? amounts});
  Future<PaymentDto> payShare(String token, String guestKey);
}

class ApiGroupRepository implements GroupRepository {
  ApiGroupRepository(this._public, this._host);
  final PublicGroupOrderApi _public;
  final CustomerGroupOrderApi _host;

  @override
  Future<GroupMemberDto> start(String bookingId) async =>
      (await _host.customerGroupStart(id: bookingId, startGroupDto: StartGroupDto())).data!;

  @override
  Future<GroupViewDto> lock(String bookingId) async => (await _host.customerGroupLock(id: bookingId)).data!;

  @override
  Future<GroupViewDto> get(String token) async => (await _public.publicGroupGet(token: token)).data!;

  @override
  Future<GroupMemberDto> join(String token, String displayName) async => (await _public.publicGroupJoin(
    token: token,
    joinGroupDto: JoinGroupDto(displayName: displayName),
  )).data!;

  @override
  Future<GroupViewDto> addItems(String token, String guestKey, List<CartLineDto> items, {bool? ageConfirmed}) async =>
      (await _public.publicGroupAdd(
        token: token,
        groupItemsDto: GroupItemsDto(guestKey: guestKey, items: items, ageConfirmed: ageConfirmed),
      )).data!;

  @override
  Future<GroupViewDto> removeItem(String token, String guestKey, String itemId) async => (await _public.publicGroupRemove(
    token: token,
    itemId: itemId,
    guestKeyDto: GuestKeyDto(guestKey: guestKey),
  )).data!;

  @override
  Future<SplitDto> split(String bookingId) async => (await _host.customerGroupSplit(id: bookingId)).data!;

  @override
  Future<SplitDto> saveSplit(String bookingId, SplitMode mode, {Map<String, int>? amounts}) async => (await _host.customerGroupSaveSplit(
    id: bookingId,
    saveSplitDto: SaveSplitDto(mode: mode, amounts: amounts),
  )).data!;

  @override
  Future<PaymentDto> payShare(String token, String guestKey) async => (await _public.groupPaymentsPay(
    token: token,
    guestKeyPayDto: GuestKeyPayDto(guestKey: guestKey),
  )).data!;
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiGroupRepository(api.getPublicGroupOrderApi(), api.getCustomerGroupOrderApi());
});

/// My member key per group token (returned once by join/start; the server keeps only a hash).
abstract class GroupKeyStore {
  Future<({String guestId, String guestKey})?> read(String token);
  Future<void> write(String token, String guestId, String guestKey);
  Future<void> clear(String token);
}

class SecureGroupKeyStore implements GroupKeyStore {
  const SecureGroupKeyStore([this._s = const FlutterSecureStorage()]);
  final FlutterSecureStorage _s;

  @override
  Future<({String guestId, String guestKey})?> read(String token) async {
    final v = await _s.read(key: 'comi.group.$token');
    final parts = v?.split('|');
    return parts == null || parts.length != 2 ? null : (guestId: parts[0], guestKey: parts[1]);
  }

  @override
  Future<void> write(String token, String guestId, String guestKey) => _s.write(key: 'comi.group.$token', value: '$guestId|$guestKey');

  @override
  Future<void> clear(String token) => _s.delete(key: 'comi.group.$token');
}

class MemoryGroupKeyStore implements GroupKeyStore {
  final values = <String, ({String guestId, String guestKey})>{};

  @override
  Future<({String guestId, String guestKey})?> read(String token) async => values[token];

  @override
  Future<void> write(String token, String guestId, String guestKey) async => values[token] = (guestId: guestId, guestKey: guestKey);

  @override
  Future<void> clear(String token) async => values.remove(token);
}

final groupKeyStoreProvider = Provider<GroupKeyStore>((ref) => const SecureGroupKeyStore());

/// Shared cart; reloads on socket hints for this group and every 15 s as a fallback.
final groupProvider = FutureProvider.autoDispose.family<GroupViewDto, String>((ref, token) async {
  final client = ref.watch(realtimeClientProvider);
  client.joinGroup(token);
  ref.listen(realtimeEventsProvider, (_, next) {
    final e = next.value;
    if (e != null && (e.name == 'group.updated' || e.name == RealtimeEvent.reconnected)) ref.invalidateSelf();
  });
  final timer = Timer(const Duration(seconds: 15), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  return ref.watch(groupRepositoryProvider).get(token);
});

final splitProvider = FutureProvider.autoDispose.family<SplitDto, String>(
  (ref, bookingId) => ref.watch(groupRepositoryProvider).split(bookingId),
);

String splitModeLabel(SplitMode m) => switch (m) {
  SplitMode.EQUAL => 'Chia đều',
  SplitMode.BY_ITEMS => 'Theo món mỗi người',
  SplitMode.CUSTOM => 'Tự nhập',
};
