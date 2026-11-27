//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_status.dart';
import 'package:comi_api/src/model/opening_hours_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'restaurant_profile_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RestaurantProfileDto {
  /// Returns a new [RestaurantProfileDto] instance.
  RestaurantProfileDto({

    required  this.id,

    required  this.slug,

    required  this.name,

     this.description,

    required  this.phone,

    required  this.address,

    required  this.provinceCode,

     this.lat,

     this.lng,

    required  this.timezone,

    required  this.cuisineTags,

    required  this.ambienceTags,

    required  this.priceLevel,

     this.coverPhotoUrl,

    required  this.status,

     this.rejectReason,

    required  this.slotMinutes,

    required  this.diningMinutes,

    required  this.graceMinutes,

    required  this.minLeadMinutes,

    required  this.maxDaysAhead,

    required  this.allowCod,

    required  this.servesLunch,

    required  this.servesNhau,

    required  this.maxGroupSize,

    required  this.confirmGroupsOver,

    required  this.allowTableChoice,

    required  this.cancelCutoffMinutes,

    required  this.ratingAvg,

    required  this.ratingCount,

    required  this.openingHours,
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
    
    name: r'provinceCode',
    required: true,
    includeIfNull: false,
  )


  final String provinceCode;



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
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final RestaurantStatus status;



  @JsonKey(
    
    name: r'rejectReason',
    required: false,
    includeIfNull: false,
  )


  final String? rejectReason;



  @JsonKey(
    
    name: r'slotMinutes',
    required: true,
    includeIfNull: false,
  )


  final num slotMinutes;



  @JsonKey(
    
    name: r'diningMinutes',
    required: true,
    includeIfNull: false,
  )


  final num diningMinutes;



  @JsonKey(
    
    name: r'graceMinutes',
    required: true,
    includeIfNull: false,
  )


  final num graceMinutes;



  @JsonKey(
    
    name: r'minLeadMinutes',
    required: true,
    includeIfNull: false,
  )


  final num minLeadMinutes;



  @JsonKey(
    
    name: r'maxDaysAhead',
    required: true,
    includeIfNull: false,
  )


  final num maxDaysAhead;



  @JsonKey(
    
    name: r'allowCod',
    required: true,
    includeIfNull: false,
  )


  final bool allowCod;



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
    
    name: r'allowTableChoice',
    required: true,
    includeIfNull: false,
  )


  final bool allowTableChoice;



  @JsonKey(
    
    name: r'cancelCutoffMinutes',
    required: true,
    includeIfNull: false,
  )


  final num cancelCutoffMinutes;



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
    
    name: r'openingHours',
    required: true,
    includeIfNull: false,
  )


  final List<OpeningHoursDto> openingHours;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RestaurantProfileDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            description,
            phone,
            address,
            provinceCode,
            lat,
            lng,
            timezone,
            cuisineTags,
            ambienceTags,
            priceLevel,
            coverPhotoUrl,
            status,
            rejectReason,
            slotMinutes,
            diningMinutes,
            graceMinutes,
            minLeadMinutes,
            maxDaysAhead,
            allowCod,
            servesLunch,
            servesNhau,
            maxGroupSize,
            confirmGroupsOver,
            allowTableChoice,
            cancelCutoffMinutes,
            ratingAvg,
            ratingCount,
            openingHours,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.description,
            other.phone,
            other.address,
            other.provinceCode,
            other.lat,
            other.lng,
            other.timezone,
            other.cuisineTags,
            other.ambienceTags,
            other.priceLevel,
            other.coverPhotoUrl,
            other.status,
            other.rejectReason,
            other.slotMinutes,
            other.diningMinutes,
            other.graceMinutes,
            other.minLeadMinutes,
            other.maxDaysAhead,
            other.allowCod,
            other.servesLunch,
            other.servesNhau,
            other.maxGroupSize,
            other.confirmGroupsOver,
            other.allowTableChoice,
            other.cancelCutoffMinutes,
            other.ratingAvg,
            other.ratingCount,
            other.openingHours,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        description,
        phone,
        address,
        provinceCode,
        lat,
        lng,
        timezone,
        cuisineTags,
        ambienceTags,
        priceLevel,
        coverPhotoUrl,
        status,
        rejectReason,
        slotMinutes,
        diningMinutes,
        graceMinutes,
        minLeadMinutes,
        maxDaysAhead,
        allowCod,
        servesLunch,
        servesNhau,
        maxGroupSize,
        confirmGroupsOver,
        allowTableChoice,
        cancelCutoffMinutes,
        ratingAvg,
        ratingCount,
        openingHours,
    ],);

  factory RestaurantProfileDto.fromJson(Map<String, dynamic> json) => _$RestaurantProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantProfileDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

