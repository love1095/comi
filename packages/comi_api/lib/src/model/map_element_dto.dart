//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_element_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapElementDto {
  /// Returns a new [MapElementDto] instance.
  MapElementDto({

    required  this.type,

     this.label,

    required  this.x,

    required  this.y,

     this.width,

     this.height,

     this.rotation,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final MapElementDtoTypeEnum type;



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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapElementDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            type,
            label,
            x,
            y,
            width,
            height,
            rotation,
        ],
        [
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
        type,
        label,
        x,
        y,
        width,
        height,
        rotation,
    ],);

  factory MapElementDto.fromJson(Map<String, dynamic> json) => _$MapElementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapElementDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MapElementDtoTypeEnum {
@JsonValue(r'ENTRANCE')
ENTRANCE(r'ENTRANCE'),
@JsonValue(r'WINDOW')
WINDOW(r'WINDOW'),
@JsonValue(r'WALL')
WALL(r'WALL'),
@JsonValue(r'KITCHEN')
KITCHEN(r'KITCHEN'),
@JsonValue(r'BAR')
BAR(r'BAR'),
@JsonValue(r'STAGE')
STAGE(r'STAGE'),
@JsonValue(r'RESTROOM')
RESTROOM(r'RESTROOM'),
@JsonValue(r'STAIRS')
STAIRS(r'STAIRS'),
@JsonValue(r'PLANT')
PLANT(r'PLANT'),
@JsonValue(r'TV')
TV(r'TV'),
@JsonValue(r'AIRCON')
AIRCON(r'AIRCON'),
@JsonValue(r'SMOKING_AREA')
SMOKING_AREA(r'SMOKING_AREA');

const MapElementDtoTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


