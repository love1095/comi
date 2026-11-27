//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/capacity_rule_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'capacity_rules_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CapacityRulesDto {
  /// Returns a new [CapacityRulesDto] instance.
  CapacityRulesDto({

    required  this.rules,
  });

  @JsonKey(
    
    name: r'rules',
    required: true,
    includeIfNull: false,
  )


  final List<CapacityRuleInput> rules;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CapacityRulesDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            rules,
        ],
        [
            other.rules,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        rules,
    ],);

  factory CapacityRulesDto.fromJson(Map<String, dynamic> json) => _$CapacityRulesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CapacityRulesDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

