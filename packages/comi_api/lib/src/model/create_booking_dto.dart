//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_booking_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateBookingDto {
  /// Returns a new [CreateBookingDto] instance.
  CreateBookingDto({

    required  this.restaurantId,

    required  this.arrivalAt,

    required  this.partySize,

     this.areaId,

     this.holdId,

    required  this.paymentMode,

     this.serveStyle,

     this.note,

     this.occasion,

     this.ageConfirmed,

     this.voucherCode,

     this.items,
  });

  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



      /// Exact slot start from /availability (ISO)
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
    
    name: r'areaId',
    required: false,
    includeIfNull: false,
  )


  final String? areaId;



      /// From POST /restaurants/:id/table-holds
  @JsonKey(
    
    name: r'holdId',
    required: false,
    includeIfNull: false,
  )


  final String? holdId;



  @JsonKey(
    
    name: r'paymentMode',
    required: true,
    includeIfNull: false,
  )


  final CreateBookingDtoPaymentModeEnum paymentMode;



  @JsonKey(
    
    name: r'serveStyle',
    required: false,
    includeIfNull: false,
  )


  final CreateBookingDtoServeStyleEnum? serveStyle;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'occasion',
    required: false,
    includeIfNull: false,
  )


  final CreateBookingDtoOccasionEnum? occasion;



      /// Required when the order contains alcohol
  @JsonKey(
    
    name: r'ageConfirmed',
    required: false,
    includeIfNull: false,
  )


  final bool? ageConfirmed;



      /// One voucher per booking (§12); never discounts alcohol
  @JsonKey(
    
    name: r'voucherCode',
    required: false,
    includeIfNull: false,
  )


  final String? voucherCode;



  @JsonKey(
    
    name: r'items',
    required: false,
    includeIfNull: false,
  )


  final List<CartLineDto>? items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateBookingDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            restaurantId,
            arrivalAt,
            partySize,
            areaId,
            holdId,
            paymentMode,
            serveStyle,
            note,
            occasion,
            ageConfirmed,
            voucherCode,
            items,
        ],
        [
            other.restaurantId,
            other.arrivalAt,
            other.partySize,
            other.areaId,
            other.holdId,
            other.paymentMode,
            other.serveStyle,
            other.note,
            other.occasion,
            other.ageConfirmed,
            other.voucherCode,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        restaurantId,
        arrivalAt,
        partySize,
        areaId,
        holdId,
        paymentMode,
        serveStyle,
        note,
        occasion,
        ageConfirmed,
        voucherCode,
        items,
    ],);

  factory CreateBookingDto.fromJson(Map<String, dynamic> json) => _$CreateBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum CreateBookingDtoPaymentModeEnum {
@JsonValue(r'PREPAID')
PREPAID(r'PREPAID'),
@JsonValue(r'COD')
COD(r'COD');

const CreateBookingDtoPaymentModeEnum(this.value);

final String value;

@override
String toString() => value;
}


enum CreateBookingDtoServeStyleEnum {
@JsonValue(r'BY_COURSE')
BY_COURSE(r'BY_COURSE'),
@JsonValue(r'ALL_TOGETHER')
ALL_TOGETHER(r'ALL_TOGETHER');

const CreateBookingDtoServeStyleEnum(this.value);

final String value;

@override
String toString() => value;
}


enum CreateBookingDtoOccasionEnum {
@JsonValue(r'DATE')
DATE(r'DATE'),
@JsonValue(r'ANNIVERSARY')
ANNIVERSARY(r'ANNIVERSARY'),
@JsonValue(r'BIRTHDAY')
BIRTHDAY(r'BIRTHDAY'),
@JsonValue(r'BUSINESS')
BUSINESS(r'BUSINESS'),
@JsonValue(r'CELEBRATION')
CELEBRATION(r'CELEBRATION');

const CreateBookingDtoOccasionEnum(this.value);

final String value;

@override
String toString() => value;
}


