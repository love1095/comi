// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_info_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LegalInfoDtoCWProxy {
  LegalInfoDto termsVersion(String termsVersion);

  LegalInfoDto privacyPath(String privacyPath);

  LegalInfoDto termsPath(String termsPath);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `LegalInfoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LegalInfoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  LegalInfoDto call({
    String termsVersion,
    String privacyPath,
    String termsPath,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLegalInfoDto.copyWith(...)` or call `instanceOfLegalInfoDto.copyWith.fieldName(value)` for a single field.
class _$LegalInfoDtoCWProxyImpl implements _$LegalInfoDtoCWProxy {
  const _$LegalInfoDtoCWProxyImpl(this._value);

  final LegalInfoDto _value;

  @override
  LegalInfoDto termsVersion(String termsVersion) =>
      call(termsVersion: termsVersion);

  @override
  LegalInfoDto privacyPath(String privacyPath) =>
      call(privacyPath: privacyPath);

  @override
  LegalInfoDto termsPath(String termsPath) => call(termsPath: termsPath);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `LegalInfoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LegalInfoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  LegalInfoDto call({
    Object? termsVersion = const $CopyWithPlaceholder(),
    Object? privacyPath = const $CopyWithPlaceholder(),
    Object? termsPath = const $CopyWithPlaceholder(),
  }) {
    return LegalInfoDto(
      termsVersion:
          termsVersion == const $CopyWithPlaceholder() || termsVersion == null
          ? _value.termsVersion
          // ignore: cast_nullable_to_non_nullable
          : termsVersion as String,
      privacyPath:
          privacyPath == const $CopyWithPlaceholder() || privacyPath == null
          ? _value.privacyPath
          // ignore: cast_nullable_to_non_nullable
          : privacyPath as String,
      termsPath: termsPath == const $CopyWithPlaceholder() || termsPath == null
          ? _value.termsPath
          // ignore: cast_nullable_to_non_nullable
          : termsPath as String,
    );
  }
}

extension $LegalInfoDtoCopyWith on LegalInfoDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLegalInfoDto.copyWith(...)` or `instanceOfLegalInfoDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LegalInfoDtoCWProxy get copyWith => _$LegalInfoDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalInfoDto _$LegalInfoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LegalInfoDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['termsVersion', 'privacyPath', 'termsPath'],
      );
      final val = LegalInfoDto(
        termsVersion: $checkedConvert('termsVersion', (v) => v as String),
        privacyPath: $checkedConvert('privacyPath', (v) => v as String),
        termsPath: $checkedConvert('termsPath', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$LegalInfoDtoToJson(LegalInfoDto instance) =>
    <String, dynamic>{
      'termsVersion': instance.termsVersion,
      'privacyPath': instance.privacyPath,
      'termsPath': instance.termsPath,
    };
