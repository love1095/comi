import 'package:admin_app/data/admin_repository.dart';
import 'package:admin_app/data/api_error.dart';
import 'package:admin_app/data/session.dart';
import 'package:comi_api/comi_api.dart';

class FakeAdminAuth implements AdminAuth {
  final enabled = <String>[];

  @override
  Future<AdminLoginResultDto> login(String email, String password, String? code) async {
    if (password != 'password123') throw const ApiError('INVALID_CREDENTIALS', 'bad');
    return AdminLoginResultDto(accessToken: 'a', refreshToken: 'r', expiresIn: 900, mfa: code != null);
  }

  @override
  Future<MfaSetupDto> setup(String accessToken) async => MfaSetupDto(secret: 'JBSWY3DPEHPK3PXP', otpauthUrl: 'otpauth://totp/x');

  @override
  Future<void> enable(String accessToken, String code) async {
    if (code != '123456') throw const ApiError('MFA_CODE_INVALID', 'bad');
    enabled.add(code);
  }
}

RestaurantProfileDto profile(String id, RestaurantStatus status) => RestaurantProfileDto(
  id: id,
  slug: 'quan-$id',
  name: 'Quán $id',
  phone: '0901234567',
  address: '1 Lê Lợi, Q1',
  provinceCode: '79',
  lat: 10.77,
  lng: 106.7,
  timezone: 'Asia/Ho_Chi_Minh',
  cuisineTags: const ['lẩu'],
  ambienceTags: const [],
  priceLevel: 2,
  status: status,
  slotMinutes: 15,
  diningMinutes: 90,
  graceMinutes: 15,
  minLeadMinutes: 30,
  maxDaysAhead: 30,
  allowCod: true,
  servesLunch: true,
  servesNhau: false,
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
  openingHours: const [],
);

class FakeAdmin implements AdminRepository {
  final calls = <String>[];
  final statuses = <String, RestaurantStatus>{'r1': RestaurantStatus.PENDING_REVIEW};
  var userRows = [
    AdminUserDto(
      id: 'u1',
      name: 'Lan',
      phone: '+84901234567',
      status: AdminUserDtoStatusEnum.ACTIVE,
      noShowCount: 3,
      mustPrepay: true,
      bookings: 5,
      createdAt: '2026-11-01T00:00:00Z',
    ),
  ];
  var statementRows = [
    StatementDto(
      id: 's1',
      restaurantId: 'r1',
      periodMonth: '2026-11',
      bookingCount: 40,
      totalBase: 8000000,
      totalFee: 400000,
      platformVoucherCredit: 0,
      amountDue: 400000,
      status: StatementDtoStatusEnum.ISSUED,
      transferMemo: 'COMI R1 2611',
    ),
  ];
  var voucherRows = <VoucherDto>[];
  AdminVoucherInputDto? createdVoucher;
  Map<String, double> rateValues = {'USD': 25400, 'KRW': 18.5, 'CNY': 3500, 'JPY': 165};

  @override
  Future<AdminDashboardDto> dashboard() async => AdminDashboardDto(
    restaurants: {'PENDING_REVIEW': statuses.values.where((s) => s == RestaurantStatus.PENDING_REVIEW).length, 'ACTIVE': 12},
    bookingsToday: 31,
    bookingsMonth: 640,
    gmvMonth: 152000000,
    noShowsMonth: 9,
    newUsersMonth: 210,
    reportedReviews: 1,
    overdueStatements: 0,
    pendingRefunds: 0,
  );

  @override
  Future<List<AdminRestaurantRowDto>> restaurants(String status) async => [
    for (final e in statuses.entries)
      if (e.value.value == status)
        AdminRestaurantRowDto(
          id: e.key,
          slug: 'quan-${e.key}',
          name: 'Quán ${e.key}',
          address: '1 Lê Lợi, Q1',
          phone: '0901234567',
          status: e.value,
        ),
  ];

  @override
  Future<RestaurantProfileDto> restaurant(String id) async => profile(id, statuses[id]!);

  RestaurantProfileDto _set(String id, RestaurantStatus s, String call) {
    calls.add(call);
    statuses[id] = s;
    return profile(id, s);
  }

  @override
  Future<RestaurantProfileDto> approve(String id) async => _set(id, RestaurantStatus.ACTIVE, 'approve $id');

  @override
  Future<RestaurantProfileDto> reject(String id, String reason) async => _set(id, RestaurantStatus.REJECTED, 'reject $id $reason');

