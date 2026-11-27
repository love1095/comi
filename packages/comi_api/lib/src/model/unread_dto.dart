//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'unread_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UnreadDto {
  /// Returns a new [UnreadDto] instance.
  UnreadDto({

    required  this.unread,
  });

  @JsonKey(
    
    name: r'unread',
    required: true,
    includeIfNull: false,
  )


  final num unread;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UnreadDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            unread,
        ],
        [
            other.unread,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        unread,
    ],);

  factory UnreadDto.fromJson(Map<String, dynamic> json) => _$UnreadDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

