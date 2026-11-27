//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_login_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminLoginResultDto {
  /// Returns a new [AdminLoginResultDto] instance.
  AdminLoginResultDto({

    required  this.accessToken,

    required  this.refreshToken,

    required  this.expiresIn,

    required  this.mfa,
  });

  @JsonKey(
    
    name: r'accessToken',
    required: true,
    includeIfNull: false,
  )


  final String accessToken;



  @JsonKey(
    
    name: r'refreshToken',
    required: true,
    includeIfNull: false,
  )


  final String refreshToken;



  @JsonKey(
    
    name: r'expiresIn',
    required: true,
    includeIfNull: false,
  )


  final num expiresIn;



      /// false = this session can only set up 2FA, not use admin routes
  @JsonKey(
    
    name: r'mfa',
    required: true,
    includeIfNull: false,
  )


  final bool mfa;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminLoginResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            accessToken,
            refreshToken,
            expiresIn,
            mfa,
        ],
        [
            other.accessToken,
            other.refreshToken,
            other.expiresIn,
            other.mfa,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        accessToken,
        refreshToken,
        expiresIn,
        mfa,
    ],);

  factory AdminLoginResultDto.fromJson(Map<String, dynamic> json) => _$AdminLoginResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminLoginResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

