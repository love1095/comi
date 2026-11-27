// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateReviewDtoCWProxy {
  CreateReviewDto rating(num rating);

  CreateReviewDto foodRating(num? foodRating);

  CreateReviewDto serviceRating(num? serviceRating);

  CreateReviewDto text(String? text);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CreateReviewDto call({
    num rating,
    num? foodRating,
    num? serviceRating,
    String? text,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCreateReviewDto.copyWith(...)` or call `instanceOfCreateReviewDto.copyWith.fieldName(value)` for a single field.
class _$CreateReviewDtoCWProxyImpl implements _$CreateReviewDtoCWProxy {
  const _$CreateReviewDtoCWProxyImpl(this._value);

  final CreateReviewDto _value;

  @override
  CreateReviewDto rating(num rating) => call(rating: rating);

  @override
  CreateReviewDto foodRating(num? foodRating) => call(foodRating: foodRating);

  @override
  CreateReviewDto serviceRating(num? serviceRating) =>
      call(serviceRating: serviceRating);

  @override
  CreateReviewDto text(String? text) => call(text: text);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CreateReviewDto call({
    Object? rating = const $CopyWithPlaceholder(),
    Object? foodRating = const $CopyWithPlaceholder(),
    Object? serviceRating = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return CreateReviewDto(
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
    );
  }
}

extension $CreateReviewDtoCopyWith on CreateReviewDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCreateReviewDto.copyWith(...)` or `instanceOfCreateReviewDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateReviewDtoCWProxy get copyWith => _$CreateReviewDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewDto _$CreateReviewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateReviewDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['rating']);
      final val = CreateReviewDto(
        rating: $checkedConvert('rating', (v) => v as num),
        foodRating: $checkedConvert('foodRating', (v) => v as num?),
        serviceRating: $checkedConvert('serviceRating', (v) => v as num?),
        text: $checkedConvert('text', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CreateReviewDtoToJson(CreateReviewDto instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'foodRating': ?instance.foodRating,
      'serviceRating': ?instance.serviceRating,
      'text': ?instance.text,
    };
