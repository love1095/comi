//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/table_shape.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_table_state_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapTableStateDto {
  /// Returns a new [MapTableStateDto] instance.
  MapTableStateDto({

    required  this.id,

    required  this.code,

    required  this.minSeats,

    required  this.maxSeats,

    required  this.shape,

     this.posX,

     this.posY,

    required  this.width,

    required  this.height,

    required  this.rotation,

    required  this.features,

    required  this.isSelectable,

    required  this.surcharge,

     this.joinGroup,

    required  this.state,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'minSeats',
    required: true,
    includeIfNull: false,
  )


  final num minSeats;



  @JsonKey(
    
    name: r'maxSeats',
    required: true,
    includeIfNull: false,
  )


  final num maxSeats;



  @JsonKey(
    
    name: r'shape',
    required: true,
    includeIfNull: false,
  )


  final TableShape shape;



  @JsonKey(
    
    name: r'posX',
    required: false,
    includeIfNull: false,
  )


  final num? posX;



  @JsonKey(
    
    name: r'posY',
    required: false,
    includeIfNull: false,
  )


  final num? posY;



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



  @JsonKey(
    
    name: r'features',
    required: true,
    includeIfNull: false,
  )


  final List<String> features;



  @JsonKey(
    
    name: r'isSelectable',
    required: true,
    includeIfNull: false,
  )


  final bool isSelectable;



  @JsonKey(
    
    name: r'surcharge',
    required: true,
    includeIfNull: false,
  )


  final num surcharge;



  @JsonKey(
    
    name: r'joinGroup',
    required: false,
    includeIfNull: false,
  )


  final String? joinGroup;



  @JsonKey(
    
    name: r'state',
    required: true,
    includeIfNull: false,
  )


  final MapTableStateDtoStateEnum state;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapTableStateDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            minSeats,
            maxSeats,
            shape,
            posX,
            posY,
            width,
            height,
            rotation,
            features,
            isSelectable,
            surcharge,
            joinGroup,
            state,
        ],
        [
            other.id,
            other.code,
            other.minSeats,
            other.maxSeats,
            other.shape,
            other.posX,
            other.posY,
            other.width,
            other.height,
            other.rotation,
            other.features,
            other.isSelectable,
            other.surcharge,
            other.joinGroup,
            other.state,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        minSeats,
        maxSeats,
        shape,
        posX,
        posY,
        width,
        height,
        rotation,
        features,
        isSelectable,
        surcharge,
        joinGroup,
        state,
    ],);

  factory MapTableStateDto.fromJson(Map<String, dynamic> json) => _$MapTableStateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapTableStateDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MapTableStateDtoStateEnum {
@JsonValue(r'available')
available(r'available'),
@JsonValue(r'booked')
booked(r'booked'),
@JsonValue(r'held')
held(r'held'),
@JsonValue(r'mine')
mine(r'mine'),
@JsonValue(r'unfit')
unfit(r'unfit'),
@JsonValue(r'unavailable')
unavailable(r'unavailable');

const MapTableStateDtoStateEnum(this.value);

final String value;

@override
String toString() => value;
}


