//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_card_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'restaurant_page_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RestaurantPageDto {
  /// Returns a new [RestaurantPageDto] instance.
  RestaurantPageDto({

    required  this.items,

     this.nextCursor,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<RestaurantCardDto> items;



      /// Pass as cursor for the next page
  @JsonKey(
    
    name: r'nextCursor',
    required: false,
    includeIfNull: false,
  )


  final num? nextCursor;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RestaurantPageDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
            nextCursor,
        ],
        [
            other.items,
            other.nextCursor,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
        nextCursor,
    ],);

  factory RestaurantPageDto.fromJson(Map<String, dynamic> json) => _$RestaurantPageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantPageDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

