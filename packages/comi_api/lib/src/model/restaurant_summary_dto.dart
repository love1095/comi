//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'restaurant_summary_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RestaurantSummaryDto {
  /// Returns a new [RestaurantSummaryDto] instance.
  RestaurantSummaryDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.status,

     this.coverPhotoUrl,
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
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final RestaurantStatus status;



  @JsonKey(
    
    name: r'coverPhotoUrl',
    required: false,
    includeIfNull: false,
  )


  final String? coverPhotoUrl;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RestaurantSummaryDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            status,
            coverPhotoUrl,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.status,
            other.coverPhotoUrl,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        status,
        coverPhotoUrl,
    ],);

  factory RestaurantSummaryDto.fromJson(Map<String, dynamic> json) => _$RestaurantSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantSummaryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

