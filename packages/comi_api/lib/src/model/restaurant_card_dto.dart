//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'restaurant_card_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RestaurantCardDto {
  /// Returns a new [RestaurantCardDto] instance.
  RestaurantCardDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.address,

    required  this.priceLevel,

    required  this.ratingAvg,

    required  this.ratingCount,

     this.coverPhotoUrl,

    required  this.cuisineTags,

    required  this.servesLunch,

    required  this.servesNhau,

    required  this.allowTableChoice,

    required  this.lat,

    required  this.lng,

     this.distanceM,

     this.minMainPrice,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'slug',
    required: true,
    includeIfNull: false,
  )


  final String slug;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'address',
    required: true,
    includeIfNull: false,
  )


  final String address;



  @JsonKey(
    
    name: r'priceLevel',
    required: true,
    includeIfNull: false,
  )


  final num priceLevel;



  @JsonKey(
    
    name: r'ratingAvg',
    required: true,
    includeIfNull: false,
  )


  final num ratingAvg;



  @JsonKey(
    
    name: r'ratingCount',
    required: true,
    includeIfNull: false,
  )


  final num ratingCount;



  @JsonKey(
    
    name: r'coverPhotoUrl',
    required: false,
    includeIfNull: false,
  )


  final String? coverPhotoUrl;



  @JsonKey(
    
    name: r'cuisineTags',
    required: true,
    includeIfNull: false,
  )


  final List<String> cuisineTags;



  @JsonKey(
    
    name: r'servesLunch',
    required: true,
    includeIfNull: false,
  )


  final bool servesLunch;



  @JsonKey(
    
    name: r'servesNhau',
    required: true,
    includeIfNull: false,
  )


  final bool servesNhau;



  @JsonKey(
    
    name: r'allowTableChoice',
    required: true,
    includeIfNull: false,
  )


  final bool allowTableChoice;



  @JsonKey(
    
    name: r'lat',
    required: true,
    includeIfNull: false,
  )


  final num lat;



  @JsonKey(
    
    name: r'lng',
    required: true,
    includeIfNull: false,
  )


  final num lng;



  @JsonKey(
    
    name: r'distanceM',
    required: false,
    includeIfNull: false,
  )


  final num? distanceM;



      /// Cheapest main dish (VND)
  @JsonKey(
    
    name: r'minMainPrice',
    required: false,
    includeIfNull: false,
  )


  final num? minMainPrice;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RestaurantCardDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            address,
            priceLevel,
            ratingAvg,
            ratingCount,
            coverPhotoUrl,
            cuisineTags,
            servesLunch,
            servesNhau,
            allowTableChoice,
            lat,
            lng,
            distanceM,
            minMainPrice,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.address,
            other.priceLevel,
            other.ratingAvg,
            other.ratingCount,
            other.coverPhotoUrl,
            other.cuisineTags,
            other.servesLunch,
            other.servesNhau,
            other.allowTableChoice,
            other.lat,
            other.lng,
            other.distanceM,
            other.minMainPrice,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        address,
        priceLevel,
        ratingAvg,
        ratingCount,
        coverPhotoUrl,
        cuisineTags,
        servesLunch,
        servesNhau,
        allowTableChoice,
        lat,
        lng,
        distanceM,
        minMainPrice,
    ],);

  factory RestaurantCardDto.fromJson(Map<String, dynamic> json) => _$RestaurantCardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantCardDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

