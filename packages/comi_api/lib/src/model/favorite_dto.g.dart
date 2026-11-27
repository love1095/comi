// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FavoriteDtoCWProxy {
  FavoriteDto menuItemId(String menuItemId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FavoriteDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FavoriteDto(...).copyWith(id: 12, name: "My name")
  /// ```
  FavoriteDto call({String menuItemId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFavoriteDto.copyWith(...)` or call `instanceOfFavoriteDto.copyWith.fieldName(value)` for a single field.
class _$FavoriteDtoCWProxyImpl implements _$FavoriteDtoCWProxy {
  const _$FavoriteDtoCWProxyImpl(this._value);

  final FavoriteDto _value;

  @override
  FavoriteDto menuItemId(String menuItemId) => call(menuItemId: menuItemId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FavoriteDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FavoriteDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FavoriteDto call({Object? menuItemId = const $CopyWithPlaceholder()}) {
    return FavoriteDto(
      menuItemId:
          menuItemId == const $CopyWithPlaceholder() || menuItemId == null
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
    );
  }
}

extension $FavoriteDtoCopyWith on FavoriteDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFavoriteDto.copyWith(...)` or `instanceOfFavoriteDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FavoriteDtoCWProxy get copyWith => _$FavoriteDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDto _$FavoriteDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FavoriteDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['menuItemId']);
      final val = FavoriteDto(
        menuItemId: $checkedConvert('menuItemId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FavoriteDtoToJson(FavoriteDto instance) =>
    <String, dynamic>{'menuItemId': instance.menuItemId};
