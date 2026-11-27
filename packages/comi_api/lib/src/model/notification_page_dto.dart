//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/notification_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'notification_page_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationPageDto {
  /// Returns a new [NotificationPageDto] instance.
  NotificationPageDto({

    required  this.items,

    required  this.unread,

     this.nextCursor,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<NotificationDto> items;



  @JsonKey(
    
    name: r'unread',
    required: true,
    includeIfNull: false,
  )


  final num unread;



  @JsonKey(
    
    name: r'nextCursor',
    required: false,
    includeIfNull: false,
  )


  final String? nextCursor;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is NotificationPageDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
            unread,
            nextCursor,
        ],
        [
            other.items,
            other.unread,
            other.nextCursor,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
        unread,
        nextCursor,
    ],);

  factory NotificationPageDto.fromJson(Map<String, dynamic> json) => _$NotificationPageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPageDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

