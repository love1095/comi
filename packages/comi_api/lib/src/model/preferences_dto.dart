//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'preferences_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PreferencesDto {
  /// Returns a new [PreferencesDto] instance.
  PreferencesDto({

     this.lunchReminder,

     this.lunchReminderMinute,

     this.dietaryTags,

     this.showApproxCurrency,
  });

  @JsonKey(
    
    name: r'lunchReminder',
    required: false,
    includeIfNull: false,
  )


  final bool? lunchReminder;



      /// Minutes from midnight (10:30)
  @JsonKey(
    
    name: r'lunchReminderMinute',
    required: false,
    includeIfNull: false,
  )


  final num? lunchReminderMinute;



  @JsonKey(
    
    name: r'dietaryTags',
    required: false,
    includeIfNull: false,
  )


  final List<String>? dietaryTags;



  @JsonKey(
    
    name: r'showApproxCurrency',
    required: false,
    includeIfNull: false,
  )


  final PreferencesDtoShowApproxCurrencyEnum? showApproxCurrency;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PreferencesDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            lunchReminder,
            lunchReminderMinute,
            dietaryTags,
            showApproxCurrency,
        ],
        [
            other.lunchReminder,
            other.lunchReminderMinute,
            other.dietaryTags,
            other.showApproxCurrency,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        lunchReminder,
        lunchReminderMinute,
        dietaryTags,
        showApproxCurrency,
    ],);

  factory PreferencesDto.fromJson(Map<String, dynamic> json) => _$PreferencesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum PreferencesDtoShowApproxCurrencyEnum {
@JsonValue(r'USD')
USD(r'USD'),
@JsonValue(r'KRW')
KRW(r'KRW'),
@JsonValue(r'CNY')
CNY(r'CNY'),
@JsonValue(r'JPY')
JPY(r'JPY');

const PreferencesDtoShowApproxCurrencyEnum(this.value);

final String value;

@override
String toString() => value;
}


