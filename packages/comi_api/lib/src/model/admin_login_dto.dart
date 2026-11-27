//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_login_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminLoginDto {
  /// Returns a new [AdminLoginDto] instance.
  AdminLoginDto({

    required  this.email,

    required  this.password,

     this.code,
  });

  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'password',
    required: true,
    includeIfNull: false,
  )


  final String password;



      /// 6-digit authenticator code (required once 2FA is on)
  @JsonKey(
    
    name: r'code',
    required: false,
    includeIfNull: false,
  )


  final String? code;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminLoginDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            email,
            password,
            code,
        ],
        [
            other.email,
            other.password,
            other.code,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        email,
        password,
        code,
    ],);

  factory AdminLoginDto.fromJson(Map<String, dynamic> json) => _$AdminLoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminLoginDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

