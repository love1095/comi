// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_photo_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicPhotoDtoCWProxy {
  PublicPhotoDto id(String id);

  PublicPhotoDto publicId(String publicId);

  PublicPhotoDto width(num width);

  PublicPhotoDto height(num height);

  PublicPhotoDto blurhash(String? blurhash);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PublicPhotoDto call({
    String id,
    String publicId,
    num width,
    num height,
    String? blurhash,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPublicPhotoDto.copyWith(...)` or call `instanceOfPublicPhotoDto.copyWith.fieldName(value)` for a single field.
class _$PublicPhotoDtoCWProxyImpl implements _$PublicPhotoDtoCWProxy {
  const _$PublicPhotoDtoCWProxyImpl(this._value);

  final PublicPhotoDto _value;

  @override
  PublicPhotoDto id(String id) => call(id: id);

  @override
  PublicPhotoDto publicId(String publicId) => call(publicId: publicId);

  @override
  PublicPhotoDto width(num width) => call(width: width);

  @override
  PublicPhotoDto height(num height) => call(height: height);

  @override
  PublicPhotoDto blurhash(String? blurhash) => call(blurhash: blurhash);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PublicPhotoDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? publicId = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? blurhash = const $CopyWithPlaceholder(),
  }) {
    return PublicPhotoDto(
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
    );
  }
}

extension $PublicPhotoDtoCopyWith on PublicPhotoDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPublicPhotoDto.copyWith(...)` or `instanceOfPublicPhotoDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicPhotoDtoCWProxy get copyWith => _$PublicPhotoDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicPhotoDto _$PublicPhotoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PublicPhotoDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'publicId', 'width', 'height'],
      );
      final val = PublicPhotoDto(
        id: $checkedConvert('id', (v) => v as String),
        publicId: $checkedConvert('publicId', (v) => v as String),
        width: $checkedConvert('width', (v) => v as num),
        height: $checkedConvert('height', (v) => v as num),
        blurhash: $checkedConvert('blurhash', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PublicPhotoDtoToJson(PublicPhotoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'publicId': instance.publicId,
      'width': instance.width,
      'height': instance.height,
      'blurhash': ?instance.blurhash,
    };
