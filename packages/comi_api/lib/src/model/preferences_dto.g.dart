// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreferencesDtoCWProxy {
  PreferencesDto lunchReminder(bool? lunchReminder);

  PreferencesDto lunchReminderMinute(num? lunchReminderMinute);

  PreferencesDto dietaryTags(List<String>? dietaryTags);

  PreferencesDto showApproxCurrency(
    PreferencesDtoShowApproxCurrencyEnum? showApproxCurrency,
  );

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PreferencesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PreferencesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PreferencesDto call({
    bool? lunchReminder,
    num? lunchReminderMinute,
    List<String>? dietaryTags,
    PreferencesDtoShowApproxCurrencyEnum? showApproxCurrency,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPreferencesDto.copyWith(...)` or call `instanceOfPreferencesDto.copyWith.fieldName(value)` for a single field.
class _$PreferencesDtoCWProxyImpl implements _$PreferencesDtoCWProxy {
  const _$PreferencesDtoCWProxyImpl(this._value);

  final PreferencesDto _value;

  @override
  PreferencesDto lunchReminder(bool? lunchReminder) =>
      call(lunchReminder: lunchReminder);

  @override
  PreferencesDto lunchReminderMinute(num? lunchReminderMinute) =>
      call(lunchReminderMinute: lunchReminderMinute);

  @override
  PreferencesDto dietaryTags(List<String>? dietaryTags) =>
      call(dietaryTags: dietaryTags);

  @override
  PreferencesDto showApproxCurrency(
    PreferencesDtoShowApproxCurrencyEnum? showApproxCurrency,
  ) => call(showApproxCurrency: showApproxCurrency);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PreferencesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PreferencesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PreferencesDto call({
    Object? lunchReminder = const $CopyWithPlaceholder(),
    Object? lunchReminderMinute = const $CopyWithPlaceholder(),
    Object? dietaryTags = const $CopyWithPlaceholder(),
    Object? showApproxCurrency = const $CopyWithPlaceholder(),
  }) {
    return PreferencesDto(
      lunchReminder: lunchReminder == const $CopyWithPlaceholder()
          ? _value.lunchReminder
          // ignore: cast_nullable_to_non_nullable
          : lunchReminder as bool?,
      lunchReminderMinute: lunchReminderMinute == const $CopyWithPlaceholder()
          ? _value.lunchReminderMinute
          // ignore: cast_nullable_to_non_nullable
          : lunchReminderMinute as num?,
      dietaryTags: dietaryTags == const $CopyWithPlaceholder()
          ? _value.dietaryTags
          // ignore: cast_nullable_to_non_nullable
          : dietaryTags as List<String>?,
      showApproxCurrency: showApproxCurrency == const $CopyWithPlaceholder()
          ? _value.showApproxCurrency
          // ignore: cast_nullable_to_non_nullable
          : showApproxCurrency as PreferencesDtoShowApproxCurrencyEnum?,
    );
  }
}

extension $PreferencesDtoCopyWith on PreferencesDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPreferencesDto.copyWith(...)` or `instanceOfPreferencesDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreferencesDtoCWProxy get copyWith => _$PreferencesDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesDto _$PreferencesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PreferencesDto', json, ($checkedConvert) {
      final val = PreferencesDto(
        lunchReminder: $checkedConvert('lunchReminder', (v) => v as bool?),
        lunchReminderMinute: $checkedConvert(
          'lunchReminderMinute',
          (v) => v as num?,
        ),
        dietaryTags: $checkedConvert(
          'dietaryTags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        showApproxCurrency: $checkedConvert(
          'showApproxCurrency',
          (v) => $enumDecodeNullable(
            _$PreferencesDtoShowApproxCurrencyEnumEnumMap,
            v,
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PreferencesDtoToJson(PreferencesDto instance) =>
    <String, dynamic>{
      'lunchReminder': ?instance.lunchReminder,
      'lunchReminderMinute': ?instance.lunchReminderMinute,
      'dietaryTags': ?instance.dietaryTags,
      'showApproxCurrency':
          ?_$PreferencesDtoShowApproxCurrencyEnumEnumMap[instance
              .showApproxCurrency],
    };

const _$PreferencesDtoShowApproxCurrencyEnumEnumMap = {
  PreferencesDtoShowApproxCurrencyEnum.USD: 'USD',
  PreferencesDtoShowApproxCurrencyEnum.KRW: 'KRW',
  PreferencesDtoShowApproxCurrencyEnum.CNY: 'CNY',
  PreferencesDtoShowApproxCurrencyEnum.JPY: 'JPY',
};
