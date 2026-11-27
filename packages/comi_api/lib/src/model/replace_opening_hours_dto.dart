//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/opening_hours_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'replace_opening_hours_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReplaceOpeningHoursDto {
  /// Returns a new [ReplaceOpeningHoursDto] instance.
  ReplaceOpeningHoursDto({

    required  this.items,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<OpeningHoursItemDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReplaceOpeningHoursDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
        ],
        [
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
    ],);

  factory ReplaceOpeningHoursDto.fromJson(Map<String, dynamic> json) => _$ReplaceOpeningHoursDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReplaceOpeningHoursDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

