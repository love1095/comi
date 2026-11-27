//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'option_snapshot_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OptionSnapshotDto {
  /// Returns a new [OptionSnapshotDto] instance.
  OptionSnapshotDto({

    required  this.group,

    required  this.option,

    required  this.priceDelta,
  });

  @JsonKey(
    
    name: r'group',
    required: true,
    includeIfNull: false,
  )


  final String group;



  @JsonKey(
    
    name: r'option',
    required: true,
    includeIfNull: false,
  )


  final String option;



  @JsonKey(
    
    name: r'priceDelta',
    required: true,
    includeIfNull: false,
  )


  final num priceDelta;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is OptionSnapshotDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            group,
            option,
            priceDelta,
        ],
        [
            other.group,
            other.option,
            other.priceDelta,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        group,
        option,
        priceDelta,
    ],);

  factory OptionSnapshotDto.fromJson(Map<String, dynamic> json) => _$OptionSnapshotDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionSnapshotDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

