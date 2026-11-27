//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'voucher_check_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoucherCheckDto {
  /// Returns a new [VoucherCheckDto] instance.
  VoucherCheckDto({

    required  this.code,

    required  this.restaurantId,

    required  this.items,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<CartLineDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is VoucherCheckDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            code,
            restaurantId,
            items,
        ],
        [
            other.code,
            other.restaurantId,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        code,
        restaurantId,
        items,
    ],);

  factory VoucherCheckDto.fromJson(Map<String, dynamic> json) => _$VoucherCheckDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherCheckDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

