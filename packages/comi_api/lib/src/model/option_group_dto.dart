//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/option_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'option_group_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OptionGroupDto {
  /// Returns a new [OptionGroupDto] instance.
  OptionGroupDto({

    required  this.name,

     this.minSelect,

     this.maxSelect,

    required  this.options,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'minSelect',
    required: false,
    includeIfNull: false,
  )


  final num? minSelect;



  @JsonKey(
    
    name: r'maxSelect',
    required: false,
    includeIfNull: false,
  )


  final num? maxSelect;



  @JsonKey(
    
    name: r'options',
    required: true,
    includeIfNull: false,
  )


  final List<OptionDto> options;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is OptionGroupDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            minSelect,
            maxSelect,
            options,
        ],
        [
            other.name,
            other.minSelect,
            other.maxSelect,
            other.options,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        minSelect,
        maxSelect,
        options,
    ],);

  factory OptionGroupDto.fromJson(Map<String, dynamic> json) => _$OptionGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionGroupDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

