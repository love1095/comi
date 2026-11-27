//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'my_hold_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MyHoldDto {
  /// Returns a new [MyHoldDto] instance.
  MyHoldDto({

    required  this.holdId,

    required  this.expiresAt,

    required  this.tableIds,
  });

  @JsonKey(
    
    name: r'holdId',
    required: true,
    includeIfNull: false,
  )


  final String holdId;



  @JsonKey(
    
    name: r'expiresAt',
    required: true,
    includeIfNull: false,
  )


  final String expiresAt;



  @JsonKey(
    
    name: r'tableIds',
    required: true,
    includeIfNull: false,
  )


  final List<String> tableIds;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MyHoldDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            holdId,
            expiresAt,
            tableIds,
        ],
        [
            other.holdId,
            other.expiresAt,
            other.tableIds,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        holdId,
        expiresAt,
        tableIds,
    ],);

  factory MyHoldDto.fromJson(Map<String, dynamic> json) => _$MyHoldDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MyHoldDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

