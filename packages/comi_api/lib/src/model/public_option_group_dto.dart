//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/public_option_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'public_option_group_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicOptionGroupDto {
  /// Returns a new [PublicOptionGroupDto] instance.
  PublicOptionGroupDto({

    required  this.id,

    required  this.name,

    required  this.minSelect,

    required  this.maxSelect,

    required  this.options,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'minSelect',
    required: true,
    includeIfNull: false,
  )


  final num minSelect;



  @JsonKey(
    
    name: r'maxSelect',
    required: true,
    includeIfNull: false,
  )


  final num maxSelect;



  @JsonKey(
    
    name: r'options',
    required: true,
    includeIfNull: false,
  )


  final List<PublicOptionDto> options;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PublicOptionGroupDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            minSelect,
            maxSelect,
            options,
        ],
        [
            other.id,
            other.name,
            other.minSelect,
            other.maxSelect,
            other.options,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        minSelect,
        maxSelect,
        options,
    ],);

  factory PublicOptionGroupDto.fromJson(Map<String, dynamic> json) => _$PublicOptionGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicOptionGroupDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

