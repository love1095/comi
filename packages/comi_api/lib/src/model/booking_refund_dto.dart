//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'booking_refund_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BookingRefundDto {
  /// Returns a new [BookingRefundDto] instance.
  BookingRefundDto({

    required  this.id,

    required  this.amount,

    required  this.status,

    required  this.reason,

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


  final BookingRefundDtoStatusEnum status;



  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;



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
      other is BookingRefundDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            amount,
            status,
            reason,
            createdAt,
            doneAt,
        ],
        [
            other.id,
            other.amount,
            other.status,
            other.reason,
            other.createdAt,
            other.doneAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        amount,
        status,
        reason,
        createdAt,
        doneAt,
    ],);

  factory BookingRefundDto.fromJson(Map<String, dynamic> json) => _$BookingRefundDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRefundDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum BookingRefundDtoStatusEnum {
@JsonValue(r'PENDING')
PENDING(r'PENDING'),
@JsonValue(r'DONE')
DONE(r'DONE');

const BookingRefundDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


