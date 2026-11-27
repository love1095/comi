//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'consent_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConsentDto {
  /// Returns a new [ConsentDto] instance.
  ConsentDto({

    required  this.termsVersion,

     this.marketing,
  });

  @JsonKey(
    
    name: r'termsVersion',
    required: true,
    includeIfNull: false,
  )


  final String termsVersion;



      /// Offers and news by notification/email
  @JsonKey(
    
    name: r'marketing',
    required: false,
    includeIfNull: false,
  )


  final bool? marketing;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ConsentDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            termsVersion,
            marketing,
        ],
        [
            other.termsVersion,
            other.marketing,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        termsVersion,
        marketing,
    ],);

  factory ConsentDto.fromJson(Map<String, dynamic> json) => _$ConsentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

