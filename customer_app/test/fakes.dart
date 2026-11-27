import 'package:comi_api/comi_api.dart';
import 'package:customer_app/data/location.dart';
import 'package:customer_app/features/booking/bookings_repository.dart';
import 'package:customer_app/features/discovery/discovery_repository.dart';

PublicMenuItemDto dish(
  String id,
  String name, {
  num price = 50000,
  Course course = Course.MAIN,
  bool alcohol = false,
  bool available = true,
  List<PublicOptionGroupDto> groups = const [],
}) => PublicMenuItemDto(
  id: id,
  name: name,
  translated: PublicMenuItemDtoTranslatedEnum.none,
  originalName: name,
  price: price,
  course: course,
  kind: ItemKind.DISH,
  prepMinutes: 10,
  isAvailable: available,
  isPreorderable: true,
  isAlcohol: alcohol,
  leadHours: 0,
  tags: const [],
  photos: const [],
  optionGroups: groups,
);

RestaurantDetailDto restaurantDetail({num confirmGroupsOver = 10, num maxGroupSize = 30, bool prepaid = false}) => RestaurantDetailDto(
  prepaidAvailable: prepaid,
  id: 'r1',
  slug: 'quan-oc',
  name: 'Quán Ốc Bờ Kè',
  translated: RestaurantDetailDtoTranslatedEnum.none,
  phone: '0901234567',
  address: '12 Bờ Kè, Quận 1',
  timezone: 'Asia/Ho_Chi_Minh',
  cuisineTags: const ['quán nhậu'],
  ambienceTags: const [],
  priceLevel: 2,
  ratingAvg: 4.6,
  ratingCount: 120,
  servesLunch: true,
  servesNhau: true,
  allowTableChoice: false,
  allowCod: true,
  maxGroupSize: maxGroupSize,
  confirmGroupsOver: confirmGroupsOver,
  cancelCutoffMinutes: 60,
  isOpenNow: true,
  openingHours: [
    for (final d in [1, 2, 3, 4, 5]) OpeningHoursDto(weekday: d, openMinute: 600, closeMinute: 1320),
    for (final d in [6, 0]) OpeningHoursDto(weekday: d, openMinute: 960, closeMinute: 1560),
  ],
  closures: const [],
  areas: const [],
);

RestaurantCardDto card(String id, String name, {num distance = 350}) => RestaurantCardDto(
  id: id,
  slug: 'slug-$id',
  name: name,
  address: '1 Lê Lợi',
  priceLevel: 1,
  ratingAvg: 4.5,
  ratingCount: 10,
  cuisineTags: const [],
  servesLunch: true,
  servesNhau: false,
  allowTableChoice: false,
  lat: 10.77,
  lng: 106.70,
  distanceM: distance,
  minMainPrice: 45000,
);

class FakeLocation implements LocationService {
  @override
  Future<LatLngPoint> current() async => const LatLngPoint(10.7769, 106.7009);
}

class FakeDiscovery implements DiscoveryRepository {
  FakeDiscovery({this.menuCats = const [], List<SlotDto>? slots, this.homeDto, this.prepaid = false}) : slots = slots ?? const [];
  bool prepaid;
  List<PublicMenuCategoryDto> menuCats;
  List<SlotDto> slots;
  HomeDto? homeDto;
  final nearbyCalls = <SearchFilters>[];
  final slotQueries = <(String, int)>[];

  @override
  Future<HomeDto> home(LatLngPoint at) async => homeDto ?? HomeDto(mode: HomeDtoModeEnum.lunch, sections: const []);

  @override
  Future<RestaurantPageDto> nearby(LatLngPoint at, SearchFilters f, {int? cursor}) async {
    nearbyCalls.add(f);
    return RestaurantPageDto(items: [card('a', 'Cơm Tấm Ba Ghiền')]);
  }

  @override
  Future<SuggestDto> suggest(String q, LatLngPoint at) async => SuggestDto(restaurants: const [], dishes: const []);

  @override
  Future<RestaurantDetailDto> detail(String slug) async => restaurantDetail(prepaid: prepaid);

  @override
  Future<List<PublicMenuCategoryDto>> menu(String restaurantId) async => menuCats;

  @override
  Future<List<SlotDto>> availability(String restaurantId, String date, int partySize) async {
    slotQueries.add((date, partySize));
    return slots;
  }

  @override
  Future<List<MapPinDto>> pins(double minLng, double minLat, double maxLng, double maxLat) async => const [];
}

CustomerBookingDto bookingDto({
  String id = 'b1',
  BookingStatus status = BookingStatus.CONFIRMED,
  bool needsApproval = false,
  List<BoardOrderItemDto> items = const [],
  PaymentMode paymentMode = PaymentMode.COD,
  List<BookingPaymentDto> payments = const [],
  List<BookingRefundDto> refunds = const [],
}) => CustomerBookingDto(
  id: id,
  code: 'CM-8K2P',
  restaurantId: 'r1',
  partySize: 4,
  arrivalAt: '2026-12-02T12:00:00.000Z',
  endsAt: '2026-12-02T14:00:00.000Z',
  paymentMode: paymentMode,
  payments: payments,
  refunds: refunds,
  serveStyle: ServeStyle.BY_COURSE,
  status: status,
  needsApproval: needsApproval,
  extraTableIds: const [],
  createdAt: '2026-12-01T00:00:00.000Z',
  restaurant: BookingRestaurantDto(
    id: 'r1',
    slug: 'quan-oc',
    name: 'Quán Ốc Bờ Kè',
    address: '12 Bờ Kè',
    phone: '0901234567',
    timezone: 'Asia/Ho_Chi_Minh',
  ),
  order: items.isEmpty
      ? null
      : CustomerOrderDto(
          id: 'o1',
          subtotal: items.fold<num>(0, (s, i) => s + i.unitPrice * i.quantity),
          restaurantDiscount: 0,
          platformDiscount: 0,
          total: items.fold<num>(0, (s, i) => s + i.unitPrice * i.quantity),
          status: OrderStatus.PLACED,
          items: items,
        ),
);

