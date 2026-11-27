//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'upload_signature_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UploadSignatureDto {
  /// Returns a new [UploadSignatureDto] instance.
  UploadSignatureDto({

    required  this.cloudName,

    required  this.apiKey,

    required  this.timestamp,

    required  this.folder,

    required  this.signature,
  });

  @JsonKey(
    
    name: r'cloudName',
    required: true,
    includeIfNull: false,
  )


  final String cloudName;



  @JsonKey(
    
    name: r'apiKey',
    required: true,
    includeIfNull: false,
  )


  final String apiKey;



  @JsonKey(
    
    name: r'timestamp',
    required: true,
    includeIfNull: false,
  )


  final num timestamp;



  @JsonKey(
    
    name: r'folder',
    required: true,
    includeIfNull: false,
  )


  final String folder;



  @JsonKey(
    
    name: r'signature',
    required: true,
    includeIfNull: false,
  )


  final String signature;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UploadSignatureDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            cloudName,
            apiKey,
            timestamp,
            folder,
            signature,
        ],
        [
            other.cloudName,
            other.apiKey,
            other.timestamp,
            other.folder,
            other.signature,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        cloudName,
        apiKey,
        timestamp,
        folder,
        signature,
    ],);

  factory UploadSignatureDto.fromJson(Map<String, dynamic> json) => _$UploadSignatureDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UploadSignatureDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

