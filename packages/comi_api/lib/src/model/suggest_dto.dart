//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/suggest_restaurant_dto.dart';
import 'package:comi_api/src/model/suggest_dish_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'suggest_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SuggestDto {
  /// Returns a new [SuggestDto] instance.
  SuggestDto({

    required  this.restaurants,

    required  this.dishes,
  });

  @JsonKey(
    
    name: r'restaurants',
    required: true,
    includeIfNull: false,
  )


  final List<SuggestRestaurantDto> restaurants;



  @JsonKey(
    
    name: r'dishes',
    required: true,
    includeIfNull: false,
  )


  final List<SuggestDishDto> dishes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SuggestDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            restaurants,
            dishes,
        ],
        [
            other.restaurants,
            other.dishes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        restaurants,
        dishes,
    ],);

  factory SuggestDto.fromJson(Map<String, dynamic> json) => _$SuggestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

