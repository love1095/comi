//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:comi_api/src/model/item_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'imported_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ImportedItemDto {
  /// Returns a new [ImportedItemDto] instance.
  ImportedItemDto({

    required  this.row,

    required  this.category,

    required  this.name,

    required  this.price,

    required  this.course,

    required  this.kind,

     this.description,

    required  this.prepMinutes,

    required  this.isAlcohol,

    required  this.tags,
  });

  @JsonKey(
    
    name: r'row',
    required: true,
    includeIfNull: false,
  )


  final num row;



  @JsonKey(
    
    name: r'category',
    required: true,
    includeIfNull: false,
  )


  final String category;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



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
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'prepMinutes',
    required: true,
    includeIfNull: false,
  )


  final num prepMinutes;



  @JsonKey(
    
    name: r'isAlcohol',
    required: true,
    includeIfNull: false,
  )


  final bool isAlcohol;



  @JsonKey(
    
    name: r'tags',
    required: true,
    includeIfNull: false,
  )


  final List<String> tags;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ImportedItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            row,
            category,
            name,
            price,
            course,
            kind,
            description,
            prepMinutes,
            isAlcohol,
            tags,
        ],
        [
            other.row,
            other.category,
            other.name,
            other.price,
            other.course,
            other.kind,
            other.description,
            other.prepMinutes,
            other.isAlcohol,
            other.tags,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        row,
        category,
        name,
        price,
        course,
        kind,
        description,
        prepMinutes,
        isAlcohol,
        tags,
    ],);

  factory ImportedItemDto.fromJson(Map<String, dynamic> json) => _$ImportedItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImportedItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

