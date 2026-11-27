//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'public_option_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicOptionDto {
  /// Returns a new [PublicOptionDto] instance.
  PublicOptionDto({

    required  this.id,

    required  this.name,

    required  this.priceDelta,
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
    
    name: r'priceDelta',
    required: true,
    includeIfNull: false,
  )


  final num priceDelta;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PublicOptionDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            priceDelta,
        ],
        [
            other.id,
            other.name,
            other.priceDelta,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        priceDelta,
    ],);

  factory PublicOptionDto.fromJson(Map<String, dynamic> json) => _$PublicOptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicOptionDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

