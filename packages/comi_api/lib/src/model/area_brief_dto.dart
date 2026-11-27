//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'area_brief_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AreaBriefDto {
  /// Returns a new [AreaBriefDto] instance.
  AreaBriefDto({

    required  this.id,

    required  this.name,

    required  this.floor,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'floor',
    required: true,
    includeIfNull: false,
  )


  final num floor;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AreaBriefDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            floor,
        ],
        [
            other.id,
            other.name,
            other.floor,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        floor,
    ],);

  factory AreaBriefDto.fromJson(Map<String, dynamic> json) => _$AreaBriefDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AreaBriefDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

