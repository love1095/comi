//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'availability_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AvailabilityDto {
  /// Returns a new [AvailabilityDto] instance.
  AvailabilityDto({

    required  this.isAvailable,
  });

  @JsonKey(
    
    name: r'isAvailable',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AvailabilityDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            isAvailable,
        ],
        [
            other.isAvailable,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        isAvailable,
    ],);

  factory AvailabilityDto.fromJson(Map<String, dynamic> json) => _$AvailabilityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

