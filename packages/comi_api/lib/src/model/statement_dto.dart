//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'statement_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StatementDto {
  /// Returns a new [StatementDto] instance.
  StatementDto({

    required  this.id,

    required  this.restaurantId,

    required  this.periodMonth,

    required  this.bookingCount,

    required  this.totalBase,

    required  this.totalFee,

    required  this.platformVoucherCredit,

    required  this.amountDue,

    required  this.status,

     this.issuedAt,

     this.paidAt,

     this.dueAt,

    required  this.transferMemo,

     this.vietQrUrl,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    
    name: r'periodMonth',
    required: true,
    includeIfNull: false,
  )


  final String periodMonth;



  @JsonKey(
    
    name: r'bookingCount',
    required: true,
    includeIfNull: false,
  )


  final num bookingCount;



  @JsonKey(
    
    name: r'totalBase',
    required: true,
    includeIfNull: false,
  )


  final num totalBase;



  @JsonKey(
    
    name: r'totalFee',
    required: true,
    includeIfNull: false,
  )


  final num totalFee;



  @JsonKey(
    
    name: r'platformVoucherCredit',
    required: true,
    includeIfNull: false,
  )


  final num platformVoucherCredit;



      /// Negative = comi pays the restaurant
  @JsonKey(
    
    name: r'amountDue',
    required: true,
    includeIfNull: false,
  )


  final num amountDue;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final StatementDtoStatusEnum status;



  @JsonKey(
    
    name: r'issuedAt',
    required: false,
    includeIfNull: false,
  )


  final String? issuedAt;



  @JsonKey(
    
    name: r'paidAt',
    required: false,
    includeIfNull: false,
  )


  final String? paidAt;



  @JsonKey(
    
    name: r'dueAt',
    required: false,
    includeIfNull: false,
  )


  final String? dueAt;



      /// Write this on the bank transfer
  @JsonKey(
    
    name: r'transferMemo',
    required: true,
    includeIfNull: false,
  )


  final String transferMemo;



      /// VietQR image to scan with a bank app
  @JsonKey(
    
    name: r'vietQrUrl',
    required: false,
    includeIfNull: false,
  )


  final String? vietQrUrl;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StatementDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            restaurantId,
            periodMonth,
            bookingCount,
            totalBase,
            totalFee,
            platformVoucherCredit,
            amountDue,
            status,
            issuedAt,
            paidAt,
            dueAt,
            transferMemo,
            vietQrUrl,
        ],
        [
            other.id,
            other.restaurantId,
            other.periodMonth,
            other.bookingCount,
            other.totalBase,
            other.totalFee,
            other.platformVoucherCredit,
            other.amountDue,
            other.status,
            other.issuedAt,
            other.paidAt,
            other.dueAt,
            other.transferMemo,
            other.vietQrUrl,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        restaurantId,
        periodMonth,
        bookingCount,
        totalBase,
        totalFee,
        platformVoucherCredit,
        amountDue,
        status,
        issuedAt,
        paidAt,
        dueAt,
        transferMemo,
        vietQrUrl,
    ],);

  factory StatementDto.fromJson(Map<String, dynamic> json) => _$StatementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StatementDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum StatementDtoStatusEnum {
@JsonValue(r'DRAFT')
DRAFT(r'DRAFT'),
@JsonValue(r'ISSUED')
ISSUED(r'ISSUED'),
@JsonValue(r'PAID')
PAID(r'PAID'),
@JsonValue(r'OVERDUE')
OVERDUE(r'OVERDUE');

const StatementDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


