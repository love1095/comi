// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_photo_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuPhotoDtoCWProxy {
  MenuPhotoDto id(String id);

  MenuPhotoDto publicId(String publicId);

  MenuPhotoDto width(num width);

  MenuPhotoDto height(num height);

  MenuPhotoDto blurhash(String? blurhash);

  MenuPhotoDto sortOrder(num sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuPhotoDto call({
    String id,
    String publicId,
    num width,
    num height,
    String? blurhash,
    num sortOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuPhotoDto.copyWith(...)` or call `instanceOfMenuPhotoDto.copyWith.fieldName(value)` for a single field.
class _$MenuPhotoDtoCWProxyImpl implements _$MenuPhotoDtoCWProxy {
  const _$MenuPhotoDtoCWProxyImpl(this._value);

  final MenuPhotoDto _value;

  @override
  MenuPhotoDto id(String id) => call(id: id);

  @override
  MenuPhotoDto publicId(String publicId) => call(publicId: publicId);

  @override
  MenuPhotoDto width(num width) => call(width: width);

  @override
  MenuPhotoDto height(num height) => call(height: height);

  @override
  MenuPhotoDto blurhash(String? blurhash) => call(blurhash: blurhash);

  @override
  MenuPhotoDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MenuPhotoDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? publicId = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? blurhash = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return MenuPhotoDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      publicId: publicId == const $CopyWithPlaceholder() || publicId == null
          ? _value.publicId
          // ignore: cast_nullable_to_non_nullable
          : publicId as String,
      width: width == const $CopyWithPlaceholder() || width == null
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num,
      height: height == const $CopyWithPlaceholder() || height == null
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num,
      blurhash: blurhash == const $CopyWithPlaceholder()
          ? _value.blurhash
          // ignore: cast_nullable_to_non_nullable
          : blurhash as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder() || sortOrder == null
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num,
    );
  }
}

extension $MenuPhotoDtoCopyWith on MenuPhotoDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuPhotoDto.copyWith(...)` or `instanceOfMenuPhotoDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuPhotoDtoCWProxy get copyWith => _$MenuPhotoDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuPhotoDto _$MenuPhotoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MenuPhotoDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'publicId', 'width', 'height', 'sortOrder'],
      );
      final val = MenuPhotoDto(
        id: $checkedConvert('id', (v) => v as String),
        publicId: $checkedConvert('publicId', (v) => v as String),
        width: $checkedConvert('width', (v) => v as num),
        height: $checkedConvert('height', (v) => v as num),
        blurhash: $checkedConvert('blurhash', (v) => v as String?),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$MenuPhotoDtoToJson(MenuPhotoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'publicId': instance.publicId,
      'width': instance.width,
      'height': instance.height,
      'blurhash': ?instance.blurhash,
      'sortOrder': instance.sortOrder,
    };
