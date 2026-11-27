//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/booking_restaurant_dto.dart';
import 'package:comi_api/src/model/customer_order_dto.dart';
import 'package:comi_api/src/model/payment_mode.dart';
import 'package:comi_api/src/model/booking_table_dto.dart';
import 'package:comi_api/src/model/booking_status.dart';
import 'package:comi_api/src/model/serve_style.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'customer_booking_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CustomerBookingDto {
  /// Returns a new [CustomerBookingDto] instance.
  CustomerBookingDto({

    required  this.id,

    required  this.code,

    required  this.restaurantId,

    required  this.partySize,

    required  this.arrivalAt,

    required  this.endsAt,

    required  this.paymentMode,

    required  this.serveStyle,

    required  this.status,

     this.note,

    required  this.needsApproval,

    required  this.extraTableIds,

     this.cancelledAt,

     this.cancelReason,

     this.cancelledBy,

     this.checkedInAt,

    required  this.createdAt,

    required  this.restaurant,

     this.table,

     this.order,
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
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;



  @JsonKey(
    
    name: r'endsAt',
    required: true,
    includeIfNull: false,
  )


  final String endsAt;



  @JsonKey(
    
    name: r'paymentMode',
    required: true,
    includeIfNull: false,
  )


  final PaymentMode paymentMode;



  @JsonKey(
    
    name: r'serveStyle',
    required: true,
    includeIfNull: false,
  )


  final ServeStyle serveStyle;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final BookingStatus status;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'needsApproval',
    required: true,
    includeIfNull: false,
  )


  final bool needsApproval;



  @JsonKey(
    
    name: r'extraTableIds',
    required: true,
    includeIfNull: false,
  )


  final List<String> extraTableIds;



  @JsonKey(
    
    name: r'cancelledAt',
    required: false,
    includeIfNull: false,
  )


  final String? cancelledAt;



  @JsonKey(
    
    name: r'cancelReason',
    required: false,
    includeIfNull: false,
  )


  final String? cancelReason;



      /// USER | RESTAURANT | SYSTEM
  @JsonKey(
    
    name: r'cancelledBy',
    required: false,
    includeIfNull: false,
  )


  final String? cancelledBy;



  @JsonKey(
    
    name: r'checkedInAt',
    required: false,
    includeIfNull: false,
  )


  final String? checkedInAt;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;



  @JsonKey(
    
    name: r'restaurant',
    required: true,
    includeIfNull: false,
  )


  final BookingRestaurantDto restaurant;



  @JsonKey(
    
    name: r'table',
    required: false,
    includeIfNull: false,
  )


  final BookingTableDto? table;



  @JsonKey(
    
    name: r'order',
    required: false,
    includeIfNull: false,
  )


  final CustomerOrderDto? order;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CustomerBookingDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            restaurantId,
            partySize,
            arrivalAt,
            endsAt,
            paymentMode,
            serveStyle,
            status,
            note,
            needsApproval,
            extraTableIds,
            cancelledAt,
            cancelReason,
            cancelledBy,
            checkedInAt,
            createdAt,
            restaurant,
            table,
            order,
        ],
        [
            other.id,
            other.code,
            other.restaurantId,
            other.partySize,
            other.arrivalAt,
            other.endsAt,
            other.paymentMode,
            other.serveStyle,
            other.status,
            other.note,
            other.needsApproval,
            other.extraTableIds,
            other.cancelledAt,
            other.cancelReason,
            other.cancelledBy,
            other.checkedInAt,
            other.createdAt,
            other.restaurant,
            other.table,
            other.order,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        restaurantId,
        partySize,
        arrivalAt,
        endsAt,
        paymentMode,
        serveStyle,
        status,
        note,
        needsApproval,
        extraTableIds,
        cancelledAt,
        cancelReason,
        cancelledBy,
        checkedInAt,
        createdAt,
        restaurant,
        table,
        order,
    ],);

  factory CustomerBookingDto.fromJson(Map<String, dynamic> json) => _$CustomerBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBookingDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

