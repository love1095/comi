//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/restaurant_summary_dto.dart';
import 'package:comi_api/src/model/staff_role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'membership_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MembershipDto {
  /// Returns a new [MembershipDto] instance.
  MembershipDto({

    required  this.role,

    required  this.restaurant,
  });

  @JsonKey(
    
    name: r'role',
    required: true,
    includeIfNull: false,
  )


  final StaffRole role;



  @JsonKey(
    
    name: r'restaurant',
    required: true,
    includeIfNull: false,
  )


  final RestaurantSummaryDto restaurant;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MembershipDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            role,
            restaurant,
        ],
        [
            other.role,
            other.restaurant,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        role,
        restaurant,
    ],);

  factory MembershipDto.fromJson(Map<String, dynamic> json) => _$MembershipDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

