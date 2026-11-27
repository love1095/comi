//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'register_restaurant_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegisterRestaurantDto {
  /// Returns a new [RegisterRestaurantDto] instance.
  RegisterRestaurantDto({

    required  this.name,

    required  this.phone,

    required  this.address,

    required  this.provinceCode,

     this.wardCode,

    required  this.priceLevel,

     this.cuisineTags,

     this.lat,

     this.lng,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



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



      /// Province code (79 = Ho Chi Minh City)
  @JsonKey(
    
    name: r'provinceCode',
    required: true,
    includeIfNull: false,
  )


  final String provinceCode;



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
    required: true,
    includeIfNull: false,
  )


  final num priceLevel;



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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RegisterRestaurantDto &&
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
    ],);

  factory RegisterRestaurantDto.fromJson(Map<String, dynamic> json) => _$RegisterRestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRestaurantDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

