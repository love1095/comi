//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'guest_key_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GuestKeyDto {
  /// Returns a new [GuestKeyDto] instance.
  GuestKeyDto({

    required  this.guestKey,
  });

  @JsonKey(
    
    name: r'guestKey',
    required: true,
    includeIfNull: false,
  )


  final String guestKey;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GuestKeyDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            guestKey,
        ],
        [
            other.guestKey,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        guestKey,
    ],);

  factory GuestKeyDto.fromJson(Map<String, dynamic> json) => _$GuestKeyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GuestKeyDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

