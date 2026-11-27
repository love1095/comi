//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'board_table_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BoardTableDto {
  /// Returns a new [BoardTableDto] instance.
  BoardTableDto({

    required  this.id,

    required  this.code,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BoardTableDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
        ],
        [
            other.id,
            other.code,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
    ],);

  factory BoardTableDto.fromJson(Map<String, dynamic> json) => _$BoardTableDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BoardTableDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

