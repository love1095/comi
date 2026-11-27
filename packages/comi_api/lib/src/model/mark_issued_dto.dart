//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'mark_issued_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MarkIssuedDto {
  /// Returns a new [MarkIssuedDto] instance.
  MarkIssuedDto({

     this.invoiceNo,
  });

      /// Invoice number from the e-invoice system
  @JsonKey(
    
    name: r'invoiceNo',
    required: false,
    includeIfNull: false,
  )


  final String? invoiceNo;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MarkIssuedDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            invoiceNo,
        ],
        [
            other.invoiceNo,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        invoiceNo,
    ],);

  factory MarkIssuedDto.fromJson(Map<String, dynamic> json) => _$MarkIssuedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MarkIssuedDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

