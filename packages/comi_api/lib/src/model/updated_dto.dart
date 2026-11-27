//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'updated_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdatedDto {
  /// Returns a new [UpdatedDto] instance.
  UpdatedDto({

    required  this.updated,
  });

  @JsonKey(
    
    name: r'updated',
    required: true,
    includeIfNull: false,
  )


  final num updated;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdatedDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            updated,
        ],
        [
            other.updated,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        updated,
    ],);

  factory UpdatedDto.fromJson(Map<String, dynamic> json) => _$UpdatedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

