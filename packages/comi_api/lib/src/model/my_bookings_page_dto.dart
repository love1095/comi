//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/customer_booking_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'my_bookings_page_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MyBookingsPageDto {
  /// Returns a new [MyBookingsPageDto] instance.
  MyBookingsPageDto({

    required  this.items,

     this.nextCursor,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<CustomerBookingDto> items;



  @JsonKey(
    
    name: r'nextCursor',
    required: false,
    includeIfNull: false,
  )


  final String? nextCursor;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MyBookingsPageDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
            nextCursor,
        ],
        [
            other.items,
            other.nextCursor,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
        nextCursor,
    ],);

  factory MyBookingsPageDto.fromJson(Map<String, dynamic> json) => _$MyBookingsPageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookingsPageDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

