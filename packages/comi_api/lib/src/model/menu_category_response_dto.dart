//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'menu_category_response_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuCategoryResponseDto {
  /// Returns a new [MenuCategoryResponseDto] instance.
  MenuCategoryResponseDto({

    required  this.id,

    required  this.name,

    required  this.sortOrder,
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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MenuCategoryResponseDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            sortOrder,
        ],
        [
            other.id,
            other.name,
            other.sortOrder,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        sortOrder,
    ],);

  factory MenuCategoryResponseDto.fromJson(Map<String, dynamic> json) => _$MenuCategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

