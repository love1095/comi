//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'fire_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FireDto {
  /// Returns a new [FireDto] instance.
  FireDto({

     this.course,
  });

      /// Omit to fire everything still waiting
  @JsonKey(
    
    name: r'course',
    required: false,
    includeIfNull: false,
  )


  final Course? course;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is FireDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            course,
        ],
        [
            other.course,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        course,
    ],);

  factory FireDto.fromJson(Map<String, dynamic> json) => _$FireDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FireDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

