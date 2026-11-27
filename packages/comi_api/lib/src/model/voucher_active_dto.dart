//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'voucher_active_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoucherActiveDto {
  /// Returns a new [VoucherActiveDto] instance.
  VoucherActiveDto({

    required  this.isActive,
  });

  @JsonKey(
    
    name: r'isActive',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is VoucherActiveDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            isActive,
        ],
        [
            other.isActive,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        isActive,
    ],);

  factory VoucherActiveDto.fromJson(Map<String, dynamic> json) => _$VoucherActiveDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherActiveDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

