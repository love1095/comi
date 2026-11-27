//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_settings_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateSettingsDto {
  /// Returns a new [UpdateSettingsDto] instance.
  UpdateSettingsDto({

     this.slotMinutes,

     this.diningMinutes,

     this.graceMinutes,

     this.minLeadMinutes,

     this.maxDaysAhead,

     this.allowCod,

     this.prepaidRefundRule,

     this.servesLunch,

     this.servesNhau,

     this.maxGroupSize,

     this.confirmGroupsOver,

     this.allowTableChoice,

     this.cancelCutoffMinutes,
  });

  @JsonKey(
    
    name: r'slotMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? slotMinutes;



  @JsonKey(
    
    name: r'diningMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? diningMinutes;



  @JsonKey(
    
    name: r'graceMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? graceMinutes;



  @JsonKey(
    
    name: r'minLeadMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? minLeadMinutes;



  @JsonKey(
    
    name: r'maxDaysAhead',
    required: false,
    includeIfNull: false,
  )


  final num? maxDaysAhead;



  @JsonKey(
    
    name: r'allowCod',
    required: false,
    includeIfNull: false,
  )


  final bool? allowCod;



  @JsonKey(
    
    name: r'prepaidRefundRule',
    required: false,
    includeIfNull: false,
  )


  final UpdateSettingsDtoPrepaidRefundRuleEnum? prepaidRefundRule;



  @JsonKey(
    
    name: r'servesLunch',
    required: false,
    includeIfNull: false,
  )


  final bool? servesLunch;



  @JsonKey(
    
    name: r'servesNhau',
    required: false,
    includeIfNull: false,
  )


  final bool? servesNhau;



  @JsonKey(
    
    name: r'maxGroupSize',
    required: false,
    includeIfNull: false,
  )


  final num? maxGroupSize;



  @JsonKey(
    
    name: r'confirmGroupsOver',
    required: false,
    includeIfNull: false,
  )


  final num? confirmGroupsOver;



  @JsonKey(
    
    name: r'allowTableChoice',
    required: false,
    includeIfNull: false,
  )


  final bool? allowTableChoice;



  @JsonKey(
    
    name: r'cancelCutoffMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? cancelCutoffMinutes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateSettingsDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            slotMinutes,
            diningMinutes,
            graceMinutes,
            minLeadMinutes,
            maxDaysAhead,
            allowCod,
            prepaidRefundRule,
            servesLunch,
            servesNhau,
            maxGroupSize,
            confirmGroupsOver,
            allowTableChoice,
            cancelCutoffMinutes,
        ],
        [
            other.slotMinutes,
            other.diningMinutes,
            other.graceMinutes,
            other.minLeadMinutes,
            other.maxDaysAhead,
            other.allowCod,
            other.prepaidRefundRule,
            other.servesLunch,
            other.servesNhau,
            other.maxGroupSize,
            other.confirmGroupsOver,
            other.allowTableChoice,
            other.cancelCutoffMinutes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        slotMinutes,
        diningMinutes,
        graceMinutes,
        minLeadMinutes,
        maxDaysAhead,
        allowCod,
        prepaidRefundRule,
        servesLunch,
        servesNhau,
        maxGroupSize,
        confirmGroupsOver,
        allowTableChoice,
        cancelCutoffMinutes,
    ],);

  factory UpdateSettingsDto.fromJson(Map<String, dynamic> json) => _$UpdateSettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSettingsDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum UpdateSettingsDtoPrepaidRefundRuleEnum {
@JsonValue(r'BEFORE_COOKING')
BEFORE_COOKING(r'BEFORE_COOKING'),
@JsonValue(r'NEVER')
NEVER(r'NEVER'),
@JsonValue(r'FULL_UNTIL_CUTOFF')
FULL_UNTIL_CUTOFF(r'FULL_UNTIL_CUTOFF');

const UpdateSettingsDtoPrepaidRefundRuleEnum(this.value);

final String value;

@override
String toString() => value;
}


