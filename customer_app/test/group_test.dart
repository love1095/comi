import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/data/realtime.dart';
import 'package:customer_app/data/session.dart';
import 'package:customer_app/data/token_store.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';
import 'package:customer_app/features/group/group_repository.dart';
import 'package:customer_app/features/group/group_screen.dart';
import 'package:customer_app/features/group/split_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

GroupViewDto groupView({List<GroupGuestDto>? guests, List<GroupItemDto> items = const [], bool locked = false}) => GroupViewDto(
  token: 'tok123456',
  link: 'https://comi.vn/g/tok123456',
  bookingId: 'b1',
  status: BookingStatus.CONFIRMED,
  restaurant: GroupRestaurantDto(id: 'r1', slug: 'quan-oc', name: 'Quán Ốc', address: '1 Lê Lợi'),
  arrivalAt: '2026-12-02T05:00:00.000Z',
  partySize: 4,
  cutoffAt: '2026-12-02T04:40:00.000Z',
  locked: locked,
  maxGuests: 4,
  guests: guests ?? [GroupGuestDto(id: 'host', displayName: 'Tuấn', isHost: true, subtotal: 0)],
  items: items,
  total: items.fold<num>(0, (s, i) => s + i.unitPrice * i.quantity),
);

class FakeGroups implements GroupRepository {
  GroupViewDto view = groupView();
  final calls = <String>[];
  SplitDto splitValue = SplitDto(total: 120000, paid: 0, guests: const []);

  GroupMemberDto _member(String guestId) => GroupMemberDto(
    token: view.token,
    link: view.link,
    bookingId: view.bookingId,
    status: view.status,
    restaurant: view.restaurant,
    arrivalAt: view.arrivalAt,
    partySize: view.partySize,
    cutoffAt: view.cutoffAt,
    locked: view.locked,
    maxGuests: view.maxGuests,
    guests: view.guests,
    items: view.items,
    total: view.total,
    guestId: guestId,
    guestKey: 'key-$guestId-0123456789',
  );

  @override
  Future<GroupMemberDto> start(String bookingId) async {
    calls.add('start $bookingId');
    return _member('host');
  }

  @override
  Future<GroupViewDto> lock(String bookingId) async {
    calls.add('lock');
    view = groupView(guests: view.guests, items: view.items, locked: true);
    return view;
  }

  @override
  Future<GroupViewDto> get(String token) async => view;

  @override
  Future<GroupMemberDto> join(String token, String displayName) async {
    calls.add('join $displayName');
    view = groupView(
      guests: [
        ...view.guests,
        GroupGuestDto(id: 'lan', displayName: displayName, isHost: false, subtotal: 0),
      ],
      items: view.items,
    );
    return _member('lan');
  }

  @override
  Future<GroupViewDto> addItems(String token, String guestKey, List<CartLineDto> items, {bool? ageConfirmed}) async {
    calls.add('add $guestKey ${items.map((l) => '${l.menuItemId}x${l.quantity}').join(',')}');
    final added = [
      for (final l in items)
        GroupItemDto(
          id: 'i-${l.menuItemId}',
          guestId: 'lan',
          menuItemId: l.menuItemId,
          nameSnapshot: 'Phở bò',
          unitPrice: 55000,
          quantity: l.quantity,
          optionsSnapshot: const [],
          course: Course.MAIN,
        ),
    ];
    view = groupView(guests: view.guests, items: [...view.items, ...added]);
    return view;
  }

  @override
  Future<GroupViewDto> removeItem(String token, String guestKey, String itemId) async {
    calls.add('remove $itemId');
    view = groupView(guests: view.guests, items: view.items.where((i) => i.id != itemId).toList());
    return view;
  }

  @override
  Future<SplitDto> split(String bookingId) async => splitValue;

