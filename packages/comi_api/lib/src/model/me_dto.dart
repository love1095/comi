//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'me_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MeDto {
  /// Returns a new [MeDto] instance.
  MeDto({

    required  this.id,

     this.phone,

     this.email,

     this.name,

     this.avatarUrl,

    required  this.locale,

    required  this.noShowCount,

    required  this.mustPrepay,

    required  this.createdAt,

     this.termsVersion,

    required  this.marketingOptIn,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'avatarUrl',
    required: false,
    includeIfNull: false,
  )


  final String? avatarUrl;



  @JsonKey(
    
    name: r'locale',
    required: true,
    includeIfNull: false,
  )


  final String locale;



  @JsonKey(
    
    name: r'noShowCount',
    required: true,
    includeIfNull: false,
  )


  final num noShowCount;



      /// Too many no-shows: bookings must be prepaid
  @JsonKey(
    
    name: r'mustPrepay',
    required: true,
    includeIfNull: false,
  )


  final bool mustPrepay;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;



      /// Accepted terms/privacy version; null = ask again
  @JsonKey(
    
    name: r'termsVersion',
    required: false,
    includeIfNull: false,
  )


  final String? termsVersion;



  @JsonKey(
    
    name: r'marketingOptIn',
    required: true,
    includeIfNull: false,
  )


  final bool marketingOptIn;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MeDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            phone,
            email,
            name,
            avatarUrl,
            locale,
            noShowCount,
            mustPrepay,
            createdAt,
            termsVersion,
            marketingOptIn,
        ],
        [
            other.id,
            other.phone,
            other.email,
            other.name,
            other.avatarUrl,
            other.locale,
            other.noShowCount,
            other.mustPrepay,
            other.createdAt,
            other.termsVersion,
            other.marketingOptIn,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        phone,
        email,
        name,
        avatarUrl,
        locale,
        noShowCount,
        mustPrepay,
        createdAt,
        termsVersion,
        marketingOptIn,
    ],);

  factory MeDto.fromJson(Map<String, dynamic> json) => _$MeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MeDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

