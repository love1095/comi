//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'dining_rule_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DiningRuleDto {
  /// Returns a new [DiningRuleDto] instance.
  DiningRuleDto({

    required  this.weekdays,

    required  this.startMinute,

    required  this.endMinute,

    required  this.diningMinutes,
  });

  @JsonKey(
    
    name: r'weekdays',
    required: true,
    includeIfNull: false,
  )


  final List<String> weekdays;



  @JsonKey(
    
    name: r'startMinute',
    required: true,
    includeIfNull: false,
  )


  final num startMinute;



  @JsonKey(
    
    name: r'endMinute',
    required: true,
    includeIfNull: false,
  )


  final num endMinute;



  @JsonKey(
    
    name: r'diningMinutes',
    required: true,
    includeIfNull: false,
  )


  final num diningMinutes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is DiningRuleDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            weekdays,
            startMinute,
            endMinute,
            diningMinutes,
        ],
        [
            other.weekdays,
            other.startMinute,
            other.endMinute,
            other.diningMinutes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        weekdays,
        startMinute,
        endMinute,
        diningMinutes,
    ],);

  factory DiningRuleDto.fromJson(Map<String, dynamic> json) => _$DiningRuleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DiningRuleDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

