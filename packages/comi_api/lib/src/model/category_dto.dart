//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'category_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategoryDto {
  /// Returns a new [CategoryDto] instance.
  CategoryDto({

    required  this.name,

     this.sortOrder,
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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CategoryDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            sortOrder,
        ],
        [
            other.name,
            other.sortOrder,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        sortOrder,
    ],);

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

