//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'decision_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DecisionDto {
  /// Returns a new [DecisionDto] instance.
  DecisionDto({

    required  this.hide_,
  });

      /// true = hide the review, false = keep it
  @JsonKey(
    
    name: r'hide',
    required: true,
    includeIfNull: false,
  )


  final bool hide_;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is DecisionDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            hide_,
        ],
        [
            other.hide_,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        hide_,
    ],);

  factory DecisionDto.fromJson(Map<String, dynamic> json) => _$DecisionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DecisionDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

