//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'mfa_setup_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MfaSetupDto {
  /// Returns a new [MfaSetupDto] instance.
  MfaSetupDto({

    required  this.secret,

    required  this.otpauthUrl,
  });

      /// Base32 secret (type it in if the QR cannot be scanned)
  @JsonKey(
    
    name: r'secret',
    required: true,
    includeIfNull: false,
  )


  final String secret;



      /// otpauth:// URL for the QR code
  @JsonKey(
    
    name: r'otpauthUrl',
    required: true,
    includeIfNull: false,
  )


  final String otpauthUrl;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MfaSetupDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            secret,
            otpauthUrl,
        ],
        [
            other.secret,
            other.otpauthUrl,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        secret,
        otpauthUrl,
    ],);

  factory MfaSetupDto.fromJson(Map<String, dynamic> json) => _$MfaSetupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MfaSetupDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

