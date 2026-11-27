//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'public_photo_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicPhotoDto {
  /// Returns a new [PublicPhotoDto] instance.
  PublicPhotoDto({

    required  this.id,

    required  this.publicId,

    required  this.width,

    required  this.height,

     this.blurhash,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'publicId',
    required: true,
    includeIfNull: false,
  )


  final String publicId;



  @JsonKey(
    
    name: r'width',
    required: true,
    includeIfNull: false,
  )


  final num width;



  @JsonKey(
    
    name: r'height',
    required: true,
    includeIfNull: false,
  )


  final num height;



  @JsonKey(
    
    name: r'blurhash',
    required: false,
    includeIfNull: false,
  )


  final String? blurhash;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is PublicPhotoDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            publicId,
            width,
            height,
            blurhash,
        ],
        [
            other.id,
            other.publicId,
            other.width,
            other.height,
            other.blurhash,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        publicId,
        width,
        height,
        blurhash,
    ],);

  factory PublicPhotoDto.fromJson(Map<String, dynamic> json) => _$PublicPhotoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicPhotoDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

