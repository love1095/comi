//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/voucher_funder.dart';
import 'package:comi_api/src/model/voucher_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'voucher_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoucherDto {
  /// Returns a new [VoucherDto] instance.
  VoucherDto({

    required  this.id,

    required  this.code,

     this.restaurantId,

    required  this.fundedBy,

    required  this.type,

    required  this.value,

     this.maxDiscount,

    required  this.minOrder,

    required  this.startsAt,

    required  this.endsAt,

     this.totalLimit,

    required  this.perUserLimit,

    required  this.firstOrderOnly,

    required  this.usedCount,

    required  this.isActive,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'restaurantId',
    required: false,
    includeIfNull: false,
  )


  final String? restaurantId;



  @JsonKey(
    
    name: r'fundedBy',
    required: true,
    includeIfNull: false,
  )


  final VoucherFunder fundedBy;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final VoucherType type;



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
    required: true,
    includeIfNull: false,
  )


  final num minOrder;



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
    required: true,
    includeIfNull: false,
  )


  final num perUserLimit;



  @JsonKey(
    
    name: r'firstOrderOnly',
    required: true,
    includeIfNull: false,
  )


  final bool firstOrderOnly;



  @JsonKey(
    
    name: r'usedCount',
    required: true,
    includeIfNull: false,
  )


  final num usedCount;



  @JsonKey(
    
    name: r'isActive',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is VoucherDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            restaurantId,
            fundedBy,
            type,
            value,
            maxDiscount,
            minOrder,
            startsAt,
            endsAt,
            totalLimit,
            perUserLimit,
            firstOrderOnly,
            usedCount,
            isActive,
        ],
        [
            other.id,
            other.code,
            other.restaurantId,
            other.fundedBy,
            other.type,
            other.value,
            other.maxDiscount,
            other.minOrder,
            other.startsAt,
            other.endsAt,
            other.totalLimit,
            other.perUserLimit,
            other.firstOrderOnly,
            other.usedCount,
            other.isActive,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        restaurantId,
        fundedBy,
        type,
        value,
        maxDiscount,
        minOrder,
        startsAt,
        endsAt,
        totalLimit,
        perUserLimit,
        firstOrderOnly,
        usedCount,
        isActive,
    ],);

  factory VoucherDto.fromJson(Map<String, dynamic> json) => _$VoucherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

