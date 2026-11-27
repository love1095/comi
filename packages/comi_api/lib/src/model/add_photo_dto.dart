//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'add_photo_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddPhotoDto {
  /// Returns a new [AddPhotoDto] instance.
  AddPhotoDto({

    required  this.publicId,

     this.width,

     this.height,
  });

      /// Cloudinary public_id returned by the direct upload
  @JsonKey(
    
    name: r'publicId',
    required: true,
    includeIfNull: false,
  )


  final String publicId;



      /// Only used when Cloudinary is not configured (local dev)
  @JsonKey(
    
    name: r'width',
    required: false,
    includeIfNull: false,
  )


  final num? width;



  @JsonKey(
    
    name: r'height',
    required: false,
    includeIfNull: false,
  )


  final num? height;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AddPhotoDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            publicId,
            width,
            height,
        ],
        [
            other.publicId,
            other.width,
            other.height,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        publicId,
        width,
        height,
    ],);

  factory AddPhotoDto.fromJson(Map<String, dynamic> json) => _$AddPhotoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddPhotoDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

