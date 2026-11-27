import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/app/router.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/auth/login_screen.dart';
import 'package:restaurant_app/features/onboarding/location_screen.dart';
import 'package:restaurant_app/features/onboarding/onboarding_repository.dart';
import 'package:restaurant_app/features/onboarding/opening_hours_screen.dart';
import 'package:restaurant_app/features/onboarding/setup_screen.dart';
import 'package:shared_ui/shared_ui.dart';

import 'fakes.dart';

void main() {
  Future<void> pump(WidgetTester tester, FakeOnboardingRepository repo, Widget screen, {Size size = const Size(1280, 1200)}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = const StoredSession(refreshToken: 'r', restaurantId: 'r1', restaurantName: 'Quán Demo');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStoreProvider.overrideWithValue(store),
          onboardingRepositoryProvider.overrideWithValue(repo),
          restaurantIdProvider.overrideWithValue('r1'),
        ],
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('helpers', () {
    test('rangeProblem catches overlaps and inverted ranges', () {
      expect(rangeProblem([(open: 600, close: 840), (open: 1020, close: 1320)]), isNull);
      expect(rangeProblem([(open: 960, close: 1560)]), isNull); // until 02:00
      expect(rangeProblem([(open: 600, close: 900), (open: 840, close: 1320)]), 'Các khung giờ bị chồng nhau');
      expect(rangeProblem([(open: 900, close: 600)]), 'Giờ đóng phải sau giờ mở');
    });

    test('parseLatLng accepts Google Maps copies inside Vietnam only', () {
      expect(parseLatLng('10.7769, 106.7009'), (10.7769, 106.7009));
      expect(parseLatLng('21.0285 105.8542'), (21.0285, 105.8542));
      expect(parseLatLng('48.85, 2.35'), isNull); // Paris
      expect(parseLatLng('abc'), isNull);
    });

    test('logged in without a restaurant may open the register page', () {
      const noRestaurant = AsyncData(Session(refreshToken: 'r'));
      expect(sessionRedirect(noRestaurant, '/restaurants/new'), isNull);
      expect(sessionRedirect(noRestaurant, '/board'), '/restaurants');
      const full = AsyncData(Session(refreshToken: 'r', restaurantId: 'x'));
      expect(sessionRedirect(full, '/restaurants/new'), '/board');
      expect(sessionRedirect(full, '/setup'), isNull);
    });
  });

  group('SetupScreen', () {
    testWidgets('lists missing steps; submit only when complete', (tester) async {
      final repo = FakeOnboardingRepository();
      await pump(tester, repo, const SetupScreen());

      expect(find.text('Đang thiết lập'), findsOneWidget);
      expect(find.text('Hoàn tất các bước trên để gửi duyệt'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.ancestor(of: find.text('Gửi comi duyệt'), matching: find.byWidgetPredicate((w) => w is FilledButton)),
            )
            .onPressed,
        isNull,
      );

      repo.missing = const [];
      repo.profileValue = profileDto(lat: 10.7, hours: [OpeningHoursDto(weekday: 1, openMinute: 600, closeMinute: 1320)]);
      await tester.pumpWidget(const SizedBox()); // drop the cached providers
      await pump(tester, repo, const SetupScreen());

      await tester.tap(find.text('Gửi comi duyệt'));
      await tester.pumpAndSettle();
      expect(repo.calls, ['submit']);
      expect(find.text('Đang chờ duyệt'), findsOneWidget);
    });

    testWidgets('rejected restaurant shows the reason', (tester) async {
      final repo = FakeOnboardingRepository(
        profile: profileDto(status: RestaurantStatus.REJECTED, rejectReason: 'Ảnh món bị mờ'),
      );
      await pump(tester, repo, const SetupScreen());
      expect(find.text('Chưa được duyệt'), findsOneWidget);
      expect(find.text('Ảnh món bị mờ'), findsOneWidget);
    });
  });

  testWidgets('opening hours: preset for all days saves 7 × 2 ranges', (tester) async {
    final repo = FakeOnboardingRepository();
    await pump(tester, repo, const OpeningHoursScreen(initial: []));

    expect(find.text('Nghỉ'), findsWidgets);
    await tester.tap(find.textContaining('Trưa + tối'));
    await tester.pumpAndSettle();

    // Sunday off: untick everything but Sunday, then "Nghỉ".
    for (final d in ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7']) {
      await tester.tap(find.text(d));
    }
    await tester.tap(find.widgetWithText(ActionChip, 'Nghỉ'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();
    final saved = repo.savedHours!;
    expect(saved.length, 12);
    expect(saved.where((h) => h.weekday == 0), isEmpty);
    expect(saved.first.openMinute, 600);
  });

  testWidgets('location: search falls back to pasted coordinates', (tester) async {
    final repo = FakeOnboardingRepository()..geocodeError = Exception('offline');
    await pump(tester, repo, LocationScreen(profile: profileDto()));

    await tester.tap(find.byTooltip('Tìm'));
    await tester.pumpAndSettle();
    expect(find.textContaining('offline'), findsOneWidget); // search error shown, coordinates still possible

    await tester.enterText(find.widgetWithText(TextField, '10.7769, 106.7009'), '10.78, 106.70');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dùng toạ độ này'));
    await tester.pumpAndSettle();
    expect((repo.updated!.lat, repo.updated!.lng), (10.78, 106.70));
  });

  testWidgets('login screen switches to sign-up and validates password length', (tester) async {
    await pump(tester, FakeOnboardingRepository(), const LoginScreen());
    await tester.tap(find.text('Chủ quán mới? Đăng ký'));
    await tester.pumpAndSettle();
    expect(find.text('Họ tên'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Họ tên'), 'Chị Lan');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'lan@quan.vn');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mật khẩu'), 'short');
    await tester.tap(find.text('Tạo tài khoản'));
    await tester.pumpAndSettle();
    expect(find.text('Mật khẩu ít nhất 8 ký tự'), findsOneWidget);
  });
}
