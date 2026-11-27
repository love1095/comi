//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/map_element_response_dto.dart';
import 'package:comi_api/src/model/table_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'area_layout_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AreaLayoutDto {
  /// Returns a new [AreaLayoutDto] instance.
  AreaLayoutDto({

    required  this.id,

    required  this.name,

    required  this.sortOrder,

    required  this.gridCols,

    required  this.gridRows,

    required  this.floor,

     this.backgroundUrl,

    required  this.tables,

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
    
    name: r'sortOrder',
    required: true,
    includeIfNull: false,
  )


  final num sortOrder;



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
    
    name: r'floor',
    required: true,
    includeIfNull: false,
  )


  final num floor;



  @JsonKey(
    
    name: r'backgroundUrl',
    required: false,
    includeIfNull: false,
  )


  final String? backgroundUrl;



  @JsonKey(
    
    name: r'tables',
    required: true,
    includeIfNull: false,
  )


  final List<TableDto> tables;



  @JsonKey(
    
    name: r'elements',
    required: true,
    includeIfNull: false,
  )


  final List<MapElementResponseDto> elements;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AreaLayoutDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            sortOrder,
            gridCols,
            gridRows,
            floor,
            backgroundUrl,
            tables,
            elements,
        ],
        [
            other.id,
            other.name,
            other.sortOrder,
            other.gridCols,
            other.gridRows,
            other.floor,
            other.backgroundUrl,
            other.tables,
            other.elements,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        sortOrder,
        gridCols,
        gridRows,
        floor,
        backgroundUrl,
        tables,
        elements,
    ],);

  factory AreaLayoutDto.fromJson(Map<String, dynamic> json) => _$AreaLayoutDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AreaLayoutDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

