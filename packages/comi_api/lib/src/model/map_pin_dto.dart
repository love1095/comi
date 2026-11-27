//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_pin_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapPinDto {
  /// Returns a new [MapPinDto] instance.
  MapPinDto({

    required  this.id,

    required  this.slug,

    required  this.name,

    required  this.lat,

    required  this.lng,

    required  this.priceLevel,

    required  this.ratingAvg,
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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapPinDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
            lat,
            lng,
            priceLevel,
            ratingAvg,
        ],
        [
            other.id,
            other.slug,
            other.name,
            other.lat,
            other.lng,
            other.priceLevel,
            other.ratingAvg,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
        lat,
        lng,
        priceLevel,
        ratingAvg,
    ],);

  factory MapPinDto.fromJson(Map<String, dynamic> json) => _$MapPinDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapPinDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

