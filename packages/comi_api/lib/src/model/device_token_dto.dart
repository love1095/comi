//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'device_token_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeviceTokenDto {
  /// Returns a new [DeviceTokenDto] instance.
  DeviceTokenDto({

    required  this.token,

    required  this.platform,
  });

  @JsonKey(
    
    name: r'token',
    required: true,
    includeIfNull: false,
  )


  final String token;



  @JsonKey(
    
    name: r'platform',
    required: true,
    includeIfNull: false,
  )


  final DeviceTokenDtoPlatformEnum platform;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is DeviceTokenDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            token,
            platform,
        ],
        [
            other.token,
            other.platform,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        token,
        platform,
    ],);

  factory DeviceTokenDto.fromJson(Map<String, dynamic> json) => _$DeviceTokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum DeviceTokenDtoPlatformEnum {
@JsonValue(r'ios')
ios(r'ios'),
@JsonValue(r'android')
android(r'android');

const DeviceTokenDtoPlatformEnum(this.value);

final String value;

@override
String toString() => value;
}


