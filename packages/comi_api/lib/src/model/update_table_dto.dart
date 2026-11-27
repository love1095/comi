//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_table_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateTableDto {
  /// Returns a new [UpdateTableDto] instance.
  UpdateTableDto({

     this.code,

     this.minSeats = 1,

     this.maxSeats,

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

     this.areaId,
  });

  @JsonKey(
    
    name: r'code',
    required: false,
    includeIfNull: false,
  )


  final String? code;



  @JsonKey(
    defaultValue: 1,
    name: r'minSeats',
    required: false,
    includeIfNull: false,
  )


  final num? minSeats;



  @JsonKey(
    
    name: r'maxSeats',
    required: false,
    includeIfNull: false,
  )


  final num? maxSeats;



  @JsonKey(
    
    name: r'shape',
    required: false,
    includeIfNull: false,
  )


  final UpdateTableDtoShapeEnum? shape;



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



  @JsonKey(
    
    name: r'areaId',
    required: false,
    includeIfNull: false,
  )


  final String? areaId;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateTableDto &&
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
            areaId,
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
            other.areaId,
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
        areaId,
    ],);

  factory UpdateTableDto.fromJson(Map<String, dynamic> json) => _$UpdateTableDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTableDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum UpdateTableDtoShapeEnum {
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

const UpdateTableDtoShapeEnum(this.value);

final String value;

@override
String toString() => value;
}


