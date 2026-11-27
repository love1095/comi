//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'opening_hours_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OpeningHoursDto {
  /// Returns a new [OpeningHoursDto] instance.
  OpeningHoursDto({

    required  this.weekday,

    required  this.openMinute,

    required  this.closeMinute,

     this.lastOrderMinute,
  });

  @JsonKey(
    
    name: r'weekday',
    required: true,
    includeIfNull: false,
  )


  final num weekday;



  @JsonKey(
    
    name: r'openMinute',
    required: true,
    includeIfNull: false,
  )


  final num openMinute;



  @JsonKey(
    
    name: r'closeMinute',
    required: true,
    includeIfNull: false,
  )


  final num closeMinute;



  @JsonKey(
    
    name: r'lastOrderMinute',
    required: false,
    includeIfNull: false,
  )


  final num? lastOrderMinute;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is OpeningHoursDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            weekday,
            openMinute,
            closeMinute,
            lastOrderMinute,
        ],
        [
            other.weekday,
            other.openMinute,
            other.closeMinute,
            other.lastOrderMinute,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        weekday,
        openMinute,
        closeMinute,
        lastOrderMinute,
    ],);

  factory OpeningHoursDto.fromJson(Map<String, dynamic> json) => _$OpeningHoursDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

