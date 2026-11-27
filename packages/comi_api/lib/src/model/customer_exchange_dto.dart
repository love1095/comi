//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'customer_exchange_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CustomerExchangeDto {
  /// Returns a new [CustomerExchangeDto] instance.
  CustomerExchangeDto({

    required  this.idToken,
  });

      /// Firebase ID token from the phone
  @JsonKey(
    
    name: r'idToken',
    required: true,
    includeIfNull: false,
  )


  final String idToken;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CustomerExchangeDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            idToken,
        ],
        [
            other.idToken,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        idToken,
    ],);

  factory CustomerExchangeDto.fromJson(Map<String, dynamic> json) => _$CustomerExchangeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerExchangeDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

