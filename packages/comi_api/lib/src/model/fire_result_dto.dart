//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'fire_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FireResultDto {
  /// Returns a new [FireResultDto] instance.
  FireResultDto({

    required  this.queued,
  });

  @JsonKey(
    
    name: r'queued',
    required: true,
    includeIfNull: false,
  )


  final num queued;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is FireResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            queued,
        ],
        [
            other.queued,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        queued,
    ],);

  factory FireResultDto.fromJson(Map<String, dynamic> json) => _$FireResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FireResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

