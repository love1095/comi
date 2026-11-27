//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/voucher_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'voucher_input_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoucherInputDto {
  /// Returns a new [VoucherInputDto] instance.
  VoucherInputDto({

    required  this.code,

    required  this.type,

    required  this.value,

     this.maxDiscount,

     this.minOrder,

    required  this.startsAt,

    required  this.endsAt,

     this.totalLimit,

     this.perUserLimit,

     this.firstOrderOnly,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final VoucherType type;



      /// VND for FIXED, basis points for PERCENT (2000 = 20%)
  @JsonKey(
    
    name: r'value',
    required: true,
    includeIfNull: false,
  )


  final num value;



  @JsonKey(
    
    name: r'maxDiscount',
    required: false,
    includeIfNull: false,
  )


  final num? maxDiscount;



  @JsonKey(
    
    name: r'minOrder',
    required: false,
    includeIfNull: false,
  )


  final num? minOrder;



  @JsonKey(
    
    name: r'startsAt',
    required: true,
    includeIfNull: false,
  )


  final String startsAt;



  @JsonKey(
    
    name: r'endsAt',
    required: true,
    includeIfNull: false,
  )


  final String endsAt;



  @JsonKey(
    
    name: r'totalLimit',
    required: false,
    includeIfNull: false,
  )


  final num? totalLimit;



  @JsonKey(
    
    name: r'perUserLimit',
    required: false,
    includeIfNull: false,
  )


  final num? perUserLimit;



  @JsonKey(
    
    name: r'firstOrderOnly',
    required: false,
    includeIfNull: false,
  )


  final bool? firstOrderOnly;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is VoucherInputDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            code,
            type,
            value,
            maxDiscount,
            minOrder,
            startsAt,
            endsAt,
            totalLimit,
            perUserLimit,
            firstOrderOnly,
        ],
        [
            other.code,
            other.type,
            other.value,
            other.maxDiscount,
            other.minOrder,
            other.startsAt,
            other.endsAt,
            other.totalLimit,
            other.perUserLimit,
            other.firstOrderOnly,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        code,
        type,
        value,
        maxDiscount,
        minOrder,
        startsAt,
        endsAt,
        totalLimit,
        perUserLimit,
        firstOrderOnly,
    ],);

  factory VoucherInputDto.fromJson(Map<String, dynamic> json) => _$VoucherInputDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherInputDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