  @override
  Future<SplitDto> saveSplit(String bookingId, SplitMode mode, {Map<String, int>? amounts}) async {
    calls.add('split ${mode.value}');
    splitValue = SplitDto(
      mode: SplitDtoModeEnum.values.byName(mode.value),
      total: 120000,
      paid: 0,
      guests: [
        SplitGuestDto(id: 'host', displayName: 'Tuấn', isHost: true, amountDue: 60000, amountPaid: 0),
        SplitGuestDto(id: 'lan', displayName: 'Lan', isHost: false, amountDue: 60000, amountPaid: 0),
      ],
    );
    return splitValue;
  }
}

void main() {
  Future<void> pump(
    WidgetTester tester,
    Widget screen, {
    required FakeGroups groups,
    MemoryGroupKeyStore? keys,
    List<Override> extra = const [],
  }) async {
    tester.view.physicalSize = const Size(420, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStoreProvider.overrideWithValue(store),
          locationServiceProvider.overrideWithValue(FakeLocation()),
          realtimeClientProvider.overrideWithValue(NoRealtimeClient()),
          groupRepositoryProvider.overrideWithValue(groups),
          groupKeyStoreProvider.overrideWithValue(keys ?? MemoryGroupKeyStore()),
          discoveryRepositoryProvider.overrideWithValue(
            FakeDiscovery(
              menuCats: [
                PublicMenuCategoryDto(id: 'c', name: 'Món chính', items: [dish('pho', 'Phở bò', price: 55000)]),
              ],
            ),
          ),
          ...extra,
        ],
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('friend opens the link: joins by name, adds and removes a dish', (tester) async {
    final groups = FakeGroups();
    final keys = MemoryGroupKeyStore();
    await pump(
      tester,
      const GroupScreen(token: 'tok123456'),
      groups: groups,
      keys: keys,
    );

    expect(find.text('Tham gia đặt món'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Tên của bạn'), 'Lan');
    await tester.tap(find.widgetWithText(FilledButton, 'Tham gia'));
    await tester.pumpAndSettle();
    expect(keys.values['tok123456']!.guestId, 'lan');
    expect(find.text('Lan · bạn'), findsOneWidget);

    await tester.tap(find.byTooltip('Thêm Phở bò'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gửi 1 món · ${formatVnd(55000)}'));
    await tester.pumpAndSettle();
    expect(groups.calls.last, 'add key-lan-0123456789 phox1');
    expect(find.text('1× Phở bò'), findsOneWidget);

    await tester.tap(find.byTooltip('Bỏ Phở bò'));
    await tester.pumpAndSettle();
    expect(groups.calls.last, 'remove i-pho');
  });

  testWidgets('host sees the invite link and locks the order', (tester) async {
    final groups = FakeGroups();
    final keys = MemoryGroupKeyStore()..values['tok123456'] = (guestId: 'host', guestKey: 'key-host-0123456789');
    await pump(
      tester,
      const GroupScreen(token: 'tok123456'),
      groups: groups,
      keys: keys,
    );

    expect(find.text('Chép link mời'), findsOneWidget);
    await tester.tap(find.text('Chốt đơn ngay'));
    await tester.pumpAndSettle();
    expect(groups.calls, ['lock']);
    expect(find.text('Đã chốt đơn'), findsOneWidget);
    expect(find.text('Chọn món của bạn'), findsNothing);
  });

  testWidgets('split: choose equal, see each person\'s share', (tester) async {
    final groups = FakeGroups();
    await pump(tester, const SplitScreen(bookingId: 'b1'), groups: groups);
    expect(find.text('Tổng hoá đơn: ${formatVnd(120000)}'), findsOneWidget);

    await tester.tap(find.text('Chia đều'));
    await tester.pumpAndSettle();
    expect(groups.calls, ['split EQUAL']);
    expect(find.text(formatVnd(60000)), findsNWidgets(2));
  });

  testWidgets('get home safe opens the ride app', (tester) async {
    final opened = <Uri>[];
    await pump(
      tester,
      const Scaffold(body: GetHomeSafeCard()),
      groups: FakeGroups(),
      extra: [
        openUrlProvider.overrideWithValue((u) async {
          opened.add(u);
          return true;
        }),
      ],
    );
    await tester.tap(find.text('Grab'));
    expect(opened.single.host, 'www.grab.com');
  });
}
