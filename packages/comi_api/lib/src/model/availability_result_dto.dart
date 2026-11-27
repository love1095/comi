//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'availability_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AvailabilityResultDto {
  /// Returns a new [AvailabilityResultDto] instance.
  AvailabilityResultDto({

    required  this.id,

    required  this.isAvailable,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'isAvailable',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AvailabilityResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            isAvailable,
        ],
        [
            other.id,
            other.isAvailable,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        isAvailable,
    ],);

  factory AvailabilityResultDto.fromJson(Map<String, dynamic> json) => _$AvailabilityResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

