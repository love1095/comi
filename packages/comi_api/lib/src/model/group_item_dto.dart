//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/course.dart';
import 'package:comi_api/src/model/option_snapshot_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'group_item_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupItemDto {
  /// Returns a new [GroupItemDto] instance.
  GroupItemDto({

    required  this.id,

     this.guestId,

    required  this.menuItemId,

    required  this.nameSnapshot,

    required  this.unitPrice,

    required  this.quantity,

    required  this.optionsSnapshot,

     this.note,

    required  this.course,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'guestId',
    required: false,
    includeIfNull: false,
  )


  final String? guestId;



  @JsonKey(
    
    name: r'menuItemId',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GroupItemDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            guestId,
            menuItemId,
            nameSnapshot,
            unitPrice,
            quantity,
            optionsSnapshot,
            note,
            course,
        ],
        [
            other.id,
            other.guestId,
            other.menuItemId,
            other.nameSnapshot,
            other.unitPrice,
            other.quantity,
            other.optionsSnapshot,
            other.note,
            other.course,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        guestId,
        menuItemId,
        nameSnapshot,
        unitPrice,
        quantity,
        optionsSnapshot,
        note,
        course,
    ],);

  factory GroupItemDto.fromJson(Map<String, dynamic> json) => _$GroupItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupItemDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

