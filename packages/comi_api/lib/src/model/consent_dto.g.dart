// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConsentDtoCWProxy {
  ConsentDto termsVersion(String termsVersion);

  ConsentDto marketing(bool? marketing);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ConsentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConsentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ConsentDto call({String termsVersion, bool? marketing});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConsentDto.copyWith(...)` or call `instanceOfConsentDto.copyWith.fieldName(value)` for a single field.
class _$ConsentDtoCWProxyImpl implements _$ConsentDtoCWProxy {
  const _$ConsentDtoCWProxyImpl(this._value);

  final ConsentDto _value;

  @override
  ConsentDto termsVersion(String termsVersion) =>
      call(termsVersion: termsVersion);

  @override
  ConsentDto marketing(bool? marketing) => call(marketing: marketing);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ConsentDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConsentDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ConsentDto call({
    Object? termsVersion = const $CopyWithPlaceholder(),
    Object? marketing = const $CopyWithPlaceholder(),
  }) {
    return ConsentDto(
      termsVersion:
          termsVersion == const $CopyWithPlaceholder() || termsVersion == null
          ? _value.termsVersion
          // ignore: cast_nullable_to_non_nullable
          : termsVersion as String,
      marketing: marketing == const $CopyWithPlaceholder()
          ? _value.marketing
          // ignore: cast_nullable_to_non_nullable
          : marketing as bool?,
    );
  }
}

extension $ConsentDtoCopyWith on ConsentDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConsentDto.copyWith(...)` or `instanceOfConsentDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConsentDtoCWProxy get copyWith => _$ConsentDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentDto _$ConsentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConsentDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['termsVersion']);
      final val = ConsentDto(
        termsVersion: $checkedConvert('termsVersion', (v) => v as String),
        marketing: $checkedConvert('marketing', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$ConsentDtoToJson(ConsentDto instance) =>
    <String, dynamic>{
      'termsVersion': instance.termsVersion,
      'marketing': ?instance.marketing,
    };
