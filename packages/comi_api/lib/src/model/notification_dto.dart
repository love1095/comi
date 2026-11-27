//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'notification_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationDto {
  /// Returns a new [NotificationDto] instance.
  NotificationDto({

    required  this.id,

    required  this.type,

    required  this.title,

    required  this.body,

     this.bookingId,

     this.readAt,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final String type;



  @JsonKey(
    
    name: r'title',
    required: true,
    includeIfNull: false,
  )


  final String title;



  @JsonKey(
    
    name: r'body',
    required: true,
    includeIfNull: false,
  )


  final String body;



  @JsonKey(
    
    name: r'bookingId',
    required: false,
    includeIfNull: false,
  )


  final String? bookingId;



  @JsonKey(
    
    name: r'readAt',
    required: false,
    includeIfNull: false,
  )


  final String? readAt;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is NotificationDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            type,
            title,
            body,
            bookingId,
            readAt,
            createdAt,
        ],
        [
            other.id,
            other.type,
            other.title,
            other.body,
            other.bookingId,
            other.readAt,
            other.createdAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        type,
        title,
        body,
        bookingId,
        readAt,
        createdAt,
    ],);

  factory NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

