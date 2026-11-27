//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'reorder_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReorderDto {
  /// Returns a new [ReorderDto] instance.
  ReorderDto({

    required  this.ids,
  });

      /// Ids in the new order
  @JsonKey(
    
    name: r'ids',
    required: true,
    includeIfNull: false,
  )


  final List<String> ids;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReorderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            ids,
        ],
        [
            other.ids,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        ids,
    ],);

  factory ReorderDto.fromJson(Map<String, dynamic> json) => _$ReorderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReorderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

