//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'reply_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReplyDto {
  /// Returns a new [ReplyDto] instance.
  ReplyDto({

    required  this.reply,
  });

  @JsonKey(
    
    name: r'reply',
    required: true,
    includeIfNull: false,
  )


  final String reply;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReplyDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            reply,
        ],
        [
            other.reply,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        reply,
    ],);

  factory ReplyDto.fromJson(Map<String, dynamic> json) => _$ReplyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

