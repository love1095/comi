//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:comi_api/src/model/menu_photo_dto.dart';
import 'package:comi_api/src/model/option_group_response_dto.dart';
import 'package:comi_api/src/model/menu_translation_dto.dart';
import 'package:comi_api/src/model/item_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'staff_menu_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StaffMenuItemDto {
  /// Returns a new [StaffMenuItemDto] instance.
  StaffMenuItemDto({

    required  this.id,

    required  this.categoryId,

    required  this.name,

     this.description,

    required  this.price,

    required  this.course,

    required  this.kind,

    required  this.prepMinutes,

    required  this.isAvailable,

    required  this.isPreorderable,

    required  this.isAlcohol,

    required  this.leadHours,

    required  this.tags,

    required  this.sortOrder,

    required  this.photos,

    required  this.optionGroups,

    required  this.translations,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'categoryId',
    required: true,
    includeIfNull: false,
  )


  final String categoryId;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final num price;



  @JsonKey(
    
    name: r'course',
    required: true,
    includeIfNull: false,
  )


  final Course course;



  @JsonKey(
    
    name: r'kind',
    required: true,
    includeIfNull: false,
  )


  final ItemKind kind;



  @JsonKey(
    
    name: r'prepMinutes',
    required: true,
    includeIfNull: false,
  )


  final num prepMinutes;



  @JsonKey(
    
    name: r'isAvailable',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;



  @JsonKey(
    
    name: r'isPreorderable',
    required: true,
    includeIfNull: false,
  )


  final bool isPreorderable;



  @JsonKey(
    
    name: r'isAlcohol',
    required: true,
    includeIfNull: false,
  )


  final bool isAlcohol;



  @JsonKey(
    
    name: r'leadHours',
    required: true,
    includeIfNull: false,
  )


  final num leadHours;



  @JsonKey(
    
    name: r'tags',
    required: true,
    includeIfNull: false,
  )


  final List<String> tags;



  @JsonKey(
    
    name: r'sortOrder',
    required: true,
    includeIfNull: false,
  )


  final num sortOrder;



  @JsonKey(
    
    name: r'photos',
    required: true,
    includeIfNull: false,
  )


  final List<MenuPhotoDto> photos;



  @JsonKey(
    
    name: r'optionGroups',
    required: true,
    includeIfNull: false,
  )


  final List<OptionGroupResponseDto> optionGroups;



  @JsonKey(
    
    name: r'translations',
    required: true,
    includeIfNull: false,
  )


  final List<MenuTranslationDto> translations;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StaffMenuItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
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
            photos,
            optionGroups,
            translations,
        ],
        [
            other.id,
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
            other.photos,
            other.optionGroups,
            other.translations,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
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
        photos,
        optionGroups,
        translations,
    ],);

  factory StaffMenuItemDto.fromJson(Map<String, dynamic> json) => _$StaffMenuItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMenuItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

