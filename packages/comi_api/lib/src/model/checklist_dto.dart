//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'checklist_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChecklistDto {
  /// Returns a new [ChecklistDto] instance.
  ChecklistDto({

    required  this.complete,

    required  this.missing,
  });

  @JsonKey(
    
    name: r'complete',
    required: true,
    includeIfNull: false,
  )


  final bool complete;



  @JsonKey(
    
    name: r'missing',
    required: true,
    includeIfNull: false,
  )


  final List<String> missing;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ChecklistDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            complete,
            missing,
        ],
        [
            other.complete,
            other.missing,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        complete,
        missing,
    ],);

  factory ChecklistDto.fromJson(Map<String, dynamic> json) => _$ChecklistDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

