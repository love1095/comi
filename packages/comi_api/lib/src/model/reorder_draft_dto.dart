//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/booking_restaurant_dto.dart';
import 'package:comi_api/src/model/reorder_line_dto.dart';
import 'package:comi_api/src/model/unavailable_line_dto.dart';
import 'package:comi_api/src/model/serve_style.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'reorder_draft_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReorderDraftDto {
  /// Returns a new [ReorderDraftDto] instance.
  ReorderDraftDto({

    required  this.restaurant,

    required  this.partySize,

    required  this.serveStyle,

    required  this.items,

    required  this.unavailable,
  });

  @JsonKey(
    
    name: r'restaurant',
    required: true,
    includeIfNull: false,
  )


  final BookingRestaurantDto restaurant;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'serveStyle',
    required: true,
    includeIfNull: false,
  )


  final ServeStyle serveStyle;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ReorderLineDto> items;



  @JsonKey(
    
    name: r'unavailable',
    required: true,
    includeIfNull: false,
  )


  final List<UnavailableLineDto> unavailable;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReorderDraftDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            restaurant,
            partySize,
            serveStyle,
            items,
            unavailable,
        ],
        [
            other.restaurant,
            other.partySize,
            other.serveStyle,
            other.items,
            other.unavailable,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        restaurant,
        partySize,
        serveStyle,
        items,
        unavailable,
    ],);

  factory ReorderDraftDto.fromJson(Map<String, dynamic> json) => _$ReorderDraftDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReorderDraftDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

