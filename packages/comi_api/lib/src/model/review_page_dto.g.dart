// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_page_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewPageDtoCWProxy {
  ReviewPageDto ratingAvg(num ratingAvg);

  ReviewPageDto ratingCount(num ratingCount);

  ReviewPageDto histogram(List<num> histogram);

  ReviewPageDto items(List<ReviewDto> items);

  ReviewPageDto nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReviewPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewPageDto call({
    num ratingAvg,
    num ratingCount,
    List<num> histogram,
    List<ReviewDto> items,
    String? nextCursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReviewPageDto.copyWith(...)` or call `instanceOfReviewPageDto.copyWith.fieldName(value)` for a single field.
class _$ReviewPageDtoCWProxyImpl implements _$ReviewPageDtoCWProxy {
  const _$ReviewPageDtoCWProxyImpl(this._value);

  final ReviewPageDto _value;

  @override
  ReviewPageDto ratingAvg(num ratingAvg) => call(ratingAvg: ratingAvg);

  @override
  ReviewPageDto ratingCount(num ratingCount) => call(ratingCount: ratingCount);

  @override
  ReviewPageDto histogram(List<num> histogram) => call(histogram: histogram);

  @override
  ReviewPageDto items(List<ReviewDto> items) => call(items: items);

  @override
  ReviewPageDto nextCursor(String? nextCursor) => call(nextCursor: nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReviewPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReviewPageDto call({
    Object? ratingAvg = const $CopyWithPlaceholder(),
    Object? ratingCount = const $CopyWithPlaceholder(),
    Object? histogram = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return ReviewPageDto(
      ratingAvg: ratingAvg == const $CopyWithPlaceholder() || ratingAvg == null
          ? _value.ratingAvg
          // ignore: cast_nullable_to_non_nullable
          : ratingAvg as num,
      ratingCount:
          ratingCount == const $CopyWithPlaceholder() || ratingCount == null
          ? _value.ratingCount
          // ignore: cast_nullable_to_non_nullable
          : ratingCount as num,
      histogram: histogram == const $CopyWithPlaceholder() || histogram == null
          ? _value.histogram
          // ignore: cast_nullable_to_non_nullable
          : histogram as List<num>,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ReviewDto>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $ReviewPageDtoCopyWith on ReviewPageDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReviewPageDto.copyWith(...)` or `instanceOfReviewPageDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewPageDtoCWProxy get copyWith => _$ReviewPageDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewPageDto _$ReviewPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewPageDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['ratingAvg', 'ratingCount', 'histogram', 'items'],
      );
      final val = ReviewPageDto(
        ratingAvg: $checkedConvert('ratingAvg', (v) => v as num),
        ratingCount: $checkedConvert('ratingCount', (v) => v as num),
        histogram: $checkedConvert(
          'histogram',
          (v) => (v as List<dynamic>).map((e) => e as num).toList(),
        ),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReviewPageDtoToJson(ReviewPageDto instance) =>
    <String, dynamic>{
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'histogram': instance.histogram,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': ?instance.nextCursor,
    };
