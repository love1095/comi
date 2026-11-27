//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'exchange_rate_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExchangeRateDto {
  /// Returns a new [ExchangeRateDto] instance.
  ExchangeRateDto({

    required  this.currency,

    required  this.vndPerUnit,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'currency',
    required: true,
    includeIfNull: false,
  )


  final ExchangeRateDtoCurrencyEnum currency;



      /// How many VND one unit buys
  @JsonKey(
    
    name: r'vndPerUnit',
    required: true,
    includeIfNull: false,
  )


  final num vndPerUnit;



  @JsonKey(
    
    name: r'updatedAt',
    required: true,
    includeIfNull: false,
  )


  final String updatedAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ExchangeRateDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            currency,
            vndPerUnit,
            updatedAt,
        ],
        [
            other.currency,
            other.vndPerUnit,
            other.updatedAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        currency,
        vndPerUnit,
        updatedAt,
    ],);

  factory ExchangeRateDto.fromJson(Map<String, dynamic> json) => _$ExchangeRateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ExchangeRateDtoCurrencyEnum {
@JsonValue(r'USD')
USD(r'USD'),
@JsonValue(r'KRW')
KRW(r'KRW'),
@JsonValue(r'CNY')
CNY(r'CNY'),
@JsonValue(r'JPY')
JPY(r'JPY');

const ExchangeRateDtoCurrencyEnum(this.value);

final String value;

@override
String toString() => value;
}


