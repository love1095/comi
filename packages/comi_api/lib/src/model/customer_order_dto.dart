//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/order_status.dart';
import 'package:comi_api/src/model/board_order_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'customer_order_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CustomerOrderDto {
  /// Returns a new [CustomerOrderDto] instance.
  CustomerOrderDto({

    required  this.id,

    required  this.subtotal,

    required  this.restaurantDiscount,

    required  this.platformDiscount,

    required  this.total,

    required  this.status,

    required  this.items,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final num subtotal;



  @JsonKey(
    
    name: r'restaurantDiscount',
    required: true,
    includeIfNull: false,
  )


  final num restaurantDiscount;



  @JsonKey(
    
    name: r'platformDiscount',
    required: true,
    includeIfNull: false,
  )


  final num platformDiscount;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final OrderStatus status;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<BoardOrderItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CustomerOrderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            subtotal,
            restaurantDiscount,
            platformDiscount,
            total,
            status,
            items,
        ],
        [
            other.id,
            other.subtotal,
            other.restaurantDiscount,
            other.platformDiscount,
            other.total,
            other.status,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        subtotal,
        restaurantDiscount,
        platformDiscount,
        total,
        status,
        items,
    ],);

  factory CustomerOrderDto.fromJson(Map<String, dynamic> json) => _$CustomerOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerOrderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

