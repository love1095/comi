//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/bill_round_dto.dart';
import 'package:comi_api/src/model/booking_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'bill_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BillDto {
  /// Returns a new [BillDto] instance.
  BillDto({

    required  this.bookingId,

    required  this.code,

    required  this.status,

    required  this.rounds,

    required  this.total,

     this.finalBillAmount,
  });

  @JsonKey(
    
    name: r'bookingId',
    required: true,
    includeIfNull: false,
  )


  final String bookingId;



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


  final BookingStatus status;



  @JsonKey(
    
    name: r'rounds',
    required: true,
    includeIfNull: false,
  )


  final List<BillRoundDto> rounds;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



  @JsonKey(
    
    name: r'finalBillAmount',
    required: false,
    includeIfNull: false,
  )


  final num? finalBillAmount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BillDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            bookingId,
            code,
            status,
            rounds,
            total,
            finalBillAmount,
        ],
        [
            other.bookingId,
            other.code,
            other.status,
            other.rounds,
            other.total,
            other.finalBillAmount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        bookingId,
        code,
        status,
        rounds,
        total,
        finalBillAmount,
    ],);

  factory BillDto.fromJson(Map<String, dynamic> json) => _$BillDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BillDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

