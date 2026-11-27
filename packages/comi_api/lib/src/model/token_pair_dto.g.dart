// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TokenPairDtoCWProxy {
  TokenPairDto accessToken(String accessToken);

  TokenPairDto refreshToken(String refreshToken);

  TokenPairDto expiresIn(num expiresIn);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TokenPairDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TokenPairDto(...).copyWith(id: 12, name: "My name")
  /// ```
  TokenPairDto call({String accessToken, String refreshToken, num expiresIn});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTokenPairDto.copyWith(...)` or call `instanceOfTokenPairDto.copyWith.fieldName(value)` for a single field.
class _$TokenPairDtoCWProxyImpl implements _$TokenPairDtoCWProxy {
  const _$TokenPairDtoCWProxyImpl(this._value);

  final TokenPairDto _value;

  @override
  TokenPairDto accessToken(String accessToken) =>
      call(accessToken: accessToken);

  @override
  TokenPairDto refreshToken(String refreshToken) =>
      call(refreshToken: refreshToken);

  @override
  TokenPairDto expiresIn(num expiresIn) => call(expiresIn: expiresIn);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TokenPairDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TokenPairDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  TokenPairDto call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? expiresIn = const $CopyWithPlaceholder(),
  }) {
    return TokenPairDto(
      accessToken:
          accessToken == const $CopyWithPlaceholder() || accessToken == null
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String,
      refreshToken:
          refreshToken == const $CopyWithPlaceholder() || refreshToken == null
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
      expiresIn: expiresIn == const $CopyWithPlaceholder() || expiresIn == null
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as num,
    );
  }
}

extension $TokenPairDtoCopyWith on TokenPairDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTokenPairDto.copyWith(...)` or `instanceOfTokenPairDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TokenPairDtoCWProxy get copyWith => _$TokenPairDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPairDto _$TokenPairDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TokenPairDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['accessToken', 'refreshToken', 'expiresIn'],
      );
      final val = TokenPairDto(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
        expiresIn: $checkedConvert('expiresIn', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TokenPairDtoToJson(TokenPairDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
