//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'layout_table_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LayoutTableDto {
  /// Returns a new [LayoutTableDto] instance.
  LayoutTableDto({

    required  this.code,

     this.minSeats = 1,

    required  this.maxSeats,

     this.shape,

     this.posX,

     this.posY,

     this.width,

     this.height,

     this.rotation,

     this.features,

     this.seatLayout,

     this.isSelectable,

     this.isActive,

     this.joinGroup,

     this.id,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    defaultValue: 1,
    name: r'minSeats',
    required: false,
    includeIfNull: false,
  )


  final num? minSeats;



  @JsonKey(
    
    name: r'maxSeats',
    required: true,
    includeIfNull: false,
  )


  final num maxSeats;



  @JsonKey(
    
    name: r'shape',
    required: false,
    includeIfNull: false,
  )


  final LayoutTableDtoShapeEnum? shape;



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
    required: false,
    includeIfNull: false,
  )


  final num? width;



  @JsonKey(
    
    name: r'height',
    required: false,
    includeIfNull: false,
  )


  final num? height;



      /// 0, 90, 180 or 270
  @JsonKey(
    
    name: r'rotation',
    required: false,
    includeIfNull: false,
  )


  final num? rotation;



  @JsonKey(
    
    name: r'features',
    required: false,
    includeIfNull: false,
  )


  final List<String>? features;



  @JsonKey(
    
    name: r'seatLayout',
    required: false,
    includeIfNull: false,
  )


  final Object? seatLayout;



  @JsonKey(
    
    name: r'isSelectable',
    required: false,
    includeIfNull: false,
  )


  final bool? isSelectable;



  @JsonKey(
    
    name: r'isActive',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'joinGroup',
    required: false,
    includeIfNull: false,
  )


  final String? joinGroup;



      /// Existing table id; omit to create
  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final String? id;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is LayoutTableDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
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
            seatLayout,
            isSelectable,
            isActive,
            joinGroup,
            id,
        ],
        [
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
            other.seatLayout,
            other.isSelectable,
            other.isActive,
            other.joinGroup,
            other.id,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
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
        seatLayout,
        isSelectable,
        isActive,
        joinGroup,
        id,
    ],);

  factory LayoutTableDto.fromJson(Map<String, dynamic> json) => _$LayoutTableDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutTableDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum LayoutTableDtoShapeEnum {
@JsonValue(r'RECT')
RECT(r'RECT'),
@JsonValue(r'ROUND')
ROUND(r'ROUND'),
@JsonValue(r'SQUARE')
SQUARE(r'SQUARE'),
@JsonValue(r'BOOTH')
BOOTH(r'BOOTH'),
@JsonValue(r'BAR_SEAT')
BAR_SEAT(r'BAR_SEAT');

const LayoutTableDtoShapeEnum(this.value);

final String value;

@override
String toString() => value;
}


