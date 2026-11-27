//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'suggest_restaurant_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SuggestRestaurantDto {
  /// Returns a new [SuggestRestaurantDto] instance.
  SuggestRestaurantDto({

    required  this.id,

    required  this.slug,

    required  this.name,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'slug',
    required: true,
    includeIfNull: false,
  )


  final String slug;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SuggestRestaurantDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            slug,
            name,
        ],
        [
            other.id,
            other.slug,
            other.name,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        slug,
        name,
    ],);

  factory SuggestRestaurantDto.fromJson(Map<String, dynamic> json) => _$SuggestRestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestRestaurantDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