class FakeBookings implements BookingsRepository {
  FakeBookings({List<CustomerBookingDto>? upcoming}) : upcoming = upcoming ?? [];
  List<CustomerBookingDto> upcoming;
  CreateBookingDto? created;
  final keys = <String>[];
  final calls = <String>[];
  Object? createError;
  BookingStatus createdStatus = BookingStatus.CONFIRMED;
  PaymentMode createdMode = PaymentMode.COD;

  @override
  Future<CustomerBookingDto> create(CreateBookingDto dto, {required String idempotencyKey}) async {
    keys.add(idempotencyKey);
    if (createError != null) {
      final e = createError!;
      createError = null;
      throw e;
    }
    created = dto;
    return bookingDto(id: 'new', status: createdStatus, paymentMode: createdMode);
  }

  @override
  Future<MyBookingsPageDto> mine({required bool upcoming, String? cursor}) async =>
      MyBookingsPageDto(items: upcoming ? this.upcoming : const []);

  @override
  Future<CustomerBookingDto> get(String id) async => upcoming.firstWhere((b) => b.id == id, orElse: () => bookingDto(id: id));

  @override
  Future<CustomerBookingDto> cancel(String id, {String? reason}) async {
    calls.add('cancel $id');
    upcoming = [for (final b in upcoming) b.id == id ? bookingDto(id: id, status: BookingStatus.CANCELLED) : b];
    return upcoming.firstWhere((b) => b.id == id);
  }

  @override
  Future<ReorderDraftDto> reorder(String id) => throw UnimplementedError();

  PaymentDto? payResult;
  ({String bankBin, String accountNo, String accountName})? refundAccount;

  @override
  Future<PaymentDto> pay(String id) async {
    calls.add('pay $id');
    return payResult ??
        PaymentDto(
          id: 'p1',
          bookingId: id,
          amount: 100000,
          status: PaymentDtoStatusEnum.PENDING,
          purpose: PaymentDtoPurposeEnum.BOOKING,
          checkoutUrl: 'https://pay.payos.vn/web/x',
          expiresAt: '2026-12-02T04:15:00Z',
          refundedAmount: 0,
        );
  }

  @override
  Future<void> setRefundAccount(String id, {required String bankBin, required String accountNo, required String accountName}) async {
    refundAccount = (bankBin: bankBin, accountNo: accountNo, accountName: accountName);
  }

  @override
  Future<MeDto> me() async =>
      MeDto(id: 'u1', phone: '+84901234567', locale: 'vi', noShowCount: 0, mustPrepay: false, createdAt: '2026-01-01');

  String? checkedInWith;
  List<CartLineDto>? ordered;
  BillDto? billValue;

  @override
  Future<CustomerBookingDto> checkIn(String id, String qrPayload) async {
    checkedInWith = qrPayload;
    upcoming = [for (final b in upcoming) b.id == id ? bookingDto(id: id, status: BookingStatus.CHECKED_IN) : b];
    return get(id);
  }

  @override
  Future<DepartResultDto> depart(String id, double lat, double lng) async {
    calls.add('depart $id');
    return DepartResultDto(etaAt: '2026-12-02T12:07:00.000Z', travelMinutes: 7);
  }

  @override
  Future<RoundResultDto> orderMore(String id, List<CartLineDto> items, {bool? ageConfirmed}) async {
    ordered = items;
    return RoundResultDto(round: 1, needsApproval: false, total: 0);
  }

  @override
  Future<BillDto> bill(String id) async =>
      billValue ?? BillDto(bookingId: id, code: 'CM', status: BookingStatus.CHECKED_IN, rounds: const [], total: 0);

  @override
  Future<ServiceRequestDto> requestService(String id, ServiceType type) async {
    calls.add('service ${type.value}');
    return ServiceRequestDto(
      id: 's1',
      bookingId: id,
      bookingCode: 'CM',
      type: type,
      status: ServiceRequestDtoStatusEnum.OPEN,
      createdAt: '2026-12-02T12:00:00Z',
    );
  }
}

MapTableStateDto mapTable(
  String id,
  String code, {
  int x = 0,
  int min = 2,
  int max = 4,
  MapTableStateDtoStateEnum state = MapTableStateDtoStateEnum.available,
  String? group,
}) => MapTableStateDto(
  id: id,
  code: code,
  minSeats: min,
  maxSeats: max,
  shape: TableShape.RECT,
  posX: x,
  posY: 0,
  width: 2,
  height: 2,
  rotation: 0,
  features: const [],
  isSelectable: true,
  surcharge: 0,
  joinGroup: group,
  state: state,
);
