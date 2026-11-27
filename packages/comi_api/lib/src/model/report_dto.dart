//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/report_day_dto.dart';
import 'package:comi_api/src/model/report_dish_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'report_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportDto {
  /// Returns a new [ReportDto] instance.
  ReportDto({

    required  this.from,

    required  this.to,

    required  this.bookings,

    required  this.completed,

    required  this.cancelled,

    required  this.noShows,

    required  this.noShowRate,

    required  this.guests,

    required  this.revenue,

    required  this.averageBill,

    required  this.preOrderValue,

    required  this.platformFees,

    required  this.byDay,

    required  this.topDishes,
  });

  @JsonKey(
    
    name: r'from',
    required: true,
    includeIfNull: false,
  )


  final String from;



  @JsonKey(
    
    name: r'to',
    required: true,
    includeIfNull: false,
  )


  final String to;



  @JsonKey(
    
    name: r'bookings',
    required: true,
    includeIfNull: false,
  )


  final num bookings;



  @JsonKey(
    
    name: r'completed',
    required: true,
    includeIfNull: false,
  )


  final num completed;



  @JsonKey(
    
    name: r'cancelled',
    required: true,
    includeIfNull: false,
  )


  final num cancelled;



  @JsonKey(
    
    name: r'noShows',
    required: true,
    includeIfNull: false,
  )


  final num noShows;



      /// Percent of ended bookings
  @JsonKey(
    
    name: r'noShowRate',
    required: true,
    includeIfNull: false,
  )


  final num noShowRate;



  @JsonKey(
    
    name: r'guests',
    required: true,
    includeIfNull: false,
  )


  final num guests;



      /// Sum of closed bills (VND)
  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final num revenue;



  @JsonKey(
    
    name: r'averageBill',
    required: true,
    includeIfNull: false,
  )


  final num averageBill;



  @JsonKey(
    
    name: r'preOrderValue',
    required: true,
    includeIfNull: false,
  )


  final num preOrderValue;



  @JsonKey(
    
    name: r'platformFees',
    required: true,
    includeIfNull: false,
  )


  final num platformFees;



  @JsonKey(
    
    name: r'byDay',
    required: true,
    includeIfNull: false,
  )


  final List<ReportDayDto> byDay;



  @JsonKey(
    
    name: r'topDishes',
    required: true,
    includeIfNull: false,
  )


  final List<ReportDishDto> topDishes;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReportDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            from,
            to,
            bookings,
            completed,
            cancelled,
            noShows,
            noShowRate,
            guests,
            revenue,
            averageBill,
            preOrderValue,
            platformFees,
            byDay,
            topDishes,
        ],
        [
            other.from,
            other.to,
            other.bookings,
            other.completed,
            other.cancelled,
            other.noShows,
            other.noShowRate,
            other.guests,
            other.revenue,
            other.averageBill,
            other.preOrderValue,
            other.platformFees,
            other.byDay,
            other.topDishes,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        from,
        to,
        bookings,
        completed,
        cancelled,
        noShows,
        noShowRate,
        guests,
        revenue,
        averageBill,
        preOrderValue,
        platformFees,
        byDay,
        topDishes,
    ],);

  factory ReportDto.fromJson(Map<String, dynamic> json) => _$ReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

