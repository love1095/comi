import 'dart:async';

import 'package:comi_api/comi_api.dart';

import 'package:restaurant_app/data/realtime.dart';
import 'package:restaurant_app/features/bookings/bookings_repository.dart';
import 'package:restaurant_app/features/kitchen/kitchen_repository.dart';
import 'package:restaurant_app/features/onboarding/onboarding_repository.dart';
import 'package:restaurant_app/features/tables/tables_repository.dart';

TableDto tableDto(
  String id,
  String code, {
  num? x,
  num? y,
  num w = 2,
  num h = 2,
  bool active = true,
  bool selectable = true,
  num min = 1,
  num max = 4,
}) => TableDto(
  id: id,
  areaId: 'area1',
  code: code,
  minSeats: min,
  maxSeats: max,
  isActive: active,
  posX: x,
  posY: y,
  features: const [],
  shape: TableShape.RECT,
  width: w,
  height: h,
  rotation: 0,
  isSelectable: selectable,
  surcharge: 0,
);

AreaLayoutDto layoutDto({List<TableDto> tables = const [], List<MapElementResponseDto> elements = const [], num cols = 12, num rows = 8}) =>
    AreaLayoutDto(id: 'area1', name: 'Tầng 1', sortOrder: 0, gridCols: cols, gridRows: rows, floor: 1, tables: tables, elements: elements);

class FakeTablesRepository implements TablesRepository {
  FakeTablesRepository(this.layout);

  AreaLayoutDto layout;
  SaveLayoutDto? lastSaved;

  @override
  Future<List<AreaSummaryDto>> listAreas() async => [
    AreaSummaryDto(id: layout.id, name: layout.name, sortOrder: 0, gridCols: layout.gridCols, gridRows: layout.gridRows, floor: 1),
  ];

  @override
  Future<AreaSummaryDto> createArea({required String name, int? cols, int? rows, int? floor}) async =>
      AreaSummaryDto(id: 'new', name: name, sortOrder: 0, gridCols: cols ?? 12, gridRows: rows ?? 8, floor: floor ?? 1);

  @override
  Future<AreaLayoutDto> getLayout(String areaId) async => layout;

  @override
  Future<AreaLayoutDto> saveLayout(String areaId, SaveLayoutDto dto) async {
    lastSaved = dto;
    var n = 0;
    layout = layoutDto(
      cols: dto.gridCols ?? layout.gridCols,
      rows: dto.gridRows ?? layout.gridRows,
      tables: [
        for (final t in dto.tables)
          tableDto(
            t.id ?? 'srv${++n}',
            t.code,
            x: t.posX,
            y: t.posY,
            w: t.width ?? 2,
            h: t.height ?? 2,
            active: t.isActive ?? true,
            selectable: t.isSelectable ?? true,
            min: t.minSeats ?? 1,
            max: t.maxSeats,
          ),
      ],
    );
    return layout;
  }
}

BoardUserDto userDto({String? name = 'Anh Minh', String? phone = '+84901234567', num noShows = 0}) =>
    BoardUserDto(id: 'u1', name: name, phone: phone, noShowCount: noShows);

/// `arrival` is UTC; 05:00Z = 12:00 in Vietnam.
BoardBookingDto boardDto(
  String id, {
  String code = 'ABC123',
  num party = 2,
  String arrival = '2026-12-02T05:00:00.000Z',
  BookingStatus status = BookingStatus.CONFIRMED,
  bool needsApproval = false,
  String? tableCode = 'A1',
  num? total,
  num noShows = 0,
}) => BoardBookingDto(
  id: id,
  code: code,
  partySize: party,
  arrivalAt: arrival,
  endsAt: DateTime.parse(arrival).add(const Duration(minutes: 45)).toIso8601String(),
  status: status,
  paymentMode: PaymentMode.COD,
  needsApproval: needsApproval,
  tableId: tableCode == null ? null : 't-$tableCode',
  extraTableIds: const [],
  table: tableCode == null ? null : BoardTableDto(id: 't-$tableCode', code: tableCode),
  user: userDto(noShows: noShows),
  order: total == null ? null : BoardOrderDto(total: total),
);

