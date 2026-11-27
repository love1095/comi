//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'slot_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SlotDto {
  /// Returns a new [SlotDto] instance.
  SlotDto({

    required  this.time,

    required  this.local,

    required  this.available,

    required  this.diningMinutes,
  });

      /// Slot start (ISO, UTC) — send as arrivalAt
  @JsonKey(
    
    name: r'time',
    required: true,
    includeIfNull: false,
  )


  final String time;



      /// HH:mm in the restaurant time zone
  @JsonKey(
    
    name: r'local',
    required: true,
    includeIfNull: false,
  )


  final String local;



  @JsonKey(
    
    name: r'available',
    required: true,
    includeIfNull: false,
  )


  final bool available;



  @JsonKey(
    
    name: r'diningMinutes',
    required: true,
    includeIfNull: false,
  )


  final num diningMinutes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SlotDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            time,
            local,
            available,
            diningMinutes,
        ],
        [
            other.time,
            other.local,
            other.available,
            other.diningMinutes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        time,
        local,
        available,
        diningMinutes,
    ],);

  factory SlotDto.fromJson(Map<String, dynamic> json) => _$SlotDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SlotDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

