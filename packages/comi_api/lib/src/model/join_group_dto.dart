//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'join_group_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class JoinGroupDto {
  /// Returns a new [JoinGroupDto] instance.
  JoinGroupDto({

    required  this.displayName,
  });

  @JsonKey(
    
    name: r'displayName',
    required: true,
    includeIfNull: false,
  )


  final String displayName;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is JoinGroupDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            displayName,
        ],
        [
            other.displayName,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        displayName,
    ],);

  factory JoinGroupDto.fromJson(Map<String, dynamic> json) => _$JoinGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JoinGroupDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

