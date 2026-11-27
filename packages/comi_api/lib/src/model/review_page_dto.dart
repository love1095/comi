//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/review_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'review_page_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReviewPageDto {
  /// Returns a new [ReviewPageDto] instance.
  ReviewPageDto({

    required  this.ratingAvg,

    required  this.ratingCount,

    required  this.histogram,

    required  this.items,

     this.nextCursor,
  });

  @JsonKey(
    
    name: r'ratingAvg',
    required: true,
    includeIfNull: false,
  )


  final num ratingAvg;



  @JsonKey(
    
    name: r'ratingCount',
    required: true,
    includeIfNull: false,
  )


  final num ratingCount;



      /// How many 1★..5★ reviews (index 0 = 1★)
  @JsonKey(
    
    name: r'histogram',
    required: true,
    includeIfNull: false,
  )


  final List<num> histogram;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ReviewDto> items;



  @JsonKey(
    
    name: r'nextCursor',
    required: false,
    includeIfNull: false,
  )


  final String? nextCursor;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReviewPageDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            ratingAvg,
            ratingCount,
            histogram,
            items,
            nextCursor,
        ],
        [
            other.ratingAvg,
            other.ratingCount,
            other.histogram,
            other.items,
            other.nextCursor,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        ratingAvg,
        ratingCount,
        histogram,
        items,
        nextCursor,
    ],);

  factory ReviewPageDto.fromJson(Map<String, dynamic> json) => _$ReviewPageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewPageDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

