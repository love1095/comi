// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_photo_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddPhotoDtoCWProxy {
  AddPhotoDto publicId(String publicId);

  AddPhotoDto width(num? width);

  AddPhotoDto height(num? height);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AddPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AddPhotoDto call({String publicId, num? width, num? height});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAddPhotoDto.copyWith(...)` or call `instanceOfAddPhotoDto.copyWith.fieldName(value)` for a single field.
class _$AddPhotoDtoCWProxyImpl implements _$AddPhotoDtoCWProxy {
  const _$AddPhotoDtoCWProxyImpl(this._value);

  final AddPhotoDto _value;

  @override
  AddPhotoDto publicId(String publicId) => call(publicId: publicId);

  @override
  AddPhotoDto width(num? width) => call(width: width);

  @override
  AddPhotoDto height(num? height) => call(height: height);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AddPhotoDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddPhotoDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AddPhotoDto call({
    Object? publicId = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
  }) {
    return AddPhotoDto(
      publicId: publicId == const $CopyWithPlaceholder() || publicId == null
          ? _value.publicId
          // ignore: cast_nullable_to_non_nullable
          : publicId as String,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num?,
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num?,
    );
  }
}

extension $AddPhotoDtoCopyWith on AddPhotoDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAddPhotoDto.copyWith(...)` or `instanceOfAddPhotoDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddPhotoDtoCWProxy get copyWith => _$AddPhotoDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPhotoDto _$AddPhotoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AddPhotoDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['publicId']);
      final val = AddPhotoDto(
        publicId: $checkedConvert('publicId', (v) => v as String),
        width: $checkedConvert('width', (v) => v as num?),
        height: $checkedConvert('height', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$AddPhotoDtoToJson(AddPhotoDto instance) =>
    <String, dynamic>{
      'publicId': instance.publicId,
      'width': ?instance.width,
      'height': ?instance.height,
    };
