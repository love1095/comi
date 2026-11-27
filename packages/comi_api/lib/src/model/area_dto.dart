//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'area_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AreaDto {
  /// Returns a new [AreaDto] instance.
  AreaDto({

    required  this.name,

     this.sortOrder,

     this.gridCols,

     this.gridRows,

     this.floor,

     this.backgroundUrl,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'sortOrder',
    required: false,
    includeIfNull: false,
  )


  final num? sortOrder;



  @JsonKey(
    
    name: r'gridCols',
    required: false,
    includeIfNull: false,
  )


  final num? gridCols;



  @JsonKey(
    
    name: r'gridRows',
    required: false,
    includeIfNull: false,
  )


  final num? gridRows;



  @JsonKey(
    
    name: r'floor',
    required: false,
    includeIfNull: false,
  )


  final num? floor;



  @JsonKey(
    
    name: r'backgroundUrl',
    required: false,
    includeIfNull: false,
  )


  final String? backgroundUrl;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AreaDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            sortOrder,
            gridCols,
            gridRows,
            floor,
            backgroundUrl,
        ],
        [
            other.name,
            other.sortOrder,
            other.gridCols,
            other.gridRows,
            other.floor,
            other.backgroundUrl,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        sortOrder,
        gridCols,
        gridRows,
        floor,
        backgroundUrl,
    ],);

  factory AreaDto.fromJson(Map<String, dynamic> json) => _$AreaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AreaDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

