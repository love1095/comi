import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @navExplore.
  ///
  /// In vi, this message translates to:
  /// **'Khám phá'**
  String get navExplore;

  /// No description provided for @navBookings.
  ///
  /// In vi, this message translates to:
  /// **'Đơn của tôi'**
  String get navBookings;

  /// No description provided for @navAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get navAccount;

  /// No description provided for @greetingLunch.
  ///
  /// In vi, this message translates to:
  /// **'Trưa nay ăn gì?'**
  String get greetingLunch;

  /// No description provided for @greetingTonight.
  ///
  /// In vi, this message translates to:
  /// **'Tối nay đi đâu?'**
  String get greetingTonight;

  /// No description provided for @greetingDefault.
  ///
  /// In vi, this message translates to:
  /// **'Tìm quán ngon gần bạn'**
  String get greetingDefault;

  /// No description provided for @nearYou.
  ///
  /// In vi, this message translates to:
  /// **'Gần bạn'**
  String get nearYou;

  /// No description provided for @findingLocation.
  ///
  /// In vi, this message translates to:
  /// **'Đang tìm vị trí…'**
  String get findingLocation;

  /// No description provided for @loginPhoneTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập bằng số điện thoại để đặt bàn'**
  String get loginPhoneTitle;

  /// No description provided for @loginEmailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập bằng email để đặt bàn'**
  String get loginEmailTitle;

  /// No description provided for @useEmail.
  ///
  /// In vi, this message translates to:
  /// **'Không có số Việt Nam? Dùng email'**
  String get useEmail;

  /// No description provided for @usePhone.
  ///
  /// In vi, this message translates to:
  /// **'Dùng số điện thoại Việt Nam'**
  String get usePhone;

  /// No description provided for @continueButton.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueButton;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @translatedAutomatically.
  ///
  /// In vi, this message translates to:
  /// **'Dịch tự động'**
  String get translatedAutomatically;

  /// No description provided for @showToDriver.
  ///
  /// In vi, this message translates to:
  /// **'Đưa tài xế xem'**
  String get showToDriver;

  /// No description provided for @notifications.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có thông báo'**
  String get noNotifications;

  /// No description provided for @markAllRead.
  ///
  /// In vi, this message translates to:
  /// **'Đã đọc hết'**
  String get markAllRead;

  /// No description provided for @reviews.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá'**
  String get reviews;

  /// No description provided for @verifiedVisit.
  ///
  /// In vi, this message translates to:
  /// **'Đã đến quán'**
  String get verifiedVisit;

  /// No description provided for @openNow.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở'**
  String get openNow;

  /// No description provided for @closedNow.
  ///
  /// In vi, this message translates to:
  /// **'Đang đóng'**
  String get closedNow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
