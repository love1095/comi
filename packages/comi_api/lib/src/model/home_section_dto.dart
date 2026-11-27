//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_card_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'home_section_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HomeSectionDto {
  /// Returns a new [HomeSectionDto] instance.
  HomeSectionDto({

    required  this.key,

    required  this.items,
  });

      /// lunch_near_you | under_60k | tonight_groups | open_late | top_rated | menus_in_your_language
  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final String key;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<RestaurantCardDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is HomeSectionDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            key,
            items,
        ],
        [
            other.key,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        key,
        items,
    ],);

  factory HomeSectionDto.fromJson(Map<String, dynamic> json) => _$HomeSectionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSectionDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

