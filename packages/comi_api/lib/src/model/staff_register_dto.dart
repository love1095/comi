//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'staff_register_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StaffRegisterDto {
  /// Returns a new [StaffRegisterDto] instance.
  StaffRegisterDto({

    required  this.email,

    required  this.password,

    required  this.name,

     this.phone,
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



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is StaffRegisterDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            email,
            password,
            name,
            phone,
        ],
        [
            other.email,
            other.password,
            other.name,
            other.phone,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        email,
        password,
        name,
        phone,
    ],);

  factory StaffRegisterDto.fromJson(Map<String, dynamic> json) => _$StaffRegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StaffRegisterDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

