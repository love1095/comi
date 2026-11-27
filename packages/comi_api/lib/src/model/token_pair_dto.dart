//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'token_pair_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TokenPairDto {
  /// Returns a new [TokenPairDto] instance.
  TokenPairDto({

    required  this.accessToken,

    required  this.refreshToken,

    required  this.expiresIn,
  });

  @JsonKey(
    
    name: r'accessToken',
    required: true,
    includeIfNull: false,
  )


  final String accessToken;



  @JsonKey(
    
    name: r'refreshToken',
    required: true,
    includeIfNull: false,
  )


  final String refreshToken;



      /// Access token lifetime in seconds
  @JsonKey(
    
    name: r'expiresIn',
    required: true,
    includeIfNull: false,
  )


  final num expiresIn;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is TokenPairDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            accessToken,
            refreshToken,
            expiresIn,
        ],
        [
            other.accessToken,
            other.refreshToken,
            other.expiresIn,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        accessToken,
        refreshToken,
        expiresIn,
    ],);

  factory TokenPairDto.fromJson(Map<String, dynamic> json) => _$TokenPairDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenPairDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

