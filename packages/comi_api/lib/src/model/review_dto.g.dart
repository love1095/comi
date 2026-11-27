// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewDtoCWProxy {
  ReviewDto id(String id);

  ReviewDto bookingId(String bookingId);

  ReviewDto restaurantId(String restaurantId);

  ReviewDto authorName(String authorName);

  ReviewDto rating(num rating);

  ReviewDto foodRating(num? foodRating);

  ReviewDto serviceRating(num? serviceRating);

  ReviewDto text(String? text);

  ReviewDto verifiedVisit(bool verifiedVisit);

  ReviewDto visitedAt(String visitedAt);

  ReviewDto partySize(num partySize);

  ReviewDto reply(String? reply);

  ReviewDto repliedAt(String? repliedAt);

  ReviewDto status(ReviewDtoStatusEnum status);

  ReviewDto reportReason(String? reportReason);

  ReviewDto createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewDto call({
    String id,
    String bookingId,
    String restaurantId,
    String authorName,
    num rating,
    num? foodRating,
    num? serviceRating,
    String? text,
    bool verifiedVisit,
    String visitedAt,
    num partySize,
    String? reply,
    String? repliedAt,
    ReviewDtoStatusEnum status,
    String? reportReason,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReviewDto.copyWith(...)` or call `instanceOfReviewDto.copyWith.fieldName(value)` for a single field.
class _$ReviewDtoCWProxyImpl implements _$ReviewDtoCWProxy {
  const _$ReviewDtoCWProxyImpl(this._value);

  final ReviewDto _value;

  @override
  ReviewDto id(String id) => call(id: id);

  @override
  ReviewDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  ReviewDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  ReviewDto authorName(String authorName) => call(authorName: authorName);

  @override
  ReviewDto rating(num rating) => call(rating: rating);

  @override
  ReviewDto foodRating(num? foodRating) => call(foodRating: foodRating);

  @override
  ReviewDto serviceRating(num? serviceRating) =>
      call(serviceRating: serviceRating);

  @override
  ReviewDto text(String? text) => call(text: text);

  @override
  ReviewDto verifiedVisit(bool verifiedVisit) =>
      call(verifiedVisit: verifiedVisit);

  @override
  ReviewDto visitedAt(String visitedAt) => call(visitedAt: visitedAt);

  @override
  ReviewDto partySize(num partySize) => call(partySize: partySize);

  @override
  ReviewDto reply(String? reply) => call(reply: reply);

  @override
  ReviewDto repliedAt(String? repliedAt) => call(repliedAt: repliedAt);

  @override
  ReviewDto status(ReviewDtoStatusEnum status) => call(status: status);

  @override
  ReviewDto reportReason(String? reportReason) =>
      call(reportReason: reportReason);

  @override
  ReviewDto createdAt(String createdAt) => call(createdAt: createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReviewDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? authorName = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? foodRating = const $CopyWithPlaceholder(),
    Object? serviceRating = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? verifiedVisit = const $CopyWithPlaceholder(),
    Object? visitedAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? reply = const $CopyWithPlaceholder(),
    Object? repliedAt = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? reportReason = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return ReviewDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      authorName:
          authorName == const $CopyWithPlaceholder() || authorName == null
          ? _value.authorName
          // ignore: cast_nullable_to_non_nullable
          : authorName as String,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
      foodRating: foodRating == const $CopyWithPlaceholder()
          ? _value.foodRating
          // ignore: cast_nullable_to_non_nullable
          : foodRating as num?,
      serviceRating: serviceRating == const $CopyWithPlaceholder()
          ? _value.serviceRating
          // ignore: cast_nullable_to_non_nullable
          : serviceRating as num?,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String?,
      verifiedVisit:
          verifiedVisit == const $CopyWithPlaceholder() || verifiedVisit == null
          ? _value.verifiedVisit
          // ignore: cast_nullable_to_non_nullable
          : verifiedVisit as bool,
      visitedAt: visitedAt == const $CopyWithPlaceholder() || visitedAt == null
          ? _value.visitedAt
          // ignore: cast_nullable_to_non_nullable
          : visitedAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      reply: reply == const $CopyWithPlaceholder()
          ? _value.reply
          // ignore: cast_nullable_to_non_nullable
          : reply as String?,
      repliedAt: repliedAt == const $CopyWithPlaceholder()
          ? _value.repliedAt
          // ignore: cast_nullable_to_non_nullable
          : repliedAt as String?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReviewDtoStatusEnum,
      reportReason: reportReason == const $CopyWithPlaceholder()
          ? _value.reportReason
          // ignore: cast_nullable_to_non_nullable
          : reportReason as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $ReviewDtoCopyWith on ReviewDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReviewDto.copyWith(...)` or `instanceOfReviewDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewDtoCWProxy get copyWith => _$ReviewDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'bookingId',
          'restaurantId',
          'authorName',
          'rating',
          'verifiedVisit',
          'visitedAt',
          'partySize',
          'status',
          'createdAt',
        ],
      );
      final val = ReviewDto(
        id: $checkedConvert('id', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        authorName: $checkedConvert('authorName', (v) => v as String),
        rating: $checkedConvert('rating', (v) => v as num),
        foodRating: $checkedConvert('foodRating', (v) => v as num?),
        serviceRating: $checkedConvert('serviceRating', (v) => v as num?),
        text: $checkedConvert('text', (v) => v as String?),
        verifiedVisit: $checkedConvert('verifiedVisit', (v) => v as bool),
        visitedAt: $checkedConvert('visitedAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        reply: $checkedConvert('reply', (v) => v as String?),
        repliedAt: $checkedConvert('repliedAt', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReviewDtoStatusEnumEnumMap, v),
        ),
        reportReason: $checkedConvert('reportReason', (v) => v as String?),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
  'id': instance.id,
  'bookingId': instance.bookingId,
  'restaurantId': instance.restaurantId,
  'authorName': instance.authorName,
  'rating': instance.rating,
  'foodRating': ?instance.foodRating,
  'serviceRating': ?instance.serviceRating,
  'text': ?instance.text,
  'verifiedVisit': instance.verifiedVisit,
  'visitedAt': instance.visitedAt,
  'partySize': instance.partySize,
  'reply': ?instance.reply,
  'repliedAt': ?instance.repliedAt,
  'status': _$ReviewDtoStatusEnumEnumMap[instance.status]!,
  'reportReason': ?instance.reportReason,
  'createdAt': instance.createdAt,
};

const _$ReviewDtoStatusEnumEnumMap = {
  ReviewDtoStatusEnum.PUBLISHED: 'PUBLISHED',
  ReviewDtoStatusEnum.HIDDEN: 'HIDDEN',
  ReviewDtoStatusEnum.REPORTED: 'REPORTED',
};
