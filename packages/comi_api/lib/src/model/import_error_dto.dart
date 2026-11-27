//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'import_error_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ImportErrorDto {
  /// Returns a new [ImportErrorDto] instance.
  ImportErrorDto({

    required  this.row,

     this.column,

    required  this.message,
  });

  @JsonKey(
    
    name: r'row',
    required: true,
    includeIfNull: false,
  )


  final num row;



  @JsonKey(
    
    name: r'column',
    required: false,
    includeIfNull: false,
  )


  final String? column;



  @JsonKey(
    
    name: r'message',
    required: true,
    includeIfNull: false,
  )


  final String message;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ImportErrorDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            row,
            column,
            message,
        ],
        [
            other.row,
            other.column,
            other.message,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        row,
        column,
        message,
    ],);

  factory ImportErrorDto.fromJson(Map<String, dynamic> json) => _$ImportErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImportErrorDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

