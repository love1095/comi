//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/import_error_dto.dart';
import 'package:comi_api/src/model/imported_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'import_preview_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ImportPreviewDto {
  /// Returns a new [ImportPreviewDto] instance.
  ImportPreviewDto({

    required  this.items,

    required  this.errors,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ImportedItemDto> items;



  @JsonKey(
    
    name: r'errors',
    required: true,
    includeIfNull: false,
  )


  final List<ImportErrorDto> errors;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ImportPreviewDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
            errors,
        ],
        [
            other.items,
            other.errors,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
        errors,
    ],);

  factory ImportPreviewDto.fromJson(Map<String, dynamic> json) => _$ImportPreviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImportPreviewDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

