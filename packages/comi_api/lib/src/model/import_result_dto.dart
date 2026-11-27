//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'import_result_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ImportResultDto {
  /// Returns a new [ImportResultDto] instance.
  ImportResultDto({

    required  this.created,

    required  this.categories,
  });

  @JsonKey(
    
    name: r'created',
    required: true,
    includeIfNull: false,
  )


  final num created;



  @JsonKey(
    
    name: r'categories',
    required: true,
    includeIfNull: false,
  )


  final num categories;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ImportResultDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            created,
            categories,
        ],
        [
            other.created,
            other.categories,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        created,
        categories,
    ],);

  factory ImportResultDto.fromJson(Map<String, dynamic> json) => _$ImportResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImportResultDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

