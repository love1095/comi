//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'map_area_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MapAreaDto {
  /// Returns a new [MapAreaDto] instance.
  MapAreaDto({

    required  this.id,

    required  this.name,

    required  this.floor,

    required  this.gridCols,

    required  this.gridRows,

     this.backgroundUrl,
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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MapAreaDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            floor,
            gridCols,
            gridRows,
            backgroundUrl,
        ],
        [
            other.id,
            other.name,
            other.floor,
            other.gridCols,
            other.gridRows,
            other.backgroundUrl,
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
    ],);

  factory MapAreaDto.fromJson(Map<String, dynamic> json) => _$MapAreaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MapAreaDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

