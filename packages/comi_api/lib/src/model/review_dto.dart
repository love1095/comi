//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'review_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReviewDto {
  /// Returns a new [ReviewDto] instance.
  ReviewDto({

    required  this.id,

    required  this.bookingId,

    required  this.restaurantId,

    required  this.authorName,

    required  this.rating,

     this.foodRating,

     this.serviceRating,

     this.text,

    required  this.verifiedVisit,

    required  this.visitedAt,

    required  this.partySize,

     this.reply,

     this.repliedAt,

    required  this.status,

     this.reportReason,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'bookingId',
    required: true,
    includeIfNull: false,
  )


  final String bookingId;



  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



      /// First name only (privacy)
  @JsonKey(
    
    name: r'authorName',
    required: true,
    includeIfNull: false,
  )


  final String authorName;



  @JsonKey(
    
    name: r'rating',
    required: true,
    includeIfNull: false,
  )


  final num rating;



  @JsonKey(
    
    name: r'foodRating',
    required: false,
    includeIfNull: false,
  )


  final num? foodRating;



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



      /// Every review comes from a real booking
  @JsonKey(
    
    name: r'verifiedVisit',
    required: true,
    includeIfNull: false,
  )


  final bool verifiedVisit;



  @JsonKey(
    
    name: r'visitedAt',
    required: true,
    includeIfNull: false,
  )


  final String visitedAt;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'reply',
    required: false,
    includeIfNull: false,
  )


  final String? reply;



  @JsonKey(
    
    name: r'repliedAt',
    required: false,
    includeIfNull: false,
  )


  final String? repliedAt;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final ReviewDtoStatusEnum status;



  @JsonKey(
    
    name: r'reportReason',
    required: false,
    includeIfNull: false,
  )


  final String? reportReason;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReviewDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            restaurantId,
            authorName,
            rating,
            foodRating,
            serviceRating,
            text,
            verifiedVisit,
            visitedAt,
            partySize,
            reply,
            repliedAt,
            status,
            reportReason,
            createdAt,
        ],
        [
            other.id,
            other.bookingId,
            other.restaurantId,
            other.authorName,
            other.rating,
            other.foodRating,
            other.serviceRating,
            other.text,
            other.verifiedVisit,
            other.visitedAt,
            other.partySize,
            other.reply,
            other.repliedAt,
            other.status,
            other.reportReason,
            other.createdAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        restaurantId,
        authorName,
        rating,
        foodRating,
        serviceRating,
        text,
        verifiedVisit,
        visitedAt,
        partySize,
        reply,
        repliedAt,
        status,
        reportReason,
        createdAt,
    ],);

  factory ReviewDto.fromJson(Map<String, dynamic> json) => _$ReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ReviewDtoStatusEnum {
@JsonValue(r'PUBLISHED')
PUBLISHED(r'PUBLISHED'),
@JsonValue(r'HIDDEN')
HIDDEN(r'HIDDEN'),
@JsonValue(r'REPORTED')
REPORTED(r'REPORTED');

const ReviewDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