BookingDetailDto detailOf(BoardBookingDto b, {List<BoardOrderItemDto> items = const []}) => BookingDetailDto(
  id: b.id,
  code: b.code,
  partySize: b.partySize,
  arrivalAt: b.arrivalAt,
  endsAt: b.endsAt,
  status: b.status,
  paymentMode: b.paymentMode,
  needsApproval: b.needsApproval,
  tableId: b.tableId,
  extraTableIds: b.extraTableIds,
  table: b.table,
  user: b.user,
  order: items.isEmpty
      ? null
      : BookingDetailOrderDto(
          id: 'o-${b.id}',
          total: items.fold<num>(0, (s, i) => s + i.unitPrice * i.quantity),
          subtotal: items.fold<num>(0, (s, i) => s + i.unitPrice * i.quantity),
          restaurantDiscount: 0,
          platformDiscount: 0,
          items: items,
        ),
);

BoardOrderItemDto itemDto(
  String name, {
  num price = 50000,
  num qty = 1,
  Course course = Course.MAIN,
  List<OptionSnapshotDto> options = const [],
}) => BoardOrderItemDto(
  id: 'i-$name',
  nameSnapshot: name,
  unitPrice: price,
  quantity: qty,
  optionsSnapshot: options,
  course: course,
  kitchenStatus: KitchenStatus.HOLD,
  round: 0,
);

/// In-memory bookings that apply approve / cancel / move like the server would.
class FakeBookingsRepository implements BookingsRepository {
  FakeBookingsRepository(List<BoardBookingDto> bookings, {this.tables = const [], Map<String, List<BoardOrderItemDto>>? items})
    : _bookings = {for (final b in bookings) b.id: b},
      _items = items ?? {};

  final Map<String, BoardBookingDto> _bookings;
  final Map<String, List<BoardOrderItemDto>> _items;
  final List<TableDto> tables;
  final calls = <String>[];
  String? lastDate;

  BoardBookingDto _copy(BoardBookingDto b, {BookingStatus? status, bool? needsApproval, BoardTableDto? table}) => BoardBookingDto(
    id: b.id,
    code: b.code,
    partySize: b.partySize,
    arrivalAt: b.arrivalAt,
    endsAt: b.endsAt,
    status: status ?? b.status,
    paymentMode: b.paymentMode,
    needsApproval: needsApproval ?? b.needsApproval,
    tableId: table?.id ?? b.tableId,
    extraTableIds: b.extraTableIds,
    table: table ?? b.table,
    user: b.user,
    order: b.order,
  );

  BookingDetailDto _detail(String id) => detailOf(_bookings[id]!, items: _items[id] ?? const []);

  @override
  Future<List<BoardBookingDto>> list(String date, {BookingStatus? status, String? q}) async {
    lastDate = date;
    return _bookings.values.where((b) => q == null || b.code.contains(q.toUpperCase())).toList();
  }

  @override
  Future<BookingDetailDto> get(String id) async => _detail(id);

  @override
  Future<BookingDetailDto> approve(String id) async {
    calls.add('approve $id');
    _bookings[id] = _copy(_bookings[id]!, status: BookingStatus.CONFIRMED, needsApproval: false);
    return _detail(id);
  }

  @override
  Future<BookingDetailDto> cancel(String id, String reason) async {
    calls.add('cancel $id $reason');
    _bookings[id] = _copy(_bookings[id]!, status: BookingStatus.CANCELLED);
    return _detail(id);
  }

  @override
  Future<BookingDetailDto> moveTable(String id, String tableId) async {
    calls.add('move $id $tableId');
    final t = tables.firstWhere((t) => t.id == tableId);
    _bookings[id] = _copy(
      _bookings[id]!,
      table: BoardTableDto(id: t.id, code: t.code),
    );
    return _detail(id);
  }

  @override
  Future<List<TableDto>> listTables() async => tables;
}

RestaurantProfileDto profileDto({
  RestaurantStatus status = RestaurantStatus.DRAFT,
  num? lat,
  List<OpeningHoursDto> hours = const [],
  String? rejectReason,
}) => RestaurantProfileDto(
  id: 'r1',
  slug: 'quan-demo',
  name: 'Quán Demo',
  phone: '0901234567',
  address: '12 Nguyễn Huệ',
  provinceCode: '79',
  lat: lat,
  lng: lat == null ? null : 106.7,
  timezone: 'Asia/Ho_Chi_Minh',
  cuisineTags: const [],
  ambienceTags: const [],
  priceLevel: 1,
  status: status,
  rejectReason: rejectReason,
  slotMinutes: 15,
  diningMinutes: 90,
  graceMinutes: 15,
  minLeadMinutes: 30,
  maxDaysAhead: 30,
  allowCod: true,
  servesLunch: true,
  servesNhau: true,
  maxGroupSize: 30,
  confirmGroupsOver: 10,
  allowTableChoice: true,
  cancelCutoffMinutes: 60,
  startEarlyOnCheckIn: true,
  codStartOnDepart: false,
  allowTableOrdering: true,
  tableOrderingNeedsApproval: false,
  ratingAvg: 0,
  ratingCount: 0,
  openingHours: hours,
);

