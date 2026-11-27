//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/table_shape.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'table_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableDto {
  /// Returns a new [TableDto] instance.
  TableDto({

    required  this.id,

    required  this.areaId,

    required  this.code,

    required  this.minSeats,

    required  this.maxSeats,

    required  this.isActive,

     this.posX,

     this.posY,

    required  this.features,

    required  this.shape,

    required  this.width,

    required  this.height,

    required  this.rotation,

    required  this.isSelectable,

    required  this.surcharge,

     this.joinGroup,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'areaId',
    required: true,
    includeIfNull: false,
  )


  final String areaId;



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
    
    name: r'isActive',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



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
    
    name: r'features',
    required: true,
    includeIfNull: false,
  )


  final List<String> features;



  @JsonKey(
    
    name: r'shape',
    required: true,
    includeIfNull: false,
  )


  final TableShape shape;



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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is TableDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            areaId,
            code,
            minSeats,
            maxSeats,
            isActive,
            posX,
            posY,
            features,
            shape,
            width,
            height,
            rotation,
            isSelectable,
            surcharge,
            joinGroup,
        ],
        [
            other.id,
            other.areaId,
            other.code,
            other.minSeats,
            other.maxSeats,
            other.isActive,
            other.posX,
            other.posY,
            other.features,
            other.shape,
            other.width,
            other.height,
            other.rotation,
            other.isSelectable,
            other.surcharge,
            other.joinGroup,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        areaId,
        code,
        minSeats,
        maxSeats,
        isActive,
        posX,
        posY,
        features,
        shape,
        width,
        height,
        rotation,
        isSelectable,
        surcharge,
        joinGroup,
    ],);

  factory TableDto.fromJson(Map<String, dynamic> json) => _$TableDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TableDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

