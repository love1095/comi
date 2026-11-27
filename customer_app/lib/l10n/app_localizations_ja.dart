// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navExplore => 'さがす';

  @override
  String get navBookings => '予約';

  @override
  String get navAccount => 'アカウント';

  @override
  String get greetingLunch => '今日のランチは？';

  @override
  String get greetingTonight => '今夜はどこへ？';

  @override
  String get greetingDefault => '近くのおいしいお店';

  @override
  String get nearYou => '現在地周辺';

  @override
  String get findingLocation => '現在地を取得中…';

  @override
  String get loginPhoneTitle => '電話番号でログインして予約';

  @override
  String get loginEmailTitle => 'メールでログインして予約';

  @override
  String get useEmail => 'ベトナムの番号がない場合はメール';

  @override
  String get usePhone => 'ベトナムの電話番号を使う';

  @override
  String get continueButton => '次へ';

  @override
  String get language => '言語';

  @override
  String get translatedAutomatically => '自動翻訳';

  @override
  String get showToDriver => '運転手に見せる';

  @override
  String get notifications => 'お知らせ';

  @override
  String get noNotifications => 'お知らせはありません';

  @override
  String get markAllRead => 'すべて既読';

  @override
  String get reviews => 'レビュー';

  @override
  String get verifiedVisit => '来店済み';

  @override
  String get openNow => '営業中';

  @override
  String get closedNow => '営業時間外';
}