class FakeOnboardingRepository implements OnboardingRepository {
  FakeOnboardingRepository({RestaurantProfileDto? profile, this.missing = const ['location', 'openingHours', 'tables', 'menuItems']})
    : profileValue = profile ?? profileDto();

  RestaurantProfileDto profileValue;
  List<String> missing;
  final calls = <String>[];
  List<OpeningHoursItemDto>? savedHours;
  UpdateProfileDto? updated;
  RegisterRestaurantDto? registered;
  Object? geocodeError;

  @override
  Future<RestaurantProfileDto> register(RegisterRestaurantDto dto) async {
    registered = dto;
    return profileValue;
  }

  @override
  Future<RestaurantProfileDto> profile(String restaurantId) async => profileValue;

  @override
  Future<RestaurantProfileDto> updateProfile(String restaurantId, UpdateProfileDto dto) async {
    updated = dto;
    missing = missing.where((m) => m != 'location').toList();
    return profileValue;
  }

  @override
  Future<List<GeocodeResultDto>> geocode(String query) async {
    if (geocodeError != null) throw geocodeError!;
    return [GeocodeResultDto(address: '$query, TP.HCM', lat: 10.7769, lng: 106.7009)];
  }

  @override
  Future<List<OpeningHoursDto>> setOpeningHours(String restaurantId, List<OpeningHoursItemDto> items) async {
    savedHours = items;
    missing = missing.where((m) => m != 'openingHours').toList();
    return const [];
  }

  @override
  Future<ChecklistDto> checklist(String restaurantId) async => ChecklistDto(complete: missing.isEmpty, missing: missing);

  UpdateSettingsDto? settings;

  @override
  Future<RestaurantProfileDto> updateSettings(String restaurantId, UpdateSettingsDto dto) async {
    settings = dto;
    return profileValue;
  }

  @override
  Future<RestaurantProfileDto> submit(String restaurantId) async {
    calls.add('submit');
    profileValue = profileDto(status: RestaurantStatus.PENDING_REVIEW, lat: 10.7);
    return profileValue;
  }
}

class FakeRealtime implements RealtimeClient {
  final controller = StreamController<RealtimeEvent>.broadcast();

  void send(String name, [Map<String, dynamic> data = const {}]) => controller.add(RealtimeEvent(name, data));

  @override
  Stream<RealtimeEvent> get events => controller.stream;

  @override
  void dispose() => controller.close();
}

KitchenItemDto kitchenItem(
  String id,
  String name, {
  KitchenStatus status = KitchenStatus.QUEUED,
  Course course = Course.MAIN,
  String? scheduled,
  String? started,
  num quantity = 1,
  String table = 'A1',
}) => KitchenItemDto(
  id: id,
  bookingId: 'b1',
  bookingCode: 'CM-8K2P',
  tableCode: table,
  partySize: 4,
  arrivalAt: '2026-12-02T05:00:00.000Z',
  guestArrived: status != KitchenStatus.HOLD,
  nameSnapshot: name,
  quantity: quantity,
  optionsSnapshot: const [],
  course: course,
  prepMinutes: 15,
  kitchenStatus: status,
  round: 0,
  scheduledStartAt: scheduled,
  startedAt: started,
);

class FakeKitchenRepository implements KitchenRepository {
  FakeKitchenRepository({List<KitchenItemDto>? items, this.requests = const [], this.billValue}) : items = items ?? [];

  List<KitchenItemDto> items;
  List<ServiceRequestDto> requests;
  BillDto? billValue;
  final calls = <String>[];
  String now = '2026-12-02T05:10:00.000Z';

