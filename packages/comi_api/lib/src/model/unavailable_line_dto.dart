//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'unavailable_line_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UnavailableLineDto {
  /// Returns a new [UnavailableLineDto] instance.
  UnavailableLineDto({

    required  this.menuItemId,

    required  this.name,
  });

  @JsonKey(
    
    name: r'menuItemId',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UnavailableLineDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            menuItemId,
            name,
        ],
        [
            other.menuItemId,
            other.name,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        menuItemId,
        name,
    ],);

  factory UnavailableLineDto.fromJson(Map<String, dynamic> json) => _$UnavailableLineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UnavailableLineDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

