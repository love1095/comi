//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_booking_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminBookingDto {
  /// Returns a new [AdminBookingDto] instance.
  AdminBookingDto({

    required  this.id,

    required  this.code,

    required  this.status,

    required  this.arrivalAt,

    required  this.partySize,

    required  this.restaurantName,

    required  this.restaurantId,

     this.guestName,

     this.guestPhone,

     this.total,

    required  this.paymentMode,
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
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'restaurantName',
    required: true,
    includeIfNull: false,
  )


  final String restaurantName;



  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    
    name: r'guestName',
    required: false,
    includeIfNull: false,
  )


  final String? guestName;



  @JsonKey(
    
    name: r'guestPhone',
    required: false,
    includeIfNull: false,
  )


  final String? guestPhone;



  @JsonKey(
    
    name: r'total',
    required: false,
    includeIfNull: false,
  )


  final num? total;



  @JsonKey(
    
    name: r'paymentMode',
    required: true,
    includeIfNull: false,
  )


  final String paymentMode;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminBookingDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            status,
            arrivalAt,
            partySize,
            restaurantName,
            restaurantId,
            guestName,
            guestPhone,
            total,
            paymentMode,
        ],
        [
            other.id,
            other.code,
            other.status,
            other.arrivalAt,
            other.partySize,
            other.restaurantName,
            other.restaurantId,
            other.guestName,
            other.guestPhone,
            other.total,
            other.paymentMode,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        status,
        arrivalAt,
        partySize,
        restaurantName,
        restaurantId,
        guestName,
        guestPhone,
        total,
        paymentMode,
    ],);

  factory AdminBookingDto.fromJson(Map<String, dynamic> json) => _$AdminBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminBookingDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

