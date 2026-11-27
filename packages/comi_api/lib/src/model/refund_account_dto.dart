//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'refund_account_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundAccountDto {
  /// Returns a new [RefundAccountDto] instance.
  RefundAccountDto({

    required  this.bankBin,

    required  this.accountNo,

    required  this.accountName,
  });

      /// Bank BIN (NAPAS)
  @JsonKey(
    
    name: r'bankBin',
    required: true,
    includeIfNull: false,
  )


  final String bankBin;



  @JsonKey(
    
    name: r'accountNo',
    required: true,
    includeIfNull: false,
  )


  final String accountNo;



  @JsonKey(
    
    name: r'accountName',
    required: true,
    includeIfNull: false,
  )


  final String accountName;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RefundAccountDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            bankBin,
            accountNo,
            accountName,
        ],
        [
            other.bankBin,
            other.accountNo,
            other.accountName,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        bankBin,
        accountNo,
        accountName,
    ],);

  factory RefundAccountDto.fromJson(Map<String, dynamic> json) => _$RefundAccountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefundAccountDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

