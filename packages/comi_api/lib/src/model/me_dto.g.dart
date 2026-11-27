// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MeDtoCWProxy {
  MeDto id(String id);

  MeDto phone(String? phone);

  MeDto email(String? email);

  MeDto name(String? name);

  MeDto avatarUrl(String? avatarUrl);

  MeDto locale(String locale);

  MeDto noShowCount(num noShowCount);

  MeDto mustPrepay(bool mustPrepay);

  MeDto createdAt(String createdAt);

  MeDto termsVersion(String? termsVersion);

  MeDto marketingOptIn(bool marketingOptIn);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MeDto call({
    String id,
    String? phone,
    String? email,
    String? name,
    String? avatarUrl,
    String locale,
    num noShowCount,
    bool mustPrepay,
    String createdAt,
    String? termsVersion,
    bool marketingOptIn,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMeDto.copyWith(...)` or call `instanceOfMeDto.copyWith.fieldName(value)` for a single field.
class _$MeDtoCWProxyImpl implements _$MeDtoCWProxy {
  const _$MeDtoCWProxyImpl(this._value);

  final MeDto _value;

  @override
  MeDto id(String id) => call(id: id);

  @override
  MeDto phone(String? phone) => call(phone: phone);

  @override
  MeDto email(String? email) => call(email: email);

  @override
  MeDto name(String? name) => call(name: name);

  @override
  MeDto avatarUrl(String? avatarUrl) => call(avatarUrl: avatarUrl);

  @override
  MeDto locale(String locale) => call(locale: locale);

  @override
  MeDto noShowCount(num noShowCount) => call(noShowCount: noShowCount);

  @override
  MeDto mustPrepay(bool mustPrepay) => call(mustPrepay: mustPrepay);

  @override
  MeDto createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  MeDto termsVersion(String? termsVersion) => call(termsVersion: termsVersion);

  @override
  MeDto marketingOptIn(bool marketingOptIn) =>
      call(marketingOptIn: marketingOptIn);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MeDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? avatarUrl = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
    Object? noShowCount = const $CopyWithPlaceholder(),
    Object? mustPrepay = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? termsVersion = const $CopyWithPlaceholder(),
    Object? marketingOptIn = const $CopyWithPlaceholder(),
  }) {
    return MeDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      avatarUrl: avatarUrl == const $CopyWithPlaceholder()
          ? _value.avatarUrl
          // ignore: cast_nullable_to_non_nullable
          : avatarUrl as String?,
      locale: locale == const $CopyWithPlaceholder() || locale == null
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String,
      noShowCount:
          noShowCount == const $CopyWithPlaceholder() || noShowCount == null
          ? _value.noShowCount
          // ignore: cast_nullable_to_non_nullable
          : noShowCount as num,
      mustPrepay:
          mustPrepay == const $CopyWithPlaceholder() || mustPrepay == null
          ? _value.mustPrepay
          // ignore: cast_nullable_to_non_nullable
          : mustPrepay as bool,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
      termsVersion: termsVersion == const $CopyWithPlaceholder()
          ? _value.termsVersion
          // ignore: cast_nullable_to_non_nullable
          : termsVersion as String?,
      marketingOptIn:
          marketingOptIn == const $CopyWithPlaceholder() ||
              marketingOptIn == null
          ? _value.marketingOptIn
          // ignore: cast_nullable_to_non_nullable
          : marketingOptIn as bool,
    );
  }
}

extension $MeDtoCopyWith on MeDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMeDto.copyWith(...)` or `instanceOfMeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MeDtoCWProxy get copyWith => _$MeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeDto _$MeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MeDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'locale',
          'noShowCount',
          'mustPrepay',
          'createdAt',
          'marketingOptIn',
        ],
      );
      final val = MeDto(
        id: $checkedConvert('id', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        avatarUrl: $checkedConvert('avatarUrl', (v) => v as String?),
        locale: $checkedConvert('locale', (v) => v as String),
        noShowCount: $checkedConvert('noShowCount', (v) => v as num),
        mustPrepay: $checkedConvert('mustPrepay', (v) => v as bool),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        termsVersion: $checkedConvert('termsVersion', (v) => v as String?),
        marketingOptIn: $checkedConvert('marketingOptIn', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$MeDtoToJson(MeDto instance) => <String, dynamic>{
  'id': instance.id,
  'phone': ?instance.phone,
  'email': ?instance.email,
  'name': ?instance.name,
  'avatarUrl': ?instance.avatarUrl,
  'locale': instance.locale,
  'noShowCount': instance.noShowCount,
  'mustPrepay': instance.mustPrepay,
  'createdAt': instance.createdAt,
  'termsVersion': ?instance.termsVersion,
  'marketingOptIn': instance.marketingOptIn,
};
