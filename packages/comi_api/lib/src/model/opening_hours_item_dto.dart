//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'opening_hours_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OpeningHoursItemDto {
  /// Returns a new [OpeningHoursItemDto] instance.
  OpeningHoursItemDto({

    required  this.weekday,

    required  this.openMinute,

    required  this.closeMinute,

     this.lastOrderMinute,
  });

      /// 0 = Sunday
          // minimum: 0
          // maximum: 6
  @JsonKey(
    
    name: r'weekday',
    required: true,
    includeIfNull: false,
  )


  final num weekday;



      /// Minutes from 00:00
  @JsonKey(
    
    name: r'openMinute',
    required: true,
    includeIfNull: false,
  )


  final num openMinute;



      /// May be > 1440 for after midnight
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
      other is OpeningHoursItemDto &&
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

  factory OpeningHoursItemDto.fromJson(Map<String, dynamic> json) => _$OpeningHoursItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

