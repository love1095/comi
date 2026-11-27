// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_review_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportReviewDtoCWProxy {
  ReportReviewDto reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportReviewDto call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportReviewDto.copyWith(...)` or call `instanceOfReportReviewDto.copyWith.fieldName(value)` for a single field.
class _$ReportReviewDtoCWProxyImpl implements _$ReportReviewDtoCWProxy {
  const _$ReportReviewDtoCWProxyImpl(this._value);

  final ReportReviewDto _value;

  @override
  ReportReviewDto reason(String reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportReviewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportReviewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReportReviewDto call({Object? reason = const $CopyWithPlaceholder()}) {
    return ReportReviewDto(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $ReportReviewDtoCopyWith on ReportReviewDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportReviewDto.copyWith(...)` or `instanceOfReportReviewDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportReviewDtoCWProxy get copyWith => _$ReportReviewDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportReviewDto _$ReportReviewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportReviewDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = ReportReviewDto(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ReportReviewDtoToJson(ReportReviewDto instance) =>
    <String, dynamic>{'reason': instance.reason};
