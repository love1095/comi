//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'depart_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepartDto {
  /// Returns a new [DepartDto] instance.
  DepartDto({

    required  this.lat,

    required  this.lng,
  });

  @JsonKey(
    
    name: r'lat',
    required: true,
    includeIfNull: false,
  )


  final num lat;



  @JsonKey(
    
    name: r'lng',
    required: true,
    includeIfNull: false,
  )


  final num lng;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is DepartDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            lat,
            lng,
        ],
        [
            other.lat,
            other.lng,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        lat,
        lng,
    ],);

  factory DepartDto.fromJson(Map<String, dynamic> json) => _$DepartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DepartDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

