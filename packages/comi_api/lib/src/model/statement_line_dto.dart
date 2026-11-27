//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'statement_line_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StatementLineDto {
  /// Returns a new [StatementLineDto] instance.
  StatementLineDto({

    required  this.bookingId,

    required  this.bookingCode,

    required  this.arrivalAt,

    required  this.partySize,

    required  this.baseAmount,

    required  this.rateBps,

    required  this.feeAmount,
  });

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
    
    name: r'baseAmount',
    required: true,
    includeIfNull: false,
  )


  final num baseAmount;



  @JsonKey(
    
    name: r'rateBps',
    required: true,
    includeIfNull: false,
  )


  final num rateBps;



  @JsonKey(
    
    name: r'feeAmount',
    required: true,
    includeIfNull: false,
  )


  final num feeAmount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StatementLineDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            bookingId,
            bookingCode,
            arrivalAt,
            partySize,
            baseAmount,
            rateBps,
            feeAmount,
        ],
        [
            other.bookingId,
            other.bookingCode,
            other.arrivalAt,
            other.partySize,
            other.baseAmount,
            other.rateBps,
            other.feeAmount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        bookingId,
        bookingCode,
        arrivalAt,
        partySize,
        baseAmount,
        rateBps,
        feeAmount,
    ],);

  factory StatementLineDto.fromJson(Map<String, dynamic> json) => _$StatementLineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StatementLineDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

