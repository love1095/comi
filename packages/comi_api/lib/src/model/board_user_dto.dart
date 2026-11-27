//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'board_user_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BoardUserDto {
  /// Returns a new [BoardUserDto] instance.
  BoardUserDto({

    required  this.id,

     this.name,

     this.phone,

    required  this.noShowCount,
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
    
    name: r'noShowCount',
    required: true,
    includeIfNull: false,
  )


  final num noShowCount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BoardUserDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            phone,
            noShowCount,
        ],
        [
            other.id,
            other.name,
            other.phone,
            other.noShowCount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        phone,
        noShowCount,
    ],);

  factory BoardUserDto.fromJson(Map<String, dynamic> json) => _$BoardUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BoardUserDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

