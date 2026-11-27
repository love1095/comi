//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/map_area_with_elements_dto.dart';
import 'package:comi_api/src/model/map_table_state_dto.dart';
import 'package:comi_api/src/model/my_hold_dto.dart';
import 'package:comi_api/src/model/map_area_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'table_map_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableMapDto {
  /// Returns a new [TableMapDto] instance.
  TableMapDto({

    required  this.allowTableChoice,

    required  this.arrivalAt,

    required  this.diningMinutes,

    required  this.areas,

    required  this.area,

     this.myHold,

    required  this.tables,
  });

  @JsonKey(
    
    name: r'allowTableChoice',
    required: true,
    includeIfNull: false,
  )


  final bool allowTableChoice;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;



  @JsonKey(
    
    name: r'diningMinutes',
    required: true,
    includeIfNull: false,
  )


  final num diningMinutes;



  @JsonKey(
    
    name: r'areas',
    required: true,
    includeIfNull: false,
  )


  final List<MapAreaDto> areas;



  @JsonKey(
    
    name: r'area',
    required: true,
    includeIfNull: false,
  )


  final MapAreaWithElementsDto area;



  @JsonKey(
    
    name: r'myHold',
    required: false,
    includeIfNull: false,
  )


  final MyHoldDto? myHold;



  @JsonKey(
    
    name: r'tables',
    required: true,
    includeIfNull: false,
  )


  final List<MapTableStateDto> tables;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is TableMapDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            allowTableChoice,
            arrivalAt,
            diningMinutes,
            areas,
            area,
            myHold,
            tables,
        ],
        [
            other.allowTableChoice,
            other.arrivalAt,
            other.diningMinutes,
            other.areas,
            other.area,
            other.myHold,
            other.tables,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        allowTableChoice,
        arrivalAt,
        diningMinutes,
        areas,
        area,
        myHold,
        tables,
    ],);

  factory TableMapDto.fromJson(Map<String, dynamic> json) => _$TableMapDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TableMapDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

