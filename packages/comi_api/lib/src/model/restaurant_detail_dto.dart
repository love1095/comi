//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/closure_info_dto.dart';
import 'package:comi_api/src/model/opening_hours_dto.dart';
import 'package:comi_api/src/model/area_brief_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'restaurant_detail_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RestaurantDetailDto {
  /// Returns a new [RestaurantDetailDto] instance.
  RestaurantDetailDto({

    required  this.id,

    required  this.slug,

    required  this.name,

     this.description,

    required  this.translated,

    required  this.phone,

    required  this.address,

     this.lat,

     this.lng,

    required  this.timezone,

    required  this.cuisineTags,

    required  this.ambienceTags,

    required  this.priceLevel,

     this.coverPhotoUrl,

    required  this.ratingAvg,

    required  this.ratingCount,

    required  this.servesLunch,

    required  this.servesNhau,

    required  this.allowTableChoice,

    required  this.allowCod,

    required  this.maxGroupSize,

    required  this.confirmGroupsOver,

    required  this.cancelCutoffMinutes,

    required  this.isOpenNow,

    required  this.openingHours,

    required  this.closures,

    required  this.areas,
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
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



      /// none = Vietnamese original shown
  @JsonKey(
    
    name: r'translated',
    required: true,
    includeIfNull: false,
  )


  final RestaurantDetailDtoTranslatedEnum translated;



  @JsonKey(
    
    name: r'phone',
    required: true,
    includeIfNull: false,
  )


  final String phone;



  @JsonKey(
    
    name: r'address',
    required: true,
    includeIfNull: false,
  )


  final String address;



  @JsonKey(
    
    name: r'lat',
    required: false,
    includeIfNull: false,
  )


  final num? lat;



  @JsonKey(
    
    name: r'lng',
    required: false,
    includeIfNull: false,
  )


  final num? lng;



  @JsonKey(
    
    name: r'timezone',
    required: true,
    includeIfNull: false,
  )


  final String timezone;



  @JsonKey(
    
    name: r'cuisineTags',
    required: true,
    includeIfNull: false,
  )


  final List<String> cuisineTags;



  @JsonKey(
    
    name: r'ambienceTags',
    required: true,
    includeIfNull: false,
  )


  final List<String> ambienceTags;



  @JsonKey(
    
    name: r'priceLevel',
    required: true,
    includeIfNull: false,
  )


  final num priceLevel;



  @JsonKey(
    
    name: r'coverPhotoUrl',
    required: false,
    includeIfNull: false,
  )


  final String? coverPhotoUrl;



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
    
    name: r'allowCod',
    required: true,
    includeIfNull: false,
  )


  final bool allowCod;



  @JsonKey(
    
    name: r'maxGroupSize',
    required: true,
    includeIfNull: false,
  )


  final num maxGroupSize;



  @JsonKey(
    
    name: r'confirmGroupsOver',
    required: true,
    includeIfNull: false,
  )


  final num confirmGroupsOver;



  @JsonKey(
    
    name: r'cancelCutoffMinutes',
    required: true,
    includeIfNull: false,
  )


  final num cancelCutoffMinutes;



  @JsonKey(
    
    name: r'isOpenNow',
    required: true,
    includeIfNull: false,
  )


  final bool isOpenNow;



  @JsonKey(
    
    name: r'openingHours',
    required: true,
    includeIfNull: false,
  )


  final List<OpeningHoursDto> openingHours;



  @JsonKey(
    
    name: r'closures',
    required: true,
    includeIfNull: false,
  )


  final List<ClosureInfoDto> closures;



  @JsonKey(
    
    name: r'areas',
    required: true,
    includeIfNull: false,
  )


  final List<AreaBriefDto> areas;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RestaurantDetailDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            description,
            translated,
            phone,
            address,
            lat,
            lng,
            timezone,
            cuisineTags,
            ambienceTags,
            priceLevel,
            coverPhotoUrl,
            ratingAvg,
            ratingCount,
            servesLunch,
            servesNhau,
            allowTableChoice,
            allowCod,
            maxGroupSize,
            confirmGroupsOver,
            cancelCutoffMinutes,
            isOpenNow,
            openingHours,
            closures,
            areas,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.description,
            other.translated,
            other.phone,
            other.address,
            other.lat,
            other.lng,
            other.timezone,
            other.cuisineTags,
            other.ambienceTags,
            other.priceLevel,
            other.coverPhotoUrl,
            other.ratingAvg,
            other.ratingCount,
            other.servesLunch,
            other.servesNhau,
            other.allowTableChoice,
            other.allowCod,
            other.maxGroupSize,
            other.confirmGroupsOver,
            other.cancelCutoffMinutes,
            other.isOpenNow,
            other.openingHours,
            other.closures,
            other.areas,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        description,
        translated,
        phone,
        address,
        lat,
        lng,
        timezone,
        cuisineTags,
        ambienceTags,
        priceLevel,
        coverPhotoUrl,
        ratingAvg,
        ratingCount,
        servesLunch,
        servesNhau,
        allowTableChoice,
        allowCod,
        maxGroupSize,
        confirmGroupsOver,
        cancelCutoffMinutes,
        isOpenNow,
        openingHours,
        closures,
        areas,
    ],);

  factory RestaurantDetailDto.fromJson(Map<String, dynamic> json) => _$RestaurantDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

/// none = Vietnamese original shown
enum RestaurantDetailDtoTranslatedEnum {
@JsonValue(r'none')
none(r'none'),
@JsonValue(r'human')
human(r'human'),
@JsonValue(r'machine')
machine(r'machine');

const RestaurantDetailDtoTranslatedEnum(this.value);

final String value;

@override
String toString() => value;
}