  @override
  Future<KitchenQueueDto> queue() async => KitchenQueueDto(
    now: now,
    active: items.where((i) => i.kitchenStatus == KitchenStatus.QUEUED || i.kitchenStatus == KitchenStatus.COOKING).toList(),
    ready: items.where((i) => i.kitchenStatus == KitchenStatus.READY).toList(),
    upcoming: items.where((i) => i.kitchenStatus == KitchenStatus.HOLD || i.kitchenStatus == KitchenStatus.SCHEDULED).toList(),
  );

  @override
  Future<KitchenItemDto> setStatus(String itemId, KitchenStatusDtoStatusEnum to) async {
    calls.add('status $itemId ${to.value}');
    final i = items.indexWhere((x) => x.id == itemId);
    final old = items[i];
    items[i] = kitchenItem(old.id, old.nameSnapshot, status: KitchenStatus.values.byName(to.value), started: now);
    return items[i];
  }

  @override
  Future<int> fire(String bookingId, {Course? course}) async {
    calls.add('fire $bookingId ${course?.value ?? 'ALL'}');
    return 1;
  }

  @override
  Future<List<ServiceRequestDto>> openRequests() async => requests;

  @override
  Future<void> finishRequest(String id) async {
    calls.add('done $id');
    requests = requests.where((r) => r.id != id).toList();
  }

  BookingDetailDto Function(String id)? detail;

  @override
  Future<BookingDetailDto> checkIn(String bookingId) async {
    calls.add('checkIn $bookingId');
    return detail!(bookingId);
  }

  @override
  Future<BookingDetailDto> extendGrace(String bookingId) async {
    calls.add('extend $bookingId');
    return detail!(bookingId);
  }

  @override
  Future<BillDto> bill(String bookingId) async =>
      billValue ?? BillDto(bookingId: bookingId, code: 'CM', status: BookingStatus.CHECKED_IN, rounds: const [], total: 0);

  @override
  Future<BookingDetailDto> closeBill(String bookingId, {int? amount}) async {
    calls.add('close $bookingId $amount');
    return detail!(bookingId);
  }

  @override
  Future<RoundResultDto> addRound(String bookingId, List<CartLineDto> items) async {
    calls.add('round $bookingId ${items.map((l) => '${l.menuItemId}x${l.quantity}').join(',')}');
    return RoundResultDto(round: 1, needsApproval: false, total: 0);
  }

  @override
  Future<int> approveRound(String bookingId, int round) async {
    calls.add('approve $bookingId $round');
    return 1;
  }

  List<CapacityRuleInput>? savedRules;

  @override
  Future<List<CapacityRuleDto>> capacityRules() async => const [];

  @override
  Future<List<CapacityRuleDto>> saveCapacityRules(List<CapacityRuleInput> rules) async {
    savedRules = rules;
    return const [];
  }

  SplitDto splitValue = SplitDto(total: 100000, paid: 0, guests: const []);

  @override
  Future<SplitDto> split(String bookingId) async => splitValue;

  @override
  Future<SplitDto> saveSplit(String bookingId, SplitMode mode, {int? people}) async {
    calls.add('split ${mode.value} $people');
    final n = people ?? 2;
    splitValue = SplitDto(
      mode: SplitDtoModeEnum.values.byName(mode.value),
      total: 100000,
      paid: 0,
      guests: [
        for (var i = 0; i < n; i++)
          SplitGuestDto(
            id: 'g$i',
            displayName: 'Khách ${i + 1}',
            isHost: i == 0,
            amountDue: 100000 ~/ n + (i == 0 ? 100000 % n : 0),
            amountPaid: 0,
          ),
      ],
    );
    return splitValue;
  }

  @override
  Future<SplitDto> markPaid(String bookingId, String guestId, bool paid) async {
    calls.add('paid $guestId $paid');
    splitValue = SplitDto(
      mode: splitValue.mode,
      total: splitValue.total,
      paid: splitValue.guests.where((g) => g.id == guestId).fold<num>(0, (s, g) => s + g.amountDue),
      guests: [
        for (final g in splitValue.guests)
          g.id == guestId
              ? SplitGuestDto(
                  id: g.id,
                  displayName: g.displayName,
                  isHost: g.isHost,
                  amountDue: g.amountDue,
                  amountPaid: g.amountDue,
                  paidAt: paid ? '2026-12-02T06:00:00Z' : null,
                )
              : g,
      ],
    );
    return splitValue;
  }
}
