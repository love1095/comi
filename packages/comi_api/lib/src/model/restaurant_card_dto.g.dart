// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_card_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantCardDtoCWProxy {
  RestaurantCardDto id(String id);

  RestaurantCardDto slug(String slug);

  RestaurantCardDto name(String name);

  RestaurantCardDto address(String address);

  RestaurantCardDto priceLevel(num priceLevel);

  RestaurantCardDto ratingAvg(num ratingAvg);

  RestaurantCardDto ratingCount(num ratingCount);

  RestaurantCardDto coverPhotoUrl(String? coverPhotoUrl);

  RestaurantCardDto cuisineTags(List<String> cuisineTags);

  RestaurantCardDto servesLunch(bool servesLunch);

  RestaurantCardDto servesNhau(bool servesNhau);

  RestaurantCardDto allowTableChoice(bool allowTableChoice);

  RestaurantCardDto lat(num lat);

  RestaurantCardDto lng(num lng);

  RestaurantCardDto distanceM(num? distanceM);

  RestaurantCardDto minMainPrice(num? minMainPrice);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantCardDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantCardDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RestaurantCardDto call({
    String id,
    String slug,
    String name,
    String address,
    num priceLevel,
    num ratingAvg,
    num ratingCount,
    String? coverPhotoUrl,
    List<String> cuisineTags,
    bool servesLunch,
    bool servesNhau,
    bool allowTableChoice,
    num lat,
    num lng,
    num? distanceM,
    num? minMainPrice,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRestaurantCardDto.copyWith(...)` or call `instanceOfRestaurantCardDto.copyWith.fieldName(value)` for a single field.
class _$RestaurantCardDtoCWProxyImpl implements _$RestaurantCardDtoCWProxy {
  const _$RestaurantCardDtoCWProxyImpl(this._value);

  final RestaurantCardDto _value;

  @override
  RestaurantCardDto id(String id) => call(id: id);

  @override
  RestaurantCardDto slug(String slug) => call(slug: slug);

  @override
  RestaurantCardDto name(String name) => call(name: name);

  @override
  RestaurantCardDto address(String address) => call(address: address);

  @override
  RestaurantCardDto priceLevel(num priceLevel) => call(priceLevel: priceLevel);

  @override
  RestaurantCardDto ratingAvg(num ratingAvg) => call(ratingAvg: ratingAvg);

  @override
  RestaurantCardDto ratingCount(num ratingCount) =>
      call(ratingCount: ratingCount);

  @override
  RestaurantCardDto coverPhotoUrl(String? coverPhotoUrl) =>
      call(coverPhotoUrl: coverPhotoUrl);

  @override
  RestaurantCardDto cuisineTags(List<String> cuisineTags) =>
      call(cuisineTags: cuisineTags);

  @override
  RestaurantCardDto servesLunch(bool servesLunch) =>
      call(servesLunch: servesLunch);

  @override
  RestaurantCardDto servesNhau(bool servesNhau) => call(servesNhau: servesNhau);

  @override
  RestaurantCardDto allowTableChoice(bool allowTableChoice) =>
      call(allowTableChoice: allowTableChoice);

  @override
  RestaurantCardDto lat(num lat) => call(lat: lat);

  @override
  RestaurantCardDto lng(num lng) => call(lng: lng);

  @override
  RestaurantCardDto distanceM(num? distanceM) => call(distanceM: distanceM);

  @override
  RestaurantCardDto minMainPrice(num? minMainPrice) =>
      call(minMainPrice: minMainPrice);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantCardDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantCardDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RestaurantCardDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? priceLevel = const $CopyWithPlaceholder(),
    Object? ratingAvg = const $CopyWithPlaceholder(),
    Object? ratingCount = const $CopyWithPlaceholder(),
    Object? coverPhotoUrl = const $CopyWithPlaceholder(),
    Object? cuisineTags = const $CopyWithPlaceholder(),
    Object? servesLunch = const $CopyWithPlaceholder(),
    Object? servesNhau = const $CopyWithPlaceholder(),
    Object? allowTableChoice = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? distanceM = const $CopyWithPlaceholder(),
    Object? minMainPrice = const $CopyWithPlaceholder(),
  }) {
    return RestaurantCardDto(
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
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      priceLevel:
          priceLevel == const $CopyWithPlaceholder() || priceLevel == null
          ? _value.priceLevel
          // ignore: cast_nullable_to_non_nullable
          : priceLevel as num,
      ratingAvg: ratingAvg == const $CopyWithPlaceholder() || ratingAvg == null
          ? _value.ratingAvg
          // ignore: cast_nullable_to_non_nullable
          : ratingAvg as num,
      ratingCount:
          ratingCount == const $CopyWithPlaceholder() || ratingCount == null
          ? _value.ratingCount
          // ignore: cast_nullable_to_non_nullable
          : ratingCount as num,
      coverPhotoUrl: coverPhotoUrl == const $CopyWithPlaceholder()
          ? _value.coverPhotoUrl
          // ignore: cast_nullable_to_non_nullable
          : coverPhotoUrl as String?,
      cuisineTags:
          cuisineTags == const $CopyWithPlaceholder() || cuisineTags == null
          ? _value.cuisineTags
          // ignore: cast_nullable_to_non_nullable
          : cuisineTags as List<String>,
      servesLunch:
          servesLunch == const $CopyWithPlaceholder() || servesLunch == null
          ? _value.servesLunch
          // ignore: cast_nullable_to_non_nullable
          : servesLunch as bool,
      servesNhau:
          servesNhau == const $CopyWithPlaceholder() || servesNhau == null
          ? _value.servesNhau
          // ignore: cast_nullable_to_non_nullable
          : servesNhau as bool,
      allowTableChoice:
          allowTableChoice == const $CopyWithPlaceholder() ||
              allowTableChoice == null
          ? _value.allowTableChoice
          // ignore: cast_nullable_to_non_nullable
          : allowTableChoice as bool,
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
      distanceM: distanceM == const $CopyWithPlaceholder()
          ? _value.distanceM
          // ignore: cast_nullable_to_non_nullable
          : distanceM as num?,
      minMainPrice: minMainPrice == const $CopyWithPlaceholder()
          ? _value.minMainPrice
          // ignore: cast_nullable_to_non_nullable
          : minMainPrice as num?,
    );
  }
}

extension $RestaurantCardDtoCopyWith on RestaurantCardDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRestaurantCardDto.copyWith(...)` or `instanceOfRestaurantCardDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantCardDtoCWProxy get copyWith =>
      _$RestaurantCardDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantCardDto _$RestaurantCardDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RestaurantCardDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'slug',
          'name',
          'address',
          'priceLevel',
          'ratingAvg',
          'ratingCount',
          'cuisineTags',
          'servesLunch',
          'servesNhau',
          'allowTableChoice',
          'lat',
          'lng',
        ],
      );
      final val = RestaurantCardDto(
        id: $checkedConvert('id', (v) => v as String),
        slug: $checkedConvert('slug', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        priceLevel: $checkedConvert('priceLevel', (v) => v as num),
        ratingAvg: $checkedConvert('ratingAvg', (v) => v as num),
        ratingCount: $checkedConvert('ratingCount', (v) => v as num),
        coverPhotoUrl: $checkedConvert('coverPhotoUrl', (v) => v as String?),
        cuisineTags: $checkedConvert(
          'cuisineTags',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        servesLunch: $checkedConvert('servesLunch', (v) => v as bool),
        servesNhau: $checkedConvert('servesNhau', (v) => v as bool),
        allowTableChoice: $checkedConvert('allowTableChoice', (v) => v as bool),
        lat: $checkedConvert('lat', (v) => v as num),
        lng: $checkedConvert('lng', (v) => v as num),
        distanceM: $checkedConvert('distanceM', (v) => v as num?),
        minMainPrice: $checkedConvert('minMainPrice', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$RestaurantCardDtoToJson(RestaurantCardDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'address': instance.address,
      'priceLevel': instance.priceLevel,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'coverPhotoUrl': ?instance.coverPhotoUrl,
      'cuisineTags': instance.cuisineTags,
      'servesLunch': instance.servesLunch,
      'servesNhau': instance.servesNhau,
      'allowTableChoice': instance.allowTableChoice,
      'lat': instance.lat,
      'lng': instance.lng,
      'distanceM': ?instance.distanceM,
      'minMainPrice': ?instance.minMainPrice,
    };
