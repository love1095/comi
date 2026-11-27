//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'area_summary_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AreaSummaryDto {
  /// Returns a new [AreaSummaryDto] instance.
  AreaSummaryDto({

    required  this.id,

    required  this.name,

    required  this.sortOrder,

    required  this.gridCols,

    required  this.gridRows,

    required  this.floor,

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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AreaSummaryDto &&
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
        ],
        [
            other.id,
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
        id,
        name,
        sortOrder,
        gridCols,
        gridRows,
        floor,
        backgroundUrl,
    ],);

  factory AreaSummaryDto.fromJson(Map<String, dynamic> json) => _$AreaSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AreaSummaryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

