//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'closure_info_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClosureInfoDto {
  /// Returns a new [ClosureInfoDto] instance.
  ClosureInfoDto({

    required  this.startsAt,

    required  this.endsAt,

     this.reason,
  });

  @JsonKey(
    
    name: r'startsAt',
    required: true,
    includeIfNull: false,
  )


  final String startsAt;



  @JsonKey(
    
    name: r'endsAt',
    required: true,
    includeIfNull: false,
  )


  final String endsAt;



  @JsonKey(
    
    name: r'reason',
    required: false,
    includeIfNull: false,
  )


  final String? reason;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ClosureInfoDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            startsAt,
            endsAt,
            reason,
        ],
        [
            other.startsAt,
            other.endsAt,
            other.reason,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        startsAt,
        endsAt,
        reason,
    ],);

  factory ClosureInfoDto.fromJson(Map<String, dynamic> json) => _$ClosureInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClosureInfoDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

