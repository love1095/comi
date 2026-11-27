//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'option_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OptionDto {
  /// Returns a new [OptionDto] instance.
  OptionDto({

    required  this.name,

     this.priceDelta,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



      /// VND, may be negative
  @JsonKey(
    
    name: r'priceDelta',
    required: false,
    includeIfNull: false,
  )


  final num? priceDelta;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is OptionDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            name,
            priceDelta,
        ],
        [
            other.name,
            other.priceDelta,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        name,
        priceDelta,
    ],);

  factory OptionDto.fromJson(Map<String, dynamic> json) => _$OptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

