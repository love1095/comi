//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'booking_restaurant_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BookingRestaurantDto {
  /// Returns a new [BookingRestaurantDto] instance.
  BookingRestaurantDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.address,

    required  this.phone,

     this.coverPhotoUrl,

    required  this.timezone,
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
    
    name: r'phone',
    required: true,
    includeIfNull: false,
  )


  final String phone;



  @JsonKey(
    
    name: r'coverPhotoUrl',
    required: false,
    includeIfNull: false,
  )


  final String? coverPhotoUrl;



  @JsonKey(
    
    name: r'timezone',
    required: true,
    includeIfNull: false,
  )


  final String timezone;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BookingRestaurantDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            address,
            phone,
            coverPhotoUrl,
            timezone,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.address,
            other.phone,
            other.coverPhotoUrl,
            other.timezone,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        address,
        phone,
        coverPhotoUrl,
        timezone,
    ],);

  factory BookingRestaurantDto.fromJson(Map<String, dynamic> json) => _$BookingRestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRestaurantDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

