//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'capacity_rule_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CapacityRuleDto {
  /// Returns a new [CapacityRuleDto] instance.
  CapacityRuleDto({

    required  this.weekdays,

    required  this.startMinute,

    required  this.endMinute,

    required  this.windowMinutes,

    required  this.maxItems,
  });

      /// 0 = Sunday
  @JsonKey(
    
    name: r'weekdays',
    required: true,
    includeIfNull: false,
  )


  final List<num> weekdays;



      /// Minutes from 00:00
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
    
    name: r'windowMinutes',
    required: true,
    includeIfNull: false,
  )


  final num windowMinutes;



      /// Most pre-ordered dishes starting in one window
  @JsonKey(
    
    name: r'maxItems',
    required: true,
    includeIfNull: false,
  )


  final num maxItems;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CapacityRuleDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            weekdays,
            startMinute,
            endMinute,
            windowMinutes,
            maxItems,
        ],
        [
            other.weekdays,
            other.startMinute,
            other.endMinute,
            other.windowMinutes,
            other.maxItems,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        weekdays,
        startMinute,
        endMinute,
        windowMinutes,
        maxItems,
    ],);

  factory CapacityRuleDto.fromJson(Map<String, dynamic> json) => _$CapacityRuleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CapacityRuleDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

