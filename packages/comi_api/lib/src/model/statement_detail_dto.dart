//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/statement_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'statement_detail_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StatementDetailDto {
  /// Returns a new [StatementDetailDto] instance.
  StatementDetailDto({

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

    required  this.lines,
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


  final StatementDetailDtoStatusEnum status;



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



  @JsonKey(
    
    name: r'lines',
    required: true,
    includeIfNull: false,
  )


  final List<StatementLineDto> lines;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StatementDetailDto &&
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
            lines,
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
            other.lines,
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
        lines,
    ],);

  factory StatementDetailDto.fromJson(Map<String, dynamic> json) => _$StatementDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StatementDetailDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum StatementDetailDtoStatusEnum {
@JsonValue(r'DRAFT')
DRAFT(r'DRAFT'),
@JsonValue(r'ISSUED')
ISSUED(r'ISSUED'),
@JsonValue(r'PAID')
PAID(r'PAID'),
@JsonValue(r'OVERDUE')
OVERDUE(r'OVERDUE');

const StatementDetailDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


