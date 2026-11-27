// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_me_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateMeDtoCWProxy {
  UpdateMeDto name(String? name);

  UpdateMeDto email(String? email);

  UpdateMeDto locale(UpdateMeDtoLocaleEnum? locale);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateMeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateMeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateMeDto call({
    String? name,
    String? email,
    UpdateMeDtoLocaleEnum? locale,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateMeDto.copyWith(...)` or call `instanceOfUpdateMeDto.copyWith.fieldName(value)` for a single field.
class _$UpdateMeDtoCWProxyImpl implements _$UpdateMeDtoCWProxy {
  const _$UpdateMeDtoCWProxyImpl(this._value);

  final UpdateMeDto _value;

  @override
  UpdateMeDto name(String? name) => call(name: name);

  @override
  UpdateMeDto email(String? email) => call(email: email);

  @override
  UpdateMeDto locale(UpdateMeDtoLocaleEnum? locale) => call(locale: locale);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateMeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateMeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UpdateMeDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
  }) {
    return UpdateMeDto(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      locale: locale == const $CopyWithPlaceholder()
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as UpdateMeDtoLocaleEnum?,
    );
  }
}

extension $UpdateMeDtoCopyWith on UpdateMeDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateMeDto.copyWith(...)` or `instanceOfUpdateMeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateMeDtoCWProxy get copyWith => _$UpdateMeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMeDto _$UpdateMeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateMeDto', json, ($checkedConvert) {
      final val = UpdateMeDto(
        name: $checkedConvert('name', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        locale: $checkedConvert(
          'locale',
          (v) => $enumDecodeNullable(_$UpdateMeDtoLocaleEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateMeDtoToJson(UpdateMeDto instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'email': ?instance.email,
      'locale': ?_$UpdateMeDtoLocaleEnumEnumMap[instance.locale],
    };

const _$UpdateMeDtoLocaleEnumEnumMap = {
  UpdateMeDtoLocaleEnum.vi: 'vi',
  UpdateMeDtoLocaleEnum.en: 'en',
  UpdateMeDtoLocaleEnum.ko: 'ko',
  UpdateMeDtoLocaleEnum.zh: 'zh',
  UpdateMeDtoLocaleEnum.ja: 'ja',
};
