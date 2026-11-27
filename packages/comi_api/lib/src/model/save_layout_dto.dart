//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/map_element_dto.dart';
import 'package:comi_api/src/model/layout_table_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'save_layout_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SaveLayoutDto {
  /// Returns a new [SaveLayoutDto] instance.
  SaveLayoutDto({

     this.gridCols,

     this.gridRows,

    required  this.tables,

    required  this.elements,
  });

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
    
    name: r'tables',
    required: true,
    includeIfNull: false,
  )


  final List<LayoutTableDto> tables;



  @JsonKey(
    
    name: r'elements',
    required: true,
    includeIfNull: false,
  )


  final List<MapElementDto> elements;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SaveLayoutDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            gridCols,
            gridRows,
            tables,
            elements,
        ],
        [
            other.gridCols,
            other.gridRows,
            other.tables,
            other.elements,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        gridCols,
        gridRows,
        tables,
        elements,
    ],);

  factory SaveLayoutDto.fromJson(Map<String, dynamic> json) => _$SaveLayoutDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SaveLayoutDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

