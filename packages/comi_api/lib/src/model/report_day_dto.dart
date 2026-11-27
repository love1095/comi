//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'report_day_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportDayDto {
  /// Returns a new [ReportDayDto] instance.
  ReportDayDto({

    required  this.date,

    required  this.bookings,

    required  this.guests,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'date',
    required: true,
    includeIfNull: false,
  )


  final String date;



  @JsonKey(
    
    name: r'bookings',
    required: true,
    includeIfNull: false,
  )


  final num bookings;



  @JsonKey(
    
    name: r'guests',
    required: true,
    includeIfNull: false,
  )


  final num guests;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final num revenue;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReportDayDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            date,
            bookings,
            guests,
            revenue,
        ],
        [
            other.date,
            other.bookings,
            other.guests,
            other.revenue,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        date,
        bookings,
        guests,
        revenue,
    ],);

  factory ReportDayDto.fromJson(Map<String, dynamic> json) => _$ReportDayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDayDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

