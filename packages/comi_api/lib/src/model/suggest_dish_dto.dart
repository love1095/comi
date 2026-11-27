//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'suggest_dish_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SuggestDishDto {
  /// Returns a new [SuggestDishDto] instance.
  SuggestDishDto({

    required  this.id,

    required  this.name,

    required  this.price,

    required  this.restaurantId,

    required  this.restaurantSlug,

    required  this.restaurantName,
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
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final num price;



  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    
    name: r'restaurantSlug',
    required: true,
    includeIfNull: false,
  )


  final String restaurantSlug;



  @JsonKey(
    
    name: r'restaurantName',
    required: true,
    includeIfNull: false,
  )


  final String restaurantName;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SuggestDishDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            price,
            restaurantId,
            restaurantSlug,
            restaurantName,
        ],
        [
            other.id,
            other.name,
            other.price,
            other.restaurantId,
            other.restaurantSlug,
            other.restaurantName,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        price,
        restaurantId,
        restaurantSlug,
        restaurantName,
    ],);

  factory SuggestDishDto.fromJson(Map<String, dynamic> json) => _$SuggestDishDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestDishDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

