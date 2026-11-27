//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'check_in_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CheckInDto {
  /// Returns a new [CheckInDto] instance.
  CheckInDto({

    required  this.qrPayload,
  });

      /// The scanned link: https://…/c/{slug}/{tableCode}?s=… or …/c/{slug}?s=…
  @JsonKey(
    
    name: r'qrPayload',
    required: true,
    includeIfNull: false,
  )


  final String qrPayload;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CheckInDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            qrPayload,
        ],
        [
            other.qrPayload,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        qrPayload,
    ],);

  factory CheckInDto.fromJson(Map<String, dynamic> json) => _$CheckInDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

