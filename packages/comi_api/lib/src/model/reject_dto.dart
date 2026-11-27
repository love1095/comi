//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'reject_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RejectDto {
  /// Returns a new [RejectDto] instance.
  RejectDto({

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
      other is RejectDto &&
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

  factory RejectDto.fromJson(Map<String, dynamic> json) => _$RejectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RejectDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

