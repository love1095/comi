//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'admin_user_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminUserDto {
  /// Returns a new [AdminUserDto] instance.
  AdminUserDto({

    required  this.id,

     this.name,

     this.phone,

     this.email,

    required  this.status,

    required  this.noShowCount,

    required  this.mustPrepay,

    required  this.bookings,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final AdminUserDtoStatusEnum status;



  @JsonKey(
    
    name: r'noShowCount',
    required: true,
    includeIfNull: false,
  )


  final num noShowCount;



  @JsonKey(
    
    name: r'mustPrepay',
    required: true,
    includeIfNull: false,
  )


  final bool mustPrepay;



  @JsonKey(
    
    name: r'bookings',
    required: true,
    includeIfNull: false,
  )


  final num bookings;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AdminUserDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            phone,
            email,
            status,
            noShowCount,
            mustPrepay,
            bookings,
            createdAt,
        ],
        [
            other.id,
            other.name,
            other.phone,
            other.email,
            other.status,
            other.noShowCount,
            other.mustPrepay,
            other.bookings,
            other.createdAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        phone,
        email,
        status,
        noShowCount,
        mustPrepay,
        bookings,
        createdAt,
    ],);

  factory AdminUserDto.fromJson(Map<String, dynamic> json) => _$AdminUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum AdminUserDtoStatusEnum {
@JsonValue(r'ACTIVE')
ACTIVE(r'ACTIVE'),
@JsonValue(r'BLOCKED')
BLOCKED(r'BLOCKED'),
@JsonValue(r'DELETED')
DELETED(r'DELETED');

const AdminUserDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


