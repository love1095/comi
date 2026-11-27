//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'start_group_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StartGroupDto {
  /// Returns a new [StartGroupDto] instance.
  StartGroupDto({

     this.cutoffMinutes,

     this.maxGuests,
  });

      /// Orders close this many minutes before arrival (default 20)
  @JsonKey(
    
    name: r'cutoffMinutes',
    required: false,
    includeIfNull: false,
  )


  final num? cutoffMinutes;



      /// Default = party size
  @JsonKey(
    
    name: r'maxGuests',
    required: false,
    includeIfNull: false,
  )


  final num? maxGuests;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StartGroupDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            cutoffMinutes,
            maxGuests,
        ],
        [
            other.cutoffMinutes,
            other.maxGuests,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        cutoffMinutes,
        maxGuests,
    ],);

  factory StartGroupDto.fromJson(Map<String, dynamic> json) => _$StartGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StartGroupDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

