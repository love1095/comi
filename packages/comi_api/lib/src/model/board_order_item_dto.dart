//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:comi_api/src/model/kitchen_status.dart';
import 'package:comi_api/src/model/option_snapshot_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'board_order_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BoardOrderItemDto {
  /// Returns a new [BoardOrderItemDto] instance.
  BoardOrderItemDto({

    required  this.id,

    required  this.nameSnapshot,

    required  this.unitPrice,

    required  this.quantity,

    required  this.optionsSnapshot,

     this.note,

    required  this.course,

    required  this.kitchenStatus,

    required  this.round,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'nameSnapshot',
    required: true,
    includeIfNull: false,
  )


  final String nameSnapshot;



  @JsonKey(
    
    name: r'unitPrice',
    required: true,
    includeIfNull: false,
  )


  final num unitPrice;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final num quantity;



  @JsonKey(
    
    name: r'optionsSnapshot',
    required: true,
    includeIfNull: false,
  )


  final List<OptionSnapshotDto> optionsSnapshot;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'course',
    required: true,
    includeIfNull: false,
  )


  final Course course;



  @JsonKey(
    
    name: r'kitchenStatus',
    required: true,
    includeIfNull: false,
  )


  final KitchenStatus kitchenStatus;



      /// 0 = pre-order, 1..n = ordered at the table
  @JsonKey(
    
    name: r'round',
    required: true,
    includeIfNull: false,
  )


  final num round;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BoardOrderItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            nameSnapshot,
            unitPrice,
            quantity,
            optionsSnapshot,
            note,
            course,
            kitchenStatus,
            round,
        ],
        [
            other.id,
            other.nameSnapshot,
            other.unitPrice,
            other.quantity,
            other.optionsSnapshot,
            other.note,
            other.course,
            other.kitchenStatus,
            other.round,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        nameSnapshot,
        unitPrice,
        quantity,
        optionsSnapshot,
        note,
        course,
        kitchenStatus,
        round,
    ],);

  factory BoardOrderItemDto.fromJson(Map<String, dynamic> json) => _$BoardOrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BoardOrderItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

