//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'close_bill_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CloseBillDto {
  /// Returns a new [CloseBillDto] instance.
  CloseBillDto({

     this.finalBillAmount,
  });

      /// VND; default = live bill total. Edit for dishes added outside the app.
  @JsonKey(
    
    name: r'finalBillAmount',
    required: false,
    includeIfNull: false,
  )


  final num? finalBillAmount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CloseBillDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            finalBillAmount,
        ],
        [
            other.finalBillAmount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        finalBillAmount,
    ],);

  factory CloseBillDto.fromJson(Map<String, dynamic> json) => _$CloseBillDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CloseBillDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

