//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'capacity_rule_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CapacityRuleInput {
  /// Returns a new [CapacityRuleInput] instance.
  CapacityRuleInput({

    required  this.weekdays,

    required  this.startMinute,

    required  this.endMinute,

    required  this.windowMinutes,

    required  this.maxItems,
  });

  @JsonKey(
    
    name: r'weekdays',
    required: true,
    includeIfNull: false,
  )


  final List<num> weekdays;



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



  @JsonKey(
    
    name: r'maxItems',
    required: true,
    includeIfNull: false,
  )


  final num maxItems;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CapacityRuleInput &&
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

  factory CapacityRuleInput.fromJson(Map<String, dynamic> json) => _$CapacityRuleInputFromJson(json);

  Map<String, dynamic> toJson() => _$CapacityRuleInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

