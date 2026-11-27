//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_review_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateReviewDto {
  /// Returns a new [CreateReviewDto] instance.
  CreateReviewDto({

    required  this.rating,

     this.foodRating,

     this.serviceRating,

     this.text,
  });

          // minimum: 1
          // maximum: 5
  @JsonKey(
    
    name: r'rating',
    required: true,
    includeIfNull: false,
  )


  final num rating;



          // minimum: 1
          // maximum: 5
  @JsonKey(
    
    name: r'foodRating',
    required: false,
    includeIfNull: false,
  )


  final num? foodRating;



          // minimum: 1
          // maximum: 5
  @JsonKey(
    
    name: r'serviceRating',
    required: false,
    includeIfNull: false,
  )


  final num? serviceRating;



  @JsonKey(
    
    name: r'text',
    required: false,
    includeIfNull: false,
  )


  final String? text;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateReviewDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            rating,
            foodRating,
            serviceRating,
            text,
        ],
        [
            other.rating,
            other.foodRating,
            other.serviceRating,
            other.text,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        rating,
        foodRating,
        serviceRating,
        text,
    ],);

  factory CreateReviewDto.fromJson(Map<String, dynamic> json) => _$CreateReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReviewDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

