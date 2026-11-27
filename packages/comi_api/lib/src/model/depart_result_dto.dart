//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'depart_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepartResultDto {
  /// Returns a new [DepartResultDto] instance.
  DepartResultDto({

    required  this.etaAt,

    required  this.travelMinutes,
  });

  @JsonKey(
    
    name: r'etaAt',
    required: true,
    includeIfNull: false,
  )


  final String etaAt;



  @JsonKey(
    
    name: r'travelMinutes',
    required: true,
    includeIfNull: false,
  )


  final num travelMinutes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is DepartResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            etaAt,
            travelMinutes,
        ],
        [
            other.etaAt,
            other.travelMinutes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        etaAt,
        travelMinutes,
    ],);

  factory DepartResultDto.fromJson(Map<String, dynamic> json) => _$DepartResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DepartResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

