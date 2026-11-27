//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'hold_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HoldDto {
  /// Returns a new [HoldDto] instance.
  HoldDto({

    required  this.holdId,

    required  this.expiresAt,

    required  this.tableIds,

    required  this.arrivalAt,
  });

  @JsonKey(
    
    name: r'holdId',
    required: true,
    includeIfNull: false,
  )


  final String holdId;



      /// Hold lasts 5 minutes
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



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is HoldDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            holdId,
            expiresAt,
            tableIds,
            arrivalAt,
        ],
        [
            other.holdId,
            other.expiresAt,
            other.tableIds,
            other.arrivalAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        holdId,
        expiresAt,
        tableIds,
        arrivalAt,
    ],);

  factory HoldDto.fromJson(Map<String, dynamic> json) => _$HoldDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HoldDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

