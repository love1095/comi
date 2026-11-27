//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'report_dish_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportDishDto {
  /// Returns a new [ReportDishDto] instance.
  ReportDishDto({

    required  this.name,

    required  this.quantity,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final num quantity;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final num revenue;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReportDishDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            quantity,
            revenue,
        ],
        [
            other.name,
            other.quantity,
            other.revenue,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        quantity,
        revenue,
    ],);

  factory ReportDishDto.fromJson(Map<String, dynamic> json) => _$ReportDishDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDishDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

