//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_restaurant_row_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminRestaurantRowDto {
  /// Returns a new [AdminRestaurantRowDto] instance.
  AdminRestaurantRowDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.address,

    required  this.phone,

    required  this.status,

     this.submittedAt,
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
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final RestaurantStatus status;



  @JsonKey(
    
    name: r'submittedAt',
    required: false,
    includeIfNull: false,
  )


  final String? submittedAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminRestaurantRowDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            address,
            phone,
            status,
            submittedAt,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.address,
            other.phone,
            other.status,
            other.submittedAt,
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
        status,
        submittedAt,
    ],);

  factory AdminRestaurantRowDto.fromJson(Map<String, dynamic> json) => _$AdminRestaurantRowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRestaurantRowDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

