//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'board_order_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BoardOrderDto {
  /// Returns a new [BoardOrderDto] instance.
  BoardOrderDto({

    required  this.total,
  });

  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BoardOrderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            total,
        ],
        [
            other.total,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        total,
    ],);

  factory BoardOrderDto.fromJson(Map<String, dynamic> json) => _$BoardOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BoardOrderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

