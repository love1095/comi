//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/home_section_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'home_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HomeDto {
  /// Returns a new [HomeDto] instance.
  HomeDto({

    required  this.mode,

    required  this.sections,
  });

  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  )


  final HomeDtoModeEnum mode;



  @JsonKey(
    
    name: r'sections',
    required: true,
    includeIfNull: false,
  )


  final List<HomeSectionDto> sections;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is HomeDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            mode,
            sections,
        ],
        [
            other.mode,
            other.sections,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        mode,
        sections,
    ],);

  factory HomeDto.fromJson(Map<String, dynamic> json) => _$HomeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum HomeDtoModeEnum {
@JsonValue(r'lunch')
lunch(r'lunch'),
@JsonValue(r'tonight')
tonight(r'tonight'),
@JsonValue(r'explore')
explore(r'explore');

const HomeDtoModeEnum(this.value);

final String value;

@override
String toString() => value;
}


