//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_me_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateMeDto {
  /// Returns a new [UpdateMeDto] instance.
  UpdateMeDto({

     this.name,

     this.email,

     this.locale,
  });

  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'locale',
    required: false,
    includeIfNull: false,
  )


  final UpdateMeDtoLocaleEnum? locale;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateMeDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            email,
            locale,
        ],
        [
            other.name,
            other.email,
            other.locale,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        email,
        locale,
    ],);

  factory UpdateMeDto.fromJson(Map<String, dynamic> json) => _$UpdateMeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMeDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum UpdateMeDtoLocaleEnum {
@JsonValue(r'vi')
vi(r'vi'),
@JsonValue(r'en')
en(r'en'),
@JsonValue(r'ko')
ko(r'ko'),
@JsonValue(r'zh')
zh(r'zh'),
@JsonValue(r'ja')
ja(r'ja');

const UpdateMeDtoLocaleEnum(this.value);

final String value;

@override
String toString() => value;
}


