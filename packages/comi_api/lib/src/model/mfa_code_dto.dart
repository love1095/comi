//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'mfa_code_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MfaCodeDto {
  /// Returns a new [MfaCodeDto] instance.
  MfaCodeDto({

    required  this.code,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MfaCodeDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            code,
        ],
        [
            other.code,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        code,
    ],);

  factory MfaCodeDto.fromJson(Map<String, dynamic> json) => _$MfaCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MfaCodeDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

