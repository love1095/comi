//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'legal_info_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LegalInfoDto {
  /// Returns a new [LegalInfoDto] instance.
  LegalInfoDto({

    required  this.termsVersion,

    required  this.privacyPath,

    required  this.termsPath,
  });

  @JsonKey(
    
    name: r'termsVersion',
    required: true,
    includeIfNull: false,
  )


  final String termsVersion;



  @JsonKey(
    
    name: r'privacyPath',
    required: true,
    includeIfNull: false,
  )


  final String privacyPath;



  @JsonKey(
    
    name: r'termsPath',
    required: true,
    includeIfNull: false,
  )


  final String termsPath;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is LegalInfoDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            termsVersion,
            privacyPath,
            termsPath,
        ],
        [
            other.termsVersion,
            other.privacyPath,
            other.termsPath,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        termsVersion,
        privacyPath,
        termsPath,
    ],);

  factory LegalInfoDto.fromJson(Map<String, dynamic> json) => _$LegalInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LegalInfoDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

