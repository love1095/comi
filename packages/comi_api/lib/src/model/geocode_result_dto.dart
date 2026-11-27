//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'geocode_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GeocodeResultDto {
  /// Returns a new [GeocodeResultDto] instance.
  GeocodeResultDto({

    required  this.address,

    required  this.lat,

    required  this.lng,

     this.placeId,
  });

  @JsonKey(
    
    name: r'address',
    required: true,
    includeIfNull: false,
  )


  final String address;



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
    
    name: r'placeId',
    required: false,
    includeIfNull: false,
  )


  final String? placeId;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GeocodeResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            address,
            lat,
            lng,
            placeId,
        ],
        [
            other.address,
            other.lat,
            other.lng,
            other.placeId,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        address,
        lat,
        lng,
        placeId,
    ],);

  factory GeocodeResultDto.fromJson(Map<String, dynamic> json) => _$GeocodeResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodeResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

