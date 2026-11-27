//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'connect_pay_os_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConnectPayOsDto {
  /// Returns a new [ConnectPayOsDto] instance.
  ConnectPayOsDto({

    required  this.clientId,

    required  this.apiKey,

    required  this.checksumKey,
  });

  @JsonKey(
    
    name: r'clientId',
    required: true,
    includeIfNull: false,
  )


  final String clientId;



  @JsonKey(
    
    name: r'apiKey',
    required: true,
    includeIfNull: false,
  )


  final String apiKey;



  @JsonKey(
    
    name: r'checksumKey',
    required: true,
    includeIfNull: false,
  )


  final String checksumKey;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ConnectPayOsDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            clientId,
            apiKey,
            checksumKey,
        ],
        [
            other.clientId,
            other.apiKey,
            other.checksumKey,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        clientId,
        apiKey,
        checksumKey,
    ],);

  factory ConnectPayOsDto.fromJson(Map<String, dynamic> json) => _$ConnectPayOsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectPayOsDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

