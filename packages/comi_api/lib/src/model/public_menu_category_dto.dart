//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/public_menu_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'public_menu_category_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicMenuCategoryDto {
  /// Returns a new [PublicMenuCategoryDto] instance.
  PublicMenuCategoryDto({

    required  this.id,

    required  this.name,

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
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<PublicMenuItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PublicMenuCategoryDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            items,
        ],
        [
            other.id,
            other.name,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        items,
    ],);

  factory PublicMenuCategoryDto.fromJson(Map<String, dynamic> json) => _$PublicMenuCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicMenuCategoryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

