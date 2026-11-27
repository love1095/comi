//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'group_restaurant_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupRestaurantDto {
  /// Returns a new [GroupRestaurantDto] instance.
  GroupRestaurantDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.address,
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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GroupRestaurantDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            address,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.address,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        address,
    ],);

  factory GroupRestaurantDto.fromJson(Map<String, dynamic> json) => _$GroupRestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupRestaurantDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

