//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/board_table_dto.dart';
import 'package:comi_api/src/model/payment_mode.dart';
import 'package:comi_api/src/model/board_order_dto.dart';
import 'package:comi_api/src/model/booking_status.dart';
import 'package:comi_api/src/model/board_user_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'board_booking_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BoardBookingDto {
  /// Returns a new [BoardBookingDto] instance.
  BoardBookingDto({

    required  this.id,

    required  this.code,

    required  this.partySize,

    required  this.arrivalAt,

    required  this.endsAt,

    required  this.status,

    required  this.paymentMode,

    required  this.needsApproval,

     this.note,

     this.tableId,

    required  this.extraTableIds,

     this.table,

    required  this.user,

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
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final BookingStatus status;



  @JsonKey(
    
    name: r'paymentMode',
    required: true,
    includeIfNull: false,
  )


  final PaymentMode paymentMode;



  @JsonKey(
    
    name: r'needsApproval',
    required: true,
    includeIfNull: false,
  )


  final bool needsApproval;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'tableId',
    required: false,
    includeIfNull: false,
  )


  final String? tableId;



  @JsonKey(
    
    name: r'extraTableIds',
    required: true,
    includeIfNull: false,
  )


  final List<String> extraTableIds;



  @JsonKey(
    
    name: r'table',
    required: false,
    includeIfNull: false,
  )


  final BoardTableDto? table;



  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final BoardUserDto user;



  @JsonKey(
    
    name: r'order',
    required: false,
    includeIfNull: false,
  )


  final BoardOrderDto? order;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BoardBookingDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            partySize,
            arrivalAt,
            endsAt,
            status,
            paymentMode,
            needsApproval,
            note,
            tableId,
            extraTableIds,
            table,
            user,
            order,
        ],
        [
            other.id,
            other.code,
            other.partySize,
            other.arrivalAt,
            other.endsAt,
            other.status,
            other.paymentMode,
            other.needsApproval,
            other.note,
            other.tableId,
            other.extraTableIds,
            other.table,
            other.user,
            other.order,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        partySize,
        arrivalAt,
        endsAt,
        status,
        paymentMode,
        needsApproval,
        note,
        tableId,
        extraTableIds,
        table,
        user,
        order,
    ],);

  factory BoardBookingDto.fromJson(Map<String, dynamic> json) => _$BoardBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BoardBookingDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

