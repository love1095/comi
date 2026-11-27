//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'rates_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RatesDto {
  /// Returns a new [RatesDto] instance.
  RatesDto({

    required  this.rates,
  });

  @JsonKey(
    
    name: r'rates',
    required: true,
    includeIfNull: false,
  )


  final Map<String, num> rates;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is RatesDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            rates,
        ],
        [
            other.rates,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        rates,
    ],);

  factory RatesDto.fromJson(Map<String, dynamic> json) => _$RatesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatesDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

