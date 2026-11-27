//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'round_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RoundResultDto {
  /// Returns a new [RoundResultDto] instance.
  RoundResultDto({

    required  this.round,

    required  this.needsApproval,

    required  this.total,
  });

  @JsonKey(
    
    name: r'round',
    required: true,
    includeIfNull: false,
  )


  final num round;



      /// Waiting for staff to confirm (restaurant setting)
  @JsonKey(
    
    name: r'needsApproval',
    required: true,
    includeIfNull: false,
  )


  final bool needsApproval;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RoundResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            round,
            needsApproval,
            total,
        ],
        [
            other.round,
            other.needsApproval,
            other.total,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        round,
        needsApproval,
        total,
    ],);

  factory RoundResultDto.fromJson(Map<String, dynamic> json) => _$RoundResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoundResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

