//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/option_group_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_menu_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateMenuItemDto {
  /// Returns a new [UpdateMenuItemDto] instance.
  UpdateMenuItemDto({

     this.categoryId,

     this.name,

     this.description,

     this.price,

     this.course,

     this.kind,

     this.prepMinutes,

     this.isAvailable,

     this.isPreorderable,

     this.isAlcohol,

     this.leadHours,

     this.tags,

     this.sortOrder,

     this.optionGroups,
  });

  @JsonKey(
    
    name: r'categoryId',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



      /// VND
  @JsonKey(
    
    name: r'price',
    required: false,
    includeIfNull: false,
  )


  final num? price;



  @JsonKey(
    
    name: r'course',
    required: false,
    includeIfNull: false,
  )


  final UpdateMenuItemDtoCourseEnum? course;



  @JsonKey(
    
    name: r'kind',
    required: false,
    includeIfNull: false,
  )


  final UpdateMenuItemDtoKindEnum? kind;



  @JsonKey(
    
    name: r'prepMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? prepMinutes;



  @JsonKey(
    
    name: r'isAvailable',
    required: false,
    includeIfNull: false,
  )


  final bool? isAvailable;



  @JsonKey(
    
    name: r'isPreorderable',
    required: false,
    includeIfNull: false,
  )


  final bool? isPreorderable;



  @JsonKey(
    
    name: r'isAlcohol',
    required: false,
    includeIfNull: false,
  )


  final bool? isAlcohol;



  @JsonKey(
    
    name: r'leadHours',
    required: false,
    includeIfNull: false,
  )


  final num? leadHours;



  @JsonKey(
    
    name: r'tags',
    required: false,
    includeIfNull: false,
  )


  final List<String>? tags;



  @JsonKey(
    
    name: r'sortOrder',
    required: false,
    includeIfNull: false,
  )


  final num? sortOrder;



      /// When sent, replaces all option groups
  @JsonKey(
    
    name: r'optionGroups',
    required: false,
    includeIfNull: false,
  )


  final List<OptionGroupDto>? optionGroups;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateMenuItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            categoryId,
            name,
            description,
            price,
            course,
            kind,
            prepMinutes,
            isAvailable,
            isPreorderable,
            isAlcohol,
            leadHours,
            tags,
            sortOrder,
            optionGroups,
        ],
        [
            other.categoryId,
            other.name,
            other.description,
            other.price,
            other.course,
            other.kind,
            other.prepMinutes,
            other.isAvailable,
            other.isPreorderable,
            other.isAlcohol,
            other.leadHours,
            other.tags,
            other.sortOrder,
            other.optionGroups,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        categoryId,
        name,
        description,
        price,
        course,
        kind,
        prepMinutes,
        isAvailable,
        isPreorderable,
        isAlcohol,
        leadHours,
        tags,
        sortOrder,
        optionGroups,
    ],);

  factory UpdateMenuItemDto.fromJson(Map<String, dynamic> json) => _$UpdateMenuItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMenuItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum UpdateMenuItemDtoCourseEnum {
@JsonValue(r'DRINK')
DRINK(r'DRINK'),
@JsonValue(r'STARTER')
STARTER(r'STARTER'),
@JsonValue(r'MAIN')
MAIN(r'MAIN'),
@JsonValue(r'DESSERT')
DESSERT(r'DESSERT');

const UpdateMenuItemDtoCourseEnum(this.value);

final String value;

@override
String toString() => value;
}


enum UpdateMenuItemDtoKindEnum {
@JsonValue(r'DISH')
DISH(r'DISH'),
@JsonValue(r'DRINK')
DRINK(r'DRINK'),
@JsonValue(r'SET')
SET(r'SET'),
@JsonValue(r'ADD_ON')
ADD_ON(r'ADD_ON');

const UpdateMenuItemDtoKindEnum(this.value);

final String value;

@override
String toString() => value;
}


