//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/board_order_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'bill_round_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BillRoundDto {
  /// Returns a new [BillRoundDto] instance.
  BillRoundDto({

    required  this.round,

    required  this.waitingForStaff,

    required  this.subtotal,

    required  this.items,
  });

      /// 0 = pre-order
  @JsonKey(
    
    name: r'round',
    required: true,
    includeIfNull: false,
  )


  final num round;



  @JsonKey(
    
    name: r'waitingForStaff',
    required: true,
    includeIfNull: false,
  )


  final bool waitingForStaff;



  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final num subtotal;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<BoardOrderItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BillRoundDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            round,
            waitingForStaff,
            subtotal,
            items,
        ],
        [
            other.round,
            other.waitingForStaff,
            other.subtotal,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        round,
        waitingForStaff,
        subtotal,
        items,
    ],);

  factory BillRoundDto.fromJson(Map<String, dynamic> json) => _$BillRoundDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BillRoundDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

