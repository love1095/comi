//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/staff_menu_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'staff_menu_category_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StaffMenuCategoryDto {
  /// Returns a new [StaffMenuCategoryDto] instance.
  StaffMenuCategoryDto({

    required  this.id,

    required  this.name,

    required  this.sortOrder,

    required  this.items,
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
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<StaffMenuItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StaffMenuCategoryDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            sortOrder,
            items,
        ],
        [
            other.id,
            other.name,
            other.sortOrder,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        sortOrder,
        items,
    ],);

  factory StaffMenuCategoryDto.fromJson(Map<String, dynamic> json) => _$StaffMenuCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMenuCategoryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

