//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'block_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BlockDto {
  /// Returns a new [BlockDto] instance.
  BlockDto({

    required  this.blocked,

     this.reason,
  });

  @JsonKey(
    
    name: r'blocked',
    required: true,
    includeIfNull: false,
  )


  final bool blocked;



  @JsonKey(
    
    name: r'reason',
    required: false,
    includeIfNull: false,
  )


  final String? reason;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BlockDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            blocked,
            reason,
        ],
        [
            other.blocked,
            other.reason,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        blocked,
        reason,
    ],);

  factory BlockDto.fromJson(Map<String, dynamic> json) => _$BlockDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BlockDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

