//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'invoice_request_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InvoiceRequestDto {
  /// Returns a new [InvoiceRequestDto] instance.
  InvoiceRequestDto({

    required  this.id,

    required  this.bookingId,

    required  this.bookingCode,

    required  this.companyName,

    required  this.taxCode,

    required  this.address,

    required  this.email,

    required  this.status,

     this.invoiceNo,

     this.issuedAt,

    required  this.amount,

    required  this.arrivalAt,
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
    
    name: r'companyName',
    required: true,
    includeIfNull: false,
  )


  final String companyName;



  @JsonKey(
    
    name: r'taxCode',
    required: true,
    includeIfNull: false,
  )


  final String taxCode;



  @JsonKey(
    
    name: r'address',
    required: true,
    includeIfNull: false,
  )


  final String address;



  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final InvoiceRequestDtoStatusEnum status;



  @JsonKey(
    
    name: r'invoiceNo',
    required: false,
    includeIfNull: false,
  )


  final String? invoiceNo;



  @JsonKey(
    
    name: r'issuedAt',
    required: false,
    includeIfNull: false,
  )


  final String? issuedAt;



      /// Bill amount to invoice (VND)
  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final num amount;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is InvoiceRequestDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            bookingCode,
            companyName,
            taxCode,
            address,
            email,
            status,
            invoiceNo,
            issuedAt,
            amount,
            arrivalAt,
        ],
        [
            other.id,
            other.bookingId,
            other.bookingCode,
            other.companyName,
            other.taxCode,
            other.address,
            other.email,
            other.status,
            other.invoiceNo,
            other.issuedAt,
            other.amount,
            other.arrivalAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        bookingCode,
        companyName,
        taxCode,
        address,
        email,
        status,
        invoiceNo,
        issuedAt,
        amount,
        arrivalAt,
    ],);

  factory InvoiceRequestDto.fromJson(Map<String, dynamic> json) => _$InvoiceRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum InvoiceRequestDtoStatusEnum {
@JsonValue(r'REQUESTED')
REQUESTED(r'REQUESTED'),
@JsonValue(r'SENT_TO_RESTAURANT')
SENT_TO_RESTAURANT(r'SENT_TO_RESTAURANT'),
@JsonValue(r'ISSUED')
ISSUED(r'ISSUED'),
@JsonValue(r'EMAILED')
EMAILED(r'EMAILED'),
@JsonValue(r'REJECTED')
REJECTED(r'REJECTED');

const InvoiceRequestDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


