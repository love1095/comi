//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/kitchen_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'kitchen_queue_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class KitchenQueueDto {
  /// Returns a new [KitchenQueueDto] instance.
  KitchenQueueDto({

    required  this.now,

    required  this.active,

    required  this.ready,

    required  this.upcoming,
  });

      /// Server time, for \"late by\" timers
  @JsonKey(
    
    name: r'now',
    required: true,
    includeIfNull: false,
  )


  final String now;



      /// COOKING first, then by fire time
  @JsonKey(
    
    name: r'active',
    required: true,
    includeIfNull: false,
  )


  final List<KitchenItemDto> active;



      /// Done, waiting for a waiter
  @JsonKey(
    
    name: r'ready',
    required: true,
    includeIfNull: false,
  )


  final List<KitchenItemDto> ready;



      /// SCHEDULED (next 2 h) and HOLD (COD guest not here yet)
  @JsonKey(
    
    name: r'upcoming',
    required: true,
    includeIfNull: false,
  )


  final List<KitchenItemDto> upcoming;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is KitchenQueueDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            now,
            active,
            ready,
            upcoming,
        ],
        [
            other.now,
            other.active,
            other.ready,
            other.upcoming,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        now,
        active,
        ready,
        upcoming,
    ],);

  factory KitchenQueueDto.fromJson(Map<String, dynamic> json) => _$KitchenQueueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenQueueDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

