//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_dashboard_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminDashboardDto {
  /// Returns a new [AdminDashboardDto] instance.
  AdminDashboardDto({

    required  this.restaurants,

    required  this.bookingsToday,

    required  this.bookingsMonth,

    required  this.gmvMonth,

    required  this.noShowsMonth,

    required  this.newUsersMonth,

    required  this.reportedReviews,

    required  this.overdueStatements,

    required  this.pendingRefunds,
  });

  @JsonKey(
    
    name: r'restaurants',
    required: true,
    includeIfNull: false,
  )


  final Map<String, num> restaurants;



  @JsonKey(
    
    name: r'bookingsToday',
    required: true,
    includeIfNull: false,
  )


  final num bookingsToday;



  @JsonKey(
    
    name: r'bookingsMonth',
    required: true,
    includeIfNull: false,
  )


  final num bookingsMonth;



      /// Completed order totals this month (VND)
  @JsonKey(
    
    name: r'gmvMonth',
    required: true,
    includeIfNull: false,
  )


  final num gmvMonth;



  @JsonKey(
    
    name: r'noShowsMonth',
    required: true,
    includeIfNull: false,
  )


  final num noShowsMonth;



  @JsonKey(
    
    name: r'newUsersMonth',
    required: true,
    includeIfNull: false,
  )


  final num newUsersMonth;



  @JsonKey(
    
    name: r'reportedReviews',
    required: true,
    includeIfNull: false,
  )


  final num reportedReviews;



  @JsonKey(
    
    name: r'overdueStatements',
    required: true,
    includeIfNull: false,
  )


  final num overdueStatements;



  @JsonKey(
    
    name: r'pendingRefunds',
    required: true,
    includeIfNull: false,
  )


  final num pendingRefunds;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminDashboardDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            restaurants,
            bookingsToday,
            bookingsMonth,
            gmvMonth,
            noShowsMonth,
            newUsersMonth,
            reportedReviews,
            overdueStatements,
            pendingRefunds,
        ],
        [
            other.restaurants,
            other.bookingsToday,
            other.bookingsMonth,
            other.gmvMonth,
            other.noShowsMonth,
            other.newUsersMonth,
            other.reportedReviews,
            other.overdueStatements,
            other.pendingRefunds,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        restaurants,
        bookingsToday,
        bookingsMonth,
        gmvMonth,
        noShowsMonth,
        newUsersMonth,
        reportedReviews,
        overdueStatements,
        pendingRefunds,
    ],);

  factory AdminDashboardDto.fromJson(Map<String, dynamic> json) => _$AdminDashboardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDashboardDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

