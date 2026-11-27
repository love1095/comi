//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_hold_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateHoldDto {
  /// Returns a new [CreateHoldDto] instance.
  CreateHoldDto({

    required  this.tableIds,

    required  this.arrivalAt,

    required  this.partySize,
  });

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



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateHoldDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            tableIds,
            arrivalAt,
            partySize,
        ],
        [
            other.tableIds,
            other.arrivalAt,
            other.partySize,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        tableIds,
        arrivalAt,
        partySize,
    ],);

  factory CreateHoldDto.fromJson(Map<String, dynamic> json) => _$CreateHoldDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHoldDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

