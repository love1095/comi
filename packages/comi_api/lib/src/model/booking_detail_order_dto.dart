//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/board_order_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'booking_detail_order_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BookingDetailOrderDto {
  /// Returns a new [BookingDetailOrderDto] instance.
  BookingDetailOrderDto({

    required  this.total,

    required  this.id,

    required  this.subtotal,

    required  this.restaurantDiscount,

    required  this.platformDiscount,

    required  this.items,
  });

  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



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
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<BoardOrderItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BookingDetailOrderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            total,
            id,
            subtotal,
            restaurantDiscount,
            platformDiscount,
            items,
        ],
        [
            other.total,
            other.id,
            other.subtotal,
            other.restaurantDiscount,
            other.platformDiscount,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        total,
        id,
        subtotal,
        restaurantDiscount,
        platformDiscount,
        items,
    ],);

  factory BookingDetailOrderDto.fromJson(Map<String, dynamic> json) => _$BookingDetailOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailOrderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

