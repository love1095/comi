//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'menu_photo_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuPhotoDto {
  /// Returns a new [MenuPhotoDto] instance.
  MenuPhotoDto({

    required  this.id,

    required  this.publicId,

    required  this.width,

    required  this.height,

     this.blurhash,

    required  this.sortOrder,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



      /// Cloudinary public_id; apps build the delivery URL
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



  @JsonKey(
    
    name: r'sortOrder',
    required: true,
    includeIfNull: false,
  )


  final num sortOrder;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MenuPhotoDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            publicId,
            width,
            height,
            blurhash,
            sortOrder,
        ],
        [
            other.id,
            other.publicId,
            other.width,
            other.height,
            other.blurhash,
            other.sortOrder,
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
        sortOrder,
    ],);

  factory MenuPhotoDto.fromJson(Map<String, dynamic> json) => _$MenuPhotoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuPhotoDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

