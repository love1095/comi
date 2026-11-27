//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'guest_key_pay_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GuestKeyPayDto {
  /// Returns a new [GuestKeyPayDto] instance.
  GuestKeyPayDto({

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
      other is GuestKeyPayDto &&
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

  factory GuestKeyPayDto.fromJson(Map<String, dynamic> json) => _$GuestKeyPayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GuestKeyPayDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

