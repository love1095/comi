//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'payment_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentDto {
  /// Returns a new [PaymentDto] instance.
  PaymentDto({

    required  this.id,

    required  this.bookingId,

    required  this.amount,

    required  this.status,

    required  this.purpose,

     this.guestId,

     this.checkoutUrl,

     this.qrCode,

    required  this.expiresAt,

     this.paidAt,

    required  this.refundedAmount,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'bookingId',
    required: true,
    includeIfNull: false,
  )


  final String bookingId;



  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final num amount;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final PaymentDtoStatusEnum status;



  @JsonKey(
    
    name: r'purpose',
    required: true,
    includeIfNull: false,
  )


  final PaymentDtoPurposeEnum purpose;



  @JsonKey(
    
    name: r'guestId',
    required: false,
    includeIfNull: false,
  )


  final String? guestId;



      /// Open in the browser / bank app
  @JsonKey(
    
    name: r'checkoutUrl',
    required: false,
    includeIfNull: false,
  )


  final String? checkoutUrl;



      /// VietQR payload to draw as a QR code
  @JsonKey(
    
    name: r'qrCode',
    required: false,
    includeIfNull: false,
  )


  final String? qrCode;



  @JsonKey(
    
    name: r'expiresAt',
    required: true,
    includeIfNull: false,
  )


  final String expiresAt;



  @JsonKey(
    
    name: r'paidAt',
    required: false,
    includeIfNull: false,
  )


  final String? paidAt;



  @JsonKey(
    
    name: r'refundedAmount',
    required: true,
    includeIfNull: false,
  )


  final num refundedAmount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PaymentDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            amount,
            status,
            purpose,
            guestId,
            checkoutUrl,
            qrCode,
            expiresAt,
            paidAt,
            refundedAmount,
        ],
        [
            other.id,
            other.bookingId,
            other.amount,
            other.status,
            other.purpose,
            other.guestId,
            other.checkoutUrl,
            other.qrCode,
            other.expiresAt,
            other.paidAt,
            other.refundedAmount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        amount,
        status,
        purpose,
        guestId,
        checkoutUrl,
        qrCode,
        expiresAt,
        paidAt,
        refundedAmount,
    ],);

  factory PaymentDto.fromJson(Map<String, dynamic> json) => _$PaymentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum PaymentDtoStatusEnum {
@JsonValue(r'CREATED')
CREATED(r'CREATED'),
@JsonValue(r'PENDING')
PENDING(r'PENDING'),
@JsonValue(r'PAID')
PAID(r'PAID'),
@JsonValue(r'FAILED')
FAILED(r'FAILED'),
@JsonValue(r'EXPIRED')
EXPIRED(r'EXPIRED'),
@JsonValue(r'REFUNDED')
REFUNDED(r'REFUNDED'),
@JsonValue(r'PARTIALLY_REFUNDED')
PARTIALLY_REFUNDED(r'PARTIALLY_REFUNDED');

const PaymentDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


enum PaymentDtoPurposeEnum {
@JsonValue(r'BOOKING')
BOOKING(r'BOOKING'),
@JsonValue(r'SHARE')
SHARE(r'SHARE');

const PaymentDtoPurposeEnum(this.value);

final String value;

@override
String toString() => value;
}


