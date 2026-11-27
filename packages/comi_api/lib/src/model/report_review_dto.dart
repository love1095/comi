//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'report_review_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportReviewDto {
  /// Returns a new [ReportReviewDto] instance.
  ReportReviewDto({

    required  this.reason,
  });

  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReportReviewDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            reason,
        ],
        [
            other.reason,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        reason,
    ],);

  factory ReportReviewDto.fromJson(Map<String, dynamic> json) => _$ReportReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReportReviewDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

