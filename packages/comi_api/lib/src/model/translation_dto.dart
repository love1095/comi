//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'translation_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TranslationDto {
  /// Returns a new [TranslationDto] instance.
  TranslationDto({

    required  this.name,

     this.description,
  });

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




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is TranslationDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            description,
        ],
        [
            other.name,
            other.description,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        description,
    ],);

  factory TranslationDto.fromJson(Map<String, dynamic> json) => _$TranslationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

