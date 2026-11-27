//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/map_element_response_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_area_with_elements_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapAreaWithElementsDto {
  /// Returns a new [MapAreaWithElementsDto] instance.
  MapAreaWithElementsDto({

    required  this.id,

    required  this.name,

    required  this.floor,

    required  this.gridCols,

    required  this.gridRows,

     this.backgroundUrl,

    required  this.elements,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'floor',
    required: true,
    includeIfNull: false,
  )


  final num floor;



  @JsonKey(
    
    name: r'gridCols',
    required: true,
    includeIfNull: false,
  )


  final num gridCols;



  @JsonKey(
    
    name: r'gridRows',
    required: true,
    includeIfNull: false,
  )


  final num gridRows;



  @JsonKey(
    
    name: r'backgroundUrl',
    required: false,
    includeIfNull: false,
  )


  final String? backgroundUrl;



  @JsonKey(
    
    name: r'elements',
    required: true,
    includeIfNull: false,
  )


  final List<MapElementResponseDto> elements;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapAreaWithElementsDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            floor,
            gridCols,
            gridRows,
            backgroundUrl,
            elements,
        ],
        [
            other.id,
            other.name,
            other.floor,
            other.gridCols,
            other.gridRows,
            other.backgroundUrl,
            other.elements,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        floor,
        gridCols,
        gridRows,
        backgroundUrl,
        elements,
    ],);

  factory MapAreaWithElementsDto.fromJson(Map<String, dynamic> json) => _$MapAreaWithElementsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapAreaWithElementsDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

