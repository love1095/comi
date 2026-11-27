//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'mark_paid_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MarkPaidDto {
  /// Returns a new [MarkPaidDto] instance.
  MarkPaidDto({

    required  this.paid,
  });

      /// false = undo
  @JsonKey(
    
    name: r'paid',
    required: true,
    includeIfNull: false,
  )


  final bool paid;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MarkPaidDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            paid,
        ],
        [
            other.paid,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        paid,
    ],);

  factory MarkPaidDto.fromJson(Map<String, dynamic> json) => _$MarkPaidDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MarkPaidDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

