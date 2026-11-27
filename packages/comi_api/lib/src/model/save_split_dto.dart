//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/split_mode.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'save_split_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SaveSplitDto {
  /// Returns a new [SaveSplitDto] instance.
  SaveSplitDto({

    required  this.mode,

     this.people,

     this.amounts,
  });

  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  )


  final SplitMode mode;



      /// Table without group members: split between this many people
  @JsonKey(
    
    name: r'people',
    required: false,
    includeIfNull: false,
  )


  final num? people;



      /// CUSTOM: guestId → VND
  @JsonKey(
    
    name: r'amounts',
    required: false,
    includeIfNull: false,
  )


  final Map<String, int>? amounts;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SaveSplitDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            mode,
            people,
            amounts,
        ],
        [
            other.mode,
            other.people,
            other.amounts,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        mode,
        people,
        amounts,
    ],);

  factory SaveSplitDto.fromJson(Map<String, dynamic> json) => _$SaveSplitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SaveSplitDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

