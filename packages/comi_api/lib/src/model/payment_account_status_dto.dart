//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'payment_account_status_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentAccountStatusDto {
  /// Returns a new [PaymentAccountStatusDto] instance.
  PaymentAccountStatusDto({

    required  this.provider,

    required  this.connected,

     this.clientIdHint,

    required  this.serverReady,
  });

  @JsonKey(
    
    name: r'provider',
    required: true,
    includeIfNull: false,
  )


  final PaymentAccountStatusDtoProviderEnum provider;



  @JsonKey(
    
    name: r'connected',
    required: true,
    includeIfNull: false,
  )


  final bool connected;



      /// Last 4 characters of the client id
  @JsonKey(
    
    name: r'clientIdHint',
    required: false,
    includeIfNull: false,
  )


  final String? clientIdHint;



      /// False when the server has no encryption key (payments off on this server)
  @JsonKey(
    
    name: r'serverReady',
    required: true,
    includeIfNull: false,
  )


  final bool serverReady;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PaymentAccountStatusDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            provider,
            connected,
            clientIdHint,
            serverReady,
        ],
        [
            other.provider,
            other.connected,
            other.clientIdHint,
            other.serverReady,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        provider,
        connected,
        clientIdHint,
        serverReady,
    ],);

  factory PaymentAccountStatusDto.fromJson(Map<String, dynamic> json) => _$PaymentAccountStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAccountStatusDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum PaymentAccountStatusDtoProviderEnum {
@JsonValue(r'PAYOS')
PAYOS(r'PAYOS');

const PaymentAccountStatusDtoProviderEnum(this.value);

final String value;

@override
String toString() => value;
}


