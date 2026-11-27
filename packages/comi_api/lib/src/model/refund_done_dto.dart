//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'refund_done_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundDoneDto {
  /// Returns a new [RefundDoneDto] instance.
  RefundDoneDto({

     this.note,
  });

      /// Bank transfer reference
  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RefundDoneDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            note,
        ],
        [
            other.note,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        note,
    ],);

  factory RefundDoneDto.fromJson(Map<String, dynamic> json) => _$RefundDoneDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefundDoneDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

