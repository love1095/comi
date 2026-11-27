// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_summary_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantSummaryDtoCWProxy {
  RestaurantSummaryDto id(String id);

  RestaurantSummaryDto slug(String slug);

  RestaurantSummaryDto name(String name);

  RestaurantSummaryDto status(RestaurantStatus status);

  RestaurantSummaryDto coverPhotoUrl(String? coverPhotoUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantSummaryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantSummaryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RestaurantSummaryDto call({
    String id,
    String slug,
    String name,
    RestaurantStatus status,
    String? coverPhotoUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRestaurantSummaryDto.copyWith(...)` or call `instanceOfRestaurantSummaryDto.copyWith.fieldName(value)` for a single field.
class _$RestaurantSummaryDtoCWProxyImpl
    implements _$RestaurantSummaryDtoCWProxy {
  const _$RestaurantSummaryDtoCWProxyImpl(this._value);

  final RestaurantSummaryDto _value;

  @override
  RestaurantSummaryDto id(String id) => call(id: id);

  @override
  RestaurantSummaryDto slug(String slug) => call(slug: slug);

  @override
  RestaurantSummaryDto name(String name) => call(name: name);

  @override
  RestaurantSummaryDto status(RestaurantStatus status) => call(status: status);

  @override
  RestaurantSummaryDto coverPhotoUrl(String? coverPhotoUrl) =>
      call(coverPhotoUrl: coverPhotoUrl);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantSummaryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantSummaryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RestaurantSummaryDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? coverPhotoUrl = const $CopyWithPlaceholder(),
  }) {
    return RestaurantSummaryDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      slug: slug == const $CopyWithPlaceholder() || slug == null
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RestaurantStatus,
      coverPhotoUrl: coverPhotoUrl == const $CopyWithPlaceholder()
          ? _value.coverPhotoUrl
          // ignore: cast_nullable_to_non_nullable
          : coverPhotoUrl as String?,
    );
  }
}

extension $RestaurantSummaryDtoCopyWith on RestaurantSummaryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRestaurantSummaryDto.copyWith(...)` or `instanceOfRestaurantSummaryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantSummaryDtoCWProxy get copyWith =>
      _$RestaurantSummaryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantSummaryDto _$RestaurantSummaryDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RestaurantSummaryDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'slug', 'name', 'status']);
  final val = RestaurantSummaryDto(
    id: $checkedConvert('id', (v) => v as String),
    slug: $checkedConvert('slug', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$RestaurantStatusEnumMap, v),
    ),
    coverPhotoUrl: $checkedConvert('coverPhotoUrl', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$RestaurantSummaryDtoToJson(
  RestaurantSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'status': _$RestaurantStatusEnumMap[instance.status]!,
  'coverPhotoUrl': ?instance.coverPhotoUrl,
};

const _$RestaurantStatusEnumMap = {
  RestaurantStatus.DRAFT: 'DRAFT',
  RestaurantStatus.PENDING_REVIEW: 'PENDING_REVIEW',
  RestaurantStatus.ACTIVE: 'ACTIVE',
  RestaurantStatus.PAUSED: 'PAUSED',
  RestaurantStatus.REJECTED: 'REJECTED',
};
