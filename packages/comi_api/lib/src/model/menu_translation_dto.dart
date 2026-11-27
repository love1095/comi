//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'menu_translation_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuTranslationDto {
  /// Returns a new [MenuTranslationDto] instance.
  MenuTranslationDto({

    required  this.locale,

    required  this.name,

     this.description,

    required  this.isMachine,
  });

  @JsonKey(
    
    name: r'locale',
    required: true,
    includeIfNull: false,
  )


  final String locale;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'isMachine',
    required: true,
    includeIfNull: false,
  )


  final bool isMachine;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MenuTranslationDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            locale,
            name,
            description,
            isMachine,
        ],
        [
            other.locale,
            other.name,
            other.description,
            other.isMachine,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        locale,
        name,
        description,
        isMachine,
    ],);

  factory MenuTranslationDto.fromJson(Map<String, dynamic> json) => _$MenuTranslationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuTranslationDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

