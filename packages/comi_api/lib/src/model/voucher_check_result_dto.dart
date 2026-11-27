//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'voucher_check_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoucherCheckResultDto {
  /// Returns a new [VoucherCheckResultDto] instance.
  VoucherCheckResultDto({

    required  this.valid,

    required  this.discount,

     this.problem,

     this.message,
  });

  @JsonKey(
    
    name: r'valid',
    required: true,
    includeIfNull: false,
  )


  final bool valid;



  @JsonKey(
    
    name: r'discount',
    required: true,
    includeIfNull: false,
  )


  final num discount;



      /// Why not (code), when invalid
  @JsonKey(
    
    name: r'problem',
    required: false,
    includeIfNull: false,
  )


  final String? problem;



  @JsonKey(
    
    name: r'message',
    required: false,
    includeIfNull: false,
  )


  final String? message;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is VoucherCheckResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            valid,
            discount,
            problem,
            message,
        ],
        [
            other.valid,
            other.discount,
            other.problem,
            other.message,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        valid,
        discount,
        problem,
        message,
    ],);

  factory VoucherCheckResultDto.fromJson(Map<String, dynamic> json) => _$VoucherCheckResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherCheckResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

