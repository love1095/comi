//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'refund_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundDto {
  /// Returns a new [RefundDto] instance.
  RefundDto({

    required  this.id,

    required  this.bookingId,

    required  this.bookingCode,

     this.guestName,

     this.guestPhone,

    required  this.amount,

    required  this.reason,

    required  this.status,

     this.toBankBin,

     this.toAccountNo,

     this.toAccountName,

     this.note,

    required  this.createdAt,

     this.doneAt,
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
    
    name: r'bookingCode',
    required: true,
    includeIfNull: false,
  )


  final String bookingCode;



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
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final num amount;



  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final RefundDtoReasonEnum reason;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final RefundDtoStatusEnum status;



  @JsonKey(
    
    name: r'toBankBin',
    required: false,
    includeIfNull: false,
  )


  final String? toBankBin;



  @JsonKey(
    
    name: r'toAccountNo',
    required: false,
    includeIfNull: false,
  )


  final String? toAccountNo;



  @JsonKey(
    
    name: r'toAccountName',
    required: false,
    includeIfNull: false,
  )


  final String? toAccountName;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;



  @JsonKey(
    
    name: r'doneAt',
    required: false,
    includeIfNull: false,
  )


  final String? doneAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RefundDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            bookingCode,
            guestName,
            guestPhone,
            amount,
            reason,
            status,
            toBankBin,
            toAccountNo,
            toAccountName,
            note,
            createdAt,
            doneAt,
        ],
        [
            other.id,
            other.bookingId,
            other.bookingCode,
            other.guestName,
            other.guestPhone,
            other.amount,
            other.reason,
            other.status,
            other.toBankBin,
            other.toAccountNo,
            other.toAccountName,
            other.note,
            other.createdAt,
            other.doneAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        bookingCode,
        guestName,
        guestPhone,
        amount,
        reason,
        status,
        toBankBin,
        toAccountNo,
        toAccountName,
        note,
        createdAt,
        doneAt,
    ],);

  factory RefundDto.fromJson(Map<String, dynamic> json) => _$RefundDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefundDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum RefundDtoReasonEnum {
@JsonValue(r'RESTAURANT_CANCELLED')
RESTAURANT_CANCELLED(r'RESTAURANT_CANCELLED'),
@JsonValue(r'CUSTOMER_CANCELLED')
CUSTOMER_CANCELLED(r'CUSTOMER_CANCELLED'),
@JsonValue(r'LATE_PAYMENT_NO_TABLE')
LATE_PAYMENT_NO_TABLE(r'LATE_PAYMENT_NO_TABLE'),
@JsonValue(r'AMOUNT_MISMATCH')
AMOUNT_MISMATCH(r'AMOUNT_MISMATCH'),
@JsonValue(r'NO_SHOW_POLICY')
NO_SHOW_POLICY(r'NO_SHOW_POLICY');

const RefundDtoReasonEnum(this.value);

final String value;

@override
String toString() => value;
}


enum RefundDtoStatusEnum {
@JsonValue(r'PENDING')
PENDING(r'PENDING'),
@JsonValue(r'DONE')
DONE(r'DONE');

const RefundDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


