//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:comi_api/src/model/public_option_group_dto.dart';
import 'package:comi_api/src/model/public_photo_dto.dart';
import 'package:comi_api/src/model/item_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'public_menu_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicMenuItemDto {
  /// Returns a new [PublicMenuItemDto] instance.
  PublicMenuItemDto({

    required  this.id,

    required  this.name,

     this.description,

    required  this.translated,

    required  this.originalName,

    required  this.price,

    required  this.course,

    required  this.kind,

    required  this.prepMinutes,

    required  this.isAvailable,

    required  this.isPreorderable,

    required  this.isAlcohol,

    required  this.leadHours,

    required  this.tags,

    required  this.photos,

    required  this.optionGroups,
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
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



      /// machine = show \"auto-translated\"
  @JsonKey(
    
    name: r'translated',
    required: true,
    includeIfNull: false,
  )


  final PublicMenuItemDtoTranslatedEnum translated;



      /// Vietnamese name (show to staff / taxi)
  @JsonKey(
    
    name: r'originalName',
    required: true,
    includeIfNull: false,
  )


  final String originalName;



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
    
    name: r'photos',
    required: true,
    includeIfNull: false,
  )


  final List<PublicPhotoDto> photos;



  @JsonKey(
    
    name: r'optionGroups',
    required: true,
    includeIfNull: false,
  )


  final List<PublicOptionGroupDto> optionGroups;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PublicMenuItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            description,
            translated,
            originalName,
            price,
            course,
            kind,
            prepMinutes,
            isAvailable,
            isPreorderable,
            isAlcohol,
            leadHours,
            tags,
            photos,
            optionGroups,
        ],
        [
            other.id,
            other.name,
            other.description,
            other.translated,
            other.originalName,
            other.price,
            other.course,
            other.kind,
            other.prepMinutes,
            other.isAvailable,
            other.isPreorderable,
            other.isAlcohol,
            other.leadHours,
            other.tags,
            other.photos,
            other.optionGroups,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        description,
        translated,
        originalName,
        price,
        course,
        kind,
        prepMinutes,
        isAvailable,
        isPreorderable,
        isAlcohol,
        leadHours,
        tags,
        photos,
        optionGroups,
    ],);

  factory PublicMenuItemDto.fromJson(Map<String, dynamic> json) => _$PublicMenuItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicMenuItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

/// machine = show \"auto-translated\"
enum PublicMenuItemDtoTranslatedEnum {
@JsonValue(r'none')
none(r'none'),
@JsonValue(r'human')
human(r'human'),
@JsonValue(r'machine')
machine(r'machine');

const PublicMenuItemDtoTranslatedEnum(this.value);

final String value;

@override
String toString() => value;
}