  @override
  Future<RestaurantProfileDto> pause(String id) async => _set(id, RestaurantStatus.PAUSED, 'pause $id');

  var reviewRows = [
    ReviewDto(
      id: 'rv1',
      bookingId: 'b1',
      restaurantId: 'r1',
      authorName: 'Minh',
      rating: 1,
      text: 'Tệ',
      verifiedVisit: true,
      visitedAt: '2026-11-20T05:00:00Z',
      partySize: 2,
      reportReason: 'Khách chưa từng đến',
      status: ReviewDtoStatusEnum.REPORTED,
      createdAt: '2026-11-20T08:00:00Z',
    ),
  ];

  @override
  Future<List<ReviewDto>> reportedReviews() async => reviewRows;

  @override
  Future<ReviewDto> decideReview(String id, {required bool hide}) async {
    calls.add('review $id hide=$hide');
    final r = reviewRows.firstWhere((x) => x.id == id);
    reviewRows = [];
    return r;
  }

  @override
  Future<List<AdminUserDto>> users(String? q) async {
    calls.add('users ${q ?? ''}');
    return userRows;
  }

  AdminUserDto _user(AdminUserDto u, {AdminUserDtoStatusEnum? status, bool reset = false}) => AdminUserDto(
    id: u.id,
    name: u.name,
    phone: u.phone,
    status: status ?? u.status,
    noShowCount: reset ? 0 : u.noShowCount,
    mustPrepay: reset ? false : u.mustPrepay,
    bookings: u.bookings,
    createdAt: u.createdAt,
  );

  @override
  Future<AdminUserDto> block(String id, {required bool blocked, String? reason}) async {
    calls.add('block $id $blocked ${reason ?? ''}'.trim());
    userRows = [_user(userRows.first, status: blocked ? AdminUserDtoStatusEnum.BLOCKED : AdminUserDtoStatusEnum.ACTIVE)];
    return userRows.first;
  }

  @override
  Future<AdminUserDto> resetNoShow(String id) async {
    calls.add('reset $id');
    userRows = [_user(userRows.first, reset: true)];
    return userRows.first;
  }

  @override
  Future<List<AdminBookingDto>> bookings({String? code, String? userId, String? restaurantId}) async => [
    if (code == 'CM8K2P' || userId != null)
      AdminBookingDto(
        id: 'b1',
        code: 'CM8K2P',
        status: 'CONFIRMED',
        arrivalAt: '2026-12-02T05:00:00Z',
        partySize: 4,
        restaurantName: 'Quán Ốc',
        restaurantId: 'r1',
        guestPhone: '+84901234567',
        total: 450000,
        paymentMode: 'COD',
      ),
  ];

  @override
  Future<List<StatementDto>> statements(String? status) async => statementRows.where((s) => s.status.value == status).toList();

  @override
  Future<void> markStatementPaid(String id) async => calls.add('paid $id');

  @override
  Future<void> generateStatements(String month) async => calls.add('generate $month');

  @override
  Future<List<VoucherDto>> vouchers() async => voucherRows;

  @override
  Future<VoucherDto> createVoucher(AdminVoucherInputDto dto) async {
    createdVoucher = dto;
    return VoucherDto(
      id: 'v1',
      code: dto.code,
      fundedBy: VoucherFunder.PLATFORM,
      type: dto.type,
      value: dto.value,
      minOrder: dto.minOrder ?? 0,
      startsAt: dto.startsAt,
      endsAt: dto.endsAt,
      perUserLimit: 1,
      firstOrderOnly: dto.firstOrderOnly ?? false,
      usedCount: 0,
      isActive: true,
    );
  }

  @override
  Future<VoucherDto> setVoucherActive(String id, bool active) async => throw UnimplementedError();

  @override
  Future<Map<String, double>> rates() async => rateValues;

  @override
  Future<void> setRates(Map<String, double> rates) async {
    calls.add('rates ${rates['USD']}');
    rateValues = rates;
  }

  @override
  Future<List<AuditEntryDto>> audit({String? entity, String? entityId, String? before}) async => [
    AuditEntryDto(
      id: 'a1',
      actorType: 'STAFF',
      actorId: 'aaaaaaaa-1',
      action: 'user.block',
      entity: 'User',
      entityId: 'u1',
      createdAt: '2026-12-01T03:00:00Z',
    ),
  ];
}
