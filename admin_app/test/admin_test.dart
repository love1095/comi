import 'package:admin_app/data/admin_repository.dart';
import 'package:admin_app/data/session.dart';
import 'package:admin_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'fakes.dart';

void main() {
  late FakeAdmin repo;
  late FakeAdminAuth auth;

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    repo = FakeAdmin();
    auth = FakeAdminAuth();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [adminRepositoryProvider.overrideWithValue(repo), adminAuthProvider.overrideWithValue(auth)],
        child: const AdminApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> signIn(WidgetTester tester, {String? code = '654321'}) async {
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'admin@comi.vn');
    await tester.enterText(find.widgetWithText(TextField, 'Mật khẩu'), 'password123');
    if (code != null) await tester.enterText(find.widgetWithText(TextField, 'Mã xác thực (6 số)'), code);
    await tester.tap(find.widgetWithText(FilledButton, 'Đăng nhập'));
    await tester.pumpAndSettle();
  }

  Future<void> open(WidgetTester tester, String page) async {
    await tester.tap(find.descendant(of: find.byType(NavigationRail), matching: find.text(page)));
    await tester.pumpAndSettle();
  }

  testWidgets('first sign-in without a code → authenticator setup → enabled → sign in again', (tester) async {
    await pump(tester);
    await signIn(tester, code: null);
    expect(find.text('JBSWY3DPEHPK3PXP'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Mã 6 số trong ứng dụng'), '000000');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Bật'));
    await tester.pumpAndSettle();
    expect(find.text('Mã xác thực sai hoặc đã dùng'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Mã 6 số trong ứng dụng'), '123456');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Bật'));
    await tester.pumpAndSettle();
    expect(auth.enabled, ['123456']);
    await tester.tap(find.text('Đăng nhập lại'));
    await tester.pumpAndSettle();
    expect(find.text('comi admin'), findsOneWidget);
  });

  testWidgets('wrong password is explained', (tester) async {
    await pump(tester);
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'admin@comi.vn');
    await tester.enterText(find.widgetWithText(TextField, 'Mật khẩu'), 'nope');
    await tester.tap(find.widgetWithText(FilledButton, 'Đăng nhập'));
    await tester.pumpAndSettle();
    expect(find.text('Email hoặc mật khẩu không đúng'), findsOneWidget);
  });

  testWidgets('dashboard → pending restaurant → approve', (tester) async {
    await pump(tester);
    await signIn(tester);
    expect(find.text('Đơn hôm nay'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    await tester.tap(find.text('Quán chờ duyệt'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quán r1'));
    await tester.pumpAndSettle();
    expect(find.text('Chờ duyệt'), findsWidgets);
    await tester.tap(find.widgetWithText(FilledButton, 'Duyệt'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('approve r1'));
    expect(find.text('Không có quán nào'), findsOneWidget);
  });

  testWidgets('reject needs a reason', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Quán');
    await tester.tap(find.text('Quán r1'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Từ chối'));
    await tester.pumpAndSettle();
    final ok = find.widgetWithText(FilledButton, 'Từ chối');
    expect(tester.widget<FilledButton>(ok).onPressed, isNull);
    await tester.enterText(find.widgetWithText(TextField, 'Lý do (quán sẽ thấy)'), 'Thiếu ảnh mặt tiền');
    await tester.pump();
    await tester.tap(ok);
    await tester.pumpAndSettle();
    expect(repo.calls, contains('reject r1 Thiếu ảnh mặt tiền'));
  });

  testWidgets('reported review: hide', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Đánh giá');
    expect(find.text('Lý do quán báo cáo: Khách chưa từng đến'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Ẩn'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('review rv1 hide=true'));
    expect(find.text('Không có đánh giá nào cần xem'), findsOneWidget);
  });

  testWidgets('guests: search, block with reason, clear no-shows, see bookings', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Khách');
    await tester.enterText(find.byType(TextField), '0901234567');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(repo.calls, contains('users 0901234567'));
    expect(find.textContaining('vắng 3 lần'), findsOneWidget);

    await tester.tap(find.text('Khoá'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Lý do (lưu trong nhật ký)'), 'Đặt bàn ảo');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Khoá'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('block u1 true Đặt bàn ảo'));
    expect(find.text('Mở khoá'), findsOneWidget);

    await tester.tap(find.text('Xoá vắng mặt'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Đồng ý'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('reset u1'));
    expect(find.textContaining('vắng 3 lần'), findsNothing);

    await tester.tap(find.text('Lan'));
    await tester.pumpAndSettle();
    expect(find.text('CM8K2P · Quán Ốc'), findsOneWidget);
  });

  testWidgets('booking lookup by code', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Tra cứu đơn');
    await tester.enterText(find.byType(TextField), 'CM8K2P');
    await tester.tap(find.widgetWithText(FilledButton, 'Tìm'));
    await tester.pumpAndSettle();
    expect(find.textContaining('4 người'), findsOneWidget);
  });

  testWidgets('statements: confirm transfer received', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Phí comi');
    expect(find.text('COMI R1 2611 · tháng 2026-11'), findsOneWidget);
    await tester.tap(find.text('Đã nhận tiền'));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(FilledButton, 'Đã nhận tiền')));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('paid s1'));
  });

  testWidgets('platform voucher: 30k first-order code', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Mã giảm giá');
    await tester.tap(find.text('Tạo mã'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Mã (VD: COMI30K)'), 'comi30k');
    await tester.enterText(find.widgetWithText(TextFormField, 'Số tiền (đ)'), '30000');
    await tester.tap(find.widgetWithText(FilledButton, 'Tạo'));
    await tester.pumpAndSettle();
    final v = repo.createdVoucher!;
    expect((v.code, v.value, v.firstOrderOnly), ('COMI30K', 30000, true));
  });

  testWidgets('exchange rates: edit and save', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Tỷ giá');
    expect(find.text('25400'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, '1 USD (Đô la Mỹ) = … đ'), '25600');
    await tester.tap(find.widgetWithText(FilledButton, 'Lưu'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('rates 25600.0'));
  });

  testWidgets('audit log and sign out', (tester) async {
    await pump(tester);
    await signIn(tester);
    await open(tester, 'Nhật ký');
    expect(find.textContaining('user.block · User'), findsOneWidget);
    await tester.tap(find.byTooltip('Đăng xuất'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Đăng nhập'), findsOneWidget);
  });
}
