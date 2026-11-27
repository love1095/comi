// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefreshDtoCWProxy {
  RefreshDto refreshToken(String refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefreshDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefreshDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RefreshDto call({String refreshToken});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefreshDto.copyWith(...)` or call `instanceOfRefreshDto.copyWith.fieldName(value)` for a single field.
class _$RefreshDtoCWProxyImpl implements _$RefreshDtoCWProxy {
  const _$RefreshDtoCWProxyImpl(this._value);

  final RefreshDto _value;

  @override
  RefreshDto refreshToken(String refreshToken) =>
      call(refreshToken: refreshToken);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefreshDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefreshDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RefreshDto call({Object? refreshToken = const $CopyWithPlaceholder()}) {
    return RefreshDto(
      refreshToken:
          refreshToken == const $CopyWithPlaceholder() || refreshToken == null
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
    );
  }
}

extension $RefreshDtoCopyWith on RefreshDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefreshDto.copyWith(...)` or `instanceOfRefreshDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefreshDtoCWProxy get copyWith => _$RefreshDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshDto _$RefreshDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefreshDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['refreshToken']);
      final val = RefreshDto(
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RefreshDtoToJson(RefreshDto instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};
