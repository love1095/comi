//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/map_element_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_element_response_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapElementResponseDto {
  /// Returns a new [MapElementResponseDto] instance.
  MapElementResponseDto({

    required  this.id,

    required  this.type,

     this.label,

    required  this.x,

    required  this.y,

    required  this.width,

    required  this.height,

    required  this.rotation,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final MapElementType type;



  @JsonKey(
    
    name: r'label',
    required: false,
    includeIfNull: false,
  )


  final String? label;



  @JsonKey(
    
    name: r'x',
    required: true,
    includeIfNull: false,
  )


  final num x;



  @JsonKey(
    
    name: r'y',
    required: true,
    includeIfNull: false,
  )


  final num y;



  @JsonKey(
    
    name: r'width',
    required: true,
    includeIfNull: false,
  )


  final num width;



  @JsonKey(
    
    name: r'height',
    required: true,
    includeIfNull: false,
  )


  final num height;



  @JsonKey(
    
    name: r'rotation',
    required: true,
    includeIfNull: false,
  )


  final num rotation;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapElementResponseDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            type,
            label,
            x,
            y,
            width,
            height,
            rotation,
        ],
        [
            other.id,
            other.type,
            other.label,
            other.x,
            other.y,
            other.width,
            other.height,
            other.rotation,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        type,
        label,
        x,
        y,
        width,
        height,
        rotation,
    ],);

  factory MapElementResponseDto.fromJson(Map<String, dynamic> json) => _$MapElementResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapElementResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

