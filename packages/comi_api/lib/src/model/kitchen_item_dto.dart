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

part 'kitchen_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class KitchenItemDto {
  /// Returns a new [KitchenItemDto] instance.
  KitchenItemDto({

    required  this.id,

    required  this.bookingId,

    required  this.bookingCode,

     this.tableCode,

    required  this.partySize,

    required  this.arrivalAt,

    required  this.guestArrived,

    required  this.nameSnapshot,

    required  this.quantity,

    required  this.optionsSnapshot,

     this.note,

    required  this.course,

    required  this.prepMinutes,

    required  this.kitchenStatus,

    required  this.round,

     this.scheduledStartAt,

     this.releasedAt,

     this.startedAt,

     this.readyAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



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
    
    name: r'tableCode',
    required: false,
    includeIfNull: false,
  )


  final String? tableCode;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;



      /// Booking is CHECKED_IN
  @JsonKey(
    
    name: r'guestArrived',
    required: true,
    includeIfNull: false,
  )


  final bool guestArrived;



  @JsonKey(
    
    name: r'nameSnapshot',
    required: true,
    includeIfNull: false,
  )


  final String nameSnapshot;



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
    
    name: r'prepMinutes',
    required: true,
    includeIfNull: false,
  )


  final num prepMinutes;



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



  @JsonKey(
    
    name: r'scheduledStartAt',
    required: false,
    includeIfNull: false,
  )


  final String? scheduledStartAt;



  @JsonKey(
    
    name: r'releasedAt',
    required: false,
    includeIfNull: false,
  )


  final String? releasedAt;



  @JsonKey(
    
    name: r'startedAt',
    required: false,
    includeIfNull: false,
  )


  final String? startedAt;



  @JsonKey(
    
    name: r'readyAt',
    required: false,
    includeIfNull: false,
  )


  final String? readyAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is KitchenItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            bookingCode,
            tableCode,
            partySize,
            arrivalAt,
            guestArrived,
            nameSnapshot,
            quantity,
            optionsSnapshot,
            note,
            course,
            prepMinutes,
            kitchenStatus,
            round,
            scheduledStartAt,
            releasedAt,
            startedAt,
            readyAt,
        ],
        [
            other.id,
            other.bookingId,
            other.bookingCode,
            other.tableCode,
            other.partySize,
            other.arrivalAt,
            other.guestArrived,
            other.nameSnapshot,
            other.quantity,
            other.optionsSnapshot,
            other.note,
            other.course,
            other.prepMinutes,
            other.kitchenStatus,
            other.round,
            other.scheduledStartAt,
            other.releasedAt,
            other.startedAt,
            other.readyAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        bookingCode,
        tableCode,
        partySize,
        arrivalAt,
        guestArrived,
        nameSnapshot,
        quantity,
        optionsSnapshot,
        note,
        course,
        prepMinutes,
        kitchenStatus,
        round,
        scheduledStartAt,
        releasedAt,
        startedAt,
        readyAt,
    ],);

  factory KitchenItemDto.fromJson(Map<String, dynamic> json) => _$KitchenItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

