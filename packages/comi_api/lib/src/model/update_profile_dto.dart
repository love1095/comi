//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_profile_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateProfileDto {
  /// Returns a new [UpdateProfileDto] instance.
  UpdateProfileDto({

     this.name,

     this.phone,

     this.address,

     this.provinceCode,

     this.wardCode,

     this.priceLevel,

     this.cuisineTags,

     this.lat,

     this.lng,

     this.description,

     this.ambienceTags,

     this.coverPhotoUrl,

     this.googlePlaceId,

     this.timezone,
  });

  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'address',
    required: false,
    includeIfNull: false,
  )


  final String? address;



      /// Province code (79 = Ho Chi Minh City)
  @JsonKey(
    
    name: r'provinceCode',
    required: false,
    includeIfNull: false,
  )


  final String? provinceCode;



  @JsonKey(
    
    name: r'wardCode',
    required: false,
    includeIfNull: false,
  )


  final String? wardCode;



          // minimum: 1
          // maximum: 4
  @JsonKey(
    
    name: r'priceLevel',
    required: false,
    includeIfNull: false,
  )


  final num? priceLevel;



  @JsonKey(
    
    name: r'cuisineTags',
    required: false,
    includeIfNull: false,
  )


  final List<String>? cuisineTags;



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
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'ambienceTags',
    required: false,
    includeIfNull: false,
  )


  final List<String>? ambienceTags;



  @JsonKey(
    
    name: r'coverPhotoUrl',
    required: false,
    includeIfNull: false,
  )


  final String? coverPhotoUrl;



  @JsonKey(
    
    name: r'googlePlaceId',
    required: false,
    includeIfNull: false,
  )


  final String? googlePlaceId;



  @JsonKey(
    
    name: r'timezone',
    required: false,
    includeIfNull: false,
  )


  final String? timezone;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateProfileDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            phone,
            address,
            provinceCode,
            wardCode,
            priceLevel,
            cuisineTags,
            lat,
            lng,
            description,
            ambienceTags,
            coverPhotoUrl,
            googlePlaceId,
            timezone,
        ],
        [
            other.name,
            other.phone,
            other.address,
            other.provinceCode,
            other.wardCode,
            other.priceLevel,
            other.cuisineTags,
            other.lat,
            other.lng,
            other.description,
            other.ambienceTags,
            other.coverPhotoUrl,
            other.googlePlaceId,
            other.timezone,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        phone,
        address,
        provinceCode,
        wardCode,
        priceLevel,
        cuisineTags,
        lat,
        lng,
        description,
        ambienceTags,
        coverPhotoUrl,
        googlePlaceId,
        timezone,
    ],);

  factory UpdateProfileDto.fromJson(Map<String, dynamic> json) => _$UpdateProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

